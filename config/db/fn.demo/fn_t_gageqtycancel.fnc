create or replace function FN_T_GageQtyCancel(
    --p_ValidID       number,     --生效仓单号 modify by yukx 20100422
    --p_Modifier      varchar2,   --最后修改人 modify by yukx 20100422
    p_customerId      varchar2,   --交易客户代码
    p_commodityId     varchar2,   --商品代码
    p_Quantity        number,     --撤销抵顶数量
	  p_ApplyType     number    --申请种类:2：正常撤销已有抵顶;3：强制撤销已有抵顶
) return number
/****
 * 取消抵顶
 * 返回值
 * 1 成功
 * 2 已处理过
 * -11  取消抵顶时超出抵顶数量
 * -12  取消抵顶数量大于抵顶数量
 * -13  资金余额不足
 * -100 其它错误
****/
as
	v_version varchar2(10):='1.0.2.1';
    --v_CommodityID varchar2(16);  modify by yukx 20100422
    v_FirmID     varchar2(32);
    v_BS_Flag        number(2);
    v_price          number(15,2);
    v_GageQty       number(10);
    v_frozenGageQty number(10);
    v_holdQty        number(10);
    v_Margin         number(15,2):=0;   --应收保证金
	v_Assure         number(15,2):=0;   --应收担保金
    v_A_HoldNo       number(15);
    v_MarginPriceType       number(1);
    v_errorcode      number;
    v_errormsg       varchar2(200);
    v_MarginPrice    number(15,2);  --计算成交保证金的价格
	v_HoldFunds    number(15,2):=0;  --平仓时应退持仓金额
    v_unCloseQty     number(10); --未平数量，用于中间计算
    v_margin_one     number(15,2);   --用于中间计算
	v_Assure_one     number(15,2);   --用于中间计算
    v_tradedAmount   number(10):=0;  --成交数量
	--v_CustomerID        varchar2(16);  modify by yukx 20100422
	v_calFLPrice number(15,2) default 0;        --计算浮亏的价格
	v_ContractFactor T_Commodity.ContractFactor%type;
	v_FloatLoss_one         number(15,2):=0;    --正值表示的浮亏
	v_FloatLoss         number(15,2):=0;        --正值表示的浮亏合计
	v_A_Funds        number(15,2);   --可用资金
	--v_Quantity     number(10); --未平数量，用于中间计算  modify by yukx 20100422
	v_CloseAlgr           number(2);
	v_FloatingLossComputeType number(2);
	v_orderby  varchar2(100);
	v_VirtualFunds   number(15,2);   --虚拟资金
	v_F_FrozenFunds   number(15,2);
	v_MaxOverdraft   number(15,2);   --最大透支额度
	type c_HoldPosition is ref cursor;
	v_HoldPosition c_HoldPosition;
	v_sql varchar2(1000);
	v_num            number(10);
	v_FL_ret            timestamp;
	v_AtClearDate          date;
	v_closeTodayHis        number(2);    --平今仓还是历史仓(0平今仓；1平历史仓)
	v_YesterBalancePrice    number(15,2);
	v_TradeDate date;
	v_FloatingProfitSubTax number(1);
	v_AddedTax number(10,4);
	v_GageMode number(2);--抵顶模式，分0全抵顶和1半抵顶，半抵顶时要计算浮亏，2009-10-14
begin
     -- modify by yukx 20100422
	   -- select count(*) into v_num from T_ValidBill where ValidID = p_ValidID and Status=0;
	   -- if(v_num >0) then
	   --     rollback;
	   --     return 2;  --已处理过
	   -- end if;

    --  modify by yukx 20100422
		--根据生效仓单号查询卖方二级客户ID，商品统一代码，仓单数量
		--select CustomerID_S,CommodityID,Quantity into v_CustomerID,v_CommodityID,v_Quantity from T_ValidBill where ValidID=p_ValidID;
    --v_CustomerID   := p_customerId;
    --v_CommodityID  := p_commodityId;
    --v_Quantity     := p_Quantity;
        --获取平仓算法，保证金计算类型,合约因子
        select CloseAlgr,FloatingLossComputeType,FloatingProfitSubTax,GageMode into v_CloseAlgr,v_FloatingLossComputeType,v_FloatingProfitSubTax,v_GageMode from T_A_Market;
        select MarginPriceType,ContractFactor,LastPrice,AddedTax into v_MarginPriceType,v_ContractFactor,v_YesterBalancePrice,v_AddedTax from T_Commodity where CommodityID=p_commodityId;
		select TradeDate into v_TradeDate from T_SystemStatus;

        v_BS_Flag := 2; --卖抵顶
		v_unCloseQty := p_Quantity;
		--注意锁住持仓
        select GageQty,GageFrozenQty into v_GageQty,v_frozenGageQty
        from T_CustomerHoldSum
        where CustomerID = p_customerId
          and CommodityID = p_commodityId
          and bs_flag = v_BS_Flag for update;

        -- modify by yukx 20100422
        if(p_Quantity > v_GageQty-v_frozenGageQty) then
            rollback;
            return -11;
        end if;
    	--如果计算保证金价不是按开仓价，则在当前行情表中找昨结算价，未找到则找历史中最后一天的结算价
        begin
        	select nvl(Price,0) into v_calFLPrice from T_Quotation where CommodityID=p_commodityId;
        exception
            when NO_DATA_FOUND then
                select nvl(Price,0) into v_calFLPrice from T_H_Quotation where CommodityID=p_commodityId and ClearDate =(select max(ClearDate) from T_H_Quotation where CommodityID=p_commodityId);
        end;
        --找出抵顶数量大于0的持仓
        --取消抵顶时与抵顶时顺序相反
        --根据平仓算法(0先开先平；1后开先平；2持仓均价平仓(不排序)选择排序条件
        if(v_CloseAlgr = 0) then
	        v_orderby := ' order by A_HoldNo desc ';
	    elsif(v_CloseAlgr = 1) then
	        v_orderby := ' order by A_HoldNo ';
	    end if;
    	v_sql := 'select a_holdno,FirmID,price,GageQty,AtClearDate from T_holdposition ' ||
                 ' where GageQty>0 and CustomerID=''' || p_customerId ||
                 ''' and CommodityID =''' || p_commodityId || ''' and bs_flag = ' || v_BS_Flag || v_orderby;

            open v_HoldPosition for v_sql;
            loop
                fetch v_HoldPosition into v_a_holdno, v_FirmID, v_price, v_holdqty,v_AtClearDate;
                exit when v_HoldPosition%NOTFOUND;
                if(v_holdqty<=v_unCloseQty) then
                    v_tradedAmount:=v_holdqty;
                else
                    v_tradedAmount:=v_unCloseQty;
                end if;

                --计算应收保证金，根据设置选择开仓价还是昨结算价来算
				if(v_MarginPriceType = 1) then
			        v_MarginPrice := v_YesterBalancePrice;
			    elsif(v_MarginPriceType = 2) then
					--判断是平今仓还是平历史仓
				    if(trunc(v_TradeDate) = trunc(v_AtClearDate)) then
				        v_closeTodayHis := 0;
				    else
				    	v_closeTodayHis := 1;
				    end if;
					if(v_closeTodayHis = 0) then  --平今仓
						v_MarginPrice := v_price;
					else  --平历史仓
				        v_MarginPrice := v_YesterBalancePrice;
				    end if;
				else  -- default type is 0
					v_MarginPrice := v_price;
				end if;
                v_Margin_one := FN_T_ComputeMargin(v_FirmID,p_commodityId,v_BS_Flag,v_tradedAmount,v_MarginPrice);
                if(v_Margin_one < 0) then
                    Raise_application_error(-20040, 'computeMargin error');
                end if;
		        --计算担保金
		        v_Assure_one := FN_T_ComputeAssure(v_FirmID,p_commodityId,v_BS_Flag,v_tradedAmount,v_MarginPrice);
		        if(v_Assure_one < 0) then
		            Raise_application_error(-20041, 'computeAssure error');
		        end if;
		        --保证金应加上担保金
		        v_Margin_one := v_Margin_one + v_Assure_one;
		        --计算浮亏，根据参数是否扣税
				v_FloatLoss_one := FN_T_ComputeFPSubTax(v_Price,v_calFLPrice,v_tradedAmount,v_ContractFactor,v_BS_Flag,v_AddedTax,v_FloatingProfitSubTax);
				if(v_FloatingLossComputeType = 3 or v_FloatingLossComputeType = 4) then  --盘中算盈亏或不算盈亏
					--v_FloatLoss_one := -FN_T_ComputeFloatingProfit(v_Price,v_calFLPrice,v_tradedAmount,v_ContractFactor,v_BS_Flag); --盈亏并取反
					v_FloatLoss_one := -v_FloatLoss_one;
				else
		        	--v_FloatLoss_one := FN_T_ComputeFloatingLoss(v_Price,v_calFLPrice,v_tradedAmount,v_ContractFactor,v_BS_Flag); --浮亏
					if(v_FloatLoss_one > 0) then
						v_FloatLoss_one := 0;
					else
						v_FloatLoss_one := -v_FloatLoss_one;
					end if;
		        end if;
                v_Margin:=v_Margin + v_Margin_one;
                v_Assure:=v_Assure + v_Assure_one;
                v_FloatLoss := v_FloatLoss + v_FloatLoss_one;
	            --计算应退持仓金额
	            v_HoldFunds := v_HoldFunds + v_tradedAmount*v_price*v_ContractFactor;

                --更新持仓记录
		        update T_holdposition
                set holdqty = holdqty + v_tradedAmount,HoldMargin=HoldMargin+v_Margin_one,HoldAssure=HoldAssure+v_Assure_one,GageQty=GageQty-v_tradedAmount
                where a_holdno = v_a_holdno;

                v_unCloseQty:=v_unCloseQty - v_tradedAmount;
                exit when v_unCloseQty=0;
            end loop;
            close v_HoldPosition;
            if(v_unCloseQty>0) then --取消抵顶数量大于抵顶数量，出错
                rollback;
                return -12;
            end if;
            --根据申请种类:2：正常撤销已有抵顶;3：强制撤销已有抵顶，来判断金额是否足够释放此抵顶，如果是3不需要此判断
			if(p_ApplyType = 2) then
				select VirtualFunds,MaxOverdraft into v_VirtualFunds,v_MaxOverdraft from T_Firm where FirmID = v_FirmID;
		        --计算可用资金
		        v_A_Funds := FN_F_GetRealFunds(v_FirmID,0) + v_VirtualFunds + v_MaxOverdraft;
		        --如果是半抵顶则不释放浮亏2009-10-15
		        if(v_GageMode=1) then
		        	v_FloatLoss := 0;
				end if;
		        if(v_A_Funds < v_Margin-v_Assure + v_FloatLoss) then
		            rollback;
		            return -13;  --资金余额不足
		        end if;
	        end if;

        --调用减少交易客户，交易商的持仓合计信息存储，注意参数值与减少持仓不一样   2009-10-15
        if(v_GageMode=1) then
        	v_num := FN_T_SubHoldSum(-p_Quantity,p_Quantity,-v_Margin,-v_Assure,p_commodityId,v_ContractFactor,v_BS_Flag,v_FirmID,0,p_customerId,0,v_GageMode,0);
		else
			v_num := FN_T_SubHoldSum(-p_Quantity,p_Quantity,-v_Margin,-v_Assure,p_commodityId,v_ContractFactor,v_BS_Flag,v_FirmID,-v_HoldFunds,p_customerId,0,v_GageMode,0);
		end if;

        --更新保证金和担保金
        update T_Firm
        set runtimemargin = runtimemargin + v_Margin,
            RuntimeAssure = RuntimeAssure + v_Assure
        where Firmid = v_FirmID;
        --更新冻结资金，扣除个人部分的保证金
        v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,v_Margin-v_Assure,'15');

        --modify by tangzy 20100729 增加where条件
        --modify by yukx 20100422 新增抵顶转让后部更新生效仓单表 直接增加生效抵顶仓单表的数量
        --更新生效仓单表的状态为已撤消
        --update T_ValidBill set Status=0,ModifyTime=sysdate,Modifier=p_Modifier where ValidID=p_ValidID;
        update T_ValidGageBill set Quantity = Quantity+p_Quantity
        where FirmID=v_FirmID and commodityID= p_CommodityID;
    commit;
    --提交后计算此交易商浮亏
    v_FL_ret := FN_T_UpdateFloatingLoss(null,null,null);

    return 1;
exception
    when OTHERS then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_GageQtyCancel',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/


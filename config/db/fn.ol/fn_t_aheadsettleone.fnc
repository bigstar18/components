create or replace function FN_T_AheadSettleOne(
    p_CommodityID varchar2,   --商品代码
	p_Price         number,  --交收价
	p_BS_Flag     number,  --买卖标志
    p_CustomerID    varchar2,     --交易客户ID
    p_HoldQty      number,   --交收持仓数量，即非抵顶数量
	p_GageQty      number   --交收抵顶数量
) return number
/****
 * 买卖单方向提前交收
 * 1、注意不要提交commit，因为别的函数要调用它；
 * 返回值
 * 1 成功
 * -1  可交收持仓数量不足
 * -2  可交收抵顶数量不足
 * -3  交收持仓数量大于可交收持仓数量
 * -4  交收抵顶数量大于可抵顶数量
 * -100 其它错误
****/
as
	v_version varchar2(10):='1.0.2.1';
    v_CommodityID varchar2(16);
    v_CustomerID        varchar2(40);
    v_FirmID varchar2(32);
    v_HoldQty  number;
    v_HoldSumQty     number(10);
    v_frozenQty      number(10);
    v_Margin         number(15,2):=0;
    v_Margin_one         number(15,2):=0;
    v_closeFL_one         number(15,2):=0;    --一条记录的交收盈亏
    v_CloseFL         number(15,2):=0;        --交收盈亏累加
    v_Fee_one         number(15,2):=0;    --一条记录的交收手续费
    v_Fee         number(15,2):=0;        --交收手续费累加
	v_Assure         number(15,2):=0;
	v_Assure_one         number(15,2):=0;
    v_Payout         number(15,2):=0;
    v_Payout_one         number(15,2):=0;
    v_BS_Flag           number(2);
    v_Price         number(15,2);
    v_ContractFactor    number(12,2);
    v_MarginPriceType           number(1);
    v_MarginPrice    number(15,2);  --计算成交保证金的价格
	v_HoldFunds    number(15,2):=0;  --平仓时应退持仓金额，不包括抵顶的
	v_CustomerHoldFunds    number(15,2):=0;  --平仓时应退持仓金额，包括抵顶的
    v_TradeDate date;
	v_A_HoldNo number(15);
	v_ID number(15);
	v_AddedTaxFactor T_Commodity.AddedTaxFactor%type;--增值税率系数=AddedTax/(1+AddedTax)
	v_GageQty     number(10);
	v_CloseAddedTax_one   number(15,2); --交收盈亏增值税
	v_CloseAddedTax         number(15,2):=0;        --交收盈亏增值税累加
	v_unCloseQty     number(10):=p_HoldQty; --未平数量，用于中间计算
	v_unCloseQtyGage     number(10):=p_GageQty; --未平数量，用于中间计算
	v_tradedAmount   number(10):=0;  --成交数量
	v_tradedAmountGage   number(10):=0;  --成交数量
	v_CloseAlgr           number(2);
	v_num            number(10);
	v_Balance    number(15,2);
	v_F_FrozenFunds   number(15,2);
	type cur_T_HoldPosition is ref cursor;
	v_HoldPosition cur_T_HoldPosition;
	v_sql varchar2(500);
	v_orderby  varchar2(100);
	v_closeTodayHis        number(2);    --平今仓还是历史仓(0平今仓；1平历史仓)
	v_YesterBalancePrice    number(15,2);
	v_AtClearDate          date;
	v_LowestSettleFee             number(15,2) default 0;
	v_GageMode number(2);--抵顶模式，分0全抵顶和1半抵顶，半抵顶时要计算浮亏，2009-10-14
begin
		v_CustomerID := p_CustomerID;
	    v_CommodityID := p_CommodityID;
        v_BS_Flag := p_BS_Flag;
        --锁住交易客户持仓合计，以防止并发更新
        select HoldQty,FrozenQty,GageQty
        into v_HoldSumQty, v_frozenQty,v_GageQty
        from T_CustomerHoldSum
        where CustomerID = v_CustomerID
          and CommodityID = v_CommodityID
          and bs_flag = v_BS_Flag for update;
        --可交收持仓数量不足
        if(p_HoldQty > v_HoldSumQty-v_frozenQty) then
            rollback;
            return -1;
        end if;
        --可交收抵顶数量不足
        if(p_GageQty > v_GageQty) then
            rollback;
            return -2;
        end if;
        --获取平仓算法,抵顶模式，保证金计算类型，增值税，合约因子
        select CloseAlgr,GageMode into v_CloseAlgr,v_GageMode from T_A_Market;
        select Contractfactor,MarginPriceType,AddedTaxFactor,LastPrice,LowestSettleFee
        into v_ContractFactor,v_MarginPriceType,v_AddedTaxFactor,v_YesterBalancePrice,v_LowestSettleFee
        from T_Commodity where CommodityID=v_CommodityID;
	    select TradeDate into v_TradeDate from T_SystemStatus;

        --根据平仓算法(0先开先平；1后开先平；2持仓均价平仓(不排序)选择排序条件
        if(v_CloseAlgr = 0) then
	        v_orderby := ' order by a.A_HoldNo ';
	    elsif(v_CloseAlgr = 1) then
	        v_orderby := ' order by a.A_HoldNo desc ';
	    end if;

    	v_sql := 'select a.a_holdno,FirmID,price,(a.HoldQty-nvl(b.FrozenQty,0)),GageQty,nvl(b.FrozenQty,0),a.AtClearDate from T_holdposition a,(select A_HoldNo,nvl(sum(FrozenQty),0) FrozenQty from T_SpecFrozenHold group by A_HoldNo) b ' ||
                 ' where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and CustomerID=''' || v_CustomerID ||
                 ''' and CommodityID =''' || v_CommodityID || ''' and bs_flag = ' || v_BS_Flag || v_orderby;

	   		--遍历持仓明细的数量并过滤掉指定平仓冻结的数量
            open v_HoldPosition for v_sql;
            loop
                fetch v_HoldPosition into v_a_holdno, v_FirmID, v_price, v_holdqty,v_GageQty,v_frozenQty,v_AtClearDate;
                exit when v_HoldPosition%NOTFOUND;
                --如果此笔持仓全部被指定平仓冻结且没有抵顶则指向下一条记录
	            --2011-01-12 by chenxc 修改当持仓明细的持仓数量为0，抵顶数量不为0，提前交收非抵顶的会插入一条持仓记录都是0的到交收持仓明细表，反之依然
                if((v_holdqty <> 0 and v_unCloseQty>0) or (v_GageQty <> 0 and v_unCloseQtyGage>0)) then
                	--清0
	                v_tradedAmount:=0;
	                v_tradedAmountGage:=0;
	                v_Payout_one := 0;
	                --1、计算应退款项
	                if(v_holdqty > 0) then
		                if(v_holdqty<=v_unCloseQty) then
		                    v_tradedAmount:=v_holdqty;
		                else
		                    v_tradedAmount:=v_unCloseQty;
		                end if;
		                --计算应退保证金，根据设置选择开仓价还是昨结算价来算
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
		                v_Margin_one := FN_T_ComputeMargin(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount,v_MarginPrice);
		                if(v_Margin_one < 0) then
		                    Raise_application_error(-20040, 'computeMargin error');
		                end if;
				        --计算担保金
				        v_Assure_one := FN_T_ComputeAssure(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount,v_MarginPrice);
				        if(v_Assure_one < 0) then
				            Raise_application_error(-20041, 'computeAssure error');
				        end if;
				        --保证金应加上担保金
				        v_Margin_one := v_Margin_one + v_Assure_one;
		                v_Margin:=v_Margin + v_Margin_one;
		                v_Assure:=v_Assure + v_Assure_one;
			            --计算应退持仓金额，不包括抵顶的
			            v_HoldFunds := v_HoldFunds + v_tradedAmount*v_price*v_ContractFactor;
	                end if;
	                --2、计算持仓明细中交收的抵顶数量
					if(v_GageQty > 0) then
		                if(v_GageQty<=v_unCloseQtyGage) then
		                    v_tradedAmountGage:=v_GageQty;
		                else
		                    v_tradedAmountGage:=v_unCloseQtyGage;
		                end if;
	                end if;
			        --如果是半抵顶模式则交易商持仓金额要退抵顶的
			        if(v_GageMode=1) then
			        	v_HoldFunds := v_HoldFunds + v_tradedAmountGage*v_price*v_ContractFactor;
			        end if;
	                --二级客户合计金额，包括抵顶的
	                v_CustomerHoldFunds := v_CustomerHoldFunds + (v_tradedAmount+v_tradedAmountGage)*v_price*v_ContractFactor;
		            --3、计算交收款项
					--计算买方交收货款，提前交收不用收交收保证金
					if(v_BS_Flag = 1) then
				        v_Payout_one := FN_T_ComputePayout(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,p_Price);
			            if(v_Payout_one < 0) then
			                Raise_application_error(-20043, 'computePayout error');
			            end if;
		            end if;
			        --计算交收手续费
					v_Fee_one := FN_T_ComputeSettleFee(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,p_Price);
		            if(v_Fee_one < 0) then
		              Raise_application_error(-20031, 'computeFee error');
		            end if;
		            --计算税前交收盈亏
		            if(v_BS_Flag = 1) then
		                v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(p_Price-v_price)*v_contractFactor; --税前盈亏
		            else
		                v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(v_price-p_Price)*v_contractFactor; --税前盈亏
		            end if;
		            --计算交收增值税,v_AddedTaxFactor增值税系数=AddedTax/(1+AddedTax)
		            v_CloseAddedTax_one := round(v_closeFL_one*v_AddedTaxFactor,2);
		            --计算税后交收盈亏
		            v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --税后盈亏
					--累计金额
		        	v_Payout := v_Payout + v_Payout_one;
		        	v_Fee := v_Fee + v_Fee_one;
					v_CloseFL:=v_CloseFL + v_closeFL_one;  --税后盈亏合计
					v_CloseAddedTax:=v_CloseAddedTax + v_CloseAddedTax_one;  --交收增值税合计
			        --将当前持仓记录和交收费用插入交收持仓明细表，并更新持仓数量和抵顶数量为实际交收的数量
					select SEQ_T_SettleHoldPosition.nextval into v_ID from dual;
					--按字段名插入交收持仓明细表
			        insert into t_settleholdposition
  					(id, settleprocessdate, a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss, settlemargin, payout, settlefee, settle_pl, settleaddedtax, settleprice, settletype, holdtype, atcleardate)
			        select v_ID,v_TradeDate,a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss,0,v_Payout_one,v_Fee_one,v_closeFL_one,v_CloseAddedTax_one,p_Price,2, holdtype, atcleardate
			        from t_holdposition
			        where A_HoldNo=v_A_HoldNo;

			        update T_SettleHoldPosition set HoldQty=v_tradedAmount,GageQty=v_tradedAmountGage where ID=v_ID;

	                --更新持仓记录
                    update T_holdposition
                    set holdqty = holdqty - v_tradedAmount,HoldMargin=HoldMargin-v_Margin_one,HoldAssure=HoldAssure-v_Assure_one,GageQty = GageQty - v_tradedAmountGage
                    where a_holdno = v_a_holdno;

	                v_unCloseQty:=v_unCloseQty - v_tradedAmount;
	                v_unCloseQtyGage:=v_unCloseQtyGage - v_tradedAmountGage;
	                exit when v_unCloseQty=0 and v_unCloseQtyGage=0;
                end if;
            end loop;
            close v_HoldPosition;
            if(v_unCloseQty>0) then --交收持仓数量大于可交收持仓数量
                rollback;
                return -3;
            end if;
            if(v_unCloseQtyGage>0) then --交收抵顶数量大于可抵顶数量
                rollback;
                return -4;
            end if;
		--减少交易客户，交易商的持仓合计信息2009-10-15
        v_num := FN_T_SubHoldSum(p_HoldQty,p_GageQty,v_Margin,v_Assure,v_CommodityID,v_ContractFactor,v_BS_Flag,v_FirmID,v_HoldFunds,v_CustomerID,v_CustomerHoldFunds,v_GageMode,0);

		--写合计的流水
        --扣除交收货款,同时退保证金和担保金
        update T_Firm
        set runtimemargin = runtimemargin - v_Margin,
            RuntimeAssure = RuntimeAssure - v_Assure
        where Firmid = v_FirmID;
        --更新冻结资金，释放个人部分的保证金
		v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,-(v_Margin-v_Assure),'15');
        --插入扣除交收货款资金流水
		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15008',v_Payout,null,v_CommodityID,null,null);
        --更新资金,同时插入交收手续费资金流水
		--如果手续费低于最低交收手续费，则按最低交收手续费收取，并且将此交易商最后一笔明细的手续费更新成加上差额的手续费
		if(v_ID is not null) then  --表示必须是有持仓做了交收，因为不判断当没有持仓时也会收取最低交收手续费的
		    if(v_Fee >= v_LowestSettleFee) then
		        v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15010',v_Fee,null,v_CommodityID,null,null);
			else
			    v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15010',v_LowestSettleFee,null,v_CommodityID,null,null);
		        update T_SettleHoldPosition
		        set SettleFee=SettleFee+(v_LowestSettleFee-v_Fee)
		        where ID=v_ID;
		    end if;
	    end if;
		--更新资金余额，并写付交收盈利或收交收亏损流水
		if(v_CloseFL >= 0) then
			v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15011',v_CloseFL,null,v_CommodityID,v_CloseAddedTax,null);
		else
			v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15012',-v_CloseFL,null,v_CommodityID,-v_CloseAddedTax,null);
		end if;
    return 1;

end;
/


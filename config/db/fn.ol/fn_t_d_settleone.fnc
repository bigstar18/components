create or replace function FN_T_D_SettleOne(
    p_CommodityID varchar2,   --商品代码
	p_Price         number,  --交收价
	p_BS_Flag     number,  --买卖标志
    p_CustomerID    varchar2,     --交易客户ID
    p_HoldQty      number,   --交收持仓数量，即非抵顶数量
	p_GageQty      number   --交收抵顶数量，目前不支持抵顶交收
) return number
/****
 * 买卖单方向延期交收
 * 返回值
 * 1 成功
 * -3  交收持仓数量大于可交收持仓数量
 * -4  交收抵顶数量大于可抵顶数量
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_CommodityID varchar2(16);
    v_CustomerID        varchar2(40);
    v_FirmID varchar2(32);
    v_HoldQty  number;
    v_frozenQty      number(10);
    v_Margin_one         number(15,2):=0;
    v_closeFL_one         number(15,2):=0;    --一条记录的交收盈亏
    v_Fee_one         number(15,2):=0;    --一条记录的交收手续费
	v_Assure_one         number(15,2):=0;
    v_Payout_one         number(15,2):=0;
    v_BS_Flag           number(2);
    v_Price         number(15,2);
    v_ContractFactor    number(12,2);
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
	v_HoldType           number(2);
	v_HoldMargin         number(15,2);
    v_HoldAssure         number(15,2);
    v_NeutralFeeWay           number(2);
    v_SettleMargin_one     number(15,2);
	type cur_T_HoldPosition is ref cursor;
	v_HoldPosition cur_T_HoldPosition;
	v_sql varchar2(500);
	v_orderby  varchar2(100);
	v_AtClearDate          date;
	v_num            number(10);
	v_GageMode     number(2);
	v_SettleMargin     number(15,2):=0;
	v_Fee         number(15,2):=0;
	v_Payout         number(15,2):=0;
	v_Balance    number(15,2);
	v_F_FrozenFunds   number(15,2);
	v_CloseFL         number(15,2):=0;
	v_ret     number(4);
	v_RuntimeMargin       number(15,2);
  v_SettlePrice number(15,2);
  v_settlePriceType  number(2);
begin
		v_CustomerID := p_CustomerID;
	    v_CommodityID := p_CommodityID;
        v_BS_Flag := p_BS_Flag;

        --获取平仓算法,抵顶模式，保证金计算类型，增值税，合约因子
        select CloseAlgr,NeutralFeeWay,GageMode into v_CloseAlgr,v_NeutralFeeWay,v_GageMode from T_A_Market;
        select Contractfactor,AddedTaxFactor
        into v_ContractFactor,v_AddedTaxFactor
        from T_Commodity where CommodityID=v_CommodityID;
	    select TradeDate into v_TradeDate from T_SystemStatus;

          --根据交收申报类型来决定交收价格 add by  zhangjian 2011年12月13日11:04:51 start
          select DelaySettlePriceType  into v_settlePriceType from t_commodity where commodityid=p_CommodityID;
          --end by zhangjian

        --根据平仓算法(0先开先平；1后开先平；2持仓均价平仓(不排序)选择排序条件 --去掉排序算法，所有交收信息查询均按默认排序 mod by zhangjian 2011年12月12日13:47:21 start
         v_orderby := ' order by a.A_HoldNo ';
        --if(v_CloseAlgr = 0) then
	      --  v_orderby := ' order by a.A_HoldNo ';
	   -- elsif(v_CloseAlgr = 1) then
	       -- v_orderby := ' order by a.A_HoldNo desc ';
	   -- end if;
     --end by zhangjian 2011年12月12日13:47:36

    	v_sql := 'select a.a_holdno,FirmID,price,(a.HoldQty-nvl(b.FrozenQty,0)),GageQty,nvl(b.FrozenQty,0),a.AtClearDate,a.HoldType,a.HoldMargin,a.HoldAssure from T_holdposition a,(select A_HoldNo,nvl(sum(FrozenQty),0) FrozenQty from T_SpecFrozenHold group by A_HoldNo) b ' ||
                 ' where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and CustomerID=''' || v_CustomerID ||
                 ''' and CommodityID =''' || v_CommodityID || ''' and bs_flag = ' || v_BS_Flag || v_orderby;

   		--遍历持仓明细的数量并过滤掉指定平仓冻结的数量
        open v_HoldPosition for v_sql;
        loop
            fetch v_HoldPosition into v_a_holdno, v_FirmID, v_price, v_holdqty,v_GageQty,v_frozenQty,v_AtClearDate,v_HoldType,v_HoldMargin,v_HoldAssure;
            exit when v_HoldPosition%NOTFOUND;

            if(v_settlePriceType=0)then--如果按昨结算交收
                  v_SettlePrice:=p_Price;

            else --如果按订立价交收
                 v_SettlePrice:=v_Price;
            end if;
            --如果此笔持仓全部被指定平仓冻结且没有抵顶则指向下一条记录
            if(v_holdqty <> 0 or v_GageQty <> 0) then
            	--清0
                v_tradedAmount:=0;
                v_tradedAmountGage:=0;
                v_Payout_one := 0;
                v_Margin_one := 0;
	            v_Assure_one := 0;
	            v_SettleMargin_one := 0;
                --1、计算应退款项
                if(v_holdqty > 0) then
	                if(v_holdqty<=v_unCloseQty) then
	                    v_tradedAmount:=v_holdqty;
	                    v_Margin_one := v_HoldMargin;
	                    v_Assure_one := v_HoldAssure;
	                else
	                    v_tradedAmount:=v_unCloseQty;
	                    v_Margin_one := v_HoldMargin*v_tradedAmount/v_holdqty;
	                    v_Assure_one := v_HoldAssure*v_tradedAmount/v_holdqty;
	                end if;
                end if;
                --2、计算持仓明细中交收的抵顶数量
				if(v_GageQty > 0) then
	                if(v_GageQty<=v_unCloseQtyGage) then
	                    v_tradedAmountGage:=v_GageQty;
	                else
	                    v_tradedAmountGage:=v_unCloseQtyGage;
	                end if;
                end if;
     			--计算交收保证金
		        v_SettleMargin_one := FN_T_ComputeSettleMargin(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,v_SettlePrice);
	            if(v_SettleMargin_one < 0) then
	                Raise_application_error(-20042, 'ComputeSettleMargin error');
	            end if;
	            --3、计算交收款项
				--计算买方交收货款
				if(v_BS_Flag = 1) then
			        v_Payout_one := FN_T_ComputePayout(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,v_SettlePrice);
		            if(v_Payout_one < 0) then
		                Raise_application_error(-20043, 'computePayout error');
		            end if;
	            end if;
		        --计算交收手续费
		        if(v_HoldType = 2 and v_NeutralFeeWay = 0) then
		        	v_Fee_one := 0;
		        else
					v_Fee_one := FN_T_ComputeSettleFee(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,v_SettlePrice);
				end if;
	            if(v_Fee_one < 0) then
	              Raise_application_error(-20031, 'computeFee error');
	            end if;
	            --计算税前交收盈亏
	            if(v_BS_Flag = 1) then
	                v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(v_SettlePrice-v_price)*v_contractFactor; --税前盈亏
	            else
	                v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(v_Price-v_SettlePrice)*v_contractFactor; --税前盈亏
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
				v_SettleMargin := v_SettleMargin + v_SettleMargin_one;
		        --将当前持仓记录和交收费用插入交收持仓明细表，并更新持仓数量和抵顶数量为实际交收的数量
				select SEQ_T_SettleHoldPosition.nextval into v_ID from dual;
				--按字段名插入交收持仓明细表
			    insert into t_settleholdposition
  				(id, settleprocessdate, a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss, settlemargin, payout, settlefee, settle_pl, settleaddedtax, settleprice, settletype, holdtype, atcleardate)
		        select v_ID,v_TradeDate,a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss,v_SettleMargin_one,v_Payout_one,v_Fee_one,v_closeFL_one,v_CloseAddedTax_one,v_SettlePrice,3, holdtype, atcleardate
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
        --持仓合计数量的更新，不支持抵顶数量
		--更新交易客户持仓合计
        v_ret := FN_T_D_ChgCustHoldByQty(v_CustomerID,v_CommodityID,v_BS_Flag,p_HoldQty);
        --释放交易保证金
    	v_RuntimeMargin := FN_T_D_ChgFirmMarginByQty(v_FirmID,v_CommodityID,v_BS_Flag,p_HoldQty);
    	v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,-v_RuntimeMargin,'15');
    	--更新交易商持仓合计
		v_ret := FN_T_D_ChgFirmHoldByQty(v_FirmID,v_CommodityID,v_BS_Flag,p_HoldQty,v_GageMode);
        --扣除交收货款，交收手续费，付交收盈利或收交收亏损,交收保证金 ，并写流水
		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15008',v_Payout,null,v_CommodityID,null,null);
		--注意这里不能按最低交收手续费收取，因为实时撮合，实时更新明细持仓，所以按实际手续费收取
	    v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15010',v_Fee,null,v_CommodityID,null,null);
		if(v_CloseFL >= 0) then
			v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15011',v_CloseFL,null,v_CommodityID,v_CloseAddedTax,null);
		else
			v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15012',-v_CloseFL,null,v_CommodityID,-v_CloseAddedTax,null);
		end if;
		update T_Firm set RuntimeSettleMargin=RuntimeSettleMargin+v_SettleMargin where FirmID=v_FirmID;
		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15013',v_SettleMargin,null,v_CommodityID,null,null);
    return 1;

end;
/


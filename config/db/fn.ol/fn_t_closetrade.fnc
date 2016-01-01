create or replace function FN_T_CloseTrade(
    p_A_OrderNo     number,  --委托单号
    p_M_TradeNo     number,  --撮合成交号
    p_Price         number,  --成交价
    p_Quantity      number,   --成交数量
    p_M_TradeNo_Opp     number,  --对方撮合成交号
    p_CommodityID varchar2,
    p_FirmID     varchar2,
    p_TraderID       varchar2,
    p_bs_flag        number,
    p_status         number,
    p_orderQty       number,--委托数量
    p_orderTradeQty       number,--委托已成交数量
    p_CustomerID        varchar2,
    p_OrderType      number,
    p_closeMode      number,
    p_specPrice      number,
    p_timeFlag       number,
    p_CloseFlag      number,
    p_contractFactor number,
    p_MarginPriceType         number,     --计算成交保证金结算价类型 0:实时和闭市时都按开仓价；1:实时按昨结算价，闭市按当日结算价;2:盘中按订立价，闭市结算时按当日结算价;
    p_marginAlgr         number,
    p_marginRate_b         number,
    p_marginRate_s         number,
    p_marginAssure_b         number,
    p_marginAssure_s         number,
    p_feeAlgr       number,
    p_feeRate_b         number,
    p_feeRate_s         number,
    p_TodayCloseFeeRate_B         number,
    p_TodayCloseFeeRate_S         number,
    p_HistoryCloseFeeRate_B         number,
    p_HistoryCloseFeeRate_S         number,
    p_ForceCloseFeeAlgr       number,
    p_ForceCloseFeeRate_B         number,
    p_ForceCloseFeeRate_S         number,
    p_YesterBalancePrice    number,
    p_AddedTaxFactor          number,  --增值税率系数=AddedTax/(1+AddedTax)
    p_GageMode    number,
    p_CloseAlgr    number,
    p_TradeDate date,
    p_FirmID_opp     varchar2   --对手交易商ID
) return number
/****
 * 平仓成交回报
 * 1、注意不要提交commit，因为别的函数要调用它；
 * 返回值
 * 1 成功
 * -1 成交数量大于未成交数量
 * -2 成交数量大于冻结数量
 * -3 平仓成交数量大于持仓数量
 * -100 其它错误
****/
as
    v_version varchar2(10):='1.0.2.2';
    v_price          number(15,2);
    v_frozenQty      number(10);
    v_holdQty        number(10);
    v_a_tradeno_closed number(15);
    v_Margin         number(15,2):=0;   --应收保证金
    v_Assure         number(15,2):=0;   --应收担保金
    v_Fee            number(15,2):=0;   --应收费用
    v_Fee_one            number(15,2);   --应收费用
    v_A_TradeNo      number(15);
    v_A_HoldNo       number(15);
    v_id             number(15);
    v_tmp_bs_flag    number(2);
    v_TradeType      number(1);
    v_AtClearDate          date;
    v_HoldTime          date;
    v_MarginPrice    number(15,2);  --计算成交保证金的价格
    v_HoldFunds    number(15,2):=0;  --平仓时应退持仓金额
    v_unCloseQty     number(10):=p_quantity; --未平数量，用于中间计算
    v_closeFL    number(15,2):=0;
    v_closeFL_one    number(15,2);   --单笔平仓盈亏，用于中间计算
    v_CloseAddedTax_one    number(15,2);   --单笔平仓增值税
    v_margin_one     number(15,2);   --用于中间计算
    v_Assure_one     number(15,2);   --用于中间计算
    v_tradedAmount   number(10):=0;  --成交数量
    v_GageQty       number(10);
    v_GageQty_fsum       number(10);
    v_F_FrozenFunds   number(15,2);
    type c_T_HoldPosition is ref cursor;
    v_T_HoldPosition c_T_HoldPosition;
    v_sql varchar2(500);
    v_str  varchar2(200);
    v_orderby  varchar2(100);
    v_closeTodayHis        number(2);    --平今仓还是历史仓(0平今仓；1平历史仓)
    v_num            number(10);
    v_holddaysLimit number(1):=0;
begin
      if(p_TraderID is not null) then
          v_TradeType := 1;  --有交易员为正常交易（开，平仓）
      else
        if(p_CloseFlag = 2) then
          v_TradeType := 3;  --交易员为空且平仓标志为2表示市场强平
        else
          v_TradeType := 4;  --否则有交易员的表示委托交易（开，平仓）
        end if;
      end if;

        if(p_bs_flag=1) then  --委托平仓的买卖标志
            v_tmp_bs_flag:=2; --相当于被平仓的买卖标志
        else
            v_tmp_bs_flag:=1;
        end if;
        select frozenqty
        into v_frozenQty
        from T_CustomerHoldSum
        where CustomerID = p_CustomerID
          and CommodityID = p_CommodityID
          and bs_flag = v_tmp_bs_flag for update;
        if(v_frozenqty <p_quantity) then
            rollback;
            return -2;
        end if;

		--指定平仓查询条件
        if(p_closeMode = 2) then  --指定时间平仓
            if(p_timeFlag = 1) then  --平今仓
		            --从持仓明细表获得该交易客户当日该商品持仓合计
		            v_str := ' and to_char(AtClearDate,''yyyy-MM-dd'')=''' || to_char(p_TradeDate,'yyyy-MM-dd') || ''' ';
	        elsif(p_timeFlag = 2) then  --平历史仓
	                --从持仓明细表获得该交易客户非当日该商品持仓合计
	                v_str := ' and to_char(AtClearDate,''yyyy-MM-dd'')<>''' || to_char(p_TradeDate,'yyyy-MM-dd') || ''' ';
	        end if;
        elsif(p_closeMode = 3) then  --指定价格平仓
            v_str := ' and Price =' || p_specPrice || ' ';
        end if;
        --根据平仓算法(0先开先平；1后开先平；2持仓均价平仓(不排序)选择排序条件
		--2009-08-04增加强平时按后开先平顺序
		if(p_TraderID is null and p_CloseFlag = 2) then
			--v_orderby := ' order by a.A_HoldNo desc ';
             select holddayslimit into v_holddaysLimit from t_commodity where commodityid=p_CommodityID;
             if(v_holddaysLimit=0) then   --无持仓天数限制
               v_orderby := ' order by a.A_HoldNo desc ';
             else
               v_orderby := ' order by a.A_HoldNo asc ';
             end if;
        else
	        if(p_CloseAlgr = 0) then
		        v_orderby := ' order by a.A_HoldNo ';
		    elsif(p_CloseAlgr = 1) then
		        v_orderby := ' order by a.A_HoldNo desc ';
		    end if;
	    end if;
	    v_str := v_str || v_orderby;

          if(p_Quantity = p_orderQty - p_orderTradeQty) then
            --更新委托
            update T_Orders
            set tradeqty=tradeqty + p_Quantity,
                Status=3,UpdateTime=systimestamp(3)
            where A_orderNo = p_A_OrderNo;
          elsif(p_Quantity < p_orderQty - p_orderTradeQty) then
            --更新委托
			if(p_status = 6) then  --状态为部分成交后撤单，如果部分成交回报在撤单回报之后，不用再更新状态了
	            update T_Orders
	            set tradeqty=tradeqty + p_Quantity,UpdateTime=systimestamp(3)
	            where A_orderNo = p_A_OrderNo;
			else
	            update T_Orders
	            set tradeqty=tradeqty + p_Quantity,Status=2,UpdateTime=systimestamp(3)
	            where A_orderNo = p_A_OrderNo;
			end if;
          else
            rollback;
            return -1;
          end if;

            --不指定平仓平持仓记录时以持仓明细表为主，而指定平仓时以当日指定平仓冻结表为主
            if(p_closeMode = 1) then --不指定平仓
	            --遍历持仓明细的数量并过滤掉指定平仓冻结的数量,此平仓没用到b.ID，因为b中没有它，所以用0替换
	            v_sql := 'select a.a_holdno,a_tradeno,price,(a.HoldQty-nvl(b.FrozenQty,0)),GageQty,HoldTime,AtClearDate,nvl(b.FrozenQty,0),0 from T_holdposition a,(select A_HoldNo,nvl(sum(FrozenQty),0) FrozenQty from T_SpecFrozenHold group by A_HoldNo) b ' ||
	                     ' where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and nvl(b.FrozenQty,0)<a.HoldQty and CustomerID=''' || p_CustomerID ||
	                     ''' and CommodityID =''' || p_CommodityID || ''' and bs_flag = ' || v_tmp_bs_flag || v_str;
			else  --指定平仓
	            v_sql := 'select a.a_holdno,a_tradeno,price,HoldQty,GageQty,HoldTime,AtClearDate,nvl(b.FrozenQty,0),b.ID from T_holdposition a,T_SpecFrozenHold b ' ||
	                     ' where (a.HoldQty+a.GageQty) > 0 and b.A_HoldNo=a.A_HoldNo(+) and b.A_OrderNo= ' || p_A_OrderNo || v_str;
			end if;
            open v_T_HoldPosition for v_sql;
            loop
                fetch v_T_HoldPosition into v_a_holdno, v_a_tradeno_closed, v_price, v_holdqty,v_GageQty,v_HoldTime,v_AtClearDate,v_frozenQty,v_id;
                exit when v_T_HoldPosition%NOTFOUND;
                if(p_closeMode = 1) then --不指定平仓
	                if(v_holdqty<=v_unCloseQty) then
	                    v_tradedAmount:=v_holdqty;
	                else
	                    v_tradedAmount:=v_unCloseQty;
	                end if;
                else  --指定平仓
	                if(v_frozenQty<=v_unCloseQty) then
	                    v_tradedAmount:=v_frozenQty;
	                    delete from T_SpecFrozenHold where id=v_id;
	                else
	                    v_tradedAmount:=v_unCloseQty;
	                    update T_SpecFrozenHold set FrozenQty=FrozenQty-v_tradedAmount where id=v_id;
	                end if;
				end if;
				--判断是平今仓还是平历史仓
			    if(trunc(p_TradeDate) = trunc(v_AtClearDate)) then
			        v_closeTodayHis := 0;
			    else
			    	v_closeTodayHis := 1;
			    end if;
		        --计算成交后应扣除的手续费
				if(v_TradeType = 3) then  --强平
					v_Fee_one := FN_T_ComputeFeeByArgs(p_bs_flag,v_tradedAmount,p_Price,p_contractFactor,p_ForceCloseFeeAlgr,p_ForceCloseFeeRate_B,p_ForceCloseFeeRate_S);
				else  --其它，如果平的是今天开的仓则按今开今平手续费计算
					if(v_closeTodayHis = 0) then  --平今仓
						v_Fee_one := FN_T_ComputeFeeByArgs(p_bs_flag,v_tradedAmount,p_Price,p_contractFactor,p_feeAlgr,p_TodayCloseFeeRate_B,p_TodayCloseFeeRate_S);
					else  --平历史仓
				        v_Fee_one := FN_T_ComputeFeeByArgs(p_bs_flag,v_tradedAmount,p_Price,p_contractFactor,p_feeAlgr,p_HistoryCloseFeeRate_B,p_HistoryCloseFeeRate_S);
				    end if;
			    end if;
                if(v_Fee_one < 0) then
                  Raise_application_error(-20030, 'computeFee error');
                end if;
                --计算应退保证金，根据设置选择开仓价还是昨结算价来算
				if(p_MarginPriceType = 1) then
			        v_MarginPrice := p_YesterBalancePrice;
			    elsif(p_MarginPriceType = 2) then
					if(v_closeTodayHis = 0) then  --平今仓
						v_MarginPrice := v_price;
					else  --平历史仓
				        v_MarginPrice := p_YesterBalancePrice;
				    end if;
				else  -- default type is 0
					v_MarginPrice := v_price;
				end if;
                v_Margin_one := FN_T_ComputeMarginByArgs(v_tmp_bs_flag,v_tradedAmount,v_MarginPrice,p_contractFactor,p_marginAlgr,p_marginRate_b,p_marginRate_s);
                if(v_Margin_one < 0) then
                    Raise_application_error(-20040, 'computeMargin error');
                end if;
		        --计算担保金
		        v_Assure_one := FN_T_ComputeAssureByArgs(v_tmp_bs_flag,v_tradedAmount,v_MarginPrice,p_contractFactor,p_marginAlgr,p_marginAssure_b,p_marginAssure_s);
		        if(v_Assure_one < 0) then
		            Raise_application_error(-20040, 'computeAssure error');
		        end if;
		        --保证金应加上担保金
		        v_Margin_one := v_Margin_one + v_Assure_one;

	            --计算应退持仓金额
	            v_HoldFunds := v_HoldFunds + v_tradedAmount*v_price*p_contractFactor;
                --计算平仓盈亏
                if(v_tmp_bs_flag=1) then  --v_tmp_bs_flag是持仓的买卖标志
                    v_closeFL_one := v_tradedAmount*(p_price-v_price)*p_contractFactor; --税前盈亏
                else
                    v_closeFL_one := v_tradedAmount*(v_price-p_price)*p_contractFactor; --税前盈亏
                end if;
	            --计算平仓增值税,v_AddedTaxFactor增值税系数=AddedTax/(1+AddedTax)
	            v_CloseAddedTax_one := round(v_closeFL_one*p_AddedTaxFactor,2);
                v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --税后盈亏
				--调用计算函数修改成交单号 2011-2-15 by feijl
                select FN_T_ComputeTradeNo(SEQ_T_Trade.nextval) into v_A_TradeNo from dual;
                 insert into T_Trade
                  (a_tradeno, m_tradeno, a_orderno, a_tradeno_closed,tradetime, Firmid, CommodityID, bs_flag, ordertype, price, quantity, close_pl, tradefee,TradeType,HoldPrice,HoldTime,CustomerID,CloseAddedTax,M_TradeNo_Opp,AtClearDate,TradeAtClearDate,oppFirmid)
                values
                  (v_A_TradeNo, p_M_TradeNo, p_A_OrderNo, v_a_tradeno_closed, sysdate, p_Firmid, p_CommodityID,p_bs_flag, p_ordertype, p_price, v_tradedAmount, v_closeFL_one, v_Fee_one,v_TradeType,v_price,v_HoldTime,p_CustomerID,v_CloseAddedTax_one,p_M_TradeNo_Opp,v_AtClearDate,p_TradeDate,p_FirmID_opp);

                --更新持仓记录
                update T_holdposition
                set holdqty = holdqty - v_tradedAmount,HoldMargin=HoldMargin-v_Margin_one,HoldAssure=HoldAssure-v_Assure_one
                where a_holdno = v_a_holdno;
                v_unCloseQty:=v_unCloseQty - v_tradedAmount;

                v_Margin:=v_Margin + v_Margin_one;
                v_Assure:=v_Assure + v_Assure_one;
                v_Fee:=v_Fee + v_Fee_one;
                v_closeFL:=v_closeFL + v_closeFL_one;

                exit when v_unCloseQty=0;
            end loop;
            close v_T_HoldPosition;
            if(v_unCloseQty>0) then --成交数量大于持仓数量，出错
                rollback;
                return -3;
            end if;

        --减少交易客户，交易商的持仓合计信息2009-10-15
        v_num := FN_T_SubHoldSum(p_quantity,0,v_Margin,v_Assure,p_CommodityID,p_contractFactor,v_tmp_bs_flag,p_FirmID,v_HoldFunds,p_CustomerID,v_HoldFunds,p_GageMode,p_quantity);

        --更新临时保证金和临时担保金
        update T_Firm
        set runtimemargin = runtimemargin - v_Margin,
		    RuntimeAssure = RuntimeAssure - v_Assure
        where Firmid = p_FirmID;
        --更新冻结资金，释放个人部分的保证金
		v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,-(v_Margin-v_Assure)+v_Fee-v_closeFL,'15');
    return 1;

end;
/


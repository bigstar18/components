create or replace function FN_T_ConferCloseOne(
    p_CommodityID    varchar2,   --商品代码
    p_Price          number,     --平仓价
    p_BS_Flag        number,     --买卖标志
    p_CustomerID     varchar2,   --交易客户ID
    p_OppCustomerID  varchar2,   --对方交易客户ID
    p_HoldQty        number,     --平仓持仓数量，即非抵顶数量
    p_GageQty        number default 0,   --平仓抵顶数量，业务上不支持，如果要协议平仓抵顶的要先做抵顶转提前交收
    p_M_TradeNo      number,     --撮合成交号
    p_M_TradeNo_Opp  number      --对方撮合成交号
) return number
/****
 * 买卖单方向协议平仓
 * 1、注意不要提交commit，因为别的函数要调用它；
 * 返回值
 * 1 成功
 * -1  可平仓持仓数量不足
 * -2  可平仓抵顶数量不足
 * -3  平仓持仓数量大于可平仓持仓数量
 * -4  平仓抵顶数量大于可抵顶数量
 * -100 其它错误
****/
as
    v_version        varchar2(10):='1.0.2.1';
    v_CommodityID    varchar2(16);
    v_CustomerID     varchar2(40);
    v_FirmID         varchar2(32);
    v_OppFirmid      varchar2(32);     --对手交易商代码
    v_HoldQty        number;
    v_HoldSumQty     number(10);
    v_frozenQty      number(10);
    v_Margin         number(15,2):=0;
    v_Margin_one     number(15,2):=0;
    v_closeFL        number(15,2):=0;
    v_closeFL_one    number(15,2):=0;    --一条记录的交收盈亏
    v_Fee            number(15,2):=0;   --应收费用
    v_Fee_one        number(15,2):=0;    --一条记录的交收手续费
    v_Assure         number(15,2):=0;
    v_Assure_one     number(15,2):=0;
    v_BS_Flag        number(2);
    v_Price          number(15,2);
    v_ContractFactor  number(12,2);
    v_MarginPriceType number(1);
    v_MarginPrice     number(15,2);  --计算成交保证金的价格
    v_HoldFunds       number(15,2):=0;  --平仓时应退持仓金额，不包括抵顶的
    v_CustomerHoldFunds    number(15,2):=0;  --平仓时应退持仓金额，包括抵顶的
    v_TradeDate            date;
    v_A_HoldNo       number(15);
    v_A_TradeNo      number(15);
    v_a_tradeno_closed     number(15);
    v_AddedTaxFactor T_Commodity.AddedTaxFactor%type;--增值税率系数=AddedTax/(1+AddedTax)
    v_GageQty        number(10);
          v_GageFrozenQty number(10);--add by zhaodc 20140804 抵顶冻结数量
    v_CloseAddedTax_one    number(15,2); --交收盈亏增值税
    v_unCloseQty     number(10):=p_HoldQty; --未平数量，用于中间计算
    v_unCloseQtyGage       number(10):=p_GageQty; --未平数量，用于中间计算
    v_tradedAmount   number(10):=0;  --成交数量
    v_tradedAmountGage     number(10):=0;  --成交数量
    v_CloseAlgr      number(2);
    v_Balance        number(15,2);
    v_F_FrozenFunds  number(15,2);
    v_AtClearDate    date;
    v_HoldTime       date;
    v_tmp_bs_flag    number(2);
    type c_HoldPosition is ref cursor;
      v_HoldPosition c_HoldPosition;
    v_sql varchar2(500);
    v_orderby  varchar2(100);
    v_closeTodayHis         number(2);    --平今仓还是历史仓(0平今仓；1平历史仓)
    v_YesterBalancePrice    number(15,2);
    v_GageMode       number(2);--抵顶模式，分0全抵顶和1半抵顶，半抵顶时要计算浮亏，2009-10-14
    v_num            number(10);
    v_TaxInclusive     number(1);   --商品是否含税 0含税  1不含税   xiefei 20150730
begin
      v_CustomerID := p_CustomerID;
      v_CommodityID := p_CommodityID;
      v_BS_Flag := p_BS_Flag;

      --获取对手交易商ID
      select firmid into v_OppFirmid from t_customer where customerid = p_OppCustomerID;

      if(v_BS_Flag=1) then  --持仓的买卖标志
          v_tmp_bs_flag:=2; --相当于委托平仓的买卖标志
      else
          v_tmp_bs_flag:=1;
      end if;
      --锁住交易客户持仓合计，以防止并发更新
      begin
        select HoldQty,FrozenQty,GageQty,GageFrozenQty
        into v_HoldSumQty, v_frozenQty,v_GageQty,v_GageFrozenQty
        from T_CustomerHoldSum
        where CustomerID = v_CustomerID
          and CommodityID = v_CommodityID
          and bs_flag = v_BS_Flag for update;
      exception
          when NO_DATA_FOUND then
          return -15;--没有找到对应的持仓记录
      end;

      /*--可平仓持仓数量不足
      if(p_HoldQty > v_HoldSumQty-v_frozenQty) then
          rollback;
          return -1;
      end if;

      --可平仓抵顶数量不足
      if(p_GageQty > v_GageQty) then
          rollback;
          return -2;
      end if;*/

      --可平仓持仓数量不足
      if(p_HoldQty > v_frozenQty) then
          rollback;
          return -1;
      end if;

      --可平仓抵顶数量不足
      if(p_GageQty > v_GageFrozenQty) then
          rollback;
          return -2;
      end if;

      --获取平仓算法,抵顶模式
      select CloseAlgr,GageMode into v_CloseAlgr,v_GageMode from T_A_Market;

/*
   select Contractfactor,MarginPriceType,AddedTaxFactor,LastPrice
        into v_ContractFactor,v_MarginPriceType,v_AddedTaxFactor,v_YesterBalancePrice   xief 20150730*/

        ----增加是否含税
   select Contractfactor,MarginPriceType,AddedTaxFactor,LastPrice,TaxInclusive
        into v_ContractFactor,v_MarginPriceType,v_AddedTaxFactor,v_YesterBalancePrice,v_TaxInclusive

        from T_Commodity where CommodityID=v_CommodityID;
      select TradeDate into v_TradeDate from T_SystemStatus;

      --根据平仓算法(0先开先平；1后开先平；2持仓均价平仓(不排序)选择排序条件
      if(v_CloseAlgr = 0) then
          v_orderby := ' order by a.A_HoldNo ';
      elsif(v_CloseAlgr = 1) then
          v_orderby := ' order by a.A_HoldNo desc ';
      end if;

      v_sql := 'select a.a_holdno,FirmID,price,(a.HoldQty-nvl(b.FrozenQty,0)),GageQty,HoldTime,AtClearDate,a_tradeno,nvl(b.FrozenQty,0) from T_holdposition a,(select A_HoldNo,nvl(sum(FrozenQty),0) FrozenQty from T_SpecFrozenHold group by A_HoldNo) b ' ||
                 ' where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and CustomerID=''' || v_CustomerID ||
                 ''' and CommodityID =''' || v_CommodityID || ''' and bs_flag = ' || v_BS_Flag || v_orderby;
      --遍历持仓明细的数量并过滤掉指定平仓冻结的数量
      open v_HoldPosition for v_sql;
          loop
              fetch v_HoldPosition into v_a_holdno, v_FirmID, v_price, v_holdqty,v_GageQty,v_HoldTime,v_AtClearDate,v_a_tradeno_closed,v_frozenQty;
                exit when v_HoldPosition%NOTFOUND;
                --如果此笔持仓全部被指定平仓冻结且没有抵顶则指向下一条记录
                if(v_holdqty <> 0 or v_GageQty <> 0) then
                    v_tradedAmount:=0;
                    v_tradedAmountGage:=0;
                    v_Margin_one:=0;
                    v_Assure_one:=0;
                    --判断是平今仓还是平历史仓
                    if(trunc(v_TradeDate) = trunc(v_AtClearDate)) then
                        v_closeTodayHis := 0;
                    else
                        v_closeTodayHis := 1;
                    end if;

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

                    --2、计算持仓明细中平仓的抵顶数量
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

                    --3、计算平仓款项
                    --计算平仓手续费
                    if(v_closeTodayHis = 0) then  --平今仓
                        v_Fee_one := FN_T_ComputeTodayCloseFee(v_FirmID,v_CommodityID,v_tmp_bs_flag,v_tradedAmount+v_tradedAmountGage,p_Price);
                    else  --平历史仓
                        v_Fee_one := FN_T_ComputeHistoryCloseFee(v_FirmID,v_CommodityID,v_tmp_bs_flag,v_tradedAmount+v_tradedAmountGage,p_Price);
                    end if;
                    if(v_Fee_one < 0) then
                        Raise_application_error(-20030, 'computeFee error');
                    end if;
                    --计算税前平仓盈亏
                    if(v_BS_Flag = 1) then
                        v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(p_Price-v_price)*v_contractFactor; --税前盈亏
                    else
                        v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(v_price-p_Price)*v_contractFactor; --税前盈亏
                    end if;

                   --计算平仓增值税,v_AddedTaxFactor增值税系数=AddedTax/(1+AddedTax)  xief 20158011
                   -- v_CloseAddedTax_one := round(v_closeFL_one*v_AddedTaxFactor,2);
                      v_CloseAddedTax_one := 0;


                   --计算税后的平仓盈亏 xief 20150730   xief 20150811
                 /*   if(v_TaxInclusive=1) then
                           --不含税 扣除增值税
                           v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --税后盈亏
                    end if;
                   */
                   /* --计算税后平仓盈亏
                    v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --税后盈亏  xief   20150730*/

                    --调用计算函数修改成交单号 2011-2-15 by feijl
                    select FN_T_ComputeTradeNo(SEQ_T_Trade.nextval) into v_A_TradeNo from dual;
                    insert into T_Trade
                      (a_tradeno, m_tradeno, a_orderno, a_tradeno_closed,tradetime, Firmid, CommodityID,         bs_flag,       ordertype, price, quantity,                             close_pl,     tradefee,TradeType,HoldPrice,HoldTime,CustomerID,CloseAddedTax,M_TradeNo_Opp,AtClearDate,TradeAtClearDate,OppFirmID)
                    values
                      (v_A_TradeNo,p_M_TradeNo, null, v_a_tradeno_closed, sysdate, v_Firmid, v_CommodityID,v_tmp_bs_flag, 2,    p_Price, v_tradedAmount+v_tradedAmountGage, v_closeFL_one,v_Fee_one,    6,     v_price,v_HoldTime,v_CustomerID,v_CloseAddedTax_one,p_M_TradeNo_Opp,v_AtClearDate,v_TradeDate,v_OppFirmid);

                    --更新持仓记录
                    update T_holdposition
                    set holdqty = holdqty - v_tradedAmount,HoldMargin=HoldMargin-v_Margin_one,HoldAssure=HoldAssure-v_Assure_one,GageQty = GageQty - v_tradedAmountGage
                    where a_holdno = v_a_holdno;

                    v_unCloseQty:=v_unCloseQty - v_tradedAmount;
                    v_unCloseQtyGage:=v_unCloseQtyGage - v_tradedAmountGage;

                    v_Fee:=v_Fee + v_Fee_one;
                     v_closeFL:=v_closeFL + v_closeFL_one;

                  exit when v_unCloseQty=0 and v_unCloseQtyGage=0;
                end if;
            end loop;
            close v_HoldPosition;
            if(v_unCloseQty>0) then --平仓持仓数量大于可平仓持仓数量
                rollback;
                return -3;
            end if;
            if(v_unCloseQtyGage>0) then --平仓抵顶数量大于可抵顶数量
                rollback;
                return -4;
            end if;

            --减少交易客户，交易商的持仓合计信息2009-10-15
            v_num := FN_T_SubHoldSum(p_HoldQty,p_GageQty,v_Margin,v_Assure,v_CommodityID,v_ContractFactor,v_BS_Flag,v_FirmID,v_HoldFunds,v_CustomerID,v_CustomerHoldFunds,v_GageMode,p_HoldQty);

            --更新临时保证金和临时担保金
            update T_Firm
               set runtimemargin = runtimemargin - v_Margin,
                   RuntimeAssure = RuntimeAssure - v_Assure
             where Firmid = v_FirmID;
            --更新冻结资金，释放个人部分的保证金
            v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,-(v_Margin-v_Assure)+v_Fee-v_closeFL,'15');
    return 1;

end;
/


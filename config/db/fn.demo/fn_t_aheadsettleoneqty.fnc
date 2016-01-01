create or replace function FN_T_AheadSettleOneQty(
  p_ApplyID   varchar2,    --交收配对编号
  p_CommodityID varchar2,   --商品代码
  p_Price         number,  --交收价
  p_BS_Flag     number,  --买卖标志
    p_CustomerID    varchar2,     --交易客户ID
    p_OCustomerID    varchar2,     --对方交易客户ID
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

  v_GageFrozenQty number(10);--add by yukx 20100428 抵顶冻结数量

  v_IsChargeMargin number(2);-- 是否收取交收保证金(0 不收取，1收取)  add by zhangjian- 20110713
  v_SettlementMargin_one     number(15,2):=0;-- 交收保证金
  v_SettlementMargin     number(15,2):=0;-- 交收保证金累加
  v_aheadSettlePriceType number(2);--提前交收价格类型 0:按订立价交收 1：按自主价交收
  v_settlePrice number(15,2);--交收价格
  v_settleMachID number(10):=0;--交收持仓明细表 ID
  v_totalRef         number(15,2):=0;  --基准货款的总值
  v_bFirmID   varchar2(32);  --买方交易商ID
  v_SettlementMargin_B      number(15,2):=0; --买方交收保证金
  v_settlePirce_B    number(15,6):=0;--买方交收价格
  v_bPayout         number(15,2):=0; --买方货款
   v_TaxInclusive     number(1);   --商品是否含税 0含税  1不含税   duanbaodi 20150730
begin
    v_CustomerID := p_CustomerID;
      v_CommodityID := p_CommodityID;
        v_BS_Flag := p_BS_Flag;
        --锁住交易客户持仓合计，以防止并发更新
        select HoldQty,FrozenQty,GageQty,GageFrozenQty
        into v_HoldSumQty, v_frozenQty,v_GageQty,v_GageFrozenQty
        from T_CustomerHoldSum
        where CustomerID = v_CustomerID
          and CommodityID = v_CommodityID
          and bs_flag = v_BS_Flag for update;
        /*  可交收持仓数量不足和可交收抵顶数量不足的判断用冻结数量和抵顶冻结数量判断
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
        */
        --可交收持仓数量不足
        if(p_HoldQty > v_frozenQty) then
            rollback;
            return -1;
        end if;
        --可交收抵顶数量不足
        if(p_GageQty > v_GageFrozenQty) then
            rollback;
            return -2;
        end if;
         --select   seq_T_SettleMatch.nextVal into v_settleMachNumber from dual;
         --v_settleMachNumber:=p_settleMachNumber;

        --获取平仓算法,抵顶模式,是否收取交收保证金 , 保证金计算类型，增值税，合约因子,是否含税
        select CloseAlgr,GageMode,ASMarginType into v_CloseAlgr,v_GageMode,v_IsChargeMargin from T_A_Market;
       /* select Contractfactor,MarginPriceType,AddedTaxFactor,LastPrice,LowestSettleFee
        into v_ContractFactor,v_MarginPriceType,v_AddedTaxFactor,v_YesterBalancePrice,v_LowestSettleFee
        from T_Commodity where CommodityID=v_CommodityID;   duanbaodi 20150730 */

         select Contractfactor,MarginPriceType,AddedTaxFactor,LastPrice,LowestSettleFee,TaxInclusive
        into v_ContractFactor,v_MarginPriceType,v_AddedTaxFactor,v_YesterBalancePrice,v_LowestSettleFee,v_TaxInclusive
        from T_Commodity where CommodityID=v_CommodityID;  -- 增加 是否含税字段查询 duanbaodi 20150730

      select TradeDate into v_TradeDate from T_SystemStatus;

        --根据平仓算法(0先开先平；1后开先平；2持仓均价平仓(不排序)选择排序条件
        if(v_CloseAlgr = 0) then
         v_orderby := ' order by a.A_HoldNo ';
        elsif(v_CloseAlgr = 1) then
           v_orderby := ' order by a.A_HoldNo desc ';
       end if;

         select  aheadSettlePriceType  into v_aheadSettlePriceType from t_commodity  where commodityid=p_CommodityID;--获取提前交收交收价格类型


      v_sql := 'select  a.a_holdno,FirmID,price,(a.HoldQty-nvl(b.FrozenQty,0)),GageQty,nvl(b.FrozenQty,0),a.AtClearDate from T_holdposition a,(select A_HoldNo,nvl(sum(FrozenQty),0) FrozenQty from T_SpecFrozenHold group by A_HoldNo) b ' ||
                 ' where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and CustomerID=''' || v_CustomerID ||
                 ''' and CommodityID =''' || v_CommodityID || ''' and bs_flag = ' || v_BS_Flag || v_orderby;


         --遍历持仓明细的数量并过滤掉指定平仓冻结的数量
            open v_HoldPosition for v_sql;
            loop
                fetch v_HoldPosition into v_a_holdno, v_FirmID, v_price, v_holdqty,v_GageQty,v_frozenQty,v_AtClearDate;
                exit when v_HoldPosition%NOTFOUND;

                if(v_aheadSettlePriceType=0)then --如果按订立价交收
                      v_settlePrice:=v_Price;
                      else                   --如果按自主价交收
                       v_settlePrice:=p_Price;
                      end  if;

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

         --根据市场参数设置来决定是否收取交收保证金 ---add by zhangjian start
         if(v_IsChargeMargin = 1 )then  --如果收取保证金
          --计算交收保证金
          v_SettlementMargin_one := FN_T_ComputeSettleMargin(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,v_settlePrice);
            if(v_SettlementMargin_one < 0) then
                Raise_application_error(-20042, 'ComputeSettleMargin error');
            end if;
         end if;   --add by zhangjian end


          --计算买方交收货款，提前交收不用收交收保证金
          if(v_BS_Flag = 1) then
                v_Payout_one := FN_T_ComputePayout(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,v_settlePrice);
                  if(v_Payout_one < 0) then
                      Raise_application_error(-20043, 'computePayout error');
                  end if;
          end if;
          --计算交收手续费
          v_Fee_one := FN_T_ComputeSettleFee(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,v_settlePrice);
                if(v_Fee_one < 0) then
                  Raise_application_error(-20031, 'computeFee error');
                end if;
                --计算税前交收盈亏
                if(v_BS_Flag = 1) then
                    v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(v_settlePrice-v_price)*v_contractFactor; --税前盈亏
                else
                    v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(v_price-v_settlePrice)*v_contractFactor; --税前盈亏
                end if;
                --计算交收增值税,v_AddedTaxFactor增值税系数=AddedTax/(1+AddedTax)
              --  v_CloseAddedTax_one := round(v_closeFL_one*v_AddedTaxFactor,2);   xief 20150811
                  v_CloseAddedTax_one := 0;
                --计算税后交收盈亏
                --v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --税后盈亏   duanbaodi 20150730   xief 20150811
               /* if(v_TaxInclusive = 1) then
                     --不含税 扣除增值税  duanbaodi 20150730
                     v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one;
                end if ;
                */

          --累计金额
              v_Payout := v_Payout + v_Payout_one;
              v_Fee := v_Fee + v_Fee_one;
          v_CloseFL:=v_CloseFL + v_closeFL_one;  --税后盈亏合计
          v_CloseAddedTax:=v_CloseAddedTax + v_CloseAddedTax_one;  --交收增值税合计
          v_SettlementMargin:=v_SettlementMargin + v_SettlementMargin_one; --交收保证金合计 add by zhangjian
              --将当前持仓记录和交收费用插入交收持仓明细表，并更新持仓数量和抵顶数量为实际交收的数量
          select SEQ_T_SettleHoldPosition.nextval into v_ID from dual;
          --按字段名插入交收持仓明细表
              insert into t_settleholdposition
            (id, settleprocessdate, a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss, settlemargin, payout, settlefee, settle_pl, settleaddedtax, settleprice, settletype, holdtype, atcleardate, MatchQuantity ,happenMATCHQTY)
              select v_ID,v_TradeDate,a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss,v_SettlementMargin_one,v_Payout_one,v_Fee_one,v_closeFL_one,v_CloseAddedTax_one,v_settlePrice,2, holdtype, atcleardate, holdqty, v_tradedAmount
              from t_holdposition
              where A_HoldNo=v_A_HoldNo;
           --添加配对交收持仓明细表关联关系  add by zhangjian 2011年12月15日13:16:45 start

           insert into T_MatchSettleholdRelevance values (p_ApplyID,v_ID,v_tradedAmount,v_settlePrice,v_Payout_one,v_SettlementMargin_one);

           --end  by zhangjian 2011年12月15日13:16:55

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
        v_num := FN_T_SubHoldSum(p_HoldQty,p_GageQty,v_Margin,v_Assure,v_CommodityID,v_ContractFactor,v_BS_Flag,v_FirmID,v_HoldFunds,v_CustomerID,v_CustomerHoldFunds,v_GageMode,p_HoldQty);

    --写合计的流水
        --扣除交收货款和交收保证金,同时退保证金和担保金 --modify by zhangjian
        update T_Firm
        set runtimemargin = runtimemargin - v_Margin,
            RuntimeAssure = RuntimeAssure - v_Assure,
            RuntimeSettleMargin = RuntimeSettleMargin + v_SettlementMargin
        where Firmid = v_FirmID;
        --更新冻结资金，释放个人部分的保证金
    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,-(v_Margin-v_Assure),'15');
        --插入扣除交收货款资金流水
    v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15008',v_Payout,null,v_CommodityID,null,null);
        --写交收保证金流水 add by zhangjian
        if(v_IsChargeMargin = 1 )then
    v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15013',v_SettlementMargin,null,v_CommodityID,null,null);
        end if;
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
    --商品含不含税，在交易过程中均不扣税
   /* if(v_CloseFL >= 0) then
      v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15011',v_CloseFL,null,v_CommodityID,v_CloseAddedTax,null);
    else
      v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15012',-v_CloseFL,null,v_CommodityID,-v_CloseAddedTax,null);
    end if;*/
    ------xief  20150811
    if(v_CloseFL >= 0) then
      v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15011',v_CloseFL,null,v_CommodityID,null,null);
    else
      v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15012',-v_CloseFL,null,v_CommodityID,null,null);
    end if;

    --存储合并项  add  by  zhangjian  　2011年12月26日 14:52:34

    if(v_aheadSettlePriceType=0)then  --如果按订立价交收则在此处交收配对数据的插入
       select sum(m.quantity*m.price*v_ContractFactor)
       into v_totalRef
       from T_MatchSettleholdRelevance m, T_SettleHoldPosition s
       where m.settleid = s.id
       and matchid = p_ApplyID
       and bs_flag = p_BS_Flag;
       if(p_BS_Flag=1)then --如果是买 则插入新的交收配对数据

           --2.5 插入交收配对表
         insert into T_SettleMatch (MatchID,CommodityID,ContractFactor,Quantity,HL_Amount,Status,Result,SettleType,FirmID_B,BuyPrice,BuyPayout_Ref,BuyPayout,BuyMargin,TakePenalty_B,PayPenalty_B,SettlePL_B,
               FirmID_S,SellPrice,SellIncome_Ref,SellIncome,SellMargin,TakePenalty_S,PayPenalty_S,SettlePL_S,CreateTime,ModifyTime,SettleDate)
               values (p_ApplyID,p_CommodityID,v_ContractFactor,(p_HoldQty+p_GageQty),0,0,1,2,v_FirmID,v_settlePrice,v_totalRef,v_Payout,v_settlementmargin,0,0,0,
               v_FirmID,v_settlePrice,v_totalRef,0,v_SettlementMargin,0,0,0,sysdate,sysdate,v_TradeDate);
       elsif(p_BS_Flag=2)then  --如果是卖方则更新交收配对数据表
       update T_SettleMatch set FirmID_S=v_FirmID , SellPrice=v_settlePrice,SellIncome_Ref=v_totalRef,SellMargin=v_settlementmargin where MatchID=p_ApplyID;
       end if;
    elsif(v_aheadSettlePriceType=1) then
       if(p_BS_Flag=2)then --如果是卖 则插入新的交收配对数据
           --1、计算买方交收货款
           select FirmID into v_bFirmID from T_Customer where CustomerID=p_OCustomerID;--找出买方交易商ID
           v_bPayout := FN_T_ComputePayout(v_bFirmID,p_CommodityID,1,(p_HoldQty+p_GageQty),p_Price);
           if(v_bPayout < 0) then
              Raise_application_error(-20043, 'computePayout error');
           end if;
           --2、插入交收配对表，提前交收不计算交收保证金
           --2.提前交收根据市场参数设定来判断是否收取保证金 -- modify by zhangjian
           select ASMarginType into v_IsChargeMargin from t_a_market;
           if(v_IsChargeMargin = 1 )then  --如果收取保证金
              --计算买方交收保证金
              v_SettlementMargin_B := FN_T_ComputeSettleMargin(v_bFirmID,p_CommodityID,1,p_HoldQty+p_GageQty,p_Price);
              if(v_SettlementMargin_B < 0) then
                 Raise_application_error(-20042, 'ComputeSettleMargin error');
              end if;
              --计算卖方交收保证金
             /* v_SettlementMargin_S := FN_T_ComputeSettleMargin(v_FirmID,p_CommodityID,2,(p_HoldQty+p_GageQty),p_Price);
              if(v_SettlementMargin_S < 0) then
                  Raise_application_error(-20042, 'ComputeSettleMargin error');
              end if;*/
           end if;   --add by zhangjian end

           --2.5 插入交收配对表
           select ContractFactor into v_ContractFactor from T_Commodity where CommodityID=p_CommodityID;
           insert into T_SettleMatch (MatchID,CommodityID,ContractFactor,Quantity,HL_Amount,Status,Result,SettleType,FirmID_B,BuyPrice,BuyPayout_Ref,BuyPayout,BuyMargin,TakePenalty_B,PayPenalty_B,SettlePL_B,
           FirmID_S,SellPrice,SellIncome_Ref,SellIncome,SellMargin,TakePenalty_S,PayPenalty_S,SettlePL_S,CreateTime,ModifyTime,SettleDate)
           values (p_ApplyID,p_CommodityID,v_ContractFactor,(p_HoldQty+p_GageQty),0,0,1,2,v_bFirmID,p_Price,(p_HoldQty+p_GageQty)*p_Price*v_ContractFactor,v_bPayout,v_SettlementMargin_B,0,0,0,
           v_FirmID,p_Price,(p_HoldQty+p_GageQty)*p_Price*v_ContractFactor,0,v_SettlementMargin,0,0,0,sysdate,sysdate,v_TradeDate);
       end if;
    end if;
    return 1;

end;
/


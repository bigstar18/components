create or replace function FN_T_D_NeutralMatchOne
(
  p_CommodityID varchar2 --商品代码
)  return number
/****
 * 某商品交收申报配对
 * 返回值
 * 1 成功
 * -3  交收持仓数量大于可交收持仓数量
 * -4  交收抵顶数量大于可抵顶数量
****/
as
    v_version varchar2(10):='1.0.2.2';
    b_qty     number(10);
    s_qty      number(10);
    Neutral_bs_flag     number(2); --中立仓方向
    Settle_bs_flag      number(2); --交收申报剩余方向
    Neutral_qty     number(10);
    Settle_qty      number(10):=0;
    v_ret     number(4);
    v_tradeQtySum      number(10):=0;
    v_settleQty     number(10);
    v_exitFlag      boolean:=false;
    v_GageMode     number(2);
    v_TradeDate     date;
    v_Balance    number(15,2):=0;
    v_F_FrozenFunds   number(15,2);
    v_num            number(10);
    v_DelayNeedBill number(2);    --延期交收是否需要仓单，0：不需要； 1：需要；
    v_NeutralFeeWay number(2);    --是否收中立仓交收手续费，0：不收；1：收取
    v_ContractFactor    number(12,2);
    v_UnfrozenFunds   number(15,2);
    v_Status          number(2);
    v_A_TradeNo      number(15);
    v_Price    number(15,2);   --交收价
    v_Margin   number(15,2);   --反向持仓交易保证金
    v_Assure   number(15,2):=0;   --应收担保金
    v_A_HoldNo       number(15);
    v_SettleMargin_one     number(15,2);
    v_Payout_one         number(15,2):=0;
    v_Fee_one         number(15,2):=0; --交收手续费
    v_ID number(15);
    v_NeutralMatchPriority   number(2); --中立仓反向持仓是否优先撮合,0:不优先；1：优先
    v_errorcode number;
    v_errormsg  varchar2(200);
begin
    --1、确定中立仓方向和申报数量
    select nvl(sum(Quantity-TradeQty),0) into b_qty from T_DelayOrders where DelayOrderType=2 and Status in(1,2) and BS_Flag=1 and CommodityID=p_CommodityID;
    select nvl(sum(Quantity-TradeQty),0) into s_qty from T_DelayOrders where DelayOrderType=2 and Status in(1,2) and BS_Flag=2 and CommodityID=p_CommodityID;
    if(b_qty >= s_qty) then
        Neutral_bs_flag := 1;
        Settle_bs_flag := 2;
        Neutral_qty := b_qty;
    else
        Neutral_bs_flag := 2;
        Settle_bs_flag := 1;
        Neutral_qty := s_qty;
    end if;
    --1.1、确定交收申报剩余未成交数量
    select nvl(sum(Quantity-TradeQty),0) into Settle_qty from T_DelayOrders where DelayOrderType=1 and Status in(1,2) and BS_Flag=Settle_bs_flag and CommodityID=p_CommodityID;
    --1.2、如果没有需要配对的数据，则直接返回成功
    if(Neutral_qty = 0 or Settle_qty = 0) then
        return 1;
    end if;

    --2、按时间顺序轮询中立仓委托撮合，生成反向持仓数据、交收明细
    --取交易日、抵顶模式、延期交收是否需要仓单、中立仓手续费方式、合约因子
    select TradeDate into v_TradeDate from T_SystemStatus;
    select GageMode,DelayNeedBill,NeutralFeeWay into v_GageMode,v_DelayNeedBill,v_NeutralFeeWay from T_A_Market;
    select Contractfactor into v_ContractFactor from T_Commodity where CommodityID=p_CommodityID;
    select NEUTRALMATCHPriority into v_NeutralMatchPriority from t_a_market;
    for NeutralOrder in(select A_OrderNo,CommodityID,CustomerID,BS_Flag,(Quantity-TradeQty) NotTradeQty,Price,FirmID from T_DelayOrders where DelayOrderType=2 and Status in(1,2) and BS_Flag=Neutral_bs_flag and CommodityID=p_CommodityID order by A_OrderNo for update)
    loop
        v_exitFlag := false;
        v_tradeQtySum := 0;
        --2.1、按时间顺序轮询撮合未成交的交收申报（中立仓反向持仓优先撮合时有反向持仓的会员委托优先排序，不优先时只按委托号排序）
        --for SettleOrder in(select A_OrderNo,CommodityID,CustomerID,BS_Flag,(Quantity-TradeQty) NotTradeQty,Price,FrozenFunds,UnfrozenFunds,Quantity,FirmID from T_DelayOrders where DelayOrderType=1 and Status in(1,2) and BS_Flag=Settle_bs_flag and CommodityID=p_CommodityID order by A_OrderNo for update)
        for SettleOrder in(select A_OrderNo,CommodityID,CustomerID,BS_Flag,(Quantity-TradeQty) NotTradeQty,Price,FrozenFunds,UnfrozenFunds,Quantity,FirmID from T_DelayOrders,(select distinct(t.FirmID) as FID,1 as OrderType from T_HoldPosition t where t.BS_Flag=Settle_bs_flag and t.HoldType=decode(v_NeutralMatchPriority,1,2,0) and t.CommodityID=p_CommodityID) hp where DelayOrderType=1 and Status in(1,2) and BS_Flag=Settle_bs_flag and CommodityID=p_CommodityID and firmid=hp.FID(+) order by nvl(hp.OrderType,0) desc,A_OrderNo for update of A_OrderNo)
        loop
            if(v_tradeQtySum + SettleOrder.NotTradeQty <= NeutralOrder.NotTradeQty) then --全部成交
                v_settleQty := SettleOrder.NotTradeQty;
                v_UnfrozenFunds := SettleOrder.FrozenFunds-SettleOrder.UnfrozenFunds;
                v_Status := 3;
                if(v_tradeQtySum + SettleOrder.NotTradeQty = NeutralOrder.NotTradeQty) then
                    v_exitFlag := true;
                end if;
            else --部分成交
                v_settleQty := NeutralOrder.NotTradeQty - v_tradeQtySum;
                v_UnfrozenFunds:=SettleOrder.FrozenFunds*v_settleQty/SettleOrder.Quantity;
                v_Status := 2;
                v_exitFlag := true;
            end if;
            v_tradeQtySum := v_tradeQtySum + v_settleQty;
            --交收申报持仓交收，涉及持仓明细，持仓合计，资金
            v_ret := FN_T_D_SettleOne(p_CommodityID,SettleOrder.Price,Settle_bs_flag,SettleOrder.CustomerID,v_settleQty,0);
            if(v_ret < 0) then
                rollback;
                return v_ret;
            end if;
            --更新交收申报委托状态、冻结资金、仓单
            update T_DelayOrders set Status=v_Status,TradeQty=TradeQty+v_settleQty,UnfrozenFunds=UnfrozenFunds+v_UnfrozenFunds where A_OrderNo=SettleOrder.A_OrderNo;
            v_F_FrozenFunds := FN_F_UpdateFrozenFunds(SettleOrder.FirmID,-v_UnfrozenFunds,'15');
            if(v_DelayNeedBill = 1) then
                v_ret := FN_T_D_TradeBill(SettleOrder.FirmID,SettleOrder.CommodityID,v_settleQty);
            end if;
            exit when v_exitFlag=true;
        end loop;

        if(v_tradeQtySum > 0) then
            --2.2、生成中立仓反向持仓相关数据(方向=Settle_bs_flag,无交易手续费)
            --2.2.1、插入延期成交表反向持仓成交记录
            select SEQ_T_DelayTrade.nextval into v_A_TradeNo from dual;
            insert into T_DelayTrade
              (a_tradeno,       a_orderno,         tradetime,     CustomerID,        CommodityID,            bs_flag,   DelayOrderType,  quantity,   TradeType,    Firmid)
            values
              (v_A_TradeNo,NeutralOrder.A_OrderNo, sysdate,NeutralOrder.CustomerID,  p_CommodityID,     Settle_bs_flag,    2,    v_tradeQtySum, 1,  NeutralOrder.FirmID);
            --2.2.2、插入中立仓反向持仓明细表
            --持仓价格
            v_Price := NeutralOrder.Price;
            --计算保证金
            v_Margin := FN_T_ComputeMargin(NeutralOrder.FirmID,p_CommodityID,Settle_bs_flag,v_tradeQtySum,v_Price);
            if(v_Margin < 0) then
                Raise_application_error(-20040, 'computeMargin error');
            end if;
            --计算担保金
            v_Assure := FN_T_ComputeAssure(NeutralOrder.FirmID,p_CommodityID,Settle_bs_flag,v_tradeQtySum,v_Price);
            if(v_Assure < 0) then
                Raise_application_error(-20041, 'computeAssure error');
            end if;
            --保证金应加上担保金
            v_Margin := v_Margin + v_Assure;
            --插入持仓明细表
			--调用计算函数修改持仓单号 2011-2-15 by feijl
            select FN_T_ComputeHoldNo(SEQ_T_HoldPosition.nextval) into v_A_HoldNo from dual;
            insert into T_Holdposition
              (a_holdno,    a_tradeno,  CommodityID,    CustomerID , bs_flag,   price,    holdqty,    openqty, holdtime,HoldMargin,HoldAssure,Firmid,FloatingLoss,HoldType,AtClearDate)
            select v_A_HoldNo,a_tradeno,CommodityID,CustomerID,bs_flag,v_Price,v_tradeQtySum,v_tradeQtySum,sysdate,v_Margin,v_Assure,Firmid,0,2,v_TradeDate
            from T_DelayTrade where a_tradeno=v_A_TradeNo;
            --2.2.3、更新持仓合计表
            --更新交易客户持仓合计表
            select count(*) into v_num from T_CustomerHoldSum
            where CustomerID = NeutralOrder.CustomerID
              and CommodityID = p_CommodityID
              and bs_flag = Settle_bs_flag;
            if(v_num >0) then
                --2011/5/23取消调用FN_T_D_ChgCustHoldByQty()，因新增持仓时无法正确更新保证金、持仓金额、均价等，且可能会出现除数=0
                --v_ret := FN_T_D_ChgCustHoldByQty(NeutralOrder.CustomerID,p_CommodityID,Settle_bs_flag,-v_tradeQtySum);
                update T_CustomerHoldSum
                set holdQty = holdQty + v_tradeQtySum,
                holdFunds = holdFunds + v_Price*v_tradeQtySum*v_contractFactor,
                HoldMargin = HoldMargin + v_Margin,
                HoldAssure = HoldAssure + v_Assure,
                evenprice = (holdFunds + v_Price*v_tradeQtySum*v_contractFactor)/((holdQty + GageQty + v_tradeQtySum)*v_contractFactor)
                where CustomerID = NeutralOrder.CustomerID
                and CommodityID = p_CommodityID
                and bs_flag = Settle_bs_flag;
            else
              insert into T_CustomerHoldSum
                (CustomerID, CommodityID, bs_flag, holdQty, holdFunds,FloatingLoss, evenprice,FrozenQty,HoldMargin,HoldAssure,FirmID)
              values
                (NeutralOrder.CustomerID, p_CommodityID, Settle_bs_flag, v_tradeQtySum, v_Price*v_tradeQtySum*v_contractFactor,0, v_Price,0,v_Margin,v_Assure,NeutralOrder.FirmID);
            end if;
            --更新交易商持仓合计表
            select count(*) into v_num from T_FirmHoldSum
            where Firmid = NeutralOrder.FirmID
              and CommodityID = p_CommodityID
              and bs_flag = Settle_bs_flag;
            if(v_num >0) then
                --2011/5/23取消调用FN_T_D_ChgFirmHoldByQty()，因新增持仓时无法正确更新保证金、持仓金额、均价等，且可能会出现除数=0
                --v_ret := FN_T_D_ChgFirmHoldByQty(NeutralOrder.FirmID,p_CommodityID,Settle_bs_flag,-v_tradeQtySum,v_GageMode);
                update T_FirmHoldSum
                set holdQty = holdQty + v_tradeQtySum,
                holdFunds = holdFunds + v_Price*v_tradeQtySum*v_contractFactor,
                HoldMargin = HoldMargin + v_Margin,
                HoldAssure = HoldAssure + v_Assure,
                evenprice = (holdFunds + v_Price*v_tradeQtySum*v_contractFactor)/((holdQty + v_tradeQtySum + decode(v_GageMode,1,GageQty,0))*v_contractFactor)
                where Firmid = NeutralOrder.FirmID
                and CommodityID = p_CommodityID
                and bs_flag = Settle_bs_flag;
            else
              insert into T_FirmHoldSum
                (FirmID, CommodityID,      bs_flag,  holdQty,        holdFunds,FloatingLoss, evenprice,HoldMargin,HoldAssure)
              values
                (NeutralOrder.FirmID, p_CommodityID, Settle_bs_flag, v_tradeQtySum, v_Price*v_tradeQtySum*v_contractFactor,0,         v_Price, v_Margin,  v_Assure);
            end if;

            --更新临时保证金和临时担保金
            update T_Firm
            set runtimemargin = runtimemargin + v_Margin,
                RuntimeAssure = RuntimeAssure + v_Assure
            where Firmid = NeutralOrder.FirmID;
            --更新冻结资金
            v_F_FrozenFunds := FN_F_UpdateFrozenFunds(NeutralOrder.FirmID,v_Margin-v_Assure,'15');

            --2.3、生成中立仓交收持仓明细数据
            --2.3.1、插入延期成交表成交记录
            select SEQ_T_DelayTrade.nextval into v_A_TradeNo from dual;
            insert into T_DelayTrade
              (a_tradeno,       a_orderno,         tradetime,     CustomerID,        CommodityID,            bs_flag,   DelayOrderType,  quantity,   TradeType,    Firmid)
            values
              (v_A_TradeNo,NeutralOrder.A_OrderNo, sysdate,NeutralOrder.CustomerID,  p_CommodityID,     Neutral_bs_flag,    2,    v_tradeQtySum, 1,  NeutralOrder.FirmID);
            --2.3.2、插入交收持仓明细表
            --计算交收保证金
            v_SettleMargin_one := FN_T_ComputeSettleMargin(NeutralOrder.FirmID,p_CommodityID,Neutral_bs_flag,v_tradeQtySum,v_Price);
            if(v_SettleMargin_one < 0) then
                Raise_application_error(-20042, 'ComputeSettleMargin error');
            end if;
            --计算买方交收货款
            if(Neutral_bs_flag = 1) then
                v_Payout_one := FN_T_ComputePayout(NeutralOrder.FirmID,p_CommodityID,Neutral_bs_flag,v_tradeQtySum,v_Price);
                if(v_Payout_one < 0) then
                    Raise_application_error(-20043, 'computePayout error');
                end if;
            end if;
            --计算交收手续费
            if(v_NeutralFeeWay = 0) then
                v_Fee_one := 0;
            else
                v_Fee_one := FN_T_ComputeSettleFee(NeutralOrder.FirmID,p_CommodityID,Neutral_bs_flag,v_tradeQtySum,v_Price);
            end if;
            if(v_Fee_one < 0) then
              Raise_application_error(-20031, 'computeFee error');
            end if;
            --按字段名插入交收持仓明细表
            select SEQ_T_SettleHoldPosition.nextval into v_ID from dual;
            --调用计算函数修改持仓单号 2011-2-15 by feijl
            select FN_T_ComputeHoldNo(SEQ_T_HoldPosition.nextval) into v_A_HoldNo from dual;
            insert into t_settleholdposition
            (id, settleprocessdate, a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss, settlemargin, payout, settlefee, settle_pl, settleaddedtax, settleprice, settletype, holdtype, atcleardate)
            select v_ID,v_TradeDate,v_A_HoldNo, a_tradeno, customerid, commodityid, bs_flag, v_Price, quantity, quantity, sysdate,    0,   firmid,      0,       0,         0,      v_SettleMargin_one,v_Payout_one,v_Fee_one, 0,        0,         v_Price,       3,       2,     v_TradeDate
            from T_DelayTrade
            where a_tradeno=v_A_TradeNo;

            --2.4、更新交易商临时保证金，解冻资金，更新仓单数量
            for delayOrder in(select CommodityID,FirmID,BS_Flag,Quantity,TradeQty,FrozenFunds,UnfrozenFunds from T_DelayOrders where A_OrderNo=NeutralOrder.A_OrderNo)
            loop
                --如果是全部成交，解冻所有冻结资金；如果是部分成交按比例解冻资金
                if((delayOrder.Quantity-delayOrder.TradeQty)=v_tradeQtySum) then
                    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(delayOrder.FirmID,-(delayOrder.FrozenFunds-delayOrder.UnfrozenFunds),'15');
                else
                    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(delayOrder.FirmID,-(delayOrder.FrozenFunds*v_tradeQtySum/delayOrder.Quantity),'15');
                end if;
                if(v_DelayNeedBill = 1) then
                    v_ret := FN_T_D_TradeBill(delayOrder.FirmID,delayOrder.CommodityID,v_tradeQtySum);
                end if;
            end loop;

            --2.5、写交收资金流水
            for SettleHoldPosition in(select a.FirmID,a.CommodityID,sum(a.SettleMargin) SettleMargin,sum(a.Payout) Payout,sum(a.SettleFee) SettleFee,sum(a.Settle_PL) Settle_PL,sum(a.SettleAddedTax) SettleAddedTax  from T_SettleHoldPosition a where a.id=v_ID group by a.FirmID,a.CommodityID)
            loop
                --扣除交收货款，交收手续费，付交收盈利或收交收亏损,交收保证金 ，并写流水
                v_Balance := FN_F_UpdateFundsFull(SettleHoldPosition.FirmID,'15008',SettleHoldPosition.Payout,null,SettleHoldPosition.CommodityID,null,null);
                --注意：支持实时撮合后无法处理最低交收手续费，按实际交收手续费收取
                v_Balance := FN_F_UpdateFundsFull(SettleHoldPosition.FirmID,'15010',SettleHoldPosition.SettleFee,null,SettleHoldPosition.CommodityID,null,null);

                if(SettleHoldPosition.Settle_PL >= 0) then
                    v_Balance := FN_F_UpdateFundsFull(SettleHoldPosition.FirmID,'15011',SettleHoldPosition.Settle_PL,null,SettleHoldPosition.CommodityID,SettleHoldPosition.SettleAddedTax,null);
                else
                    v_Balance := FN_F_UpdateFundsFull(SettleHoldPosition.FirmID,'15012',-SettleHoldPosition.Settle_PL,null,SettleHoldPosition.CommodityID,-SettleHoldPosition.SettleAddedTax,null);
                end if;
                update T_Firm set RuntimeSettleMargin=RuntimeSettleMargin+SettleHoldPosition.SettleMargin where FirmID=SettleHoldPosition.FirmID;
                v_Balance := FN_F_UpdateFundsFull(SettleHoldPosition.FirmID,'15013',SettleHoldPosition.SettleMargin,null,SettleHoldPosition.CommodityID,null,null);
            end loop;
            --2.6、更新委托记录，必须放在最后一步，上面要用到委托的数量，资金信息
            update T_DelayOrders
            set Status=decode(TradeQty+v_tradeQtySum,Quantity,3,2),
                TradeQty=TradeQty+v_tradeQtySum,
                UnfrozenFunds=decode(TradeQty+v_tradeQtySum,Quantity,FrozenFunds,UnfrozenFunds+(FrozenFunds*v_tradeQtySum/Quantity))
            where A_OrderNo=NeutralOrder.A_OrderNo;
        end if;

        exit when NeutralOrder.NotTradeQty > v_tradeQtySum;
    end loop;

    --3、如果交收商品表中没有此商品则插入
    select count(*) into v_num from T_SettleCommodity where CommodityID=p_CommodityID;
    if(v_num = 0) then
        insert into T_SettleCommodity select v_TradeDate,a.* from T_Commodity a where a.CommodityID=p_CommodityID;
    end if;

    return 1;

end;
/


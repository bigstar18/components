create or replace function FN_T_D_SettleMatchOne
(
  p_CommodityID varchar2 --商品代码
)  return number
/****
 * 某商品交收申报配对
 * 返回值
 * 1 成功
 * -1  买方成交数量出错
 * -3  交收持仓数量大于可交收持仓数量
 * -4  交收抵顶数量大于可抵顶数量
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_ret     number(4);
    v_OrderTradeQty      number(10):=0;
    v_TradeDate     date;
    v_Balance    number(15,2):=0;
    v_UnfrozenFunds   number(15,2);
    v_F_FrozenFunds   number(15,2);
    v_Status            number(2);
    v_num            number(10);
    v_DelayNeedBill number(2);    --延期交收是否需要仓单，0：不需要； 1：需要；
    v_tradedAmount   number(10):=0;  --成交数量
    v_unCloseQty     number(10); --未平数量，用于中间计算
    v_NeutralMatchPriority   number(2); --中立仓反向持仓是否优先撮合,0:不优先；1：优先
begin
	--1、如果交收商品表中没有此商品则插入
    select count(*) into v_num from T_SettleCommodity where CommodityID=p_CommodityID;
	if(v_num = 0) then
		select TradeDate into v_TradeDate from T_SystemStatus;
		insert into T_SettleCommodity select v_TradeDate,a.* from T_Commodity a where a.CommodityID=p_CommodityID;
	end if;
    select DelayNeedBill into v_DelayNeedBill from T_A_Market;
    select NEUTRALMATCHPriority into v_NeutralMatchPriority from t_a_market;
    --2、轮询买委托记录（中立仓反向持仓优先撮合时有反向持仓的会员委托优先排序，不优先时只按委托号排序）
    --for delayOrder_B in(select A_OrderNo,CommodityID,CustomerID,BS_Flag,(Quantity-TradeQty) NotTradeQty,Price,FrozenFunds,UnfrozenFunds,Quantity,FirmID from T_DelayOrders where DelayOrderType=1 and Status in(1,2) and BS_Flag=1 and CommodityID=p_CommodityID order by A_OrderNo for update)
    for delayOrder_B in(select A_OrderNo,CommodityID,CustomerID,BS_Flag,(Quantity-TradeQty) NotTradeQty,Price,FrozenFunds,UnfrozenFunds,Quantity,FirmID from T_DelayOrders,(select distinct(t.FirmID) as FID,1 as OrderType from T_HoldPosition t where t.BS_Flag=1 and t.HoldType=decode(v_NeutralMatchPriority,1,2,0) and t.CommodityID=p_CommodityID) hp where DelayOrderType=1 and Status in(1,2) and BS_Flag=1 and CommodityID=p_CommodityID and firmid=hp.FID(+) order by nvl(hp.OrderType,0) desc,A_OrderNo for update of A_OrderNo)
    loop
    	v_unCloseQty := delayOrder_B.NotTradeQty;
    	--轮询卖委托记录，成交完买委托的数量
      --for delayOrder_S in(select A_OrderNo,CommodityID,CustomerID,BS_Flag,(Quantity-TradeQty) NotTradeQty,Price,FrozenFunds,UnfrozenFunds,Quantity,FirmID from T_DelayOrders where DelayOrderType=1 and Status in(1,2) and BS_Flag=2 and CommodityID=p_CommodityID order by A_OrderNo for update)
      for delayOrder_S in(select A_OrderNo,CommodityID,CustomerID,BS_Flag,(Quantity-TradeQty) NotTradeQty,Price,FrozenFunds,UnfrozenFunds,Quantity,FirmID from T_DelayOrders,(select distinct(t.FirmID) as FID,1 as OrderType from T_HoldPosition t where t.BS_Flag=2 and t.HoldType=decode(v_NeutralMatchPriority,1,2,0) and t.CommodityID=p_CommodityID) hp where DelayOrderType=1 and Status in(1,2) and BS_Flag=2 and CommodityID=p_CommodityID and firmid=hp.FID(+) order by nvl(hp.OrderType,0) desc,A_OrderNo for update of A_OrderNo)
    	loop
    		if(delayOrder_S.NotTradeQty <= v_unCloseQty) then  --全部成交
    			v_tradedAmount:=delayOrder_S.NotTradeQty;
    			v_Status := 3;
    			v_UnfrozenFunds:=delayOrder_S.FrozenFunds-delayOrder_S.UnfrozenFunds;
            else  --部分成交
                v_tradedAmount:=v_unCloseQty;
                v_Status := 2;
    			v_UnfrozenFunds:=delayOrder_S.FrozenFunds*v_tradedAmount/delayOrder_S.Quantity;
    		end if;
	    	update T_DelayOrders set Status=v_Status,TradeQty=TradeQty+v_tradedAmount,UnfrozenFunds=UnfrozenFunds+v_UnfrozenFunds where A_OrderNo=delayOrder_S.A_OrderNo;
	        --更新冻结资金
			v_F_FrozenFunds := FN_F_UpdateFrozenFunds(delayOrder_S.FirmID,-v_UnfrozenFunds,'15');
    		if(v_DelayNeedBill = 1) then
    			v_ret := FN_T_D_TradeBill(delayOrder_S.FirmID,delayOrder_S.CommodityID,v_tradedAmount);
    		end if;
    		--卖方持仓交收，涉及持仓明细，持仓合计，资金
	    	v_ret := FN_T_D_SettleOne(delayOrder_S.CommodityID,delayOrder_S.Price,delayOrder_S.BS_Flag,delayOrder_S.CustomerID,v_tradedAmount,0);
	    	if(v_ret < 0) then
	    		rollback;
	        	return v_ret;
	    	end if;
    		v_unCloseQty:=v_unCloseQty - v_tradedAmount;
    		exit when v_unCloseQty=0;
    	end loop;
    	v_OrderTradeQty := delayOrder_B.NotTradeQty-v_unCloseQty;
    	if(v_unCloseQty = 0) then  --全部成交
    		v_Status := 3;
    		v_UnfrozenFunds:=delayOrder_B.FrozenFunds-delayOrder_B.UnfrozenFunds;
    	elsif(v_unCloseQty > 0 and v_unCloseQty < delayOrder_B.NotTradeQty) then  --部分成交
    		v_Status := 2;
    		v_UnfrozenFunds:=delayOrder_B.FrozenFunds*v_OrderTradeQty/delayOrder_B.Quantity;
    	elsif(v_unCloseQty = delayOrder_B.NotTradeQty) then  --无卖方配对记录，成功返回
    		return 1;
    	else  --出错回滚，要交收数量为负数了
    		rollback;
	        return -1;
    	end if;
    	update T_DelayOrders set Status=v_Status,TradeQty=TradeQty+v_OrderTradeQty,UnfrozenFunds=UnfrozenFunds+v_UnfrozenFunds where A_OrderNo=delayOrder_B.A_OrderNo;
        --更新冻结资金
		v_F_FrozenFunds := FN_F_UpdateFrozenFunds(delayOrder_B.FirmID,-v_UnfrozenFunds,'15');
		--买方持仓交收，涉及持仓明细，持仓合计，资金
    	v_ret := FN_T_D_SettleOne(delayOrder_B.CommodityID,delayOrder_B.Price,delayOrder_B.BS_Flag,delayOrder_B.CustomerID,v_OrderTradeQty,0);
    	if(v_ret < 0) then
    		rollback;
        	return v_ret;
    	end if;
    end loop;

    return 1;

end;
/


create or replace function FN_T_D_BuySettleOrder(
    p_FirmID     varchar2,   --交易商ID
    p_TraderID       varchar2,  --交易员ID
    p_CommodityID varchar2 ,--商品ID
    p_Quantity       number ,--数量
    p_Price       number ,--委托价格，行情结算价
  p_CustomerID     varchar2,  --交易客户ID
  p_ConsignerID       varchar2,  --代为委托员ID
  p_TradeMargin_B       number,  --应退买方交易保证金
  p_DelayQuoShowType       number  --延期行情显示类型，0：交收申报结束和中立仓申报结束显示； 1：实时显示；
) return number
/****
 * 买交收申报委托
 * 根据配置修改申报数量判断，用净订货量还是单边总持仓判断 by chenxc 2011-09-20
 * 返回值
 * >0  成功提交，并返回委托单号
 * -1  持仓不足
 * -2  资金余额不足
 * -99  不存在相关数据
 * -100 其它错误
****/
as
  v_version varchar2(10):='1.0.2.2';
    v_HoldSum        number(10);   --持仓合计数量
    v_Payout_B    number(15,2);   --买方交收货款
     v_Payout_BSum number(15,2):=0;  --买方向交收货款汇总
    v_SettleMargin_B    number(15,2):=0;   --买方交收保证金
    v_SettleMargin_BSum    number(15,2):=0;   --买方交收保证金汇总
    v_TradeMargin_B    number(15,2);   --买方交易保证金
    v_TradeMargin_BSum    number(15,2):=0;   --买方交易保证金汇总
    v_F_Funds      number(15,2):=0;   --应冻结资金
    v_A_Funds      number(15,2);   --可用资金
    v_F_FrozenFunds  number(15,2); --财务冻结资金
    v_A_OrderNo       number(15); --委托单号
    v_HoldOrderNo  number(15):=0;--持仓委托单号  ---add by zhangjian 2012年3月2日
    v_errorcode number;
    v_errormsg  varchar2(200);
    v_DelayOrderIsPure        number(1);   --交收申报是否按净订货量申报
    v_HoldSum_S        number(10):=0;   --卖方持仓合计数量
    v_HoldSum_B        number(10):=0;   --买方持仓合计数量
    v_DelaySettlePriceType         number(10);   --交收申报交收类型 0：按结算价交收申报 ， 1：按订立价交收  -- add  by zhangjian
    v_sql varchar2(500);
    v_qtySum number(15):=0;  -- 已委托的交收申报冻结数量
    v_price number(15,6);-- 交收申报价格
    v_theOrderPriceSum number(15,6):=0;-- 本次交收申报订立价格汇总
    v_holdQty number(15):=0;--每笔持仓明细中的持仓数量
    v_tempQty number(15):=0;--中间变量
    v_aheadSettleQty number(15):=0;--提前交收申请数量
    v_alreadyQty number(15):=0;--本次委托已冻结数量
    type cur_T_HoldPosition is ref cursor;
    v_HoldPosition cur_T_HoldPosition;
  v_orderLogNo number(15):=0;--委托下单日志 ID。
  v_orderSumLogNo number(15):=0;--委托下单日志合计数据 ID

begin

  --1、检查持仓，并锁住持仓合计记录
  begin
      select nvl(holdQty - frozenQty, 0) into v_HoldSum
      from T_CustomerHoldSum
      where CustomerID = p_CustomerID
        and CommodityID = p_CommodityID
        and bs_flag = 1 for update;
  exception
        when NO_DATA_FOUND then
            rollback;
           return -1;  --持仓不足
    end;
    --根据配置修改申报数量判断，用净订货量还是单边总持仓判断 by chenxc 2011-09-20
    --交收申报是否按净订货量申报
  select DelayOrderIsPure into v_DelayOrderIsPure from T_A_Market;
  if(v_DelayOrderIsPure = 1) then --按净订货量申报
      begin
        select holdQty+GageQty into v_HoldSum_S
        from T_CustomerHoldSum
        where CustomerID = p_CustomerID
          and CommodityID = p_CommodityID
          and bs_flag = 2 ;
    exception
          when NO_DATA_FOUND then
              v_HoldSum_S := 0;
      end;
      if(v_HoldSum-v_HoldSum_S < p_Quantity) then
          rollback;
          return -1;  --净订货量不足
      end if;
  else
      if(v_HoldSum < p_Quantity) then
          rollback;
          return -1;  --持仓不足
      end if;
    end if;
    --2、检查并冻结资金：冻结买方交收货款+买方交收保证金-买方占用的交易保证金
      --根据交收申报价格类型 判断如何冻结资金。0：按结算价交收 ；1：按订立价交收  mod by zhangjian
    select   DelaySettlePriceType into v_DelaySettlePriceType from t_commodity where commodityid=p_CommodityID;

    if(v_DelaySettlePriceType=1) then -- 如果是按订立价交收
    select nvl(sum(Quantity-TradeQty),0) into v_qtySum from T_DelayOrders where  commodityid=p_CommodityID and customerid=p_CustomerID and   status in (1,2) and bs_flag=1;
     -- select sum(quantity) into   v_aheadSettleQty from T_E_ApplyAheadSettle where modifier is null;
      v_qtySum:=v_qtySum+v_aheadSettleQty;--已经冻结的数量

    v_sql:='select price,HoldQty,a.A_HoldNo   from T_holdposition a,(select A_HoldNo from T_SpecFrozenHold group by A_HoldNo) b
                 where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and CustomerID='''||p_CustomerID||'''
                   and CommodityID ='''|| p_CommodityID||''' and bs_flag =  1   '||'  order by a.A_HoldNo';
     open v_HoldPosition for v_sql;
        loop
            fetch v_HoldPosition into v_price,v_holdQty,v_HoldOrderNo;
            exit when v_HoldPosition%NOTFOUND;
           v_HoldSum_S:=v_HoldSum_S+v_holdQty;
            v_tempQty:=0; --每次清空遍历数量
            if(v_HoldSum_S>v_qtySum)then --计算交收货款以及交收保证金累积，必须是大于当前延期委托表中已经存在的。
            if(p_Quantity>=(v_HoldSum_S-v_qtySum))then
            v_tempQty:=v_HoldSum_S-v_qtySum-v_alreadyQty;--当前冻结的数量
            v_alreadyQty:=v_tempQty+v_alreadyQty;
            else  --如果不满足当前条件则退出遍历
            v_tempQty:=p_Quantity-v_alreadyQty;
            v_HoldSum_S:=0;
             end if;
            end if;
            --计算交收货款
            v_Payout_B  := FN_T_ComputePayout(p_FirmID,p_CommodityID,1,v_tempQty,v_price);
            --计算交收保证金
            v_SettleMargin_B := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,1,v_tempQty,v_price);
            --计算交易保证金
            v_TradeMargin_B := FN_T_ComputeMargin(p_FirmID,p_CommodityID,1,v_tempQty,v_price);


            v_Payout_BSum :=v_Payout_BSum+v_Payout_B;--累积交收货款
            v_SettleMargin_BSum :=v_SettleMargin_BSum+v_SettleMargin_B;  --累积交收保证金
            v_TradeMargin_BSum := v_TradeMargin_BSum+v_TradeMargin_B;  --累加交易保证金
            v_theOrderPriceSum :=v_theOrderPriceSum+v_price*v_tempQty;--累加订立价格

            --循环每笔持仓明细都要插入委托日志  add by zhangjian 2012年3月2日
            select SEQ_T_D_OrderLog.nextval into v_orderLogNo  from dual  ;
            insert into T_D_DelayOrderLog  values (v_orderLogNo,p_firmid,1,p_CommodityID,v_HoldOrderNo,v_price,v_tempQty,v_SettleMargin_B,v_TradeMargin_B,v_Payout_B,Sysdate,null );

            if(v_HoldSum_S=0)then
                   v_price:=v_theOrderPriceSum/p_Quantity;--如果退出循环则计算平均订立价格
                   exit;
               end if;
        end loop;

   elsif(v_DelaySettlePriceType=0)then --如果是按结算价交收
   v_price:=p_Price;
  --计算交收货款
  v_Payout_B := FN_T_ComputePayout(p_FirmID,p_CommodityID,1,p_Quantity,v_price);
  --计算交收保证金
  v_SettleMargin_B := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,1,p_Quantity,v_price);
              v_Payout_BSum :=v_Payout_B;
              v_SettleMargin_BSum :=v_SettleMargin_B;
   --交易保证金
   v_TradeMargin_BSum:=p_TradeMargin_B;
  end if;
    --应冻结资金
    v_F_Funds := v_Payout_BSum + v_SettleMargin_BSum - v_TradeMargin_BSum;
    --计算可用资金，并锁住财务资金
    v_A_Funds := FN_F_GetRealFunds(p_FirmID,1);

    --插入延期委托合计表日志   --add by zhangjian  2012年3月2日
    select SEQ_T_D_OrderSumLog.nextval  into v_orderSumLogNo from dual;
    insert into  T_D_DelayOrderSumLog values (v_orderSumLogNo,p_firmid,1,p_CommodityID,v_price,p_Quantity,v_SettleMargin_BSum,p_TradeMargin_B,v_Payout_BSum,v_A_Funds,v_F_Funds,Sysdate,null);


    if(v_A_Funds < v_F_Funds) then
        rollback;
        return -2;  --资金余额不足
    end if;
  --3、更新交易客户持仓合计的冻结数量
    update T_CustomerHoldSum set frozenQty = frozenQty + p_Quantity
    where CustomerID = p_CustomerID
    and CommodityID = p_CommodityID
    and bs_flag = 1;
    --4、更新冻结资金
  v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,v_F_Funds,'15');
    --5、插入延期委托表，并返回委托单号
    select SEQ_T_DelayOrders.nextval into v_A_OrderNo from dual;
    insert into T_DelayOrders
      ( a_orderno,    CommodityID,   CustomerID,    traderid,   bs_flag, DelayOrderType, status, quantity, price, tradeqty, frozenfunds, unfrozenfunds, ordertime, withdrawtime, ordererip, signature,  FirmID ,ConsignerID)
    values
      (v_A_OrderNo,  p_CommodityID, p_CustomerID,  p_TraderID,     1,           1,          1,  p_Quantity, v_price,  0,     v_F_Funds,       0,         sysdate,      null,       null,     null,     p_FirmID ,p_ConsignerID);


    --行情实时显示则要更新行情
    if(p_DelayQuoShowType = 1) then
      update T_DelayQuotation set BuySettleQty=BuySettleQty + p_Quantity,CreateTime=sysdate where CommodityID = p_CommodityID;
    end if;

    commit;
    return v_A_OrderNo;
exception
    when NO_DATA_FOUND then
        rollback;
        return -99;  --不存在相关数据
    when others then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_D_BuySettleOrder',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/


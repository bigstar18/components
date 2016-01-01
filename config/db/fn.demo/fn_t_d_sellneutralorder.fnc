create or replace function FN_T_D_SellNeutralOrder(
  p_FirmID     varchar2,   --交易商ID
  p_TraderID       varchar2,  --交易员ID
  p_CommodityID varchar2 ,--商品ID
  p_Quantity       number ,--数量
  p_Price       number ,--委托价格，行情结算价
  p_CustomerID     varchar2,  --交易客户ID
  p_ConsignerID    varchar2,  --代为委托员ID
  p_DelayQuoShowType number, --延期行情显示类型，0：交收申报结束和中立仓申报结束显示； 1：实时显示；
  p_DelayNeedBill    number  --延期交收是否需要仓单，0：不需要； 1：需要；
) return number
/****
 * 中立仓申报委托
 * 返回值
 * >0  成功提交，并返回委托单号
 * -2  交易商可用资金不足
 * -32 仓单数量不足
****/
as
  v_version varchar2(10):='1.0.0.0';
  v_Payout_B    number(15,2);   --买方交收货款
  v_SettleMargin    number(15,2);   --交收保证金
  v_HoldFunds     number(15,2);   --反向持仓冻结资金
  v_F_Funds      number(15,2):=0;   --应冻结资金
  v_F_FrozenFunds  number(15,2); --财务冻结资金
  v_A_Funds      number(15,2);   --可用资金
  v_A_OrderNo       number(15); --委托单号
  v_b_s_unsettleqty number(15);--交收申报买卖量之间的差值
  v_NeutralSide number(2); --中立仓方向
  v_ret  number(4);
  v_errorcode number;
  v_errormsg  varchar2(200);
begin
  --1. 根据参数是否需要检查并冻结仓单
  if(p_DelayNeedBill = 1) then
	v_ret := FN_T_D_CheckAndFrozenBill(p_FirmID,p_CommodityID,p_Quantity);
	if(v_ret = -1) then
		rollback;
		return -32;  --仓单数量不足
	end if;
  end if;
  --2. 检查并冻结资金：
  --卖方冻结资金：卖方交收保证金＋反向持仓保证金
  --计算交收保证金
  v_SettleMargin := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,2,p_Quantity,p_Price);
  --计算反向持仓保证金
  v_HoldFunds := FN_T_ComputeMargin(p_FirmID,p_CommodityID,1,p_Quantity,p_Price);
  --应冻结资金
  v_F_Funds := v_SettleMargin + v_HoldFunds;
  --计算可用资金，并锁住财务资金
  v_A_Funds := FN_F_GetRealFunds(p_FirmID,1);
  if (v_F_Funds>v_A_Funds) then
    rollback;
    return -2; --可用资金不足
  end if;
  --3. 更新冻结资金
  v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,v_F_Funds,'15');
  --4. 插入延期委托表，并返回委托单号
  select SEQ_T_DelayOrders.nextval into v_A_OrderNo from dual;
  insert into T_DelayOrders
    ( a_orderno,    CommodityID,   CustomerID,    traderid,   bs_flag, DelayOrderType, status, quantity, price, tradeqty, frozenfunds, unfrozenfunds, ordertime, withdrawtime, ordererip, signature,  FirmID ,ConsignerID)
  values
    (v_A_OrderNo,  p_CommodityID, p_CustomerID,  p_TraderID,         2,           2,         1,p_Quantity, p_Price,  0,     v_F_Funds,       0,         sysdate,      null,       null,     null,     p_FirmID ,p_ConsignerID);

  --5. 行情实时显示则要更新行情
  if(p_DelayQuoShowType = 1) then
    update T_DelayQuotation set SellNeutralQty=nvl(SellNeutralQty,0) + p_Quantity,CreateTime=sysdate where CommodityID = p_CommodityID;
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
  values(sysdate,'FN_T_D_SellNeutralOrder',v_errorcode,v_errormsg);
  commit;
  return -100;
end;
/


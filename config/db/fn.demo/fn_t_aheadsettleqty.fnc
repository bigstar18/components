create or replace function FN_T_AheadSettleQty(
    p_ApplyID       varchar2,     --申请单号
    p_CommodityID varchar2, --商品代码
    --p_BillID         varchar2, --仓单号-- mod by yukx 20100428
    p_Quantity      number,   --仓单数量，即交收数量，包括抵顶的
   p_Price         number,  --交收价
  p_sCustomerID    varchar2,     --卖方交易客户ID
  p_sGageQty      number default 0,    --其中卖交收抵顶数量
    p_bCustomerID    varchar2,     --买方交易客户ID
   p_bGageQty      number default 0,   --其中买交收抵顶数量，业务上不存在此参数，实现上保留
    p_Modifier      varchar2,   --创建人
  p_ApplyType     number    --申请种类: 1:提前交收  mod by yukx /*3：已有仓单转提前交收;6：提前交收*/
  --p_ValidID       number    --生效仓单号，只有申请种类为3：已有仓单转提前交收才需要
) return number
/****
 * 提前交收
 * 返回值
 * 1 成功
 * 2 已处理过
 * -1  可交收买持仓数量不足
 * -2  可交收买抵顶数量不足
 * -3  交收买持仓数量大于可交收买持仓数量
 * -4  交收买抵顶数量大于可买抵顶数量
 * -11  可交收卖持仓数量不足
 * -12  可交收卖抵顶数量不足
 * -13  交收卖持仓数量大于可交收卖持仓数量
 * -14  交收卖抵顶数量大于可卖抵顶数量
 * -100 其它错误
****/
as
   v_version varchar2(10):='1.0.0.9';
   v_FirmID varchar2(32);      --卖方交易商ID
  v_bFirmID varchar2(32);      --买方交易商ID
    bRet            number(5);
    sRet            number(5);
    v_FL_ret            timestamp;
    v_num            number(10);
    v_errorcode      number;
    v_errormsg       varchar2(200);
    v_Payout         number(15,2):=0;
    v_ContractFactor T_Commodity.ContractFactor%type;
  v_IsChargeMargin       number(2):=0;    --是否收取保证金 -add by zhangjian
  v_SettlementMargin_S     number(15,2):=0; --卖方交收保证金
  v_SettlementMargin_B      number(15,2):=0; --买方交收保证金
  v_settlePirce_B    number(15,6):=0;--买方交收价格
  v_settlePirce_S    number(15,6):=0;--卖方交收价格
  v_alreadyAheadSettleQty number(15):=0;  --已存在的提前交收申请数量
  v_holdPrice  number(15):=0;--每一笔持仓明细中的订立价
  v_holdQty  number(15):=0;--每一笔持仓明细中的持仓数量
  v_HoldSum number(15):=0;--累积提前交收申请数量
  v_tempQty number(15):=0;--临时变量数量
  v_holdPirceSum number(15):=0;--本次需要冻结持仓明细订立价格累加
  v_priceType number(2);--交收价类型  0:按订立价交收  1:按自主价交收 add by zhangjian
  v_sql varchar2(500);
  v_orderby  varchar2(100);
  v_CloseAlgr number;
  type cur_T_HoldPosition is ref cursor;
  v_HoldPosition cur_T_HoldPosition;
  v_settleMachNumber number(15);
  v_aheadSettlePriceType number(2);--提前交收价格类型 0:按订立价交收 1：按自主价交收

begin
    /* -- mod by yukx 20100428
    select count(*) into v_num from T_ValidBill where BillID = p_BillID and Status=1 and BillType=4;
    if(v_num >0) then
        rollback;
        return 2;  --已处理过
    end if;
    */
select aheadSettlePriceType into v_aheadSettlePriceType  from t_commodity where commodityid=p_CommodityID;
  --这里应该调用FN_T_AheadSettleOneQty，以前调用FN_T_AheadSettleOne
  --增加传递 提前交收申请单号。用来当提前交收价格类型为 按订立价交收的时候更新提前交收价格
   bRet := FN_T_AheadSettleOneQty(p_ApplyID,p_CommodityID,p_Price,1,p_bCustomerID,p_sCustomerID,p_Quantity-p_bGageQty,p_bGageQty); --买
   if(bRet = 1) then
      sRet := FN_T_AheadSettleOneQty(p_ApplyID,p_CommodityID,p_Price,2,p_sCustomerID,p_bCustomerID,p_Quantity-p_sGageQty,p_sGageQty);  --卖

      if(sRet = 1) then
          select FirmID into v_FirmID from T_Customer where CustomerID=p_sCustomerID;--找出卖方交易商ID
          --3有抵顶交收则增加生效仓单抵顶表的数量
          update T_ValidGageBill set Quantity=Quantity+p_sGageQty where FirmID=v_FirmID and commodityId=p_CommodityID;
          commit;
          --提交后计算买卖双方浮亏
          v_FL_ret := FN_T_UpdateFloatingLoss(null,null,null);

          return 1;
       elsif(sRet = -1) then
         rollback;
         return -11;
      elsif(sRet = -2) then
         rollback;
         return -12;
      elsif(sRet = -3) then
         rollback;
         return -13;
      elsif(sRet = -4) then
         rollback;
         return -14;
      else
         rollback;
         return -100;
      end if;
   else
      rollback;
      return bRet;
   end if;
exception
    when OTHERS then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_AheadSettleQty',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/


create or replace function FN_T_ConferClose(
    p_CommodityID varchar2,   --商品代码
 	  p_Price         number,  --平仓价
    p_bCustomerID    varchar2,     --买交易客户ID
    p_bHoldQty      number,   --买平仓持仓数量，即非抵顶数量
 	  p_bGageQty      number,   --买平仓抵顶数量
    p_sCustomerID    varchar2,     --卖交易客户ID
    p_sHoldQty      number,   --卖平仓持仓数量，即非抵顶数量
 	  p_sGageQty      number   --卖平仓抵顶数量
) return number
/****
 * 协议平仓
 * 返回值
 * 1 成功
 * -1  可平仓买持仓数量不足
 * -2  可平仓买抵顶数量不足
 * -3  平仓买持仓数量大于可平仓买持仓数量
 * -4  平仓买抵顶数量大于可买抵顶数量
 * -11  可平仓卖持仓数量不足
 * -12  可平仓卖抵顶数量不足
 * -13  平仓卖持仓数量大于可平仓卖持仓数量
 * -14  平仓卖抵顶数量大于可卖抵顶数量
 * -100 其它错误
****/
as
 	  v_version varchar2(10):='1.0.0.1';
    bRet            number(5);
    sRet            number(5);
    v_FL_ret            timestamp;
    v_sFirmID varchar2(32);      --卖方交易商ID
	  v_bFirmID varchar2(32);      --买方交易商ID
    bM_TradeNo            number(15);
    sM_TradeNo            number(15);
    v_errorcode      number;
    v_errormsg       varchar2(200);
begin
	  select nvl(max(M_TradeNo),0)+1 into bM_TradeNo from T_Trade;
	  sM_TradeNo := bM_TradeNo + 1;
    bRet := FN_T_ConferCloseOne(p_CommodityID,p_Price,1,p_bCustomerID,p_sCustomerID,p_bHoldQty,p_bGageQty,bM_TradeNo,sM_TradeNo);--买
    if(bRet = 1) then
    	  sRet := FN_T_ConferCloseOne(p_CommodityID,p_Price,2,p_sCustomerID,p_bCustomerID,p_sHoldQty,p_sGageQty,sM_TradeNo,bM_TradeNo); --卖
  		  if(sRet = 1) then
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
    values(sysdate,'FN_T_ConferClose',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/


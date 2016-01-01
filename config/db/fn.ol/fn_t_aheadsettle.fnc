create or replace function FN_T_AheadSettle(
    p_ApplyID       number,     --申请单号
    p_CommodityID varchar2, --商品代码
    p_BillID         varchar2, --仓单号
    p_Quantity      number,   --仓单数量，即交收数量，包括抵顶的
 	p_Price         number,  --交收价
	p_sCustomerID    varchar2,     --卖方交易客户ID
	p_sGageQty      number default 0,    --其中卖交收抵顶数量
    p_bCustomerID    varchar2,     --买方交易客户ID
 	p_bGageQty      number default 0,   --其中买交收抵顶数量，业务上不存在此参数，实现上保留
    p_Modifier      varchar2,   --创建人
	p_ApplyType     number,    --申请种类:3：已有仓单转提前交收;6：提前交收
	p_ValidID       number    --生效仓单号，只有申请种类为3：已有仓单转提前交收才需要
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
 	v_FirmID varchar2(10);      --卖方交易商ID
	v_bFirmID varchar2(10);      --买方交易商ID
    bRet            number(5);
    sRet            number(5);
    v_FL_ret            timestamp;
    v_num            number(10);
    v_errorcode      number;
    v_errormsg       varchar2(200);
    v_Payout         number(15,2):=0;
    v_ContractFactor T_Commodity.ContractFactor%type;
begin
 	bRet := FN_T_AheadSettleOne(p_CommodityID,p_Price,1,p_bCustomerID,p_Quantity-p_bGageQty,p_bGageQty); --买
 	if(bRet = 1) then
  		sRet := FN_T_AheadSettleOne(p_CommodityID,p_Price,2,p_sCustomerID,p_Quantity-p_sGageQty,p_sGageQty);  --卖
  		if(sRet = 1) then
	        --插入生效仓单表，不管是已有仓单转提前交收还是提前交收都应该插入新申请的有效仓单
            select FirmID into v_FirmID from T_Customer where CustomerID=p_sCustomerID;--找出卖方交易商ID
   			--2009-09-08增加提前交收完后直接插入交收配对表
   			--1、计算买方交收货款
   			select FirmID into v_bFirmID from T_Customer where CustomerID=p_bCustomerID;--找出买方交易商ID
	        v_Payout := FN_T_ComputePayout(v_bFirmID,p_CommodityID,1,p_Quantity,p_Price);
            if(v_Payout < 0) then
                Raise_application_error(-20043, 'computePayout error');
            end if;
            --2、插入交收配对表，提前交收不计算交收保证金
            select ContractFactor into v_ContractFactor from T_Commodity where CommodityID=p_CommodityID;
			insert into T_SettleMatch (MatchID,CommodityID,ContractFactor,Quantity,HL_Amount,Status,Result,FirmID_B,BuyPrice,BuyPayout_Ref,BuyPayout,BuyMargin,TakePenalty_B,PayPenalty_B,SettlePL_B,
			   		FirmID_S,SellPrice,SellIncome_Ref,SellIncome,SellMargin,TakePenalty_S,PayPenalty_S,SettlePL_S,CreateTime,ModifyTime)
			   		values ('ATS_'||seq_T_SettleMatch.nextVal,p_CommodityID,v_ContractFactor,p_Quantity,0,0,1,v_bFirmID,p_Price,p_Quantity*p_Price*v_ContractFactor,v_Payout,0,0,0,0,
			   		v_FirmID,p_Price,p_Quantity*p_Price*v_ContractFactor,0,0,0,0,0,sysdate,sysdate);

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
    values(sysdate,'FN_T_AheadSettle',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/


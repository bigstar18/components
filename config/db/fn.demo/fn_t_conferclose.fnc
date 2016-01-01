create or replace function FN_T_ConferClose(
    p_CommodityID varchar2,   --��Ʒ����
 	  p_Price         number,  --ƽ�ּ�
    p_bCustomerID    varchar2,     --���׿ͻ�ID
    p_bHoldQty      number,   --��ƽ�ֲֳ����������ǵֶ�����
 	  p_bGageQty      number,   --��ƽ�ֵֶ�����
    p_sCustomerID    varchar2,     --�����׿ͻ�ID
    p_sHoldQty      number,   --��ƽ�ֲֳ����������ǵֶ�����
 	  p_sGageQty      number   --��ƽ�ֵֶ�����
) return number
/****
 * Э��ƽ��
 * ����ֵ
 * 1 �ɹ�
 * -1  ��ƽ����ֲ���������
 * -2  ��ƽ����ֶ���������
 * -3  ƽ����ֲ��������ڿ�ƽ����ֲ�����
 * -4  ƽ����ֶ��������ڿ���ֶ�����
 * -11  ��ƽ�����ֲ���������
 * -12  ��ƽ�����ֶ���������
 * -13  ƽ�����ֲ��������ڿ�ƽ�����ֲ�����
 * -14  ƽ�����ֶ��������ڿ����ֶ�����
 * -100 ��������
****/
as
 	  v_version varchar2(10):='1.0.0.1';
    bRet            number(5);
    sRet            number(5);
    v_FL_ret            timestamp;
    v_sFirmID varchar2(32);      --����������ID
	  v_bFirmID varchar2(32);      --�򷽽�����ID
    bM_TradeNo            number(15);
    sM_TradeNo            number(15);
    v_errorcode      number;
    v_errormsg       varchar2(200);
begin
	  select nvl(max(M_TradeNo),0)+1 into bM_TradeNo from T_Trade;
	  sM_TradeNo := bM_TradeNo + 1;
    bRet := FN_T_ConferCloseOne(p_CommodityID,p_Price,1,p_bCustomerID,p_sCustomerID,p_bHoldQty,p_bGageQty,bM_TradeNo,sM_TradeNo);--��
    if(bRet = 1) then
    	  sRet := FN_T_ConferCloseOne(p_CommodityID,p_Price,2,p_sCustomerID,p_bCustomerID,p_sHoldQty,p_sGageQty,sM_TradeNo,bM_TradeNo); --��
  		  if(sRet = 1) then
   			    commit;
   			    --�ύ���������˫������
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


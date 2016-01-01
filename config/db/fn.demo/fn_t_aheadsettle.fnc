create or replace function FN_T_AheadSettle(
    p_ApplyID       number,     --���뵥��
    p_CommodityID varchar2, --��Ʒ����
    p_BillID         varchar2, --�ֵ���
    p_Quantity      number,   --�ֵ������������������������ֶ���
 	p_Price         number,  --���ռ�
	p_sCustomerID    varchar2,     --�������׿ͻ�ID
	p_sGageQty      number default 0,    --���������յֶ�����
    p_bCustomerID    varchar2,     --�򷽽��׿ͻ�ID
 	p_bGageQty      number default 0,   --�������յֶ�������ҵ���ϲ����ڴ˲�����ʵ���ϱ���
    p_Modifier      varchar2,   --������
	p_ApplyType     number,    --��������:3�����вֵ�ת��ǰ����;6����ǰ����
	p_ValidID       number    --��Ч�ֵ��ţ�ֻ����������Ϊ3�����вֵ�ת��ǰ���ղ���Ҫ
) return number
/****
 * ��ǰ����
 * ����ֵ
 * 1 �ɹ�
 * 2 �Ѵ����
 * -1  �ɽ�����ֲ���������
 * -2  �ɽ�����ֶ���������
 * -3  ������ֲ��������ڿɽ�����ֲ�����
 * -4  ������ֶ��������ڿ���ֶ�����
 * -11  �ɽ������ֲ���������
 * -12  �ɽ������ֶ���������
 * -13  �������ֲ��������ڿɽ������ֲ�����
 * -14  �������ֶ��������ڿ����ֶ�����
 * -100 ��������
****/
as
 	v_version varchar2(10):='1.0.0.9';
 	v_FirmID varchar2(10);      --����������ID
	v_bFirmID varchar2(10);      --�򷽽�����ID
    bRet            number(5);
    sRet            number(5);
    v_FL_ret            timestamp;
    v_num            number(10);
    v_errorcode      number;
    v_errormsg       varchar2(200);
    v_Payout         number(15,2):=0;
    v_ContractFactor T_Commodity.ContractFactor%type;
begin
 	bRet := FN_T_AheadSettleOne(p_CommodityID,p_Price,1,p_bCustomerID,p_Quantity-p_bGageQty,p_bGageQty); --��
 	if(bRet = 1) then
  		sRet := FN_T_AheadSettleOne(p_CommodityID,p_Price,2,p_sCustomerID,p_Quantity-p_sGageQty,p_sGageQty);  --��
  		if(sRet = 1) then
	        --������Ч�ֵ������������вֵ�ת��ǰ���ջ�����ǰ���ն�Ӧ�ò������������Ч�ֵ�
            select FirmID into v_FirmID from T_Customer where CustomerID=p_sCustomerID;--�ҳ�����������ID
   			--2009-09-08������ǰ�������ֱ�Ӳ��뽻����Ա�
   			--1�������򷽽��ջ���
   			select FirmID into v_bFirmID from T_Customer where CustomerID=p_bCustomerID;--�ҳ��򷽽�����ID
	        v_Payout := FN_T_ComputePayout(v_bFirmID,p_CommodityID,1,p_Quantity,p_Price);
            if(v_Payout < 0) then
                Raise_application_error(-20043, 'computePayout error');
            end if;
            --2�����뽻����Ա���ǰ���ղ����㽻�ձ�֤��
            select ContractFactor into v_ContractFactor from T_Commodity where CommodityID=p_CommodityID;
			insert into T_SettleMatch (MatchID,CommodityID,ContractFactor,Quantity,HL_Amount,Status,Result,FirmID_B,BuyPrice,BuyPayout_Ref,BuyPayout,BuyMargin,TakePenalty_B,PayPenalty_B,SettlePL_B,
			   		FirmID_S,SellPrice,SellIncome_Ref,SellIncome,SellMargin,TakePenalty_S,PayPenalty_S,SettlePL_S,CreateTime,ModifyTime)
			   		values ('ATS_'||seq_T_SettleMatch.nextVal,p_CommodityID,v_ContractFactor,p_Quantity,0,0,1,v_bFirmID,p_Price,p_Quantity*p_Price*v_ContractFactor,v_Payout,0,0,0,0,
			   		v_FirmID,p_Price,p_Quantity*p_Price*v_ContractFactor,0,0,0,0,0,sysdate,sysdate);

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
    values(sysdate,'FN_T_AheadSettle',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/


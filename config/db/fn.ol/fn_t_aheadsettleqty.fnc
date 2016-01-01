create or replace function FN_T_AheadSettleQty(
    p_ApplyID       varchar2,     --���뵥��
    p_CommodityID varchar2, --��Ʒ����
    --p_BillID         varchar2, --�ֵ���-- mod by yukx 20100428
    p_Quantity      number,   --�ֵ������������������������ֶ���
   p_Price         number,  --���ռ�
  p_sCustomerID    varchar2,     --�������׿ͻ�ID
  p_sGageQty      number default 0,    --���������յֶ�����
    p_bCustomerID    varchar2,     --�򷽽��׿ͻ�ID
   p_bGageQty      number default 0,   --�������յֶ�������ҵ���ϲ����ڴ˲�����ʵ���ϱ���
    p_Modifier      varchar2,   --������
  p_ApplyType     number    --��������: 1:��ǰ����  mod by yukx /*3�����вֵ�ת��ǰ����;6����ǰ����*/
  --p_ValidID       number    --��Ч�ֵ��ţ�ֻ����������Ϊ3�����вֵ�ת��ǰ���ղ���Ҫ
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
   v_FirmID varchar2(32);      --����������ID
  v_bFirmID varchar2(32);      --�򷽽�����ID
    bRet            number(5);
    sRet            number(5);
    v_FL_ret            timestamp;
    v_num            number(10);
    v_errorcode      number;
    v_errormsg       varchar2(200);
    v_Payout         number(15,2):=0;
    v_ContractFactor T_Commodity.ContractFactor%type;
  v_IsChargeMargin       number(2):=0;    --�Ƿ���ȡ��֤�� -add by zhangjian
  v_SettlementMargin_S     number(15,2):=0; --�������ձ�֤��
  v_SettlementMargin_B      number(15,2):=0; --�򷽽��ձ�֤��
  v_settlePirce_B    number(15,6):=0;--�򷽽��ռ۸�
  v_settlePirce_S    number(15,6):=0;--�������ռ۸�
  v_alreadyAheadSettleQty number(15):=0;  --�Ѵ��ڵ���ǰ������������
  v_holdPrice  number(15):=0;--ÿһ�ʳֲ���ϸ�еĶ�����
  v_holdQty  number(15):=0;--ÿһ�ʳֲ���ϸ�еĳֲ�����
  v_HoldSum number(15):=0;--�ۻ���ǰ������������
  v_tempQty number(15):=0;--��ʱ��������
  v_holdPirceSum number(15):=0;--������Ҫ����ֲ���ϸ�����۸��ۼ�
  v_priceType number(2);--���ռ�����  0:�������۽���  1:�������۽��� add by zhangjian
  v_sql varchar2(500);
  v_orderby  varchar2(100);
  v_CloseAlgr number;
  type cur_T_HoldPosition is ref cursor;
  v_HoldPosition cur_T_HoldPosition;
  v_settleMachNumber number(15);
  v_aheadSettlePriceType number(2);--��ǰ���ռ۸����� 0:�������۽��� 1���������۽���

begin
    /* -- mod by yukx 20100428
    select count(*) into v_num from T_ValidBill where BillID = p_BillID and Status=1 and BillType=4;
    if(v_num >0) then
        rollback;
        return 2;  --�Ѵ����
    end if;
    */
select aheadSettlePriceType into v_aheadSettlePriceType  from t_commodity where commodityid=p_CommodityID;
  --����Ӧ�õ���FN_T_AheadSettleOneQty����ǰ����FN_T_AheadSettleOne
  --���Ӵ��� ��ǰ�������뵥�š���������ǰ���ռ۸�����Ϊ �������۽��յ�ʱ�������ǰ���ռ۸�
   bRet := FN_T_AheadSettleOneQty(p_ApplyID,p_CommodityID,p_Price,1,p_bCustomerID,p_sCustomerID,p_Quantity-p_bGageQty,p_bGageQty); --��
   if(bRet = 1) then
      sRet := FN_T_AheadSettleOneQty(p_ApplyID,p_CommodityID,p_Price,2,p_sCustomerID,p_bCustomerID,p_Quantity-p_sGageQty,p_sGageQty);  --��

      if(sRet = 1) then
          select FirmID into v_FirmID from T_Customer where CustomerID=p_sCustomerID;--�ҳ�����������ID
          --3�еֶ�������������Ч�ֵ��ֶ��������
          update T_ValidGageBill set Quantity=Quantity+p_sGageQty where FirmID=v_FirmID and commodityId=p_CommodityID;
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
    values(sysdate,'FN_T_AheadSettleQty',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/


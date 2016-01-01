create or replace function FN_T_D_BuySettleOrder(
    p_FirmID     varchar2,   --������ID
    p_TraderID       varchar2,  --����ԱID
    p_CommodityID varchar2 ,--��ƷID
    p_Quantity       number ,--����
    p_Price       number ,--ί�м۸���������
  p_CustomerID     varchar2,  --���׿ͻ�ID
  p_ConsignerID       varchar2,  --��Ϊί��ԱID
  p_TradeMargin_B       number,  --Ӧ���򷽽��ױ�֤��
  p_DelayQuoShowType       number  --����������ʾ���ͣ�0�������걨�������������걨������ʾ�� 1��ʵʱ��ʾ��
) return number
/****
 * �����걨ί��
 * ���������޸��걨�����жϣ��þ����������ǵ����ֲܳ��ж� by chenxc 2011-09-20
 * ����ֵ
 * >0  �ɹ��ύ��������ί�е���
 * -1  �ֲֲ���
 * -2  �ʽ�����
 * -99  �������������
 * -100 ��������
****/
as
  v_version varchar2(10):='1.0.2.2';
    v_HoldSum        number(10);   --�ֲֺϼ�����
    v_Payout_B    number(15,2);   --�򷽽��ջ���
     v_Payout_BSum number(15,2):=0;  --�����ջ������
    v_SettleMargin_B    number(15,2):=0;   --�򷽽��ձ�֤��
    v_SettleMargin_BSum    number(15,2):=0;   --�򷽽��ձ�֤�����
    v_TradeMargin_B    number(15,2);   --�򷽽��ױ�֤��
    v_TradeMargin_BSum    number(15,2):=0;   --�򷽽��ױ�֤�����
    v_F_Funds      number(15,2):=0;   --Ӧ�����ʽ�
    v_A_Funds      number(15,2);   --�����ʽ�
    v_F_FrozenFunds  number(15,2); --���񶳽��ʽ�
    v_A_OrderNo       number(15); --ί�е���
    v_HoldOrderNo  number(15):=0;--�ֲ�ί�е���  ---add by zhangjian 2012��3��2��
    v_errorcode number;
    v_errormsg  varchar2(200);
    v_DelayOrderIsPure        number(1);   --�����걨�Ƿ񰴾��������걨
    v_HoldSum_S        number(10):=0;   --�����ֲֺϼ�����
    v_HoldSum_B        number(10):=0;   --�򷽳ֲֺϼ�����
    v_DelaySettlePriceType         number(10);   --�����걨�������� 0��������۽����걨 �� 1���������۽���  -- add  by zhangjian
    v_sql varchar2(500);
    v_qtySum number(15):=0;  -- ��ί�еĽ����걨��������
    v_price number(15,6);-- �����걨�۸�
    v_theOrderPriceSum number(15,6):=0;-- ���ν����걨�����۸����
    v_holdQty number(15):=0;--ÿ�ʳֲ���ϸ�еĳֲ�����
    v_tempQty number(15):=0;--�м����
    v_aheadSettleQty number(15):=0;--��ǰ������������
    v_alreadyQty number(15):=0;--����ί���Ѷ�������
    type cur_T_HoldPosition is ref cursor;
    v_HoldPosition cur_T_HoldPosition;
  v_orderLogNo number(15):=0;--ί���µ���־ ID��
  v_orderSumLogNo number(15):=0;--ί���µ���־�ϼ����� ID

begin

  --1�����ֲ֣�����ס�ֲֺϼƼ�¼
  begin
      select nvl(holdQty - frozenQty, 0) into v_HoldSum
      from T_CustomerHoldSum
      where CustomerID = p_CustomerID
        and CommodityID = p_CommodityID
        and bs_flag = 1 for update;
  exception
        when NO_DATA_FOUND then
            rollback;
           return -1;  --�ֲֲ���
    end;
    --���������޸��걨�����жϣ��þ����������ǵ����ֲܳ��ж� by chenxc 2011-09-20
    --�����걨�Ƿ񰴾��������걨
  select DelayOrderIsPure into v_DelayOrderIsPure from T_A_Market;
  if(v_DelayOrderIsPure = 1) then --�����������걨
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
          return -1;  --������������
      end if;
  else
      if(v_HoldSum < p_Quantity) then
          rollback;
          return -1;  --�ֲֲ���
      end if;
    end if;
    --2����鲢�����ʽ𣺶����򷽽��ջ���+�򷽽��ձ�֤��-��ռ�õĽ��ױ�֤��
      --���ݽ����걨�۸����� �ж���ζ����ʽ�0��������۽��� ��1���������۽���  mod by zhangjian
    select   DelaySettlePriceType into v_DelaySettlePriceType from t_commodity where commodityid=p_CommodityID;

    if(v_DelaySettlePriceType=1) then -- ����ǰ������۽���
    select nvl(sum(Quantity-TradeQty),0) into v_qtySum from T_DelayOrders where  commodityid=p_CommodityID and customerid=p_CustomerID and   status in (1,2) and bs_flag=1;
     -- select sum(quantity) into   v_aheadSettleQty from T_E_ApplyAheadSettle where modifier is null;
      v_qtySum:=v_qtySum+v_aheadSettleQty;--�Ѿ����������

    v_sql:='select price,HoldQty,a.A_HoldNo   from T_holdposition a,(select A_HoldNo from T_SpecFrozenHold group by A_HoldNo) b
                 where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and CustomerID='''||p_CustomerID||'''
                   and CommodityID ='''|| p_CommodityID||''' and bs_flag =  1   '||'  order by a.A_HoldNo';
     open v_HoldPosition for v_sql;
        loop
            fetch v_HoldPosition into v_price,v_holdQty,v_HoldOrderNo;
            exit when v_HoldPosition%NOTFOUND;
           v_HoldSum_S:=v_HoldSum_S+v_holdQty;
            v_tempQty:=0; --ÿ����ձ�������
            if(v_HoldSum_S>v_qtySum)then --���㽻�ջ����Լ����ձ�֤���ۻ��������Ǵ��ڵ�ǰ����ί�б����Ѿ����ڵġ�
            if(p_Quantity>=(v_HoldSum_S-v_qtySum))then
            v_tempQty:=v_HoldSum_S-v_qtySum-v_alreadyQty;--��ǰ���������
            v_alreadyQty:=v_tempQty+v_alreadyQty;
            else  --��������㵱ǰ�������˳�����
            v_tempQty:=p_Quantity-v_alreadyQty;
            v_HoldSum_S:=0;
             end if;
            end if;
            --���㽻�ջ���
            v_Payout_B  := FN_T_ComputePayout(p_FirmID,p_CommodityID,1,v_tempQty,v_price);
            --���㽻�ձ�֤��
            v_SettleMargin_B := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,1,v_tempQty,v_price);
            --���㽻�ױ�֤��
            v_TradeMargin_B := FN_T_ComputeMargin(p_FirmID,p_CommodityID,1,v_tempQty,v_price);


            v_Payout_BSum :=v_Payout_BSum+v_Payout_B;--�ۻ����ջ���
            v_SettleMargin_BSum :=v_SettleMargin_BSum+v_SettleMargin_B;  --�ۻ����ձ�֤��
            v_TradeMargin_BSum := v_TradeMargin_BSum+v_TradeMargin_B;  --�ۼӽ��ױ�֤��
            v_theOrderPriceSum :=v_theOrderPriceSum+v_price*v_tempQty;--�ۼӶ����۸�

            --ѭ��ÿ�ʳֲ���ϸ��Ҫ����ί����־  add by zhangjian 2012��3��2��
            select SEQ_T_D_OrderLog.nextval into v_orderLogNo  from dual  ;
            insert into T_D_DelayOrderLog  values (v_orderLogNo,p_firmid,1,p_CommodityID,v_HoldOrderNo,v_price,v_tempQty,v_SettleMargin_B,v_TradeMargin_B,v_Payout_B,Sysdate,null );

            if(v_HoldSum_S=0)then
                   v_price:=v_theOrderPriceSum/p_Quantity;--����˳�ѭ�������ƽ�������۸�
                   exit;
               end if;
        end loop;

   elsif(v_DelaySettlePriceType=0)then --����ǰ�����۽���
   v_price:=p_Price;
  --���㽻�ջ���
  v_Payout_B := FN_T_ComputePayout(p_FirmID,p_CommodityID,1,p_Quantity,v_price);
  --���㽻�ձ�֤��
  v_SettleMargin_B := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,1,p_Quantity,v_price);
              v_Payout_BSum :=v_Payout_B;
              v_SettleMargin_BSum :=v_SettleMargin_B;
   --���ױ�֤��
   v_TradeMargin_BSum:=p_TradeMargin_B;
  end if;
    --Ӧ�����ʽ�
    v_F_Funds := v_Payout_BSum + v_SettleMargin_BSum - v_TradeMargin_BSum;
    --��������ʽ𣬲���ס�����ʽ�
    v_A_Funds := FN_F_GetRealFunds(p_FirmID,1);

    --��������ί�кϼƱ���־   --add by zhangjian  2012��3��2��
    select SEQ_T_D_OrderSumLog.nextval  into v_orderSumLogNo from dual;
    insert into  T_D_DelayOrderSumLog values (v_orderSumLogNo,p_firmid,1,p_CommodityID,v_price,p_Quantity,v_SettleMargin_BSum,p_TradeMargin_B,v_Payout_BSum,v_A_Funds,v_F_Funds,Sysdate,null);


    if(v_A_Funds < v_F_Funds) then
        rollback;
        return -2;  --�ʽ�����
    end if;
  --3�����½��׿ͻ��ֲֺϼƵĶ�������
    update T_CustomerHoldSum set frozenQty = frozenQty + p_Quantity
    where CustomerID = p_CustomerID
    and CommodityID = p_CommodityID
    and bs_flag = 1;
    --4�����¶����ʽ�
  v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,v_F_Funds,'15');
    --5����������ί�б�������ί�е���
    select SEQ_T_DelayOrders.nextval into v_A_OrderNo from dual;
    insert into T_DelayOrders
      ( a_orderno,    CommodityID,   CustomerID,    traderid,   bs_flag, DelayOrderType, status, quantity, price, tradeqty, frozenfunds, unfrozenfunds, ordertime, withdrawtime, ordererip, signature,  FirmID ,ConsignerID)
    values
      (v_A_OrderNo,  p_CommodityID, p_CustomerID,  p_TraderID,     1,           1,          1,  p_Quantity, v_price,  0,     v_F_Funds,       0,         sysdate,      null,       null,     null,     p_FirmID ,p_ConsignerID);


    --����ʵʱ��ʾ��Ҫ��������
    if(p_DelayQuoShowType = 1) then
      update T_DelayQuotation set BuySettleQty=BuySettleQty + p_Quantity,CreateTime=sysdate where CommodityID = p_CommodityID;
    end if;

    commit;
    return v_A_OrderNo;
exception
    when NO_DATA_FOUND then
        rollback;
        return -99;  --�������������
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


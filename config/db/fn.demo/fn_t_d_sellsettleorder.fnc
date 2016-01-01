create or replace function FN_T_D_SellSettleOrder(
    p_FirmID     varchar2,   --������ID
    p_TraderID       varchar2,  --����ԱID
    p_CommodityID varchar2 ,--��ƷID
    p_Quantity       number ,--����
    p_Price       number ,--ί�м۸���������
  p_CustomerID     varchar2,  --���׿ͻ�ID
  p_ConsignerID       varchar2,  --��Ϊί��ԱID
  p_DelayQuoShowType       number,  --����������ʾ���ͣ�0�������걨�������������걨������ʾ�� 1��ʵʱ��ʾ��
  p_DelayNeedBill       number  --���ڽ����Ƿ���Ҫ�ֵ���0������Ҫ�� 1����Ҫ��
) return number
/****
 * �������걨ί��
 * ���������޸��걨�����жϣ��þ����������ǵ����ֲܳ��ж� by chenxc 2011-09-20
 * ����ֵ
 * >0  �ɹ��ύ��������ί�е���
 * -2  �ʽ�����
 * -31  �ֲֲ���
 * -32  �ֵ���������
 * -99  �������������
 * -100 ��������
****/
as
    v_version varchar2(10):='1.0.2.3';
    v_HoldSum        number(10):=0;   --�����ֲֺϼ�����
    v_SettleMargin_S    number(15,2);   --�������ձ�֤��
    v_SettleMargin_SSum    number(15,2):=0;   --�������ձ�֤�����
    v_TradeMargin_S    number(15,2);   --�������ױ�֤��
    v_TradeMargin_SSum    number(15,2):=0;   --�������ױ�֤�����
    v_F_Funds      number(15,2):=0;   --Ӧ�����ʽ�
    v_A_Funds      number(15,2);   --�����ʽ�
    v_F_FrozenFunds  number(15,2); --���񶳽��ʽ�
    v_ret  number(4);
    v_A_OrderNo       number(15); --ί�е���
    v_HoldOrderNo  number(15):=0;--�ֲ�ί�е���
    v_errorcode number;
    v_errormsg  varchar2(200);
    v_DelayOrderIsPure        number(1);   --�����걨�Ƿ񰴾��������걨
  v_HoldSum_S        number(10):=0;   --�����ֲֺϼ�����
  v_DelaySettlePriceType         number(10);   --�����걨�������� 0��������۽����걨 �� 1���������۽���  -- add  by zhangjian
   v_sql varchar2(500);
   v_qtySum number(15):=0;  --��ί�еĽ����걨��������
   v_price number(15,6);-- �����걨�۸�
   v_theOrderPriceSum number(15,6):=0;-- ���ν����걨�����۸����
   v_holdQty number(15):=0;--ÿ�ʳֲ���ϸ�еĳֲ�����
   v_tempQty number(15):=0;--�м����
    v_alreadyQty number(15):=0;--����ί���Ѷ�������
  type cur_T_HoldPosition is ref cursor;
  v_HoldPosition cur_T_HoldPosition;
  v_orderLogNo number(15):=0;--ί���µ���־ ID��
  v_orderSumLogNo number(15):=0;--ί���µ���־�ϼ����� ID��
  v_HoldSum_B number;
begin
  --1�����ֲֲ�����ֲ�
  begin
      select nvl(holdQty - frozenQty, 0) into v_HoldSum
      from T_CustomerHoldSum
      where CustomerID = p_CustomerID
        and CommodityID = p_CommodityID
        and bs_flag = 2 for update;
  exception
        when NO_DATA_FOUND then
            rollback;
           return -31;  --�ֲֲ���
    end;
    --���������޸��걨�����жϣ��þ����������ǵ����ֲܳ��ж� by chenxc 2011-09-20
    --�����걨�Ƿ񰴾��������걨
  select DelayOrderIsPure into v_DelayOrderIsPure from T_A_Market;
  if(v_DelayOrderIsPure = 1) then --�����������걨
      begin
        select holdQty+GageQty into v_HoldSum_B
        from T_CustomerHoldSum
        where CustomerID = p_CustomerID
          and CommodityID = p_CommodityID
          and bs_flag = 1 ;
    exception
          when NO_DATA_FOUND then
              v_HoldSum_S := 0;
      end;
      if(v_HoldSum-v_HoldSum_B < p_Quantity) then
          rollback;
          return -31;  --������������
      end if;
  else
      if(v_HoldSum < p_Quantity) then
          rollback;
          return -31;  --�ֲֲ���
      end if;
    end if;
    --<<Added by Lizs 2010/7/15 �������걨ʱ���Ӷ��ύ�ձ�֤��
    --2����鲢�����ʽ𣺶����������ձ�֤��-����ռ�õĽ��ױ�֤��
     --���ݽ����걨�۸����� �ж���ζ����ʽ�0��������۽��� ��1���������۽���  mod by zhangjian
    select   DelaySettlePriceType into v_DelaySettlePriceType from t_commodity where commodityid=p_CommodityID;
    if(v_DelaySettlePriceType=1) then -- ����ǰ������۽���

      select nvl(sum(Quantity-TradeQty),0) into v_qtySum from T_DelayOrders where  commodityid=p_CommodityID and customerid=p_CustomerID   and status in (1,2) and bs_flag=2;
     -- select sum(quantity) into   v_aheadSettleQty from T_E_ApplyAheadSettle;
     -- v_qtySum:=v_qtySum+v_aheadSettleQty;--�Ѿ����������

    v_sql:='select price,HoldQty,a.A_HoldNo   from T_holdposition a,(select A_HoldNo from T_SpecFrozenHold group by A_HoldNo) b
                 where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and CustomerID='''||  p_CustomerID||'''
                   and CommodityID ='''|| p_CommodityID||''' and bs_flag =  2   '||' order by a.A_HoldNo';
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

           --���㽻�ױ�֤��
              v_TradeMargin_S := FN_T_ComputeMargin(p_FirmID,p_CommodityID,2,v_tempQty,v_price);
            --���㽻�ձ�֤��
              v_SettleMargin_S := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,2,v_tempQty,v_price);

               v_TradeMargin_SSum :=v_TradeMargin_SSum+v_TradeMargin_S;--�ۼӽ��ױ�֤��
              v_SettleMargin_SSum :=v_SettleMargin_SSum+v_SettleMargin_S;--�ۼӽ��ձ�֤��
              v_theOrderPriceSum :=v_theOrderPriceSum+v_price*v_tempQty;--�ۼӶ����۸�


                --ѭ��ÿ�ʳֲ���ϸ��Ҫ����ί����־  add by zhangjian 2012��3��2��
                   select SEQ_T_D_OrderLog.nextval into v_orderLogNo  from dual  ;
             insert into T_D_DelayOrderLog  values (v_orderLogNo,p_firmid,2,p_CommodityID,v_HoldOrderNo,v_price,v_tempQty,v_SettleMargin_S,v_TradeMargin_S,0,Sysdate,null );

               if(v_HoldSum_S=0)then
                   v_price:=v_theOrderPriceSum/p_Quantity;--����˳�ѭ�������ƽ�������۸�
                   exit;
               end if;

            end loop;

   elsif(v_DelaySettlePriceType=0)then --����ǰ�����۽���
    v_price:=p_Price;
    --���㽻�ױ�֤��
    v_TradeMargin_S := FN_T_ComputeMargin(p_FirmID,p_CommodityID,2,p_Quantity,v_price);
    --���㽻�ձ�֤��
    v_SettleMargin_S := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,2,p_Quantity,v_price);
              v_TradeMargin_SSum :=v_TradeMargin_S;
              v_SettleMargin_SSum :=v_SettleMargin_S;
  end if;
    --���㽻�ձ�֤��
    --v_SettleMargin_S := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,2,p_Quantity,p_Price);
    --���㽻�ױ�֤��
    --v_TradeMargin_S := FN_T_ComputeMargin(p_FirmID,p_CommodityID,2,p_Quantity,p_Price);
    --Ӧ�����ʽ�

    v_F_Funds := v_SettleMargin_SSum - v_TradeMargin_SSum;
    --��������ʽ𣬲���ס�����ʽ�
    v_A_Funds := FN_F_GetRealFunds(p_FirmID,1);

       --��������ί�кϼƱ���־   --add by zhangjian  2012��3��2��
    select SEQ_T_D_OrderSumLog.nextval  into v_orderSumLogNo from dual;
    insert into  T_D_DelayOrderSumLog values (v_orderSumLogNo,p_firmid,2,p_CommodityID,v_price,p_Quantity,v_SettleMargin_SSum,v_TradeMargin_SSum,0,v_A_Funds,v_F_Funds,Sysdate,null);


    if(v_A_Funds < v_F_Funds) then
        rollback;
        return -2;  --�ʽ�����
    end if;
    --3�����½��׿ͻ��ֲֺϼƵĶ�������
    update T_CustomerHoldSum set frozenQty = frozenQty + p_Quantity
    where CustomerID = p_CustomerID
    and CommodityID = p_CommodityID
    and bs_flag = 2;
    --4�����ݲ����Ƿ���Ҫ��鲢����ֵ�
    if(p_DelayNeedBill = 1) then
    v_ret := FN_T_D_CheckAndFrozenBill(p_FirmID,p_CommodityID,p_Quantity);
    if(v_ret = -1) then
          rollback;
          return -32;  --�ֵ���������
      end if;
  end if;
    --5�����¶����ʽ�
    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,v_F_Funds,'15');
    -->>======================================================================
    --6����������ί�б�������ί�е���
    select SEQ_T_DelayOrders.nextval into v_A_OrderNo from dual;
    insert into T_DelayOrders
      ( a_orderno,    CommodityID,   CustomerID,    traderid,   bs_flag, DelayOrderType, status, quantity, price, tradeqty, frozenfunds, unfrozenfunds, ordertime, withdrawtime, ordererip, signature,  FirmID ,ConsignerID)
    values
      (v_A_OrderNo,  p_CommodityID, p_CustomerID,  p_TraderID,     2,           1,          1,  p_Quantity, v_price,  0,      v_F_Funds,         0,         sysdate,      null,       null,     null,     p_FirmID ,p_ConsignerID);

    --����ʵʱ��ʾ��Ҫ��������
    if(p_DelayQuoShowType = 1) then
      update T_DelayQuotation set SellSettleQty=SellSettleQty + p_Quantity,CreateTime=sysdate where CommodityID = p_CommodityID;
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
    values(sysdate,'FN_T_D_SellSettleOrder',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/


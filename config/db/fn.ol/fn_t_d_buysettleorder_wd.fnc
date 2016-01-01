create or replace function FN_T_D_BuySettleOrder_WD(
    p_FirmID     varchar2,   --������ID
    p_CustomerID     varchar2,  --���׿ͻ�ID
    p_CommodityID varchar2 ,--��ƷID
    p_Quantity       number ,--ί������
    p_TradeQty       number ,--�ѳɽ�����
    p_Price       number ,--ί�м۸���������
	p_A_OrderNo_W     number,  --����ί�е���
	p_quantity_wd       number,  --��������
	p_frozenfunds     number,  --�����ʽ�
	p_unfrozenfunds       number  --�ⶳ�ʽ�
) return number
/****
 * �����걨ί�г���
 * ����ֵ
 * 1 �ɹ�
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_Margin         number(15,2);   --Ӧ�ձ�֤��
    v_Payout_B    number(15,2);   --�򷽽��ջ���
    v_SettleMargin_B    number(15,2);   --�򷽽��ձ�֤��
    v_to_unfrozenF   number(15,2);
    v_F_FrozenFunds   number(15,2);   --�����̶����ʽ�
    v_MarginPriceType         number(1);     --����ɽ���֤���������� 0:ʵʱ�ͱ���ʱ�������ּۣ�1:ʵʱ�������ۣ����а����ս����
    v_LastPrice    number(15,2);   --������
begin
	--1���ͷ�ʣ��Ķ���ֲ�
    update T_CustomerHoldSum set frozenQty = frozenQty - p_quantity_wd
    where CustomerID = p_CustomerID
      and CommodityID = p_CommodityID
      and bs_flag = 1;
	--2���ͷ�ʣ��Ķ����ʽ𣬸���δ�ɽ�����
    if(p_Quantity - p_TradeQty = p_quantity_wd) then
        v_to_unfrozenF := p_frozenfunds - p_unfrozenfunds;
    else
	    --�����ʽ𣺶����򷽽��ջ���+�򷽽��ձ�֤��-��ռ�õĽ��ױ�֤��
		--���㽻�ջ���
		v_Payout_B := FN_T_ComputePayout(p_FirmID,p_CommodityID,1,p_quantity_wd,p_Price);
		--���㽻�ձ�֤��
		v_SettleMargin_B := FN_T_ComputeSettleMargin(p_FirmID,p_CommodityID,1,p_quantity_wd,p_Price);
	    --���㽻�ױ�֤��
	    select MarginPriceType,LastPrice
	    into v_MarginPriceType,v_LastPrice
	    from T_Commodity where CommodityID=p_CommodityID;
    	if(v_MarginPriceType = 1) then
	    	v_Margin := FN_T_ComputeMargin(p_FirmID,p_CommodityID,1,p_quantity_wd,v_LastPrice);
	    else
	    	v_Margin := FN_T_ComputeMargin(p_FirmID,p_CommodityID,1,p_quantity_wd,p_Price);
	    end if;
	    if(v_Margin < 0) then
	        Raise_application_error(-20040, 'computeMargin error');
	    end if;
	    v_to_unfrozenF := v_Payout_B + v_SettleMargin_B - v_Margin;
    end if;
    update T_DelayOrders set unfrozenfunds = unfrozenfunds + v_to_unfrozenF
    where A_orderNo = p_a_orderno_w;
    --���¶����ʽ�
	v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,-v_to_unfrozenF,'15');

    return 1;
end;
/


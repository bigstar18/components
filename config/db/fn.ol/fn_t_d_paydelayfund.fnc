create or replace function FN_T_D_PayDelayFund(
	p_CommodityID    varchar2, --��Ʒ����
    p_DelayFunds     number   --���ڲ�����
) return number
/****
 * �����������ڲ�����
 * ���ظ������̵����ڲ�����
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_OrderQtySum        number(10);   --����
    v_DelayFundOneInit    number(15,4);   --ĳ������Ӧ�����ڷѣ�δ����
    v_DelayFundOne    number(15,2);   --ĳ������Ӧ�����ڷѣ����㾫ȷ����
    v_DelayFunds      number(15,2):=0;   --���ڲ����Ѻϼ�
    v_Balance      number(15,2);   --�����ʽ�
    v_OrderQtyOne       number(10); --��������
begin
	--1������Ӧ�ò����ѵ�������
	select nvl(sum(DiffQty),0)
	into v_OrderQtySum
    from
    (
    	(select nvl(sum(Quantity-TradeQty),0) DiffQty from T_DelayOrders where DelayOrderType=1 and Status in(5,6) and WithdrawType=4 and CommodityID=p_CommodityID) union all
        (select nvl(sum(TradeQty),0) DiffQty from T_DelayOrders where DelayOrderType=2 and CommodityID=p_CommodityID)
    );

	--2���걨��δ�ܽ��յĽ����̺Ͳ��������ֳɽ��Ľ����̰���ƽ�������ܲ�����
    for cur_DelayFund in(
		select FirmID,nvl(sum(DiffQty),0) DiffQty
		from
		(
			(select FirmID,nvl(sum(Quantity-TradeQty),0) DiffQty from T_DelayOrders where DelayOrderType=1 and Status in(5,6) and WithdrawType=4 and CommodityID=p_CommodityID group by FirmID) union all
			(select FirmID,nvl(sum(TradeQty),0) DiffQty from T_DelayOrders where DelayOrderType=2 and CommodityID=p_CommodityID group by FirmID)
		)
		group by FirmID
    )
    loop
    	v_OrderQtyOne := cur_DelayFund.DiffQty;
		if(v_OrderQtyOne > 0) then
			--ĳ������Ӧ���������ܲ����ѡ����������˽�����Ӧ������,����С�������ԭ�򣬾�ȷ����
			v_DelayFundOneInit := p_DelayFunds/v_OrderQtySum*v_OrderQtyOne;
			v_DelayFundOne := trunc(v_DelayFundOneInit,2);
	        --�����������ڷ� ����д��ˮ
    		v_Balance := FN_F_UpdateFundsFull(cur_DelayFund.FirmID,'15021',v_DelayFundOne,null,p_CommodityID,null,null);
    		v_DelayFunds := v_DelayFunds + v_DelayFundOne;
		end if;
    end loop;
	--3�������ܲ������ڷ�
    return v_DelayFunds;
end;
/


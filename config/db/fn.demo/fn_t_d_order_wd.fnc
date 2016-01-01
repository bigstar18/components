create or replace function FN_T_D_Order_WD(
	p_WithdrawerID       varchar2,  --����ԱID
    p_A_OrderNo_W   number,             --������ί�е���
    p_WithdrawType  number,  			--�������� 1:ί�г�����4������ʱ�Զ�����
    p_Quantity      number,              --�����ɹ������������-1��ʾ�ֲ�ί�б������㳷������
	p_DelayQuoShowType       number  --����������ʾ���ͣ�0�������걨�������������걨������ʾ�� 1��ʵʱ��ʾ��
) return number
/****
 * ���ڽ���ί�г���
 * 1��������Զ������򳷵�Ա�ͳ�������Ϊnull
 * ����ֵ
 * 1 �ɹ�
 * 2 �Ѵ����
 * -99  �������������
 * -100 ��������
****/
as
    v_version varchar2(10):='1.0.2.3';
    v_a_orderno_w    number(15);
    v_status         number(2);
    v_CommodityID varchar2(16);
    v_FirmID     varchar2(32);
    v_CustomerID     varchar2(40);
    v_bs_flag        number(2);
    v_ordertype      number(2);
    v_quantity       number(10);
    v_price          number(15,2);
    v_tradeqty       number(10);
    v_frozenfunds    number(15,2);
    v_unfrozenfunds  number(15,2);
    v_quantity_wd    number(10);
    v_ret  number(4);
    v_errorcode number;
    v_errormsg  varchar2(200);
begin
    v_a_orderno_w := p_A_OrderNo_W;
    --��ȡ��������Ϣ
    select CommodityID, Firmid, bs_flag, DelayOrderType, status, quantity, price, tradeqty, frozenfunds, unfrozenfunds,CustomerID
    into v_CommodityID, v_FirmID, v_bs_flag, v_ordertype, v_status, v_quantity, v_price, v_tradeqty, v_frozenfunds, v_unfrozenfunds,v_CustomerID
    from T_DelayOrders
    where a_orderno = v_a_orderno_w for update;

    if(v_status in (3,5,6)) then
        rollback;
        return 2;  --�Ѵ����
    end if;

    if(p_WithdrawType = 4) then --�Զ�����
    	v_quantity_wd := v_quantity - v_tradeqty;
    else
    	if(p_Quantity = -1) then  ---1��ʾ�ֲ�ί�б������㳷������
    		v_quantity_wd := v_quantity - v_tradeqty;
    	else
        	v_quantity_wd := p_Quantity;
        end if;
    end if;
    if(v_ordertype=1) then    --�����걨
    	if(v_bs_flag = 1) then  --��
    		v_ret := FN_T_D_BuySettleOrder_WD(v_FirmID,v_CustomerID,v_CommodityID,v_Quantity,v_TradeQty,v_Price,v_A_OrderNo_W,v_quantity_wd,v_frozenfunds,v_unfrozenfunds);
    	else  --��
            v_ret := FN_T_D_SellSettleOrder_WD(v_FirmID,v_CustomerID,v_CommodityID,v_Quantity,v_TradeQty,v_Price,v_A_OrderNo_W,v_quantity_wd,v_frozenfunds,v_unfrozenfunds);
    	end if;
    elsif(v_ordertype=2) then    --�������걨
    	-- add by tangzy 2010-08-07
		if(v_bs_flag = 1) then
            v_ret := FN_T_D_BuyNeutralOrder_WD(v_FirmID,v_CustomerID,v_CommodityID,v_Quantity,v_TradeQty,v_Price,v_A_OrderNo_W,v_quantity_wd,v_frozenfunds,v_unfrozenfunds);
		else
		    v_ret := FN_T_D_SellNeutralOrder_WD(v_FirmID,v_CustomerID,v_CommodityID,v_Quantity,v_TradeQty,v_Price,v_A_OrderNo_W,v_quantity_wd,v_frozenfunds,v_unfrozenfunds);
		end if;
    end if;

    --����ί�У�1������ί�г�����Ҫ���±���ί�е�״̬��5��6���ͳ������ͣ�1��2��
    --        2�������Զ�������Ҫ���±���ί�е�״̬��5��6���ͳ������ͣ�3��4��
    if(p_WithdrawType = 4) then --�Զ�����
          --����ί��״̬
          if(v_tradeqty = 0) then
            v_status := 5; --ȫ������
          else
            v_status := 6; --���ֳɽ��󳷵�
          end if;
	else
        --����ί��״̬
        if(v_quantity = v_quantity_wd) then
            v_status := 5; --ȫ������
        elsif(v_quantity > v_quantity_wd) then
            v_status := 6; --���ֳɽ��󳷵�
        else
            Raise_application_error(-20020, 'Parameter p_quantity > the order ''s available num');
        end if;

    end if;
	update T_DelayOrders set status=v_status,WithdrawType=p_WithdrawType,WithdrawTime=sysdate,WithdrawerID=p_WithdrawerID where A_orderNo = v_a_orderno_w;
    --����ʵʱ��ʾ��Ҫ��������
    --2010-01-21 ����Զ�����ʱ��Ӱ����������
    if(p_WithdrawType=1 and p_DelayQuoShowType = 1) then
	    if(v_ordertype=1) then    --�����걨
	    	if(v_bs_flag = 1) then  --��
	    		update T_DelayQuotation set BuySettleQty=BuySettleQty - v_quantity_wd,CreateTime=sysdate where CommodityID = v_CommodityID;
	    	else  --��
	    		update T_DelayQuotation set SellSettleQty=SellSettleQty - v_quantity_wd,CreateTime=sysdate where CommodityID = v_CommodityID;
	    	end if;
	    elsif(v_ordertype=2) then    --�������걨
	    	-- add by tangzy 2010-08-07
			if(v_bs_flag = 1) then  --��
	    		update T_DelayQuotation set BuyNeutralQty=BuyNeutralQty - v_quantity_wd,CreateTime=sysdate where CommodityID = v_CommodityID;
	    	else  --��
	    		update T_DelayQuotation set SellNeutralQty=SellNeutralQty - v_quantity_wd,CreateTime=sysdate where CommodityID = v_CommodityID;
	    	end if;
	    end if;
    end if;

    commit;
    return 1;

exception
    when NO_DATA_FOUND then
        rollback;
        return -99;  --�������������
    when others then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_D_Order_WD',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/


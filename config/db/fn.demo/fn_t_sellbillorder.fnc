create or replace function FN_T_SellBillOrder(
    p_FirmID     varchar2,  --������ID
    p_TraderID       varchar2,  --����ԱID
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_price          number,
    p_quantity       number,
  --p_Margin     number,     --ί��Ӧ�ձ�֤��
    p_Fee   number,   --ί��Ӧ��������
	p_CustomerID     varchar2,  --���׿ͻ�ID
	p_ConsignerID       varchar2 --ί��ԱID

) return number
/****
 * ���ֵ�ί��
 * ����ֵ
 * >0  �ɹ��ύ��������ί�е���
 * -1  �ʽ�����
 * -2  ���������̶Դ���Ʒ����󶩻���
 * -3  �����������ܵ���󶩻���
 * -4  ����Ʒ����󶩻���
 * -5  ������Ʒ��󶩻���
 * -6  ���������̶Դ���Ʒ����󾻶�����
 * -7  �����������ί����������java���жϣ�2009-09-18
 * -8  �ֶ��������ڿ�������
 * -9  û�ж�Ӧ����Ч�ֵ��ֶ���¼
 * -99  �������������
 * -100 ��������
****/
as
	--v_version varchar2(10):='1.0.0.9';
    v_F_Funds        number(15,2):=0;   --Ӧ�����ʽ�
    v_VirtualFunds   number(15,2);   --�����ʽ�
    v_A_Funds        number(15,2);   --�����ʽ�
    v_HoldSum        number(15,0);   --�ֲֺϼ�
	v_HoldSum_b        number(15,0);   --�ֲֺϼ�b
	v_HoldSum_s        number(15,0);   --�ֲֺϼ�s
    v_A_OrderNo      number(15,0);   --ί�к�
    v_NotTradeSum    number(15,0);   --����δ�ɽ��ϼ�
	v_NotTradeSum_b    number(15,0);   --����δ�ɽ��ϼ�b
	v_NotTradeSum_s    number(15,0);   --����δ�ɽ��ϼ�s
	v_BreedID      number(10,0);
	v_LimitBreedQty      number(10,0);
	v_LimitCmdtyQty      number(10,0);
	v_FirmCleanQty      number(10,0);
	v_FirmMaxHoldQty      number(10,0);
	v_MaxHoldQty      number(10,0); --��������󶩻���
	v_MaxOverdraft        number(15,2):=0;   --���͸֧���
	v_F_FrozenFunds   number(15,2);   --�����ʽ�
    v_errorcode number;
    v_errormsg  varchar2(200);
  v_AvailableQuantity number(10);--�������� add by yukx 20100507
begin

      begin
        select Quantity-FrozenQty into v_AvailableQuantity from T_ValidGageBill
        where FirmID=p_FirmID
          and CommodityID = p_CommodityID;
          --and BreedID=(select BreedID from t_commodity where CommodityID=p_CommodityID);
        exception
          when NO_DATA_FOUND then
  	      return -9;--û�ж�Ӧ����Ч�ֵ��ֶ���¼
      end;

      if(v_AvailableQuantity<p_Quantity) then
        return -8;--�ֶ��������ڿ�������
      end if;

        --Ӧ�����ʽ�
        --zhengxuan ��ΪӦ���������Ѳ����ᱣ֤��
        --v_F_Funds := p_Margin + p_Fee;
        v_F_Funds :=  p_Fee;

        --��������ʽ�
        select VirtualFunds,MaxHoldQty,MaxOverdraft into v_VirtualFunds,v_MaxHoldQty,v_MaxOverdraft from T_Firm where FirmID = p_FirmID;
        --��������ʽ𣬲���ס�����ʽ�
        v_A_Funds := FN_F_GetRealFunds(p_FirmID,1) + v_VirtualFunds + v_MaxOverdraft;
        if(v_A_Funds < v_F_Funds) then
            rollback;
            return -1;  --�ʽ�����
        else
            --1����֤�Ƿ񳬹��������ܵ����ֲ���
			if(v_MaxHoldQty <> -1) then
				select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum
	            from T_Orders
	            where FirmID = p_FirmID
				and OrderType=1 and Status in(1,2);

	            select nvl(sum(holdqty+GageQty),0) into v_HoldSum
	            from T_FirmHoldSum
	            where FirmID = p_FirmID;

	            if(v_HoldSum + v_NotTradeSum + p_quantity > v_MaxHoldQty) then
	                rollback;
	                return -3;  --�����ܵ����ֲ���
	            end if;
			end if;
			--��Ʒ�ֺ���Ʒ�����л�ȡƷ����󶩻�������Ʒ��󶩻�������������󾻶���������������󶩻���
			select a.BreedID,a.LimitBreedQty,b.LimitCmdtyQty,b.FirmCleanQty,b.FirmMaxHoldQty into v_BreedID,v_LimitBreedQty,v_LimitCmdtyQty,v_FirmCleanQty,v_FirmMaxHoldQty
			from T_A_Breed a,T_Commodity b
			where a.BreedID=b.BreedID and b.CommodityID=p_CommodityID;
			--��ȡ���������ⶩ����
		    begin
		        select CleanMaxHoldQty,MaxHoldQty
		    	into v_FirmCleanQty,v_FirmMaxHoldQty
		        from T_A_FirmMaxHoldQty
		        where FirmID=p_FirmID and CommodityID=p_CommodityID;
		    exception
		        when NO_DATA_FOUND then
		            null;
		    end;
			--2����֤�Ƿ񳬹�Ʒ����󶩻���
			if(v_LimitBreedQty <> -1) then
	            select nvl(sum(a.Quantity-a.TradeQty),0) into v_NotTradeSum
	            from T_Orders a,T_Commodity b
	            where a.CommodityID=b.CommodityID and b.BreedID=v_BreedID
				and a.OrderType=1 and a.BS_Flag=p_bs_flag and a.Status in(1,2);

	            select nvl(sum(a.holdqty+a.GageQty),0) into v_HoldSum
	            from T_FirmHoldSum a,T_Commodity b
	            where a.CommodityID=b.CommodityID and b.BreedID=v_BreedID and a.BS_Flag=p_bs_flag;
	            if(v_HoldSum + v_NotTradeSum + p_quantity > v_LimitBreedQty) then
	                rollback;
	                return -4;  --����Ʒ����󶩻���
	            end if;
			end if;
            --3����֤�Ƿ񳬹���Ʒ��󶩻���
			if(v_LimitCmdtyQty <> -1) then
	            select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum
	            from T_Orders
	            where CommodityID=p_CommodityID
				and OrderType=1 and BS_Flag=p_bs_flag and Status in(1,2);

	            select nvl(sum(holdqty+GageQty),0) into v_HoldSum
	            from T_FirmHoldSum
	            where CommodityID=p_CommodityID and BS_Flag=p_bs_flag;
	            if(v_HoldSum + v_NotTradeSum + p_quantity > v_LimitCmdtyQty) then
	                rollback;
	                return -5;  --������Ʒ��󶩻���
	            end if;
			end if;
            --4����֤�Ƿ񳬹������̶Դ���Ʒ����󶩻���
			if(v_FirmMaxHoldQty <> -1) then
	            select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum
	            from T_Orders
	            where FirmID = p_FirmID and CommodityID=p_CommodityID
				and OrderType=1 and Status in(1,2);

	            select nvl(sum(holdqty+GageQty),0) into v_HoldSum
	            from T_FirmHoldSum
	            where FirmID = p_FirmID and CommodityID=p_CommodityID;

	            if(v_HoldSum + v_NotTradeSum + p_quantity > v_FirmMaxHoldQty) then
	                rollback;
	                return -2;  --���������̶Դ���Ʒ����󶩻���
	            end if;
			end if;
            --5����֤�Ƿ񳬹������̶Դ���Ʒ����󾻶�����
			if(v_FirmCleanQty <> -1) then
	            select nvl(sum(holdqty+GageQty),0) into v_HoldSum_b
	            from T_FirmHoldSum
	            where FirmID = p_FirmID and CommodityID=p_CommodityID and BS_Flag=1;
	            select nvl(sum(holdqty+GageQty),0) into v_HoldSum_s
	            from T_FirmHoldSum
	            where FirmID = p_FirmID and CommodityID=p_CommodityID and BS_Flag=2;
	            if(p_bs_flag = 1) then
		            select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum_b
		            from T_Orders
		            where FirmID = p_FirmID and CommodityID=p_CommodityID and BS_Flag=1
					and OrderType=1 and Status in(1,2);
		            if(v_HoldSum_b + v_NotTradeSum_b + p_quantity - v_HoldSum_s > v_FirmCleanQty) then
		                rollback;
		                return -6;  --���������̶Դ���Ʒ����󾻶�����
		            end if;
		        else
		            select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum_s
		            from T_Orders
		            where FirmID = p_FirmID and CommodityID=p_CommodityID and BS_Flag=2
					and OrderType=1 and Status in(1,2);
		            if(v_HoldSum_s + v_NotTradeSum_s + p_quantity - v_HoldSum_b > v_FirmCleanQty) then
		                rollback;
		                return -6;  --���������̶Դ���Ʒ����󾻶�����
		            end if;
	            end if;
			end if;

       -- zhengxuan ������Ч�ֵ��ֶ���������
       update T_ValidGageBill set Frozenqty=Frozenqty+p_quantity where FirmID=p_FirmID
               and CommodityID=p_CommodityID; --BreedID=(select BreedID from t_commodity where CommodityID=p_CommodityID);

        end if;

        --���¶����ʽ�
		v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,v_F_Funds,'15');
		--����ί�б�������ί�е���
		--���ü��㺯���޸�ί�е��� 2011-2-15 by feijl
	    select FN_T_ComputeOrderNo(SEQ_T_Orders.nextval) into v_A_OrderNo from dual;
	    --zhengxuan ���Ӳֵ���������
      insert into T_Orders
	      (a_orderno,a_orderno_w, CommodityID, Firmid, traderid,    bs_flag, ordertype, status, quantity, price, closemode, specprice, timeflag, tradeqty, frozenfunds, unfrozenfunds, ordertime, withdrawtime, ordererip, signature, CustomerID,ConsignerID,BillTradeType)
	    values
	      (v_A_OrderNo,  null, p_CommodityID, p_Firmid, p_traderid, p_bs_flag,    1 ,      1, p_quantity, p_price, null,     null,      null,    0,         v_F_Funds,     0,           sysdate,      null,        null,     null,p_CustomerID,p_ConsignerID,  1    );
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
    values(sysdate,'FN_T_SellBillOrder',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/


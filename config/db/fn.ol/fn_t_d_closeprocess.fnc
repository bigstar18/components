create or replace function FN_T_D_CloseProcess return number
/****
 * ���ڽ��׽��㴦��
 * ����ֵ
 * 1  �ɹ��ύ
 * �޸����ڲ����Ѱ�������ȡ 2011-09-20 by chenxc
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_DelayRecoupRate        number(7,5);   --�����ڲ�������
	v_DelayRecoupRate_S        number(7,5);   --�������ڲ�������,2011-09-05 by chenxc
    v_ContractFactor    number(12,2);   --��Լ����
    v_DelayFeeWay    number(2);   --���ڷ���ȡ��ʽ
    v_DelayFunds      number(20,6):=0;   --���ڲ�����
    v_Price      number(10,2);   --��������
    v_ChargeDelayFund  number(15,2); --�����ڷ�
    v_PayDelayFund       number(15,2); --�����ڷ�
    v_DiffFund      number(15,2); --����׼����
    v_Balance      number(15,2); --�����ʽ�
    v_TradeDate date;
    v_DelayDays    number(5);   --��������
    v_errorcode number;
    v_errormsg  varchar2(200);
    v_StoreFunds number(20,6):=0;   --�ִ�������
    v_StoreRecoupRate number(7,5);   --�ִ���������
begin
	--0��������������
	v_DelayDays := FN_T_D_ComputeDelayDays();
	--1����ѯ��Ʒ�������ڲ����ѣ������걨�����Լ���ӡ����ս���ۡ���������
    for delayOrder in(select CommodityID,max(BS_Flag) BS_Flag,nvl(sum(DiffQty),0) DiffQty
                      from ((select CommodityID,max(decode(BS_Flag,1,2,1)) BS_Flag,nvl(sum(Quantity-TradeQty),0) DiffQty from T_DelayOrders where DelayOrderType=1 and Status in(5,6) and WithdrawType=4 group by CommodityID) union all
                           (select  CommodityID,max(BS_Flag) BS_Flag,nvl(sum(TradeQty),0) DiffQty from T_DelayOrders where DelayOrderType=2  group by CommodityID))
                      group by CommodityID)
    loop
    	select StoreRecoupRate,DelayRecoupRate,DelayRecoupRate_S,ContractFactor,DelayFeeWay into v_StoreRecoupRate, v_DelayRecoupRate,v_DelayRecoupRate_S,v_ContractFactor,v_DelayFeeWay from T_Commodity where CommodityID = delayOrder.CommodityID;
    	select Price into v_Price from T_Quotation where CommodityID = delayOrder.CommodityID;
    	if(v_DelayFeeWay = 1) then  --����Ȼ��������ȡ
			--������򷽵Ĳ����ѣ���������������ʸ����򷽲������ʣ�delayOrder.BS_Flag��ָ�ս����̲����ѵķ��򣬶����Ǹ��������̲����ѷ���,2011-09-05 by chenxc
			if(delayOrder.BS_Flag = 1) then
				v_DelayRecoupRate := v_DelayRecoupRate_S;
			end if;
    		v_DelayFunds := delayOrder.DiffQty * v_ContractFactor * v_Price * v_DelayRecoupRate * v_DelayDays;
    		-- ���Ӳִ������ѹ���,����������������ʱ����ȡ�����ڷѷ�������� 2011-2-23 by feijl
			if (delayOrder.BS_Flag = 1) then
			    v_StoreFunds := delayOrder.DiffQty * v_ContractFactor * v_StoreRecoupRate * v_DelayDays;
			else
			    v_StoreFunds := 0;
			end if;
			--2�������ڷ�
    		v_ChargeDelayFund := FN_T_D_ChargeDelayFund(delayOrder.CommodityID,delayOrder.BS_Flag,v_DelayFunds+v_StoreFunds);
    		--3�������ڷ�
    		v_PayDelayFund := FN_T_D_PayDelayFund(delayOrder.CommodityID,v_DelayFunds+v_StoreFunds);
    		/*
    		if(v_ChargeDelayFund < v_PayDelayFund) then
    			rollback;
    			return -1;--���ڷ���ȡ����
    		end if;
    		--4�����Ǯ�������׼���𣬸��ڲ�������
    		v_DiffFund := v_ChargeDelayFund - v_PayDelayFund;
    		if(v_DiffFund > 0) then
		        --�����ս� ����д��ˮ
	    		v_Balance := FN_F_UpdateFundsFull(null,'15022',v_DiffFund,null,delayOrder.CommodityID,null,null);
    		end if;
    		*/
    	end if;

    end loop;

	--5����ȡ��������
	select TradeDate into v_TradeDate from T_SystemStatus;
    --6��������ʷ����ί�б�ɾ����������
    insert into T_H_DelayOrders select v_TradeDate,a.* from T_DelayOrders a;
    delete from T_DelayOrders;
    --7��������ʷ���ڳɽ���ɾ����������
    insert into T_H_DelayTrade select v_TradeDate,a.* from T_DelayTrade a;
    delete from T_DelayTrade;
    --8��ɾ����ʷ�������ݲ�������ʷ��������
	delete from T_H_DelayQuotation where ClearDate=v_TradeDate;
    insert into T_H_DelayQuotation select v_TradeDate,a.* from T_DelayQuotation a;

    return 1;

end;
/


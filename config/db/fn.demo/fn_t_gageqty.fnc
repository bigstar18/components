create or replace function FN_T_GageQty(
    --p_ApplyID        number,     --���뵥�� modify by yukx 20100421
    p_CommodityID varchar2, --��Ʒ����
    p_BS_Flag        number,    --������־��Ŀǰֻ������
    p_CustomerID     varchar2,     --�ͻ�ID
    --p_BillID         varchar2, --�ֵ��� modify by yukx 20100421
    --p_Modifier       varchar2,   --������ modify by yukx 20100421
    p_Quantity       number   --�ֵ�����
) return number
/****
 * �ֶ�
 * ����ֵ
 * 1 �ɹ�
 * 2 �Ѵ����
 * -1  �ֶ�ʱ�����ɵֶ�����
 * -2  �ֶ��������ڳֲ�����
 * -3  �ֶ��������ڿ�������
 * -4  û�ж�Ӧ����Ч�ֵ��ֶ���¼
 * -100 ��������
****/
as
	v_version varchar2(10):='1.0.3.1';
    v_CommodityID varchar2(16);
    v_FirmID     varchar2(32);
    v_BS_Flag        number(2);
    v_price          number(15,2);
    v_frozenQty      number(10);
    v_holdQty        number(10);
    v_Margin         number(15,2):=0;   --Ӧ�ձ�֤��
	v_Assure         number(15,2):=0;   --Ӧ�յ�����
    v_A_HoldNo       number(15);
    v_HoldSumQty     number(10);
    v_MarginPriceType       number(1);
    v_ContractFactor T_Commodity.ContractFactor%type;
    v_errorcode      number;
    v_errormsg       varchar2(200);
    v_MarginPrice    number(15,2);  --����ɽ���֤��ļ۸�
	v_HoldFunds    number(15,2):=0;  --ƽ��ʱӦ�˳ֲֽ��
    v_unCloseQty     number(10):=p_quantity; --δƽ�����������м����
    v_margin_one     number(15,2);   --�����м����
	v_Assure_one     number(15,2);   --�����м����
    v_tradedAmount   number(10):=0;  --�ɽ�����
	v_CustomerID        varchar2(40);
	v_CloseAlgr           number(2);
	v_orderby  varchar2(100);
	v_F_FrozenFunds   number(15,2);
	type c_HoldPosition is ref cursor;
	v_HoldPosition c_HoldPosition;
	v_sql varchar2(1000);
	v_num            number(10);
	v_FL_ret            timestamp;
	v_AtClearDate          date;
	v_closeTodayHis        number(2);    --ƽ��ֻ�����ʷ��(0ƽ��֣�1ƽ��ʷ��)
	v_YesterBalancePrice    number(15,2);
	v_TradeDate date;
	v_GageMode number(2);--�ֶ�ģʽ����0ȫ�ֶ���1��ֶ�����ֶ�ʱҪ���㸡����2009-10-14
  v_AvailableQuantity number(10);--�������� add by yukx 20100507
begin
     -- modify by yukx 20100421
	    --select count(*) into v_num from T_ValidBill where BillID = p_BillID and Status=1;
	    --if(v_num >0) then
	    --   rollback;
	    --    return 2;  --�Ѵ����
	    --end if;

      --��֤�ֶ�������������� add by yukx 20100507
      --����ʱ�����Ѷ��ᣬ��ʱֻ����֤���������Ƿ����㣬ԭ��v_AvailableQuantity=Quantity-FrozenQty  20131211 by jwh
      begin
        select FrozenQty into v_AvailableQuantity from T_ValidGageBill
        where FirmID=(select FirmID from T_Customer where CustomerID=p_CustomerID)
          and commodityID=p_CommodityID;
        exception
          when NO_DATA_FOUND then
  	      return -4;--û�ж�Ӧ����Ч�ֵ��ֶ���¼
      end;

      if(v_AvailableQuantity<p_Quantity) then
        return -3;--�ֶ��������ڿ�������
      end if;

		v_CustomerID := p_CustomerID;
	    v_CommodityID := p_CommodityID;
        v_BS_Flag := p_BS_Flag;
        --��ȡƽ���㷨����֤���������,��Լ����
        select CloseAlgr,GageMode into v_CloseAlgr,v_GageMode from T_A_Market;
        select MarginPriceType,ContractFactor,LastPrice into v_MarginPriceType,v_ContractFactor,v_YesterBalancePrice from T_Commodity where CommodityID=v_CommodityID;
		select TradeDate into v_TradeDate from T_SystemStatus;

     begin
      select holdqty, frozenqty  into v_HoldSumQty, v_frozenQty from T_CustomerHoldSum
        where CustomerID = v_CustomerID
          and CommodityID = v_CommodityID
          and bs_flag = v_BS_Flag for update;
        exception
        when NO_DATA_FOUND then
  	     return -13;--δ��ѯ����Ӧ�ֲ�����
      end;

      --����ʱ�����Ѷ��ᣬ��ʱֻ����֤���������Ƿ����㣬ԭ��֤�� p_quantity > v_HoldSumQty-v_frozenqty 20131211 by jwh
        if(p_quantity > v_frozenqty) then
            rollback;
            return -1;
        end if;
    	--�����ֲ���ϸ�����������˵�ָ��ƽ�ֶ��������
        --����ƽ���㷨(0�ȿ���ƽ��1����ƽ��2�ֲ־���ƽ��(������)ѡ����������
        if(v_CloseAlgr = 0) then
	        v_orderby := ' order by a.A_HoldNo ';
	    elsif(v_CloseAlgr = 1) then
	        v_orderby := ' order by a.A_HoldNo desc ';
	    end if;


    	v_sql := 'select a.a_holdno,FirmID,price,(a.HoldQty-nvl(b.FrozenQty,0)),a.AtClearDate from T_holdposition a,(select A_HoldNo,nvl(sum(FrozenQty),0) FrozenQty from T_SpecFrozenHold group by A_HoldNo) b ' ||
                 ' where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and nvl(b.FrozenQty,0)<a.HoldQty and CustomerID=''' || v_CustomerID ||
                 ''' and CommodityID =''' || v_CommodityID || ''' and bs_flag = ' || v_BS_Flag || v_orderby;

            open v_HoldPosition for v_sql;
            loop
                fetch v_HoldPosition into v_a_holdno, v_FirmID, v_price, v_holdqty,v_AtClearDate;
                exit when v_HoldPosition%NOTFOUND;
                if(v_holdqty<=v_unCloseQty) then
                    v_tradedAmount:=v_holdqty;
                else
                    v_tradedAmount:=v_unCloseQty;
                end if;

                --����Ӧ�˱�֤�𣬸�������ѡ�񿪲ּۻ�������������
				if(v_MarginPriceType = 1) then
			        v_MarginPrice := v_YesterBalancePrice;
			    elsif(v_MarginPriceType = 2) then
					--�ж���ƽ��ֻ���ƽ��ʷ��
				    if(trunc(v_TradeDate) = trunc(v_AtClearDate)) then
				        v_closeTodayHis := 0;
				    else
				    	v_closeTodayHis := 1;
				    end if;
					if(v_closeTodayHis = 0) then  --ƽ���
						v_MarginPrice := v_price;
					else  --ƽ��ʷ��
				        v_MarginPrice := v_YesterBalancePrice;
				    end if;
				else  -- default type is 0
					v_MarginPrice := v_price;
				end if;

                v_Margin_one := FN_T_ComputeMargin(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount,v_MarginPrice);
                if(v_Margin_one < 0) then
                    Raise_application_error(-20040, 'computeMargin error');
                end if;
		        --���㵣����
		        v_Assure_one := FN_T_ComputeAssure(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount,v_MarginPrice);
		        if(v_Assure_one < 0) then
		            Raise_application_error(-20041, 'computeAssure error');
		        end if;
		        --��֤��Ӧ���ϵ�����
		        v_Margin_one := v_Margin_one + v_Assure_one;

                v_Margin:=v_Margin + v_Margin_one;
                v_Assure:=v_Assure + v_Assure_one;
	            --����Ӧ�˳ֲֽ��
	            v_HoldFunds := v_HoldFunds + v_tradedAmount*v_price*v_ContractFactor;

                --���³ֲּ�¼
		        update T_holdposition
                set holdqty = holdqty - v_tradedAmount,HoldMargin=HoldMargin-v_Margin_one,HoldAssure=HoldAssure-v_Assure_one,GageQty=GageQty+v_tradedAmount
                where a_holdno = v_a_holdno;
                v_unCloseQty:=v_unCloseQty - v_tradedAmount;
                exit when v_unCloseQty=0;
            end loop;
            close v_HoldPosition;
            if(v_unCloseQty>0) then --�ֶ��������ڳֲ�����������
                rollback;
                return -2;
            end if;

        --���ü��ٽ��׿ͻ��������̵ĳֲֺϼ���Ϣ�洢��ע�����ֵ����ٳֲֲ�һ��   2009-10-15
        if(v_GageMode=1) then
        	v_num := FN_T_SubHoldSum(p_quantity,-p_quantity,v_Margin,v_Assure,v_CommodityID,v_ContractFactor,v_BS_Flag,v_FirmID,0,v_CustomerID,0,v_GageMode,p_quantity);
		else
			v_num := FN_T_SubHoldSum(p_quantity,-p_quantity,v_Margin,v_Assure,v_CommodityID,v_ContractFactor,v_BS_Flag,v_FirmID,v_HoldFunds,v_CustomerID,0,v_GageMode,p_quantity);
		end if;

        --���±�֤��͵�����
        update T_Firm
        set runtimemargin = runtimemargin - v_Margin,
            RuntimeAssure = RuntimeAssure - v_Assure
        where Firmid = v_FirmID;
        --���¶����ʽ��ͷŸ��˲��ֵı�֤��
		v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,-(v_Margin-v_Assure),'15');

        --modify by yukx 20100421
        --������Ч�ֵ���
        --insert into T_ValidBill
        --    (ValidID,               ApplyID, CommodityID,   FirmID_S, CustomerID_S,BillID,  Quantity,  BillType,  Status,CreateTime,Creator)
        --values
        --    (SEQ_T_ValidBill.nextval,p_ApplyID,v_CommodityID, v_FirmID, v_CustomerID,p_BillID,p_Quantity,    1,        1  ,  sysdate,  p_Modifier);
        update T_ValidGageBill set Quantity=Quantity-p_Quantity,FrozenQty=FrozenQty-p_Quantity where FirmID=v_FirmID
               and commodityID=p_CommodityID;

    commit;
    --�ύ�����˽����̸���
    v_FL_ret := FN_T_UpdateFloatingLoss(null,null,null);

    return 1;
exception
    when OTHERS then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_GageQty',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/


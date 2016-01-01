create or replace function FN_T_D_SettleOne(
    p_CommodityID varchar2,   --��Ʒ����
	p_Price         number,  --���ռ�
	p_BS_Flag     number,  --������־
    p_CustomerID    varchar2,     --���׿ͻ�ID
    p_HoldQty      number,   --���ճֲ����������ǵֶ�����
	p_GageQty      number   --���յֶ�������Ŀǰ��֧�ֵֶ�����
) return number
/****
 * �������������ڽ���
 * ����ֵ
 * 1 �ɹ�
 * -3  ���ճֲ��������ڿɽ��ճֲ�����
 * -4  ���յֶ��������ڿɵֶ�����
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_CommodityID varchar2(16);
    v_CustomerID        varchar2(40);
    v_FirmID varchar2(32);
    v_HoldQty  number;
    v_frozenQty      number(10);
    v_Margin_one         number(15,2):=0;
    v_closeFL_one         number(15,2):=0;    --һ����¼�Ľ���ӯ��
    v_Fee_one         number(15,2):=0;    --һ����¼�Ľ���������
	v_Assure_one         number(15,2):=0;
    v_Payout_one         number(15,2):=0;
    v_BS_Flag           number(2);
    v_Price         number(15,2);
    v_ContractFactor    number(12,2);
    v_TradeDate date;
	v_A_HoldNo number(15);
	v_ID number(15);
	v_AddedTaxFactor T_Commodity.AddedTaxFactor%type;--��ֵ˰��ϵ��=AddedTax/(1+AddedTax)
	v_GageQty     number(10);
	v_CloseAddedTax_one   number(15,2); --����ӯ����ֵ˰
	v_CloseAddedTax         number(15,2):=0;        --����ӯ����ֵ˰�ۼ�
	v_unCloseQty     number(10):=p_HoldQty; --δƽ�����������м����
	v_unCloseQtyGage     number(10):=p_GageQty; --δƽ�����������м����
	v_tradedAmount   number(10):=0;  --�ɽ�����
	v_tradedAmountGage   number(10):=0;  --�ɽ�����
	v_CloseAlgr           number(2);
	v_HoldType           number(2);
	v_HoldMargin         number(15,2);
    v_HoldAssure         number(15,2);
    v_NeutralFeeWay           number(2);
    v_SettleMargin_one     number(15,2);
	type cur_T_HoldPosition is ref cursor;
	v_HoldPosition cur_T_HoldPosition;
	v_sql varchar2(500);
	v_orderby  varchar2(100);
	v_AtClearDate          date;
	v_num            number(10);
	v_GageMode     number(2);
	v_SettleMargin     number(15,2):=0;
	v_Fee         number(15,2):=0;
	v_Payout         number(15,2):=0;
	v_Balance    number(15,2);
	v_F_FrozenFunds   number(15,2);
	v_CloseFL         number(15,2):=0;
	v_ret     number(4);
	v_RuntimeMargin       number(15,2);
  v_SettlePrice number(15,2);
  v_settlePriceType  number(2);
begin
		v_CustomerID := p_CustomerID;
	    v_CommodityID := p_CommodityID;
        v_BS_Flag := p_BS_Flag;

        --��ȡƽ���㷨,�ֶ�ģʽ����֤��������ͣ���ֵ˰����Լ����
        select CloseAlgr,NeutralFeeWay,GageMode into v_CloseAlgr,v_NeutralFeeWay,v_GageMode from T_A_Market;
        select Contractfactor,AddedTaxFactor
        into v_ContractFactor,v_AddedTaxFactor
        from T_Commodity where CommodityID=v_CommodityID;
	    select TradeDate into v_TradeDate from T_SystemStatus;

          --���ݽ����걨�������������ռ۸� add by  zhangjian 2011��12��13��11:04:51 start
          select DelaySettlePriceType  into v_settlePriceType from t_commodity where commodityid=p_CommodityID;
          --end by zhangjian

        --����ƽ���㷨(0�ȿ���ƽ��1����ƽ��2�ֲ־���ƽ��(������)ѡ���������� --ȥ�������㷨�����н�����Ϣ��ѯ����Ĭ������ mod by zhangjian 2011��12��12��13:47:21 start
         v_orderby := ' order by a.A_HoldNo ';
        --if(v_CloseAlgr = 0) then
	      --  v_orderby := ' order by a.A_HoldNo ';
	   -- elsif(v_CloseAlgr = 1) then
	       -- v_orderby := ' order by a.A_HoldNo desc ';
	   -- end if;
     --end by zhangjian 2011��12��12��13:47:36

    	v_sql := 'select a.a_holdno,FirmID,price,(a.HoldQty-nvl(b.FrozenQty,0)),GageQty,nvl(b.FrozenQty,0),a.AtClearDate,a.HoldType,a.HoldMargin,a.HoldAssure from T_holdposition a,(select A_HoldNo,nvl(sum(FrozenQty),0) FrozenQty from T_SpecFrozenHold group by A_HoldNo) b ' ||
                 ' where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and CustomerID=''' || v_CustomerID ||
                 ''' and CommodityID =''' || v_CommodityID || ''' and bs_flag = ' || v_BS_Flag || v_orderby;

   		--�����ֲ���ϸ�����������˵�ָ��ƽ�ֶ��������
        open v_HoldPosition for v_sql;
        loop
            fetch v_HoldPosition into v_a_holdno, v_FirmID, v_price, v_holdqty,v_GageQty,v_frozenQty,v_AtClearDate,v_HoldType,v_HoldMargin,v_HoldAssure;
            exit when v_HoldPosition%NOTFOUND;

            if(v_settlePriceType=0)then--���������㽻��
                  v_SettlePrice:=p_Price;

            else --����������۽���
                 v_SettlePrice:=v_Price;
            end if;
            --����˱ʳֲ�ȫ����ָ��ƽ�ֶ�����û�еֶ���ָ����һ����¼
            if(v_holdqty <> 0 or v_GageQty <> 0) then
            	--��0
                v_tradedAmount:=0;
                v_tradedAmountGage:=0;
                v_Payout_one := 0;
                v_Margin_one := 0;
	            v_Assure_one := 0;
	            v_SettleMargin_one := 0;
                --1������Ӧ�˿���
                if(v_holdqty > 0) then
	                if(v_holdqty<=v_unCloseQty) then
	                    v_tradedAmount:=v_holdqty;
	                    v_Margin_one := v_HoldMargin;
	                    v_Assure_one := v_HoldAssure;
	                else
	                    v_tradedAmount:=v_unCloseQty;
	                    v_Margin_one := v_HoldMargin*v_tradedAmount/v_holdqty;
	                    v_Assure_one := v_HoldAssure*v_tradedAmount/v_holdqty;
	                end if;
                end if;
                --2������ֲ���ϸ�н��յĵֶ�����
				if(v_GageQty > 0) then
	                if(v_GageQty<=v_unCloseQtyGage) then
	                    v_tradedAmountGage:=v_GageQty;
	                else
	                    v_tradedAmountGage:=v_unCloseQtyGage;
	                end if;
                end if;
     			--���㽻�ձ�֤��
		        v_SettleMargin_one := FN_T_ComputeSettleMargin(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,v_SettlePrice);
	            if(v_SettleMargin_one < 0) then
	                Raise_application_error(-20042, 'ComputeSettleMargin error');
	            end if;
	            --3�����㽻�տ���
				--�����򷽽��ջ���
				if(v_BS_Flag = 1) then
			        v_Payout_one := FN_T_ComputePayout(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,v_SettlePrice);
		            if(v_Payout_one < 0) then
		                Raise_application_error(-20043, 'computePayout error');
		            end if;
	            end if;
		        --���㽻��������
		        if(v_HoldType = 2 and v_NeutralFeeWay = 0) then
		        	v_Fee_one := 0;
		        else
					v_Fee_one := FN_T_ComputeSettleFee(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount+v_tradedAmountGage,v_SettlePrice);
				end if;
	            if(v_Fee_one < 0) then
	              Raise_application_error(-20031, 'computeFee error');
	            end if;
	            --����˰ǰ����ӯ��
	            if(v_BS_Flag = 1) then
	                v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(v_SettlePrice-v_price)*v_contractFactor; --˰ǰӯ��
	            else
	                v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(v_Price-v_SettlePrice)*v_contractFactor; --˰ǰӯ��
	            end if;
	            --���㽻����ֵ˰,v_AddedTaxFactor��ֵ˰ϵ��=AddedTax/(1+AddedTax)
	            v_CloseAddedTax_one := round(v_closeFL_one*v_AddedTaxFactor,2);
	            --����˰����ӯ��
	            v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --˰��ӯ��
				--�ۼƽ��
	        	v_Payout := v_Payout + v_Payout_one;
	        	v_Fee := v_Fee + v_Fee_one;
				v_CloseFL:=v_CloseFL + v_closeFL_one;  --˰��ӯ���ϼ�
				v_CloseAddedTax:=v_CloseAddedTax + v_CloseAddedTax_one;  --������ֵ˰�ϼ�
				v_SettleMargin := v_SettleMargin + v_SettleMargin_one;
		        --����ǰ�ֲּ�¼�ͽ��շ��ò��뽻�ճֲ���ϸ�������³ֲ������͵ֶ�����Ϊʵ�ʽ��յ�����
				select SEQ_T_SettleHoldPosition.nextval into v_ID from dual;
				--���ֶ������뽻�ճֲ���ϸ��
			    insert into t_settleholdposition
  				(id, settleprocessdate, a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss, settlemargin, payout, settlefee, settle_pl, settleaddedtax, settleprice, settletype, holdtype, atcleardate)
		        select v_ID,v_TradeDate,a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss,v_SettleMargin_one,v_Payout_one,v_Fee_one,v_closeFL_one,v_CloseAddedTax_one,v_SettlePrice,3, holdtype, atcleardate
		        from t_holdposition
		        where A_HoldNo=v_A_HoldNo;

		        update T_SettleHoldPosition set HoldQty=v_tradedAmount,GageQty=v_tradedAmountGage where ID=v_ID;

                --���³ֲּ�¼
                update T_holdposition
                set holdqty = holdqty - v_tradedAmount,HoldMargin=HoldMargin-v_Margin_one,HoldAssure=HoldAssure-v_Assure_one,GageQty = GageQty - v_tradedAmountGage
                where a_holdno = v_a_holdno;
                v_unCloseQty:=v_unCloseQty - v_tradedAmount;
                v_unCloseQtyGage:=v_unCloseQtyGage - v_tradedAmountGage;
                exit when v_unCloseQty=0 and v_unCloseQtyGage=0;
            end if;
        end loop;
        close v_HoldPosition;
        if(v_unCloseQty>0) then --���ճֲ��������ڿɽ��ճֲ�����
            rollback;
            return -3;
        end if;
        if(v_unCloseQtyGage>0) then --���յֶ��������ڿɵֶ�����
            rollback;
            return -4;
        end if;
        --�ֲֺϼ������ĸ��£���֧�ֵֶ�����
		--���½��׿ͻ��ֲֺϼ�
        v_ret := FN_T_D_ChgCustHoldByQty(v_CustomerID,v_CommodityID,v_BS_Flag,p_HoldQty);
        --�ͷŽ��ױ�֤��
    	v_RuntimeMargin := FN_T_D_ChgFirmMarginByQty(v_FirmID,v_CommodityID,v_BS_Flag,p_HoldQty);
    	v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,-v_RuntimeMargin,'15');
    	--���½����ֲֺ̳ϼ�
		v_ret := FN_T_D_ChgFirmHoldByQty(v_FirmID,v_CommodityID,v_BS_Flag,p_HoldQty,v_GageMode);
        --�۳����ջ�����������ѣ�������ӯ�����ս��տ���,���ձ�֤�� ����д��ˮ
		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15008',v_Payout,null,v_CommodityID,null,null);
		--ע�����ﲻ�ܰ���ͽ�����������ȡ����Ϊʵʱ��ϣ�ʵʱ������ϸ�ֲ֣����԰�ʵ����������ȡ
	    v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15010',v_Fee,null,v_CommodityID,null,null);
		if(v_CloseFL >= 0) then
			v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15011',v_CloseFL,null,v_CommodityID,v_CloseAddedTax,null);
		else
			v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15012',-v_CloseFL,null,v_CommodityID,-v_CloseAddedTax,null);
		end if;
		update T_Firm set RuntimeSettleMargin=RuntimeSettleMargin+v_SettleMargin where FirmID=v_FirmID;
		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15013',v_SettleMargin,null,v_CommodityID,null,null);
    return 1;

end;
/


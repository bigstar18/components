create or replace function FN_T_ComputeSettleMargin(
    p_FirmID varchar2,
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_quantity number,
    p_price number
) return number
/****
 * ���㽻�ձ�֤��
 * ����ֵ �ɹ����ؽ��ձ�֤��;-1 �����������ݲ�ȫ;-100 ��������
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_marginRate_b         number(10,4);
    v_marginRate_s         number(10,4);
    v_marginAlgr_b         number(2);
    v_marginAlgr_s         number(2);
    v_contractFactor     number(12,2);
    v_margin             number(15,2) default 0;
    v_settleMarginType number;   --���ձ�֤����㷽ʽ
    v_BeforeDays number;   --��ǰ����
    v_price number;
    tradeFundSum         number(15,2);
    tradeQtySum  number(10);
    v_SettleDate date;
    v_num            number(10);
    v_Quantity  number(10);
    i            number(4);
begin
select settleMargintype into v_settleMarginType from t_commodity where commodityid=p_CommodityID;--��ѯ���ձ�֤����㷽ʽ  add by lizhenli 2011-12-5
if(v_settleMarginType = 0) then  --�������յı��н����
	    --�ҳ������յ���������
	    begin
	    	select nvl(Price,0) into v_price from T_Quotation where CommodityID=p_CommodityID;
	    exception
	        when NO_DATA_FOUND then
	            select nvl(Price,0) into v_price from T_H_Quotation where CommodityID=p_CommodityID and ClearDate in(select max(ClearDate) from T_H_Quotation where CommodityID=p_CommodityID);
	    end;
      elsif(v_settleMarginType = 1) then  --��������ǰ���յı��н���۵ļ�Ȩƽ����
		--�ҳ���ǰ�գ���������
	    select SettleDate,BeforeDays_M into v_SettleDate,v_BeforeDays from T_Commodity where CommodityID=p_CommodityID;
        tradeQtySum := 0;
        tradeFundSum := 0;
        --�ж��Ƿ��ʽ������ɣ�������״̬����Ϊ��������ʱ״̬��仯
        --����ʽ������ɵĻ���ǰ�ɽ���ɾ�����Ӷ����µ���ļ۸�û�в������ 2010-05-24 by chenxc
        select count(*) into v_num from T_H_Quotation where CommodityID=p_CommodityID and ClearDate = v_SettleDate;
        if(v_num = 0) then
		    --�ӵ�ǰ���м��㽻�ս�������
		    begin
		    	select nvl(Price,0) into v_price from T_Quotation where CommodityID=p_CommodityID;
		    	select nvl(sum(Quantity),0) into v_Quantity from T_Trade where CommodityID=p_CommodityID;
		    	tradeFundSum := tradeFundSum + v_price*v_Quantity;
				tradeQtySum := tradeQtySum + v_Quantity;
		    	i := 1;
		    exception
		        when NO_DATA_FOUND then
		           i := 0;
		    end;
        else
			i := 0;
		end if;
	    --ѭ�����㽻����ǰ��v_BeforeDays�Ľ������������������յ����v_BeforeDays�Ľ�������
        while i<v_BeforeDays loop
        	--����������ж��Ǳ�ʾ������õ���ǰ���յļ�Ȩ�۵���������ʵ�ʵĽ�������ʱ�����ѭ�����������ķ�Χ��Ҳ�������õ��������ڽ��������򰴽������������Ȩ�۸�
            if(v_BeforeDays>=999 or i>=999) then
            	exit;
   			end if;
		    --����ʷ���м��㽻�ս�������
		    begin
		    	select nvl(Price,0) into v_price from T_H_Quotation where CommodityID=p_CommodityID and ClearDate = v_SettleDate-i;
		    	select nvl(sum(Quantity),0) into v_Quantity from T_H_Trade where CommodityID=p_CommodityID and ClearDate = v_SettleDate-i;
		    	tradeFundSum := tradeFundSum + v_price*v_Quantity;
		    	tradeQtySum := tradeQtySum + v_Quantity;
		    exception
		        when NO_DATA_FOUND then
		            v_BeforeDays := v_BeforeDays + 1;
		    end;
            i := i+1;
        end loop;
        --�����Ȩƽ���ۣ��������Ϊ0�Ļ������������Ľ��ռ�
		if(tradeQtySum <> 0) then
        	v_price := round(tradeFundSum/tradeQtySum,0);
        end if;

        else   --����������ۡ���ʹ�ô��ݹ����ļ۸�
        v_price:=p_price;
     end if;
    --��ȡ��Ʒ��Ϣ����Լ���ӣ����ձ�֤��ϵ�������ձ�֤���㷨
    select Settlemarginrate_b,Settlemarginrate_s,SettleMarginAlgr_B,SettleMarginAlgr_S,contractfactor
    into v_marginRate_b,v_marginRate_s,v_marginAlgr_b,v_marginAlgr_s,v_contractFactor
    from T_Commodity where CommodityID=p_CommodityID;

    begin
        --��ȡ����Ľ��ձ�֤��ϵ�������ձ�֤���㷨
        select Settlemarginrate_b,Settlemarginrate_s,SettleMarginAlgr_B,SettleMarginAlgr_S
    	into v_marginRate_b,v_marginRate_s,v_marginAlgr_b,v_marginAlgr_s
        from T_A_FirmSettleMargin
        where FirmID=p_FirmID and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;
    --���ձ�֤���㷨������
    if(p_bs_flag = 1) then  --��
		if(v_marginAlgr_b = 1) then  --Ӧ�ս��ձ�֤��=����*��Լ����*�۸�*���ձ�֤��ϵ��
			if(v_marginRate_b = -1) then --  -1��ʾ��ȫ��
				v_margin:=p_quantity*v_contractFactor*v_price;
			else
        		v_margin:=p_quantity*v_contractFactor*v_price*v_marginRate_b;
        	end if;
        elsif(v_marginAlgr_b = 2) then  --Ӧ�ս��ձ�֤��=����*���ձ�֤��ϵ��
			if(v_marginRate_b = -1) then --  -1��ʾ��ȫ��
				v_margin:=p_quantity*v_contractFactor*v_price;
			else
				v_margin:=p_quantity*v_marginRate_b;
			end if;
        end if;
    elsif(p_bs_flag = 2) then  --��
    	if(v_marginAlgr_s = 1) then  --Ӧ�ս��ձ�֤��=����*��Լ����*�۸�*���ձ�֤��ϵ��
			if(v_marginRate_s = -1) then --  -1��ʾ��ȫ��
				v_margin:=p_quantity*v_contractFactor*v_price;
			else
        		v_margin:=p_quantity*v_contractFactor*v_price*v_marginRate_s;
        	end if;
        elsif(v_marginAlgr_s = 2) then  --Ӧ�ս��ձ�֤��=����*���ձ�֤��ϵ��
			if(v_marginRate_s = -1) then --  -1��ʾ��ȫ��
				v_margin:=p_quantity*v_contractFactor*v_price;
			else
				v_margin:=p_quantity*v_marginRate_s;
			end if;
        end if;
    end if;
    if(v_margin is null) then
    	rollback;
        return -1;
    end if;
    return v_margin;
exception
    when no_data_found then
    	rollback;
        return -1;
    when others then
    	rollback;
    	return -100;
end;
/


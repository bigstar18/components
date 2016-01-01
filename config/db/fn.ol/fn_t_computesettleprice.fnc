create or replace function FN_T_ComputeSettlePrice(
    p_CommodityID varchar2,  --��Ʒ����
    p_SettlePriceType number    --���㽻�ռ�����
) return number
/****
 * ���㽻�ռ۸�
 * ���㽻�ռ�����=2�İ����ּ۲��ü��㣬ֱ�Ӱ��ֲ���ϸ�п��ּ�
 * ����ֵ �ɹ����ؽ��ռ۸�
****/
as
	v_version varchar2(10):='1.0.2.1';
    v_SettlePrice         number(15,2);
    tradeFundSum         number(15,2);
    tradeQtySum  number(10);
    v_BeforeDays  number(4);
    v_SettleDate date;
    v_Quantity  number(10);
    i            number(4);
    v_num            number(10);
begin
	if(p_SettlePriceType = 0) then  --�������յı��н����
	    --�ҳ������յ���������
	    begin
	    	select nvl(Price,0) into v_SettlePrice from T_Quotation where CommodityID=p_CommodityID;
	    exception
	        when NO_DATA_FOUND then
           begin
	            select nvl(Price,0) into v_SettlePrice from T_H_Quotation where CommodityID=p_CommodityID and ClearDate in(select max(ClearDate) from T_H_Quotation where CommodityID=p_CommodityID);
	        exception
	        when NO_DATA_FOUND then
           return 0;
           end;
      end;
	elsif(p_SettlePriceType = 1) then  --��������ǰ���յı��н���۵ļ�Ȩƽ����
		--�ҳ���ǰ�գ���������
	    select SettleDate,BeforeDays into v_SettleDate,v_BeforeDays from T_Commodity where CommodityID=p_CommodityID;
        tradeQtySum := 0;
        tradeFundSum := 0;
        --�ж��Ƿ��ʽ������ɣ�������״̬����Ϊ��������ʱ״̬��仯
        --����ʽ������ɵĻ���ǰ�ɽ���ɾ�����Ӷ����µ���ļ۸�û�в������ 2010-05-24 by chenxc
        select count(*) into v_num from T_H_Quotation where CommodityID=p_CommodityID and ClearDate = v_SettleDate;
        if(v_num = 0) then
		    --�ӵ�ǰ���м��㽻�ս�������
		    begin
		    	select nvl(Price,0) into v_SettlePrice from T_Quotation where CommodityID=p_CommodityID;
		    	select nvl(sum(Quantity),0) into v_Quantity from T_Trade where CommodityID=p_CommodityID;
		    	tradeFundSum := tradeFundSum + v_SettlePrice*v_Quantity;
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
		    	select nvl(Price,0) into v_SettlePrice from T_H_Quotation where CommodityID=p_CommodityID and ClearDate = v_SettleDate-i;
		    	select nvl(sum(Quantity),0) into v_Quantity from T_H_Trade where CommodityID=p_CommodityID and ClearDate = v_SettleDate-i;
		    	tradeFundSum := tradeFundSum + v_SettlePrice*v_Quantity;
		    	tradeQtySum := tradeQtySum + v_Quantity;
		    exception
		        when NO_DATA_FOUND then
		            v_BeforeDays := v_BeforeDays + 1;
		    end;
            i := i+1;
        end loop;
        --�����Ȩƽ���ۣ��������Ϊ0�Ļ������������Ľ��ռ�
		if(tradeQtySum <> 0) then
        	v_SettlePrice := round(tradeFundSum/tradeQtySum,0);
        end if;
	elsif(p_SettlePriceType = 3) then  --��ָ�����ռ�
		select SpecSettlePrice into v_SettlePrice from T_Commodity where CommodityID=p_CommodityID;
    end if;
    return v_SettlePrice;
end;
/


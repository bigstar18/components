create or replace function FN_T_D_ComputeDelayDays return number
/****
 * �������ڲ����ѵ�����
 * ���ؼ������ڲ����ѵ�����
****/
as
	v_version varchar2(10):='1.0.2.3';
	v_TradeDate date;
    v_Week        varchar2(30);   --�ǽ��׵����ڼ�
    v_Day    varchar2(1024);   --�ǽ��׵�����
    v_destWeek    varchar2(10);   --�¸����ڶ�Ӧ�����ڼ�
    v_pos      number(15,2):=0;   --λ��
    v_bLoop      boolean;   --�Ƿ���Ҫѭ����־
    v_Days       number(10); --���ڵ�����
begin
	--1����ȡ��������
	select TradeDate into v_TradeDate from T_SystemStatus;
	--2����ѯ�ǽ����գ�δ���÷ǽ�����ʱ����1,2010-03-29  by chenxc
	begin
		select Week,Day
		into v_Week,v_Day
	    from T_A_NotTradeDay;
	exception
	    when NO_DATA_FOUND then
	        return 1;
	end;
    if(v_Week is null and v_Day is null) then
    	return 1;
    end if;
	--3��������������
	v_Days := 1;
	v_bLoop := true;
    while v_bLoop loop
    	<<top>>
    	select ',' || TO_CHAR(v_TradeDate+v_Days,'D') || ',' into v_destWeek  from dual;
    	if(v_Week is not null) then
    		select INSTR(',' || v_Week || ',',v_destWeek,1,1) into v_pos  from dual;
    		if(v_pos > 0) then
    			v_bLoop := true;
    			v_Days := v_Days+1;
    			goto top;
    		else
    			v_bLoop := false;
    		end if;
    	end if;
    	if(v_Day is not null) then
    		select INSTR(',' || v_Day || ',',to_char(v_TradeDate+v_Days,'yyyy-MM-dd'),1,1) into v_pos  from dual;
    		if(v_pos > 0) then
    			v_bLoop := true;
    			v_Days := v_Days+1;
    			goto top;
    		else
    			v_bLoop := false;
    		end if;
    	end if;
    end loop;
	--4��������������
    return v_Days;
end;
/


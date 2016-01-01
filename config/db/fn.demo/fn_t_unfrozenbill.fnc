create or replace function FN_T_UnfrozenBill(
    p_CommodityID varchar2
) return number
/****
 * �ⶳ�ֵ�
 * ����ֵ�� 1 �ɹ���-2 �Ѿ��ⶳ
****/
as
    v_BillID varchar2(16);  -- �ֵ���
	  v_num    number(10);

    --�����α��ȡ������Ʒ�Ĳֵ���
    cursor cur_BillId is
        select billId
        from t_billfrozen
        where operation in (select to_char(id) from t_e_gagebill where CommodityID = p_CommodityID);

begin

    open cur_BillId;
      loop
    	  fetch cur_BillId into v_BillID;
    	  exit when cur_BillId%notfound;
          -- �ⶳ�ֵ�
		     v_num := FN_BI_UnfrozenBill(15,v_BillID);
         if(v_num != 1) then

           -- ��Ӷ������ݿ���־
		    	 insert into t_dblog(err_date,name_proc,err_code,err_msg)
           values (sysdate, 'FN_T_UnfrozenBill',-2, '��Ʒ��'||p_CommodityID||',�ֵ���'||v_BillID||',�ⶳ�ֵ�ʧ�ܣ�');
           -- ��Ӷ�����̨������־
           insert into c_globallog_all(ID, operator, operatetime, operatetype, operatecontent, operateresult, logtype )
           values (seq_c_globallog.nextval, 'system', sysdate, 1508, '��Ʒ��'||p_CommodityID||',�ֵ���'||v_BillID||',�ⶳ�ֵ�ʧ�ܣ�', 0, 1);

           commit;

	    	 end if;
 	    end loop;
    close cur_BillId;

    return 1;

end;
/


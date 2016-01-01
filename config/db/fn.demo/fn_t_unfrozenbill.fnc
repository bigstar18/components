create or replace function FN_T_UnfrozenBill(
    p_CommodityID varchar2
) return number
/****
 * 解冻仓单
 * 返回值： 1 成功、-2 已经解冻
****/
as
    v_BillID varchar2(16);  -- 仓单号
	  v_num    number(10);

    --利用游标获取下市商品的仓单号
    cursor cur_BillId is
        select billId
        from t_billfrozen
        where operation in (select to_char(id) from t_e_gagebill where CommodityID = p_CommodityID);

begin

    open cur_BillId;
      loop
    	  fetch cur_BillId into v_BillID;
    	  exit when cur_BillId%notfound;
          -- 解冻仓单
		     v_num := FN_BI_UnfrozenBill(15,v_BillID);
         if(v_num != 1) then

           -- 添加订单数据库日志
		    	 insert into t_dblog(err_date,name_proc,err_code,err_msg)
           values (sysdate, 'FN_T_UnfrozenBill',-2, '商品：'||p_CommodityID||',仓单：'||v_BillID||',解冻仓单失败！');
           -- 添加订单后台操作日志
           insert into c_globallog_all(ID, operator, operatetime, operatetype, operatecontent, operateresult, logtype )
           values (seq_c_globallog.nextval, 'system', sysdate, 1508, '商品：'||p_CommodityID||',仓单：'||v_BillID||',解冻仓单失败！', 0, 1);

           commit;

	    	 end if;
 	    end loop;
    close cur_BillId;

    return 1;

end;
/


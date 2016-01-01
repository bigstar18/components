create or replace procedure SP_F_StatusInit
as
/*********************
 检查财务结算状态存储
 存储说明：凡是进行初始化的系统
 需先调用本存储，对财务系统进行初始化

**********************/
v_status F_systemstatus.Status%type;
begin
  --1.检查财务系统交易状态
  begin
     select status into v_status  from F_systemstatus t where rownum < 2;
  exception
     when NO_DATA_FOUND then
       return;
  end;
  --2.如果状态不为结算完成状态，即返回
  if(v_status <> 2) then
    return;
  end if;

  --3.如果状态为结算完成，即修改状态为未结算
  update F_systemstatus set status = 0,note = '未结算';
  update F_CLEARSTATUS set status = 'N',finishtime = null;
end;
/


create or replace function FN_T_FirmAdd
(
    p_FirmID m_firm.firmid%type --交易商代码
)return integer is
  /**
  * 订单系统添加交易商
  * 返回值： 1 成功
  注意不要提交commit，因为别的函数要调用它；
  **/
  v_cnt                number(5); --数字变量
begin
  --1、插入交易商表，默认正常状态
    select count(*) into v_cnt from T_Firm where firmid=p_firmid;
    if(v_cnt=0) then
        insert into T_Firm(FirmID,Status,ModifyTime) values(p_FirmID,0,sysdate);
    end if;
    --2、插入一条默认交易商ID+00小号的客户到客户表
    select count(*) into v_cnt from T_Customer where CustomerID=p_firmid||'00';
    if(v_cnt=0) then
        insert into T_Customer(CustomerID, FirmID,  Code,Status,CreateTime,ModifyTime)
        values( p_FirmID||'00', p_FirmID ,'00', 0, sysdate, sysdate);
    end if;

    return 1;
end;
/


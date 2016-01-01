create or replace function FN_BI_firmADD
(
    p_FirmID m_firm.firmid%type --交易商代码
)
return integer is
  /**
  * 现货系统添加交易商
  * 返回值： 1 成功
  **/
  v_cnt                number(4); --数字变量
begin
  select count(*) into v_cnt from BI_firm where firmid = p_FirmID;
   if (v_cnt > 0) then
    --如果交易商已经存在则重新设置交易商信息
    update BI_firm set password=FN_M_MD5(p_FirmID||'111111'),createtime= sysdate  where firmid=p_FirmID;
  end if;

  insert into BI_firm
      (firmid, password, createtime)
  values
      (p_FirmID, FN_M_MD5(p_FirmID||'111111'), sysdate);

  return 1;
end;
/


create or replace function FN_BI_FirmDel
(
    p_FirmID   m_firm.firmid%type--交易商代码
)
return integer is
  /**
  * 删除交易商
  * 返回值： 1 成功
  **/
  v_cnt                number(4); --数字变量
  RET_RESULT integer:=-130;--仓单数字变量
begin
    --查看仓单表中状态是否有0:未注册1:注册仓单4:拆弹中 有则不能注销仓单
    select count(*) into v_cnt from bi_stock s where s.ownerfirm=p_FirmID and s.stockstatus in(0,1,4);
    if(v_cnt>0)then
    return RET_RESULT;
    end if;
    return 1;
end;
/


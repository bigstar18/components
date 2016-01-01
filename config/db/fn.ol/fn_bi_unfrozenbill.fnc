create or replace function FN_BI_UnfrozenBill
(
    p_moduleID   BI_FrozenStock.moduleid%type, --模块编号
	p_stockID    BI_FrozenStock.stockid%type --仓单编号
)
return integer is
  /**
  * 解冻交易商
  * 返回值： 1 成功、-2 已经解冻过了
  **/
  v_cnt number(4); --数字变量

  RET_RESULT integer:=-2;--仓单数字变量
begin
    --查看仓单表中状态是否有0:未注册1:注册仓单4:拆弹中 有则不能注销仓单
    select count(*) into v_cnt from BI_FrozenStock where moduleid=p_moduleID and stockID=p_stockID and status=0;
    if(v_cnt<=0)then
		return RET_RESULT;
    end if;
	--删除仓单业务
	delete from BI_StockOperation where stockID=p_stockID and operationID=4;
	--释放冻结仓单
	update BI_FrozenStock set status=1,releaseTime=sysdate where stockID=p_stockID;
	--返回成功
    return 1;
end;
/


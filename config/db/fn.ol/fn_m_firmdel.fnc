create or replace function FN_M_FirmDel
(
    p_FirmID   m_firm.firmid%type, --交易商代码
    errorInfo OUT VARCHAR2--当某个模块删除交易商发生错的时候存放错误信息
)
return integer is
  /**
  * 删除交易商
  * 返回值： 1 成功
  *          -900 交易商不存在
  *          -901 某个交易模块发生错误
  **/
  v_cnt                number(4); --数字变量
  Module_RET           number(4); --模块删除交易商返回值
  IS_Error             boolean;--调用其它模块时是否发生错误
  CodeInfo_RET         varchar2(1024);--错误信息
  E_CNName             varchar2(64);--各个系统中文名称
  v_errorcode                number(4); --数字变量
  RET_NOFoundFirmID      integer := -900;
  RET_TradeModuleError integer := -901;--与errorInfo配合使用
begin
  --检查交易商是否存在
  select count(*) into v_cnt from m_firm where firmid=p_FirmID;
  if (v_cnt = 0) then
    return RET_NOFoundFirmID;
  end if;

  IS_Error:=false;
  --循环调用每一个交易模块的删除交易商函数；从交易模块表中查询删除交易商函数长度大于5（FN_xx_）的字段
   for DelFirmFnStr in (select trim(DelFirmFn) as DelFirmFn,ModuleID from C_TradeModule where  lengthb(DelFirmFn)>5)
    loop
        --调用交易模块表中的删除交易商函数
        execute immediate 'BEGIN :Module_RET :='||DelFirmFnStr.DelFirmFn||'(:firmid); END;' using OUT Module_RET,IN p_FirmID;
        --如果返回值不是1则回滚返回交易模块发生错误
        if(Module_RET!=1)then
            IS_Error:=true;
            --获取错误信息
            select count(*) into v_errorcode from m_procedures_errorcode p where p.moduleid=DelFirmFnStr.Moduleid and p.errorcode=Module_RET;
            if(v_errorcode = 1)then
                select p.errorinfo into CodeInfo_RET from m_procedures_errorcode p where p.moduleid=DelFirmFnStr.Moduleid and p.errorcode=Module_RET;
                CodeInfo_RET:='错误信息:'||CodeInfo_RET;
            end if;
            select m.cnname into E_CNName from c_trademodule m where m.moduleid=DelFirmFnStr.Moduleid;
            errorInfo:=errorInfo||'\n'||E_CNName||'，返回码:'||Module_RET||CodeInfo_RET||';';
            CodeInfo_RET:='';
        end if;
    end loop;

    if(IS_Error) then
      rollback;
      return RET_TradeModuleError;
    end if;

    delete from m_tradermodule where traderid in (select traderid from m_trader where firmid=p_firmid);
   --mengyu 2013.08.29 注销交易商不删除表数据
   -- delete from m_trader where firmid=p_firmid;
    delete from m_firmmodule where firmid=p_firmid;
    update m_firm set status=PKG_C_Base.FIRM_STATUS_ERASE where firmid=p_firmid;

    return 1;
end;
/


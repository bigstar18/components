create or replace function FN_M_FirmAdd
(
    p_FirmID   m_firm.firmid%type, --交易商代码
    p_UserID   m_Trader.Userid%type, -- 用户名
    p_Password m_Trader.Password%type, -- 密码
    errorInfo OUT VARCHAR2--当某个模块添加交易商发生错的时候存放错误信息
)
return integer is
  /**
  * 同步交易商到各个模块
  * 返回值： 1 成功
  *          -900 交易商已经存在
  *          -901 用户名已经存在
  *          -902 某个交易模块发生错误
  **/
  v_cnt                number(4); --数字变量
  Module_RET           number(4); --模块添加交易商返回值
  IS_Error             boolean;--调用其它模块时是否发生错误
  CodeInfo_RET         varchar2(1024);--错误信息
  E_CNName             varchar2(64);--各个系统中文名称
  v_errorcode          number(4); --数字变量
  RET_FoundFirmID      integer := -900;
  RET_FoundUserID      integer := -901;
  RET_TradeModuleError integer := -902;--与errorInfo配合使用
begin
  --检查交易商是否已经存在
  select count(*) into v_cnt from m_trader where traderid = p_FirmID;
  if (v_cnt > 0) then
    return RET_FoundFirmID;
  end if;
  --检查用户是否存在
  select count(*) into v_cnt from m_trader where userID = p_UserID;
  if (v_cnt > 0) then
    return RET_FoundUserID;
  end if;

  IS_Error:=false;
  --循环调用每一个交易模块的添加交易商函数；从交易模块表中查询添加交易商函数长度大于5（FN_xx_）的字段
   for AddFirmFnStr in (select trim(AddFirmFn) as AddFirmFn,ModuleID from C_TradeModule where  lengthb(AddFirmFn)>5)
    loop
        --调试使用 dbms_output.put_line('BEGIN :Module_RET :='||AddFirmFnStr.AddFirmFn||'(:firmid); END;');
        --调用交易模块表中的添加交易商函数
        execute immediate 'BEGIN :Module_RET :='||AddFirmFnStr.AddFirmFn||'(:firmid); END;' using OUT Module_RET,IN p_FirmID;
        --如果返回值不是1则回滚返回交易模块发生错误
        if(Module_RET!=1)then
            IS_Error:=true;
            --获取错误信息
            select count(*) into v_errorcode from m_procedures_errorcode p where p.moduleid=AddFirmFnStr.Moduleid and p.errorcode=Module_RET;
            if(v_errorcode = 1)then
                select p.errorinfo into CodeInfo_RET from m_procedures_errorcode p where p.moduleid=AddFirmFnStr.Moduleid and p.errorcode=Module_RET;
                CodeInfo_RET:='错误信息:'||CodeInfo_RET;
            end if;
            select m.cnname into E_CNName from c_trademodule m where m.moduleid=AddFirmFnStr.Moduleid;
            errorInfo:=errorInfo||'\n'||E_CNName||'，返回码:'||Module_RET||CodeInfo_RET||';';
            CodeInfo_RET:='';

        end if;
    end loop;

    if(IS_Error)then
      rollback;
      return RET_TradeModuleError;
    end if;
    --写入交易商交易模块表
    --insert into m_firmmodule(moduleid, firmid, enabled)
        --select moduleid, p_FirmID, 'Y' from C_TradeModule where ISFirmSet='Y';
    --写入交易员交易模块表
    insert into m_tradermodule
            (moduleid, traderid, enabled)
        select moduleid, FirmID, enabled from m_firmmodule where FirmID=p_FirmID;
    --写入交易员表
    insert into m_trader
           (traderid, firmid, name, userid, password, status, type, createtime, modifytime, keycode, enablekey)
    values
           (p_FirmID, p_FirmID, p_FirmID, p_UserID, FN_M_MD5(p_FirmID||p_Password), 'N', 'A', sysdate, sysdate, '', 'N');

    return 1;
end;
/


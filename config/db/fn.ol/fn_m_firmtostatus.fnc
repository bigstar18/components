create or replace function FN_M_FirmToStatus
(
    p_FirmID m_firm.firmid%type,
    p_ToStatus m_firm.status%type,   -- 目标状态
    errorInfo OUT VARCHAR2--当某个模块修改交易商状态发生错的时候存放错误信息
)
return integer is
/**
 * 客户状态改变：冻结，解冻
 * 返回值： 1 成功
 *          -900 交易商状态不正确
 *          -901 不存在的交易商
 *          -920 某一个模块在修改交易商状态时发生错误
 **/
    v_cnt                number(4); --数字变量
    v_status       m_firm.status%type;--当前状态
    Module_RET           number(4); --模块修改交易商状态返回值
    IS_Error             boolean;--调用其它模块时是否发生错误
    CodeInfo_RET         varchar2(1024);--错误信息
    E_CNName             varchar2(64);--各个系统中文名称
    v_errorcode          number(4); --数字变量
    RET_StatusError integer := -900;
    RET_NotFoundError integer := -901;
    RET_TradeModuleError integer := -902;
begin
     --修改的目标状态只能是正常或者禁用
     if(p_ToStatus != PKG_C_Base.FIRM_STATUS_NORMAL and p_ToStatus!=PKG_C_Base.FIRM_STATUS_DISABLE) then
        return RET_StatusError;
     end if;

      --检查建议商是否已经存在
      select count(*) into v_cnt from m_firm where firmid = p_FirmID;
      if (v_cnt = 0) then
         return RET_NotFoundError;
      end if;

     --当前状态
    select status into v_status from m_firm t where t.firmid = p_FirmID for update;

    if(p_ToStatus = PKG_C_Base.FIRM_STATUS_DISABLE) then --客户冻结
        if(v_status != PKG_C_Base.FIRM_STATUS_NORMAL) then
            return RET_StatusError;
        end if;

    end if;

    if(p_ToStatus = PKG_C_Base.FIRM_STATUS_NORMAL) then --客户解冻
        if(v_status != PKG_C_Base.FIRM_STATUS_DISABLE) then
            return RET_StatusError;
        end if;
    end if;
    IS_Error:=false;
    --循环调用每一个交易模块的修改交易商状态函数；从交易模块表中查询修改交易商状态长度大于5（FN_xx_）的字段
    for UpdateFirmStatusFnStr in (select trim(UpdateFirmStatusFn) as UpdateFirmStatusFn,ModuleID from C_TradeModule where  lengthb(UpdateFirmStatusFn)>5)
       loop
           --调用交易模块表中的添加交易商函数
           execute immediate 'BEGIN :Module_RET :='||UpdateFirmStatusFnStr.UpdateFirmStatusFn||'(:firmid); END;' using OUT Module_RET,IN p_FirmID;
           --如果返回值不是1则回滚返回交易模块发生错误
           if(Module_RET!=1)then
              IS_Error:=true;
               --获取错误信息
              select count(*) into v_errorcode from m_procedures_errorcode p where p.moduleid=UpdateFirmStatusFnStr.Moduleid and p.errorcode=Module_RET;
              if(v_errorcode = 1)then
                  select p.errorinfo into CodeInfo_RET from m_procedures_errorcode p where p.moduleid=UpdateFirmStatusFnStr.Moduleid and p.errorcode=Module_RET;
                  CodeInfo_RET:='错误信息:'||CodeInfo_RET;
              end if;
              select m.cnname into E_CNName from c_trademodule m where m.moduleid=UpdateFirmStatusFnStr.Moduleid;
              errorInfo:=errorInfo||'\n'||E_CNName||'，返回码:'||Module_RET||CodeInfo_RET||';';
              CodeInfo_RET:='';

           end if;
     end loop;

     if(IS_Error)then
     rollback;
     return RET_TradeModuleError;
     end if;

     update m_firm set status = p_ToStatus where firmid = p_FirmID;

     return 1;
end;
/


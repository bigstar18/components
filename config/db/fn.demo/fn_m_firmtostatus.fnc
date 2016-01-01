create or replace function FN_M_FirmToStatus
(
    p_FirmID m_firm.firmid%type,
    p_ToStatus m_firm.status%type,   -- Ŀ��״̬
    errorInfo OUT VARCHAR2--��ĳ��ģ���޸Ľ�����״̬�������ʱ���Ŵ�����Ϣ
)
return integer is
/**
 * �ͻ�״̬�ı䣺���ᣬ�ⶳ
 * ����ֵ�� 1 �ɹ�
 *          -900 ������״̬����ȷ
 *          -901 �����ڵĽ�����
 *          -920 ĳһ��ģ�����޸Ľ�����״̬ʱ��������
 **/
    v_cnt                number(4); --���ֱ���
    v_status       m_firm.status%type;--��ǰ״̬
    Module_RET           number(4); --ģ���޸Ľ�����״̬����ֵ
    IS_Error             boolean;--��������ģ��ʱ�Ƿ�������
    CodeInfo_RET         varchar2(1024);--������Ϣ
    E_CNName             varchar2(64);--����ϵͳ��������
    v_errorcode          number(4); --���ֱ���
    RET_StatusError integer := -900;
    RET_NotFoundError integer := -901;
    RET_TradeModuleError integer := -902;
begin
     --�޸ĵ�Ŀ��״ֻ̬�����������߽���
     if(p_ToStatus != PKG_C_Base.FIRM_STATUS_NORMAL and p_ToStatus!=PKG_C_Base.FIRM_STATUS_DISABLE) then
        return RET_StatusError;
     end if;

      --��齨�����Ƿ��Ѿ�����
      select count(*) into v_cnt from m_firm where firmid = p_FirmID;
      if (v_cnt = 0) then
         return RET_NotFoundError;
      end if;

     --��ǰ״̬
    select status into v_status from m_firm t where t.firmid = p_FirmID for update;

    if(p_ToStatus = PKG_C_Base.FIRM_STATUS_DISABLE) then --�ͻ�����
        if(v_status != PKG_C_Base.FIRM_STATUS_NORMAL) then
            return RET_StatusError;
        end if;

    end if;

    if(p_ToStatus = PKG_C_Base.FIRM_STATUS_NORMAL) then --�ͻ��ⶳ
        if(v_status != PKG_C_Base.FIRM_STATUS_DISABLE) then
            return RET_StatusError;
        end if;
    end if;
    IS_Error:=false;
    --ѭ������ÿһ������ģ����޸Ľ�����״̬�������ӽ���ģ����в�ѯ�޸Ľ�����״̬���ȴ���5��FN_xx_�����ֶ�
    for UpdateFirmStatusFnStr in (select trim(UpdateFirmStatusFn) as UpdateFirmStatusFn,ModuleID from C_TradeModule where  lengthb(UpdateFirmStatusFn)>5)
       loop
           --���ý���ģ����е���ӽ����̺���
           execute immediate 'BEGIN :Module_RET :='||UpdateFirmStatusFnStr.UpdateFirmStatusFn||'(:firmid); END;' using OUT Module_RET,IN p_FirmID;
           --�������ֵ����1��ع����ؽ���ģ�鷢������
           if(Module_RET!=1)then
              IS_Error:=true;
               --��ȡ������Ϣ
              select count(*) into v_errorcode from m_procedures_errorcode p where p.moduleid=UpdateFirmStatusFnStr.Moduleid and p.errorcode=Module_RET;
              if(v_errorcode = 1)then
                  select p.errorinfo into CodeInfo_RET from m_procedures_errorcode p where p.moduleid=UpdateFirmStatusFnStr.Moduleid and p.errorcode=Module_RET;
                  CodeInfo_RET:='������Ϣ:'||CodeInfo_RET;
              end if;
              select m.cnname into E_CNName from c_trademodule m where m.moduleid=UpdateFirmStatusFnStr.Moduleid;
              errorInfo:=errorInfo||'\n'||E_CNName||'��������:'||Module_RET||CodeInfo_RET||';';
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


create or replace function FN_M_FirmDel
(
    p_FirmID   m_firm.firmid%type, --�����̴���
    errorInfo OUT VARCHAR2--��ĳ��ģ��ɾ�������̷������ʱ���Ŵ�����Ϣ
)
return integer is
  /**
  * ɾ��������
  * ����ֵ�� 1 �ɹ�
  *          -900 �����̲�����
  *          -901 ĳ������ģ�鷢������
  **/
  v_cnt                number(4); --���ֱ���
  Module_RET           number(4); --ģ��ɾ�������̷���ֵ
  IS_Error             boolean;--��������ģ��ʱ�Ƿ�������
  CodeInfo_RET         varchar2(1024);--������Ϣ
  E_CNName             varchar2(64);--����ϵͳ��������
  v_errorcode                number(4); --���ֱ���
  RET_NOFoundFirmID      integer := -900;
  RET_TradeModuleError integer := -901;--��errorInfo���ʹ��
begin
  --��齻�����Ƿ����
  select count(*) into v_cnt from m_firm where firmid=p_FirmID;
  if (v_cnt = 0) then
    return RET_NOFoundFirmID;
  end if;

  IS_Error:=false;
  --ѭ������ÿһ������ģ���ɾ�������̺������ӽ���ģ����в�ѯɾ�������̺������ȴ���5��FN_xx_�����ֶ�
   for DelFirmFnStr in (select trim(DelFirmFn) as DelFirmFn,ModuleID from C_TradeModule where  lengthb(DelFirmFn)>5)
    loop
        --���ý���ģ����е�ɾ�������̺���
        execute immediate 'BEGIN :Module_RET :='||DelFirmFnStr.DelFirmFn||'(:firmid); END;' using OUT Module_RET,IN p_FirmID;
        --�������ֵ����1��ع����ؽ���ģ�鷢������
        if(Module_RET!=1)then
            IS_Error:=true;
            --��ȡ������Ϣ
            select count(*) into v_errorcode from m_procedures_errorcode p where p.moduleid=DelFirmFnStr.Moduleid and p.errorcode=Module_RET;
            if(v_errorcode = 1)then
                select p.errorinfo into CodeInfo_RET from m_procedures_errorcode p where p.moduleid=DelFirmFnStr.Moduleid and p.errorcode=Module_RET;
                CodeInfo_RET:='������Ϣ:'||CodeInfo_RET;
            end if;
            select m.cnname into E_CNName from c_trademodule m where m.moduleid=DelFirmFnStr.Moduleid;
            errorInfo:=errorInfo||'\n'||E_CNName||'��������:'||Module_RET||CodeInfo_RET||';';
            CodeInfo_RET:='';
        end if;
    end loop;

    if(IS_Error) then
      rollback;
      return RET_TradeModuleError;
    end if;

    delete from m_tradermodule where traderid in (select traderid from m_trader where firmid=p_firmid);
   --mengyu 2013.08.29 ע�������̲�ɾ��������
   -- delete from m_trader where firmid=p_firmid;
    delete from m_firmmodule where firmid=p_firmid;
    update m_firm set status=PKG_C_Base.FIRM_STATUS_ERASE where firmid=p_firmid;

    return 1;
end;
/


create or replace function FN_M_FirmAdd
(
    p_FirmID   m_firm.firmid%type, --�����̴���
    p_UserID   m_Trader.Userid%type, -- �û���
    p_Password m_Trader.Password%type, -- ����
    errorInfo OUT VARCHAR2--��ĳ��ģ����ӽ����̷������ʱ���Ŵ�����Ϣ
)
return integer is
  /**
  * ͬ�������̵�����ģ��
  * ����ֵ�� 1 �ɹ�
  *          -900 �������Ѿ�����
  *          -901 �û����Ѿ�����
  *          -902 ĳ������ģ�鷢������
  **/
  v_cnt                number(4); --���ֱ���
  Module_RET           number(4); --ģ����ӽ����̷���ֵ
  IS_Error             boolean;--��������ģ��ʱ�Ƿ�������
  CodeInfo_RET         varchar2(1024);--������Ϣ
  E_CNName             varchar2(64);--����ϵͳ��������
  v_errorcode          number(4); --���ֱ���
  RET_FoundFirmID      integer := -900;
  RET_FoundUserID      integer := -901;
  RET_TradeModuleError integer := -902;--��errorInfo���ʹ��
begin
  --��齻�����Ƿ��Ѿ�����
  select count(*) into v_cnt from m_trader where traderid = p_FirmID;
  if (v_cnt > 0) then
    return RET_FoundFirmID;
  end if;
  --����û��Ƿ����
  select count(*) into v_cnt from m_trader where userID = p_UserID;
  if (v_cnt > 0) then
    return RET_FoundUserID;
  end if;

  IS_Error:=false;
  --ѭ������ÿһ������ģ�����ӽ����̺������ӽ���ģ����в�ѯ��ӽ����̺������ȴ���5��FN_xx_�����ֶ�
   for AddFirmFnStr in (select trim(AddFirmFn) as AddFirmFn,ModuleID from C_TradeModule where  lengthb(AddFirmFn)>5)
    loop
        --����ʹ�� dbms_output.put_line('BEGIN :Module_RET :='||AddFirmFnStr.AddFirmFn||'(:firmid); END;');
        --���ý���ģ����е���ӽ����̺���
        execute immediate 'BEGIN :Module_RET :='||AddFirmFnStr.AddFirmFn||'(:firmid); END;' using OUT Module_RET,IN p_FirmID;
        --�������ֵ����1��ع����ؽ���ģ�鷢������
        if(Module_RET!=1)then
            IS_Error:=true;
            --��ȡ������Ϣ
            select count(*) into v_errorcode from m_procedures_errorcode p where p.moduleid=AddFirmFnStr.Moduleid and p.errorcode=Module_RET;
            if(v_errorcode = 1)then
                select p.errorinfo into CodeInfo_RET from m_procedures_errorcode p where p.moduleid=AddFirmFnStr.Moduleid and p.errorcode=Module_RET;
                CodeInfo_RET:='������Ϣ:'||CodeInfo_RET;
            end if;
            select m.cnname into E_CNName from c_trademodule m where m.moduleid=AddFirmFnStr.Moduleid;
            errorInfo:=errorInfo||'\n'||E_CNName||'��������:'||Module_RET||CodeInfo_RET||';';
            CodeInfo_RET:='';

        end if;
    end loop;

    if(IS_Error)then
      rollback;
      return RET_TradeModuleError;
    end if;
    --д�뽻���̽���ģ���
    --insert into m_firmmodule(moduleid, firmid, enabled)
        --select moduleid, p_FirmID, 'Y' from C_TradeModule where ISFirmSet='Y';
    --д�뽻��Ա����ģ���
    insert into m_tradermodule
            (moduleid, traderid, enabled)
        select moduleid, FirmID, enabled from m_firmmodule where FirmID=p_FirmID;
    --д�뽻��Ա��
    insert into m_trader
           (traderid, firmid, name, userid, password, status, type, createtime, modifytime, keycode, enablekey)
    values
           (p_FirmID, p_FirmID, p_FirmID, p_UserID, FN_M_MD5(p_FirmID||p_Password), 'N', 'A', sysdate, sysdate, '', 'N');

    return 1;
end;
/


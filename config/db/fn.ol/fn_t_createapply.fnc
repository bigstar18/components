create or replace function FN_T_CREATEAPPLY(p_clob varchar2, p_applytype number, p_status number, p_proposer varchar2) return number
as
   v_xml_id NUMBER(12);
   v_apply_id NUMBER(10);
begin
   /* ����xml�ı�id*/
   select nvl(max(id),0)+1 into v_xml_id from c_xmltemplate;
   /* ���������ɵ�id���������*/
   insert into c_xmltemplate values(v_xml_id, to_clob(p_clob));
   /* ���������¼��id*/
   select nvl(max(id),0)+1 into v_apply_id from t_apply;
   /* ���������ɵ�id���������*/
   insert into t_apply (id,applyType,status,proposer,applytime,content) values (v_apply_id,p_applytype,p_status,p_proposer,sysdate,sys.xmlType.createXML((select clob from c_xmltemplate where id=v_xml_id)));
   /* ɾ��xml����*/
   delete from c_xmltemplate where id=v_xml_id;
   return v_apply_id;
end;
/


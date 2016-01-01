create or replace function FN_T_CREATEAPPLY(p_clob varchar2, p_applytype number, p_status number, p_proposer varchar2) return number
as
   v_xml_id NUMBER(12);
   v_apply_id NUMBER(10);
begin
   /* 生成xml文本id*/
   select nvl(max(id),0)+1 into v_xml_id from c_xmltemplate;
   /* 用上面生成的id作插入操作*/
   insert into c_xmltemplate values(v_xml_id, to_clob(p_clob));
   /* 生成申请记录的id*/
   select nvl(max(id),0)+1 into v_apply_id from t_apply;
   /* 用上面生成的id作插入操作*/
   insert into t_apply (id,applyType,status,proposer,applytime,content) values (v_apply_id,p_applytype,p_status,p_proposer,sysdate,sys.xmlType.createXML((select clob from c_xmltemplate where id=v_xml_id)));
   /* 删除xml数据*/
   delete from c_xmltemplate where id=v_xml_id;
   return v_apply_id;
end;
/


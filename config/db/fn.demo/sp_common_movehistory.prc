create or replace procedure SP_COMMON_MoveHistory(p_EndDate Date) as
/**
 * ת��ʷ
 **/
begin
  --��־ת��ʷ
  insert into c_globallog_all_h(id,operator,operatetime,operatetype,operateip,operatortype,mark,operatecontent,currentvalue,operateresult,LogType)
  select id, operator, operatetime, operatetype, operateip, operatortype, mark, operatecontent, currentvalue, operateresult, LogType
    from c_globallog_all t where t.operatetime <= p_EndDate;
  delete from c_globallog_all t where t.operatetime <= p_EndDate;
end;
/


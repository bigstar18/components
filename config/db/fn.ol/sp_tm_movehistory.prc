create or replace procedure SP_TM_MoveHistory(p_EndDate Date) as
/**
 * ת��ʷ
 **/
begin

  --�������ת��ʷ
  insert into tm_trademonitor_h(id, moduleid, type, num, datetime, categoryType)
  select t.id,t.moduleid,t.type,t.num,t.datetime,t.categorytype from tm_trademonitor  t where t.datetime<=p_EndDate;
  delete from tm_trademonitor t where t.datetime<=p_EndDate;

end;
/


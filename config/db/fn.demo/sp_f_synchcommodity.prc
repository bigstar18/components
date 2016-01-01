create or replace procedure SP_F_SynchCommodity(p_CommodityID varchar2) as
  v_cnt number;
begin
  select count(*) into v_cnt from f_account where code='200215'||p_CommodityID;
  if(v_cnt=0) then
    insert into f_account(Code,Name,accountLevel,dCFlag)
    select '200215'||p_CommodityID,name||p_CommodityID,3,'C' from f_account where code='200215';
  end if;

  select count(*) into v_cnt from f_account where code='209915'||p_CommodityID;
  if(v_cnt=0) then
    insert into f_account(Code,Name,accountLevel,dCFlag)
    select '209915'||p_CommodityID,name||p_CommodityID,3,'C' from f_account where code='209915';
  end if;

   select count(*) into v_cnt from f_account where code='100515'||p_CommodityID;
   if(v_cnt=0) then
    insert into f_account(Code,Name,accountLevel,dCFlag)
    select '100515'||p_CommodityID,name||p_CommodityID,3,'C' from f_account where code='100515';
  end if;

  select count(*) into v_cnt from f_account where code = '200515'||p_CommodityID;
  if(v_cnt=0) then
    insert into f_account(Code,Name,accountLevel,dCFlag)
    select '200515'||p_CommodityID,name||p_CommodityID,3,'C' from f_account where code='200515';
  end if;

  select count(*) into v_cnt from f_account where code = '200415'||p_CommodityID;
  if(v_cnt=0) then
    insert into f_account(Code,Name,accountLevel,dCFlag)
    select '200415'||p_CommodityID,name||p_CommodityID,3,'C' from f_account where code='200415';
  end if;

end;
/


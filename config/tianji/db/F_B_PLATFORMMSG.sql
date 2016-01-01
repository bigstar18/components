prompt PL/SQL Developer import file
prompt Created on 2015Äê11ÔÂ11ÈÕ by hxx
set feedback off
set define off
prompt Dropping F_B_PLATFORMMSG...
drop table F_B_PLATFORMMSG cascade constraints;
prompt Creating F_B_PLATFORMMSG...
create table F_B_PLATFORMMSG
(
  firmid     VARCHAR2(15) not null,
  platfirmid VARCHAR2(15) not null
)
;
alter table F_B_PLATFORMMSG
  add constraint F_B_PLATFORMMSG_PRIMARY primary key (FIRMID);

prompt Disabling triggers for F_B_PLATFORMMSG...
alter table F_B_PLATFORMMSG disable all triggers;
prompt Loading F_B_PLATFORMMSG...
insert into F_B_PLATFORMMSG (firmid, platfirmid)
values ('505000000000002', 'PTN0002979');
insert into F_B_PLATFORMMSG (firmid, platfirmid)
values ('505000000000001', 'PTN0003306');
insert into F_B_PLATFORMMSG (firmid, platfirmid)
values ('505000000000004', 'PTN0003314');
commit;
prompt 3 records loaded
prompt Enabling triggers for F_B_PLATFORMMSG...
alter table F_B_PLATFORMMSG enable all triggers;
set feedback on
set define on
prompt Done.

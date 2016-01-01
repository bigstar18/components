prompt PL/SQL Developer import file
prompt Created on 2015年11月11日 by hxx
set feedback off
set define off
prompt Dropping F_CLEARSTATUS...
drop table F_CLEARSTATUS cascade constraints;
prompt Creating F_CLEARSTATUS...
create table F_CLEARSTATUS
(
  actionid   NUMBER(3) not null,
  actionnote VARCHAR2(32) not null,
  status     CHAR(1) not null,
  finishtime DATE
)
;
comment on column F_CLEARSTATUS.status
  is 'Y:完成
N:未执行';
alter table F_CLEARSTATUS
  add constraint PK_F_CLEARSTATUS primary key (ACTIONID);

prompt Disabling triggers for F_CLEARSTATUS...
alter table F_CLEARSTATUS disable all triggers;
prompt Loading F_CLEARSTATUS...
insert into F_CLEARSTATUS (actionid, actionnote, status, finishtime)
values (0, '结算开始', 'Y', to_date('11-11-2015 16:46:43', 'dd-mm-yyyy hh24:mi:ss'));
insert into F_CLEARSTATUS (actionid, actionnote, status, finishtime)
values (1, '抽取电脑凭证', 'Y', to_date('11-11-2015 16:46:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into F_CLEARSTATUS (actionid, actionnote, status, finishtime)
values (2, '归属流水及凭证日期', 'Y', to_date('11-11-2015 16:46:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into F_CLEARSTATUS (actionid, actionnote, status, finishtime)
values (3, '将凭证记入会计账簿', 'Y', to_date('11-11-2015 16:46:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into F_CLEARSTATUS (actionid, actionnote, status, finishtime)
values (4, '结算账户', 'Y', to_date('11-11-2015 16:46:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into F_CLEARSTATUS (actionid, actionnote, status, finishtime)
values (5, '生成客户总账', 'Y', to_date('11-11-2015 16:46:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into F_CLEARSTATUS (actionid, actionnote, status, finishtime)
values (6, '归档历史表', 'Y', to_date('11-11-2015 16:46:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into F_CLEARSTATUS (actionid, actionnote, status, finishtime)
values (8, '结算完成', 'Y', to_date('11-11-2015 16:46:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into F_CLEARSTATUS (actionid, actionnote, status, finishtime)
values (7, '生成交易商清算资金数据', 'Y', to_date('11-11-2015 16:46:44', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 9 records loaded
prompt Enabling triggers for F_CLEARSTATUS...
alter table F_CLEARSTATUS enable all triggers;
set feedback on
set define on
prompt Done.

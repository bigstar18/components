prompt PL/SQL Developer import file
prompt Created on 2015��11��11�� by hxx
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
  is 'Y:���
N:δִ��';
alter table F_CLEARSTATUS
  add constraint PK_F_CLEARSTATUS primary key (ACTIONID);

prompt Disabling triggers for F_CLEARSTATUS...
alter table F_CLEARSTATUS disable all triggers;
prompt Loading F_CLEARSTATUS...
insert into F_CLEARSTATUS (actionid, actionnote, status, finishtime)
values (0, '���㿪ʼ', 'Y', to_date('11-11-2015 16:46:43', 'dd-mm-yyyy hh24:mi:ss'));
insert into F_CLEARSTATUS (actionid, actionnote, status, finishtime)
values (1, '��ȡ����ƾ֤', 'Y', to_date('11-11-2015 16:46:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into F_CLEARSTATUS (actionid, actionnote, status, finishtime)
values (2, '������ˮ��ƾ֤����', 'Y', to_date('11-11-2015 16:46:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into F_CLEARSTATUS (actionid, actionnote, status, finishtime)
values (3, '��ƾ֤�������˲�', 'Y', to_date('11-11-2015 16:46:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into F_CLEARSTATUS (actionid, actionnote, status, finishtime)
values (4, '�����˻�', 'Y', to_date('11-11-2015 16:46:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into F_CLEARSTATUS (actionid, actionnote, status, finishtime)
values (5, '���ɿͻ�����', 'Y', to_date('11-11-2015 16:46:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into F_CLEARSTATUS (actionid, actionnote, status, finishtime)
values (6, '�鵵��ʷ��', 'Y', to_date('11-11-2015 16:46:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into F_CLEARSTATUS (actionid, actionnote, status, finishtime)
values (8, '�������', 'Y', to_date('11-11-2015 16:46:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into F_CLEARSTATUS (actionid, actionnote, status, finishtime)
values (7, '���ɽ����������ʽ�����', 'Y', to_date('11-11-2015 16:46:44', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 9 records loaded
prompt Enabling triggers for F_CLEARSTATUS...
alter table F_CLEARSTATUS enable all triggers;
set feedback on
set define on
prompt Done.

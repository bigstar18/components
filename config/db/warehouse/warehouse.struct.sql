--------------------------------------------------
-- Export file for user TRADE_GNNT@SPOT.DEV.183 --
-- Created by hxx on 2015/11/13, 21:23:46 --------
--------------------------------------------------

set define off
spool warehouse.struct.log

prompt
prompt Creating table W_ERRORLOGINLOG
prompt ==============================
prompt
create table W_ERRORLOGINLOG
(
  errorloginid NUMBER(15) not null,
  userid       VARCHAR2(32) not null,
  logindate    DATE not null,
  warehouseid  VARCHAR2(32) not null,
  ip           VARCHAR2(32)
)
;
comment on column W_ERRORLOGINLOG.userid
  is '����ԱId';
alter table W_ERRORLOGINLOG
  add primary key (ERRORLOGINID);

prompt
prompt Creating table W_GLOBALLOG_ALL
prompt ==============================
prompt
create table W_GLOBALLOG_ALL
(
  id             NUMBER(15) not null,
  operator       VARCHAR2(32),
  warehouseid    VARCHAR2(32),
  operatetime    DATE default sysdate,
  operatetype    NUMBER(4),
  operateip      VARCHAR2(32),
  operatortype   VARCHAR2(32),
  mark           VARCHAR2(4000),
  operatecontent VARCHAR2(4000),
  currentvalue   VARCHAR2(4000),
  operateresult  NUMBER(1) default 0,
  logtype        NUMBER(2)
)
;
comment on column W_GLOBALLOG_ALL.id
  is 'ID';
comment on column W_GLOBALLOG_ALL.operator
  is '������';
comment on column W_GLOBALLOG_ALL.operatetime
  is '����ʱ��';
comment on column W_GLOBALLOG_ALL.operatetype
  is '��������';
comment on column W_GLOBALLOG_ALL.operateip
  is '����IP';
comment on column W_GLOBALLOG_ALL.operatortype
  is '����������';
comment on column W_GLOBALLOG_ALL.mark
  is '��ʾ';
comment on column W_GLOBALLOG_ALL.operatecontent
  is '��������';
comment on column W_GLOBALLOG_ALL.currentvalue
  is '��ǰֵ';
comment on column W_GLOBALLOG_ALL.operateresult
  is '������� 1 �ɹ�  0 ʧ��';
alter table W_GLOBALLOG_ALL
  add primary key (ID);
alter table W_GLOBALLOG_ALL
  add constraint RC_W_GLOBALLOG_ALL
  check (operateresult in(0,1));

prompt
prompt Creating table W_GLOBALLOG_ALL_H
prompt ================================
prompt
create table W_GLOBALLOG_ALL_H
(
  id             NUMBER(15) not null,
  operator       VARCHAR2(32),
  warehouseid    VARCHAR2(32),
  operatetime    DATE,
  operatetype    NUMBER(4),
  operateip      VARCHAR2(32),
  operatortype   VARCHAR2(32),
  mark           VARCHAR2(4000),
  operatecontent VARCHAR2(4000),
  currentvalue   VARCHAR2(4000),
  operateresult  NUMBER(1) default 0,
  logtype        NUMBER(2)
)
;
comment on column W_GLOBALLOG_ALL_H.id
  is 'ID';
comment on column W_GLOBALLOG_ALL_H.operator
  is '������';
comment on column W_GLOBALLOG_ALL_H.operatetime
  is '����ʱ��';
comment on column W_GLOBALLOG_ALL_H.operatetype
  is '��������';
comment on column W_GLOBALLOG_ALL_H.operateip
  is '����IP';
comment on column W_GLOBALLOG_ALL_H.operatortype
  is '����������';
comment on column W_GLOBALLOG_ALL_H.mark
  is '��ʾ';
comment on column W_GLOBALLOG_ALL_H.operatecontent
  is '��������';
comment on column W_GLOBALLOG_ALL_H.currentvalue
  is '��ǰֵ';
comment on column W_GLOBALLOG_ALL_H.operateresult
  is '������� 1 �ɹ�  0 ʧ��';
alter table W_GLOBALLOG_ALL_H
  add constraint RC_W_GLOBALLOG_ALL_H
  check (operateresult in(0,1));

prompt
prompt Creating table W_LOGCATALOG
prompt ===========================
prompt
create table W_LOGCATALOG
(
  catalogid   NUMBER(4) not null,
  moduleid    NUMBER(2) not null,
  catalogname VARCHAR2(32)
)
;
comment on table W_LOGCATALOG
  is '��־���࣬4λ���ֵı��룬����־ģ��ID��ͷ��';
comment on column W_LOGCATALOG.catalogid
  is '��־����ID��4λ���ֵı��룬�����עNotes��';
comment on column W_LOGCATALOG.catalogname
  is '��־������';
alter table W_LOGCATALOG
  add primary key (CATALOGID);

prompt
prompt Creating table W_MYMENU
prompt =======================
prompt
create table W_MYMENU
(
  userid  VARCHAR2(32) not null,
  rightid NUMBER(10) not null
)
;
alter table W_MYMENU
  add primary key (USERID, RIGHTID);

prompt
prompt Creating table W_RIGHT
prompt ======================
prompt
create table W_RIGHT
(
  id           NUMBER(10) not null,
  parentid     NUMBER(10),
  name         VARCHAR2(128),
  moduleid     NUMBER(2) not null,
  icon         VARCHAR2(128),
  authorityurl VARCHAR2(512),
  visiturl     VARCHAR2(512),
  seq          NUMBER(3),
  visible      NUMBER(1),
  type         NUMBER(1) not null,
  catalogid    NUMBER(4),
  iswritelog   VARCHAR2(1) default 'N'
)
;
comment on column W_RIGHT.id
  is ' �淶��
1����ͷ��λΪϵͳģ���
2: ������λΪһ���˵�
3��������λΪ�����˵�
4�����߰�λΪ�����˵�
5���ھ�ʮλΪҳ���е���ɾ�Ĳ�
';
comment on column W_RIGHT.parentid
  is '������';
comment on column W_RIGHT.name
  is 'Ȩ������';
comment on column W_RIGHT.icon
  is 'ͼ��';
comment on column W_RIGHT.authorityurl
  is 'Ȩ��·��';
comment on column W_RIGHT.visiturl
  is '��ʵ·��';
comment on column W_RIGHT.seq
  is '���';
comment on column W_RIGHT.visible
  is '�Ƿ�ɼ�-1 ���ɼ�0 �ɼ�';
comment on column W_RIGHT.type
  is '����-3:ֻ���session�����Ȩ�޵�url -2�������ж�Ȩ�޵�URL -1�� ���˵����� 0���Ӳ˵����� 1��ҳ������ɾ�Ĳ�Ȩ��';
comment on column W_RIGHT.catalogid
  is '��־���� 0��д��־ ������Ӧ��w_logcatalog ��CATALOGID�ֶ�';
comment on column W_RIGHT.iswritelog
  is '''Y''��д��־��''N''����д��־';
alter table W_RIGHT
  add primary key (ID);
alter table W_RIGHT
  add constraint CHECK_W_RIGHT_TYPE
  check (TYPE in (-3,-2,-1,0,1));
alter table W_RIGHT
  add constraint CHECK_W_RIGHT_VISIBLE
  check (VISIBLE in (-1,0));

prompt
prompt Creating table W_ROLE
prompt =====================
prompt
create table W_ROLE
(
  id          NUMBER(10) not null,
  name        VARCHAR2(32) not null,
  warehouseid VARCHAR2(32) not null,
  description VARCHAR2(256)
)
;
comment on column W_ROLE.id
  is '��ɫId';
comment on column W_ROLE.name
  is '��ɫ����';
comment on column W_ROLE.description
  is '����';
alter table W_ROLE
  add primary key (ID);

prompt
prompt Creating table W_ROLE_RIGHT
prompt ===========================
prompt
create table W_ROLE_RIGHT
(
  rightid NUMBER(10) not null,
  roleid  NUMBER(10) not null
)
;
comment on column W_ROLE_RIGHT.rightid
  is 'Ȩ��Id';
comment on column W_ROLE_RIGHT.roleid
  is '��ɫId';
alter table W_ROLE_RIGHT
  add primary key (RIGHTID, ROLEID);

prompt
prompt Creating table W_TRADEMODULE
prompt ============================
prompt
create table W_TRADEMODULE
(
  moduleid           NUMBER(2) not null,
  cnname             VARCHAR2(64) not null,
  enname             VARCHAR2(64),
  shortname          VARCHAR2(16),
  addfirmfn          VARCHAR2(36),
  updatefirmstatusfn VARCHAR2(36),
  delfirmfn          VARCHAR2(36),
  isfirmset          CHAR(1) default 'N' not null,
  hostip             VARCHAR2(16),
  port               NUMBER(6),
  rmidataport        NUMBER(6),
  isbalancecheck     CHAR(1) default 'N' not null,
  isneedbreed        CHAR(1) not null
)
;
comment on column W_TRADEMODULE.moduleid
  is '10�ۺϹ���ƽ̨
11����ϵͳ
12��ֿܲ����ϵͳ
13�ֵ�����ϵͳ
14����ϵͳ
15��������
18Ͷ���������Ʒ����ϵͳ
19���˻�Ա����ϵͳ
20�����̽���ϵͳ
21����ϵͳ
22���н��뼰����ϵͳ
23E�ֻ�
24�����¼ϵͳ
25ʵʱ�������ϵͳ
26���׿ͻ���
98demoϵͳ
99����ϵͳ';
comment on column W_TRADEMODULE.isfirmset
  is '��Y�� �� ��N�� �� (�����Ҫ�ڹ���ǰ̨�ҵ�ƽ̨����ʾ��ϵͳ������Ҫ�ڹ���ϵͳ�� spring_sys_msg.xml �������ϱ�ϵͳ��������Ϣ)';
comment on column W_TRADEMODULE.isbalancecheck
  is 'Y���� N����';
comment on column W_TRADEMODULE.isneedbreed
  is '��ϵͳ�Ƿ���Ҫ�ۺϹ���ƽ̨���ӵ���Ʒ   Y:��   N:��';
alter table W_TRADEMODULE
  add primary key (MODULEID);

prompt
prompt Creating table W_USER
prompt =====================
prompt
create table W_USER
(
  userid      VARCHAR2(32) not null,
  warehouseid VARCHAR2(32) not null,
  name        VARCHAR2(32),
  password    VARCHAR2(32),
  type        VARCHAR2(20) default 'ADMIN' not null,
  description VARCHAR2(256),
  isforbid    CHAR(1) default 'N' not null,
  skin        VARCHAR2(16) default 'default' not null,
  keycode     VARCHAR2(128) default '0123456789ABCDE' not null
)
;
comment on column W_USER.userid
  is '����ԱId';
comment on column W_USER.name
  is '����Ա����';
comment on column W_USER.password
  is '����';
comment on column W_USER.type
  is 'ADMIN����ͨ����Ա��ɫDEFAULT_ADMIN���߼�����Ա��ɫDEFAULT_SUPER_ADMIN��Ĭ�ϳ�������Ա��ɫ';
comment on column W_USER.description
  is '����';
comment on column W_USER.isforbid
  is 'Y������
N��������
';
comment on column W_USER.skin
  is 'Ƥ��';
comment on column W_USER.keycode
  is 'key';
alter table W_USER
  add primary key (USERID);

prompt
prompt Creating table W_USER_RIGHT
prompt ===========================
prompt
create table W_USER_RIGHT
(
  rightid NUMBER(10) not null,
  userid  VARCHAR2(32) not null
)
;
comment on column W_USER_RIGHT.rightid
  is 'Ȩ��Id
Ȩ��Id';
comment on column W_USER_RIGHT.userid
  is '����ԱId';
alter table W_USER_RIGHT
  add primary key (RIGHTID, USERID);

prompt
prompt Creating table W_USER_ROLE
prompt ==========================
prompt
create table W_USER_ROLE
(
  userid VARCHAR2(32) not null,
  roleid NUMBER(10) not null
)
;
comment on column W_USER_ROLE.userid
  is '����ԱId';
comment on column W_USER_ROLE.roleid
  is '��ɫId';
alter table W_USER_ROLE
  add primary key (USERID, ROLEID);

prompt
prompt Creating sequence SEQ_W_ERRORLOGINLOG
prompt =====================================
prompt
create sequence SEQ_W_ERRORLOGINLOG
minvalue 1
maxvalue 9999999999999999999999999999
start with 341
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_W_GLOBALLOG_ALL
prompt =====================================
prompt
create sequence SEQ_W_GLOBALLOG_ALL
minvalue 1
maxvalue 9999999999999999999999999999
start with 1221
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_W_ROLE
prompt ============================
prompt
create sequence SEQ_W_ROLE
minvalue 1
maxvalue 9999999999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating view V_W_ERRORLOGINLOG
prompt ===============================
prompt
create or replace force view v_w_errorloginlog as
select u.userid   as userid,
       u.name as name,
       logs.warehouseid as warehouseid,
       logs.counts     as counts,
       logs.loginDate  as logindate
  from (select t.userid, count(*) counts,warehouseid, trunc(loginDate) loginDate
          from w_errorloginlog t
         group by userid,warehouseid, trunc(loginDate)) logs,
       w_user u
 where u.userid = logs.userid;

prompt
prompt Creating procedure SP_W_MOVEHISTORY
prompt ===================================
prompt
create or replace procedure SP_W_MoveHistory(p_EndDate Date) as
/**
 * ת��ʷ
 **/
begin
  --��־ת��ʷ
  insert into W_GLOBALLOG_ALL_H (ID,OPERATOR,warehouseID,OPERATETIME,OPERATETYPE,OPERATEIP,OPERATORTYPE,MARK,OPERATECONTENT,CURRENTVALUE,OPERATERESULT,LogType) select ID,OPERATOR,warehouseID,OPERATETIME,OPERATETYPE,OPERATEIP,OPERATORTYPE,MARK,OPERATECONTENT,CURRENTVALUE,OPERATERESULT,LogType from W_GLOBALLOG_ALL g where g.OPERATETIME<=p_EndDate;
  delete from W_GLOBALLOG_ALL g where g.OPERATETIME<=p_EndDate;
end;
/


spool off

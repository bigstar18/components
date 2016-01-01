--------------------------------------------------
-- Export file for user TRADE_GNNT@SPOT.DEV.183 --
-- Created by hxx on 2015/11/11, 20:05:01 --------
--------------------------------------------------

set define off
spool common.struct.log

prompt
prompt Creating table C_APPLY
prompt ======================
prompt
create table C_APPLY
(
  id          NUMBER(10) not null,
  applytype   VARCHAR2(32) not null,
  status      NUMBER(3) not null,
  content     VARCHAR2(2000) not null,
  note        VARCHAR2(1024),
  discribe    VARCHAR2(512),
  modtime     DATE,
  createtime  DATE not null,
  applyuser   VARCHAR2(32) not null,
  operatetype VARCHAR2(50) not null,
  entityclass VARCHAR2(1024) not null
)
;
comment on column C_APPLY.id
  is 'ID';
comment on column C_APPLY.applytype
  is '��������';
comment on column C_APPLY.status
  is '��ǰ״̬ 0������� 1�����ͨ�� 2����˲��� 3����������';
comment on column C_APPLY.content
  is '����';
comment on column C_APPLY.note
  is '��ע';
comment on column C_APPLY.discribe
  is '����';
comment on column C_APPLY.modtime
  is '�޸�ʱ��';
comment on column C_APPLY.createtime
  is '����ʱ��';
comment on column C_APPLY.applyuser
  is '������';
comment on column C_APPLY.operatetype
  is '�������� update;add;delete;deleteCollection';
comment on column C_APPLY.entityclass
  is 'ҵ�������';
alter table C_APPLY
  add constraint PK_C_APPLY primary key (ID);

prompt
prompt Creating table C_AUDIT
prompt ======================
prompt
create table C_AUDIT
(
  id        NUMBER(10) not null,
  applyid   NUMBER(10) not null,
  status    NUMBER(3) not null,
  audituser VARCHAR2(32) not null,
  modtime   DATE default sysdate not null
)
;
comment on column C_AUDIT.id
  is 'ID';
comment on column C_AUDIT.applyid
  is '���뵥ID';
comment on column C_AUDIT.status
  is '״̬ 1�����ͨ�� 2����������';
comment on column C_AUDIT.audituser
  is '�����';
comment on column C_AUDIT.modtime
  is '�޸�ʱ��';
alter table C_AUDIT
  add constraint PK_C_AUDIT primary key (ID);

prompt
prompt Creating table C_DEPLOY_CONFIG
prompt ==============================
prompt
create table C_DEPLOY_CONFIG
(
  moduleid       NUMBER(2) not null,
  contextname    VARCHAR2(64) not null,
  serverpic      VARCHAR2(64) not null,
  serverpath     VARCHAR2(128),
  relativepath   VARCHAR2(128) not null,
  homepageaction VARCHAR2(128),
  welcomepage    VARCHAR2(128),
  welcomepic     VARCHAR2(64),
  systype        VARCHAR2(32) not null,
  sortno         NUMBER(2) default 1 not null
)
;
comment on column C_DEPLOY_CONFIG.moduleid
  is '��ɫId';
comment on column C_DEPLOY_CONFIG.contextname
  is 'ϵͳ����';
comment on column C_DEPLOY_CONFIG.serverpic
  is '��ҳ����������ϵͳ����ƽ̨�ĵ��ͼƬ';
comment on column C_DEPLOY_CONFIG.serverpath
  is '�����ַ��eg  http://127.0.0.1:8080';
comment on column C_DEPLOY_CONFIG.relativepath
  is '����ϵͳ����������ϵͳ����ƽ̨�ĵ����ַ';
comment on column C_DEPLOY_CONFIG.homepageaction
  is '����ϵͳƽ̨��ҳ��Action';
comment on column C_DEPLOY_CONFIG.welcomepage
  is '��ת������ϵͳ��ҳ����Ե�ַ(ֻ��ǰ̨������ҳ)';
comment on column C_DEPLOY_CONFIG.welcomepic
  is '����ϵͳͷ������������ϵͳ��ҳ��ͼ��չʾ(ֻ��ǰ̨������ҳͼ��)';
comment on column C_DEPLOY_CONFIG.systype
  is 'ϵͳ���ͣ�mgr����̨  front��ǰ̨';
alter table C_DEPLOY_CONFIG
  add constraint PK_C_DELOY_CONFIG primary key (MODULEID, CONTEXTNAME);

prompt
prompt Creating table C_FRONT_MYMENU
prompt =============================
prompt
create table C_FRONT_MYMENU
(
  userid  VARCHAR2(12) not null,
  rightid NUMBER(10) not null
)
;
comment on column C_FRONT_MYMENU.userid
  is '����ԱId';
alter table C_FRONT_MYMENU
  add constraint PK_C_FRONT_MYMENU primary key (USERID, RIGHTID);

prompt
prompt Creating table C_FRONT_RIGHT
prompt ============================
prompt
create table C_FRONT_RIGHT
(
  id           NUMBER(10) not null,
  parentid     NUMBER(10),
  name         VARCHAR2(128),
  icon         VARCHAR2(128),
  authorityurl VARCHAR2(512),
  visiturl     VARCHAR2(512),
  moduleid     NUMBER(3),
  seq          NUMBER(3),
  visible      NUMBER(1),
  type         NUMBER(1) not null,
  catalogid    NUMBER(10),
  iswritelog   VARCHAR2(1) default 'N'
)
;
comment on column C_FRONT_RIGHT.id
  is ' �淶��
1����ͷ��λΪϵͳģ���
2: ������λΪһ���˵�
3��������λΪ�����˵�
4�����߰�λΪ�����˵�
5���ھ�ʮλΪҳ���е���ɾ�Ĳ�
';
comment on column C_FRONT_RIGHT.parentid
  is '������';
comment on column C_FRONT_RIGHT.name
  is 'Ȩ������';
comment on column C_FRONT_RIGHT.icon
  is 'ͼ��';
comment on column C_FRONT_RIGHT.authorityurl
  is 'Ȩ��·��';
comment on column C_FRONT_RIGHT.visiturl
  is '��ʵ·��';
comment on column C_FRONT_RIGHT.moduleid
  is 'ģ��Id';
comment on column C_FRONT_RIGHT.seq
  is '���';
comment on column C_FRONT_RIGHT.visible
  is '�Ƿ�ɼ�-1 ���ɼ�0 �ɼ�';
comment on column C_FRONT_RIGHT.type
  is '����-3:ֻ���session�����Ȩ�޵�url -2�������ж�Ȩ�޵�URL -1�� ���˵����� 0���Ӳ˵����� 1��ҳ������ɾ�Ĳ�Ȩ��';
comment on column C_FRONT_RIGHT.catalogid
  is '��־���� 0��д��־ ������Ӧ��c_logcatalog ��CATALOGID�ֶ�';
comment on column C_FRONT_RIGHT.iswritelog
  is '''Y''��д��־��''N''����д��־';
alter table C_FRONT_RIGHT
  add constraint PK_C_FRONT_RIGHT primary key (ID);
alter table C_FRONT_RIGHT
  add constraint CHECK_C_FRONT_RIGHT_TYPE
  check (TYPE in (-3,-2,-1,0,1));
alter table C_FRONT_RIGHT
  add constraint CHECK_C_FRONT_RIGHT_VISIBLE
  check (VISIBLE in (-1,0));

prompt
prompt Creating table C_FRONT_ROLE
prompt ===========================
prompt
create table C_FRONT_ROLE
(
  id          NUMBER(10) not null,
  name        VARCHAR2(32) not null,
  description VARCHAR2(256)
)
;
comment on column C_FRONT_ROLE.id
  is '��ɫId';
comment on column C_FRONT_ROLE.name
  is '��ɫ����';
comment on column C_FRONT_ROLE.description
  is '����';
alter table C_FRONT_ROLE
  add constraint PK_C_FRONT_ROLE primary key (ID);

prompt
prompt Creating table C_FRONT_ROLE_RIGHT
prompt =================================
prompt
create table C_FRONT_ROLE_RIGHT
(
  rightid NUMBER(10) not null,
  roleid  NUMBER(10) not null
)
;
comment on column C_FRONT_ROLE_RIGHT.rightid
  is 'Ȩ��Id
Ȩ��Id';
comment on column C_FRONT_ROLE_RIGHT.roleid
  is '��ɫId';
alter table C_FRONT_ROLE_RIGHT
  add constraint PK_C_FRONT_ROLE_RIGHT primary key (RIGHTID, ROLEID);

prompt
prompt Creating table C_FRONT_USER_RIGHT
prompt =================================
prompt
create table C_FRONT_USER_RIGHT
(
  rightid NUMBER(10) not null,
  userid  VARCHAR2(12) not null
)
;
comment on column C_FRONT_USER_RIGHT.rightid
  is 'Ȩ��Id
Ȩ��Id';
comment on column C_FRONT_USER_RIGHT.userid
  is '����ԱId';
alter table C_FRONT_USER_RIGHT
  add constraint PK_C_FRONT_USER_RIGHT primary key (RIGHTID, USERID);

prompt
prompt Creating table C_FRONT_USER_ROLE
prompt ================================
prompt
create table C_FRONT_USER_ROLE
(
  userid VARCHAR2(12) not null,
  roleid NUMBER(10) not null
)
;
comment on column C_FRONT_USER_ROLE.userid
  is '����ԱId';
comment on column C_FRONT_USER_ROLE.roleid
  is '��ɫId
��ɫId';
alter table C_FRONT_USER_ROLE
  add constraint PK_C_FRONT_USER_ROLE primary key (USERID, ROLEID);

prompt
prompt Creating table C_GLOBALLOG_ALL
prompt ==============================
prompt
create table C_GLOBALLOG_ALL
(
  id             NUMBER(15) not null,
  operator       VARCHAR2(32),
  operatetime    DATE default sysdate,
  operatetype    NUMBER(4),
  operateip      VARCHAR2(32),
  operatortype   VARCHAR2(32),
  mark           VARCHAR2(4000),
  operatecontent VARCHAR2(4000),
  currentvalue   VARCHAR2(4000),
  operateresult  NUMBER(1) default 0,
  logtype        NUMBER(2) default 0
)
;
comment on column C_GLOBALLOG_ALL.id
  is 'ID';
comment on column C_GLOBALLOG_ALL.operator
  is '������';
comment on column C_GLOBALLOG_ALL.operatetime
  is '����ʱ��';
comment on column C_GLOBALLOG_ALL.operatetype
  is '��������';
comment on column C_GLOBALLOG_ALL.operateip
  is '����IP';
comment on column C_GLOBALLOG_ALL.operatortype
  is '����������';
comment on column C_GLOBALLOG_ALL.mark
  is '��ʾ';
comment on column C_GLOBALLOG_ALL.operatecontent
  is '��������';
comment on column C_GLOBALLOG_ALL.currentvalue
  is '��ǰֵ';
comment on column C_GLOBALLOG_ALL.operateresult
  is '������� 1 �ɹ�  0 ʧ��';
comment on column C_GLOBALLOG_ALL.logtype
  is '0 ������1 ��̨��2 ǰ̨��3 ����';
alter table C_GLOBALLOG_ALL
  add constraint PK_C_GLOBALLOG_ALL primary key (ID);
alter table C_GLOBALLOG_ALL
  add constraint GLBLOGALL
  check (operateresult in(0,1));

prompt
prompt Creating table C_GLOBALLOG_ALL_H
prompt ================================
prompt
create table C_GLOBALLOG_ALL_H
(
  id             NUMBER(15) not null,
  operator       VARCHAR2(32),
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
comment on column C_GLOBALLOG_ALL_H.id
  is 'ID';
comment on column C_GLOBALLOG_ALL_H.operator
  is '������';
comment on column C_GLOBALLOG_ALL_H.operatetime
  is '����ʱ��';
comment on column C_GLOBALLOG_ALL_H.operatetype
  is '��������';
comment on column C_GLOBALLOG_ALL_H.operateip
  is '����IP';
comment on column C_GLOBALLOG_ALL_H.operatortype
  is '����������';
comment on column C_GLOBALLOG_ALL_H.mark
  is '��ʾ';
comment on column C_GLOBALLOG_ALL_H.operatecontent
  is '��������';
comment on column C_GLOBALLOG_ALL_H.currentvalue
  is '��ǰֵ';
comment on column C_GLOBALLOG_ALL_H.operateresult
  is '������� 1 �ɹ�  0 ʧ��';
comment on column C_GLOBALLOG_ALL_H.logtype
  is '0 ������1 ��̨��2 ǰ̨��3 ����';
alter table C_GLOBALLOG_ALL_H
  add constraint GLBLOGALL_1
  check (operateresult in(0,1));

prompt
prompt Creating table C_LOGCATALOG
prompt ===========================
prompt
create table C_LOGCATALOG
(
  catalogid   NUMBER(4) not null,
  moduleid    NUMBER(2) not null,
  catalogname VARCHAR2(32)
)
;
comment on table C_LOGCATALOG
  is '��־���࣬4λ���ֵı��룬����־ģ��ID��ͷ��';
comment on column C_LOGCATALOG.catalogid
  is '��־����ID��4λ���ֵı��룬�����עNotes��';
comment on column C_LOGCATALOG.moduleid
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
comment on column C_LOGCATALOG.catalogname
  is '��־������';
alter table C_LOGCATALOG
  add constraint PK_C_LOGCATALOG primary key (CATALOGID);

prompt
prompt Creating table C_MARKETINFO
prompt ===========================
prompt
create table C_MARKETINFO
(
  infoname  VARCHAR2(128) not null,
  infovalue VARCHAR2(128) not null
)
;
alter table C_MARKETINFO
  add constraint PK_C_MARKETINFO primary key (INFONAME, INFOVALUE);

prompt
prompt Creating table C_MYMENU
prompt =======================
prompt
create table C_MYMENU
(
  userid  VARCHAR2(32) not null,
  rightid NUMBER(10) not null
)
;
alter table C_MYMENU
  add constraint PK_C_MYMENU primary key (USERID, RIGHTID);

prompt
prompt Creating table C_RIGHT
prompt ======================
prompt
create table C_RIGHT
(
  id           NUMBER(10) not null,
  parentid     NUMBER(10),
  name         VARCHAR2(128),
  icon         VARCHAR2(128),
  authorityurl VARCHAR2(512),
  visiturl     VARCHAR2(512),
  moduleid     NUMBER(2) not null,
  seq          NUMBER(3),
  visible      NUMBER(1),
  type         NUMBER(1) not null,
  catalogid    NUMBER(4),
  iswritelog   VARCHAR2(1) default 'N'
)
;
comment on column C_RIGHT.id
  is ' �淶��
1����ͷ��λΪϵͳģ���
2: ������λΪһ���˵�
3��������λΪ�����˵�
4�����߰�λΪ�����˵�
5���ھ�ʮλΪҳ���е���ɾ�Ĳ�
';
comment on column C_RIGHT.parentid
  is '������';
comment on column C_RIGHT.name
  is 'Ȩ������';
comment on column C_RIGHT.icon
  is 'ͼ��';
comment on column C_RIGHT.authorityurl
  is 'Ȩ��·��';
comment on column C_RIGHT.visiturl
  is '��ʵ·��';
comment on column C_RIGHT.moduleid
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
comment on column C_RIGHT.seq
  is '���';
comment on column C_RIGHT.visible
  is '�Ƿ�ɼ�-1 ���ɼ�0 �ɼ�';
comment on column C_RIGHT.type
  is '����-3:ֻ���session�����Ȩ�޵�url -2�������ж�Ȩ�޵�URL -1�� ���˵����� 0���Ӳ˵����� 1��ҳ������ɾ�Ĳ�Ȩ��';
comment on column C_RIGHT.catalogid
  is '��־���� 0��д��־ ������Ӧ��c_logcatalog ��CATALOGID�ֶ�';
comment on column C_RIGHT.iswritelog
  is '''Y''��д��־��''N''����д��־';
alter table C_RIGHT
  add constraint PK_C_RIGHT primary key (ID);
alter table C_RIGHT
  add constraint CHECK_C_RIGHT_TYPE
  check (TYPE in (-3,-2,-1,0,1));
alter table C_RIGHT
  add constraint CHECK_C_RIGHT_VISIBLE
  check (VISIBLE in (-1,0));

prompt
prompt Creating table C_ROLE
prompt =====================
prompt
create table C_ROLE
(
  id          NUMBER(10) not null,
  name        VARCHAR2(32) not null,
  description VARCHAR2(256)
)
;
comment on column C_ROLE.id
  is '��ɫId';
comment on column C_ROLE.name
  is '��ɫ����';
comment on column C_ROLE.description
  is '����';
alter table C_ROLE
  add constraint PK_C_ROLE primary key (ID);

prompt
prompt Creating table C_ROLE_RIGHT
prompt ===========================
prompt
create table C_ROLE_RIGHT
(
  rightid NUMBER(10) not null,
  roleid  NUMBER(10) not null
)
;
comment on column C_ROLE_RIGHT.rightid
  is 'Ȩ��Id';
comment on column C_ROLE_RIGHT.roleid
  is '��ɫId';
alter table C_ROLE_RIGHT
  add constraint PK_C_ROLE_RIGHT primary key (RIGHTID, ROLEID);

prompt
prompt Creating table C_SUBMODULE
prompt ==========================
prompt
create table C_SUBMODULE
(
  moduleid       NUMBER(4) not null,
  cnname         VARCHAR2(64) not null,
  enname         VARCHAR2(64),
  shortname      VARCHAR2(16),
  hostip         VARCHAR2(16),
  port           NUMBER(6),
  rmidataport    NUMBER(6),
  parentmoduleid NUMBER(2) not null,
  remark         VARCHAR2(128)
)
;
comment on column C_SUBMODULE.moduleid
  is '�˱�Ϊc_trademodule�е���ģ�����ñ�ģ��ID��Ҫ��c_trademodule���е�ģ��ID�ظ�';
alter table C_SUBMODULE
  add constraint PK_C_TRADEMODULE_1 primary key (MODULEID);

prompt
prompt Creating table C_TRADEMODULE
prompt ============================
prompt
create table C_TRADEMODULE
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
comment on column C_TRADEMODULE.moduleid
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
comment on column C_TRADEMODULE.isfirmset
  is '��Y�� �� ��N�� �� (�����Ҫ�ڹ���ǰ̨�ҵ�ƽ̨����ʾ��ϵͳ������Ҫ�ڹ���ϵͳ�� spring_sys_msg.xml �������ϱ�ϵͳ��������Ϣ)';
comment on column C_TRADEMODULE.isbalancecheck
  is 'Y���� N����';
comment on column C_TRADEMODULE.isneedbreed
  is '��ϵͳ�Ƿ���Ҫ�ۺϹ���ƽ̨���ӵ���Ʒ   Y:��   N:��';
alter table C_TRADEMODULE
  add constraint PK_C_TRADEMODULE primary key (MODULEID);

prompt
prompt Creating table C_USER
prompt =====================
prompt
create table C_USER
(
  id          VARCHAR2(32) not null,
  name        VARCHAR2(32),
  password    VARCHAR2(32),
  type        VARCHAR2(20) default 'ADMIN' not null,
  description VARCHAR2(256),
  isforbid    CHAR(1) default 'N' not null,
  skin        VARCHAR2(16) default 'default' not null,
  keycode     VARCHAR2(128) default '0123456789ABCDE' not null
)
;
comment on column C_USER.id
  is '����ԱId';
comment on column C_USER.name
  is '����Ա����';
comment on column C_USER.password
  is '����';
comment on column C_USER.type
  is 'ADMIN����ͨ����Ա��ɫDEFAULT_ADMIN���߼�����Ա��ɫDEFAULT_SUPER_ADMIN��Ĭ�ϳ�������Ա��ɫ';
comment on column C_USER.description
  is '����';
comment on column C_USER.isforbid
  is 'Y������
N��������
';
comment on column C_USER.skin
  is 'Ƥ��';
comment on column C_USER.keycode
  is 'key';
alter table C_USER
  add constraint PK_C_USER primary key (ID);

prompt
prompt Creating table C_USER_RIGHT
prompt ===========================
prompt
create table C_USER_RIGHT
(
  rightid NUMBER(10) not null,
  userid  VARCHAR2(32) not null
)
;
comment on column C_USER_RIGHT.rightid
  is 'Ȩ��Id
Ȩ��Id';
comment on column C_USER_RIGHT.userid
  is '����ԱId';
alter table C_USER_RIGHT
  add constraint PK_C_USER_RIGHT primary key (RIGHTID, USERID);

prompt
prompt Creating table C_USER_ROLE
prompt ==========================
prompt
create table C_USER_ROLE
(
  userid VARCHAR2(32) not null,
  roleid NUMBER(10) not null
)
;
comment on column C_USER_ROLE.userid
  is '����ԱId';
comment on column C_USER_ROLE.roleid
  is '��ɫId';
alter table C_USER_ROLE
  add constraint PK_C_USER_ROLE primary key (USERID, ROLEID);

prompt
prompt Creating table C_XMLTEMPLATE
prompt ============================
prompt
create table C_XMLTEMPLATE
(
  id   NUMBER(12) not null,
  clob CLOB not null
)
;
alter table C_XMLTEMPLATE
  add primary key (ID);

prompt
prompt Creating sequence SEQ_C_APPLY
prompt =============================
prompt
create sequence SEQ_C_APPLY
minvalue 1
maxvalue 9999999999999999999999999999
start with 1000000
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_C_AUDIT
prompt =============================
prompt
create sequence SEQ_C_AUDIT
minvalue 1
maxvalue 9999999999999999999999999999
start with 1000000
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_C_FRONT_ROLE
prompt ==================================
prompt
create sequence SEQ_C_FRONT_ROLE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_C_GLOBALLOG
prompt =================================
prompt
create sequence SEQ_C_GLOBALLOG
minvalue 1
maxvalue 9999999999999999999999999999
start with 23979
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_C_ROLE
prompt ============================
prompt
create sequence SEQ_C_ROLE
minvalue 1
maxvalue 9999999999999999999999999999
start with 101
increment by 1
cache 20;

prompt
prompt Creating view V_C_CUSTOMERFUNDS
prompt ===============================
prompt
create or replace force view v_c_customerfunds as
select FIRMID,FIRMNAME,NOWLEAVEBALANCE,RUNTIMEFL,RUNTIMEMARGIN,RUNTIMEASSURE,LASTBALANCE,CLEARFL,CLEARMARGIN,CLEARASSURE,TRADEFEE,MAXOVERDRAFT,CLOSE_PL
    from  (select a.*,
          f.balance,
          f.frozenfunds,
          f.lastbalance,
          m.name FirmName,
          tt.TradeFee,
          nvl(nvl(balance, 0) + nvl((-1) * FrozenFunds, 0), 0) nowLeaveBalance,
          nvl(d.close_PL, 0) close_PL
     from T_Firm a,
          (select sum(t.TradeFee) TradeFee, t.firmID firmID
             from T_Trade t
            group by firmID) tt,
          F_FirmFunds f,
          M_firm m,
          (select firmID, nvl(sum(Close_PL), 0) close_PL
             from T_Trade
            group by firmID) d
    where a.FirmID = tt.FirmID(+)
      and a.FirmID = f.FirmID
      and m.firmID = a.firmID
      and a.firmid = d.firmID(+)
    order by nowLeaveBalance ASC) Q;

prompt
prompt Creating view V_C_TRADEMODULE
prompt =============================
prompt
create or replace force view v_c_trademodule as
select distinct l.moduleid,t.shortname name from f_ledgerfield  l,C_TradeModule t where l.moduleid=t.moduleid;


spool off

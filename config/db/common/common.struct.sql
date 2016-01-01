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
  is '申请类型';
comment on column C_APPLY.status
  is '当前状态 0：待审核 1：审核通过 2：审核驳回 3：撤销申请';
comment on column C_APPLY.content
  is '内容';
comment on column C_APPLY.note
  is '备注';
comment on column C_APPLY.discribe
  is '描述';
comment on column C_APPLY.modtime
  is '修改时间';
comment on column C_APPLY.createtime
  is '创建时间';
comment on column C_APPLY.applyuser
  is '申请人';
comment on column C_APPLY.operatetype
  is '操作类型 update;add;delete;deleteCollection';
comment on column C_APPLY.entityclass
  is '业务对象类';
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
  is '申请单ID';
comment on column C_AUDIT.status
  is '状态 1：审核通过 2：驳回申请';
comment on column C_AUDIT.audituser
  is '审核人';
comment on column C_AUDIT.modtime
  is '修改时间';
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
  is '角色Id';
comment on column C_DEPLOY_CONFIG.contextname
  is '系统名称';
comment on column C_DEPLOY_CONFIG.serverpic
  is '首页点击进入各个系统管理平台的点击图片';
comment on column C_DEPLOY_CONFIG.serverpath
  is '服务地址：eg  http://127.0.0.1:8080';
comment on column C_DEPLOY_CONFIG.relativepath
  is '公用系统点击进入各个系统管理平台的地相对址';
comment on column C_DEPLOY_CONFIG.homepageaction
  is '各个系统平台主页的Action';
comment on column C_DEPLOY_CONFIG.welcomepage
  is '跳转到各个系统首页的相对地址(只有前台才有主页)';
comment on column C_DEPLOY_CONFIG.welcomepic
  is '公用系统头部点击进入各个系统首页的图标展示(只有前台才有首页图标)';
comment on column C_DEPLOY_CONFIG.systype
  is '系统类型，mgr：后台  front：前台';
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
  is '管理员Id';
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
  is ' 规范：
1：开头两位为系统模块号
2: 第三四位为一级菜单
3：第五六位为二级菜单
4：第七八位为三级菜单
5：第九十位为页面中的增删改查
';
comment on column C_FRONT_RIGHT.parentid
  is '父关联';
comment on column C_FRONT_RIGHT.name
  is '权限名称';
comment on column C_FRONT_RIGHT.icon
  is '图标';
comment on column C_FRONT_RIGHT.authorityurl
  is '权限路径';
comment on column C_FRONT_RIGHT.visiturl
  is '真实路径';
comment on column C_FRONT_RIGHT.moduleid
  is '模块Id';
comment on column C_FRONT_RIGHT.seq
  is '序号';
comment on column C_FRONT_RIGHT.visible
  is '是否可见-1 不可见0 可见';
comment on column C_FRONT_RIGHT.type
  is '类型-3:只检查session不检查权限的url -2：无需判断权限的URL -1： 父菜单类型 0：子菜单类型 1：页面内增删改查权限';
comment on column C_FRONT_RIGHT.catalogid
  is '日志类型 0不写日志 其它对应表c_logcatalog 的CATALOGID字段';
comment on column C_FRONT_RIGHT.iswritelog
  is '''Y''：写日志、''N''：不写日志';
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
  is '角色Id';
comment on column C_FRONT_ROLE.name
  is '角色名称';
comment on column C_FRONT_ROLE.description
  is '描述';
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
  is '权限Id
权限Id';
comment on column C_FRONT_ROLE_RIGHT.roleid
  is '角色Id';
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
  is '权限Id
权限Id';
comment on column C_FRONT_USER_RIGHT.userid
  is '管理员Id';
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
  is '管理员Id';
comment on column C_FRONT_USER_ROLE.roleid
  is '角色Id
角色Id';
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
  is '操作人';
comment on column C_GLOBALLOG_ALL.operatetime
  is '操作时间';
comment on column C_GLOBALLOG_ALL.operatetype
  is '操作类型';
comment on column C_GLOBALLOG_ALL.operateip
  is '操作IP';
comment on column C_GLOBALLOG_ALL.operatortype
  is '操作人种类';
comment on column C_GLOBALLOG_ALL.mark
  is '标示';
comment on column C_GLOBALLOG_ALL.operatecontent
  is '操作内容';
comment on column C_GLOBALLOG_ALL.currentvalue
  is '当前值';
comment on column C_GLOBALLOG_ALL.operateresult
  is '操作结果 1 成功  0 失败';
comment on column C_GLOBALLOG_ALL.logtype
  is '0 其他，1 后台，2 前台，3 核心';
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
  is '操作人';
comment on column C_GLOBALLOG_ALL_H.operatetime
  is '操作时间';
comment on column C_GLOBALLOG_ALL_H.operatetype
  is '操作类型';
comment on column C_GLOBALLOG_ALL_H.operateip
  is '操作IP';
comment on column C_GLOBALLOG_ALL_H.operatortype
  is '操作人种类';
comment on column C_GLOBALLOG_ALL_H.mark
  is '标示';
comment on column C_GLOBALLOG_ALL_H.operatecontent
  is '操作内容';
comment on column C_GLOBALLOG_ALL_H.currentvalue
  is '当前值';
comment on column C_GLOBALLOG_ALL_H.operateresult
  is '操作结果 1 成功  0 失败';
comment on column C_GLOBALLOG_ALL_H.logtype
  is '0 其他，1 后台，2 前台，3 核心';
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
  is '日志分类，4位数字的编码，以日志模块ID开头。';
comment on column C_LOGCATALOG.catalogid
  is '日志分类ID：4位数字的编码，详见备注Notes。';
comment on column C_LOGCATALOG.moduleid
  is '10综合管理平台
11财务系统
12监管仓库管理系统
13仓单管理系统
14融资系统
15订单交易
18投资类大宗商品交易系统
19加盟会员管理系统
20做市商交易系统
21竞价系统
22银行接入及结算系统
23E现货
24单点登录系统
25实时行情分析系统
26交易客户端
98demo系统
99公用系统';
comment on column C_LOGCATALOG.catalogname
  is '日志分类名';
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
  is ' 规范：
1：开头两位为系统模块号
2: 第三四位为一级菜单
3：第五六位为二级菜单
4：第七八位为三级菜单
5：第九十位为页面中的增删改查
';
comment on column C_RIGHT.parentid
  is '父关联';
comment on column C_RIGHT.name
  is '权限名称';
comment on column C_RIGHT.icon
  is '图标';
comment on column C_RIGHT.authorityurl
  is '权限路径';
comment on column C_RIGHT.visiturl
  is '真实路径';
comment on column C_RIGHT.moduleid
  is '10综合管理平台
11财务系统
12监管仓库管理系统
13仓单管理系统
14融资系统
15订单交易
18投资类大宗商品交易系统
19加盟会员管理系统
20做市商交易系统
21竞价系统
22银行接入及结算系统
23E现货
24单点登录系统
25实时行情分析系统
26交易客户端
98demo系统
99公用系统';
comment on column C_RIGHT.seq
  is '序号';
comment on column C_RIGHT.visible
  is '是否可见-1 不可见0 可见';
comment on column C_RIGHT.type
  is '类型-3:只检查session不检查权限的url -2：无需判断权限的URL -1： 父菜单类型 0：子菜单类型 1：页面内增删改查权限';
comment on column C_RIGHT.catalogid
  is '日志类型 0不写日志 其它对应表c_logcatalog 的CATALOGID字段';
comment on column C_RIGHT.iswritelog
  is '''Y''：写日志、''N''：不写日志';
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
  is '角色Id';
comment on column C_ROLE.name
  is '角色名称';
comment on column C_ROLE.description
  is '描述';
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
  is '权限Id';
comment on column C_ROLE_RIGHT.roleid
  is '角色Id';
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
  is '此表为c_trademodule中的子模块配置表，模块ID不要与c_trademodule表中的模块ID重复';
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
  is '10综合管理平台
11财务系统
12监管仓库管理系统
13仓单管理系统
14融资系统
15订单交易
18投资类大宗商品交易系统
19加盟会员管理系统
20做市商交易系统
21竞价系统
22银行接入及结算系统
23E现货
24单点登录系统
25实时行情分析系统
26交易客户端
98demo系统
99公用系统';
comment on column C_TRADEMODULE.isfirmset
  is '‘Y’ 是 ‘N’ 否 (如果需要在公用前台我的平台中显示本系统，还需要在公用系统的 spring_sys_msg.xml 中配置上本系统的配置信息)';
comment on column C_TRADEMODULE.isbalancecheck
  is 'Y：是 N：否';
comment on column C_TRADEMODULE.isneedbreed
  is '本系统是否需要综合管理平台增加的商品   Y:是   N:否';
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
  is '管理员Id';
comment on column C_USER.name
  is '管理员名称';
comment on column C_USER.password
  is '密码';
comment on column C_USER.type
  is 'ADMIN：普通管理员角色DEFAULT_ADMIN：高级管理员角色DEFAULT_SUPER_ADMIN：默认超级管理员角色';
comment on column C_USER.description
  is '描述';
comment on column C_USER.isforbid
  is 'Y：禁用
N：不禁用
';
comment on column C_USER.skin
  is '皮肤';
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
  is '权限Id
权限Id';
comment on column C_USER_RIGHT.userid
  is '管理员Id';
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
  is '管理员Id';
comment on column C_USER_ROLE.roleid
  is '角色Id';
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

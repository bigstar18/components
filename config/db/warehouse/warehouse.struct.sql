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
  is '管理员Id';
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
  is '操作人';
comment on column W_GLOBALLOG_ALL.operatetime
  is '操作时间';
comment on column W_GLOBALLOG_ALL.operatetype
  is '操作类型';
comment on column W_GLOBALLOG_ALL.operateip
  is '操作IP';
comment on column W_GLOBALLOG_ALL.operatortype
  is '操作人种类';
comment on column W_GLOBALLOG_ALL.mark
  is '标示';
comment on column W_GLOBALLOG_ALL.operatecontent
  is '操作内容';
comment on column W_GLOBALLOG_ALL.currentvalue
  is '当前值';
comment on column W_GLOBALLOG_ALL.operateresult
  is '操作结果 1 成功  0 失败';
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
  is '操作人';
comment on column W_GLOBALLOG_ALL_H.operatetime
  is '操作时间';
comment on column W_GLOBALLOG_ALL_H.operatetype
  is '操作类型';
comment on column W_GLOBALLOG_ALL_H.operateip
  is '操作IP';
comment on column W_GLOBALLOG_ALL_H.operatortype
  is '操作人种类';
comment on column W_GLOBALLOG_ALL_H.mark
  is '标示';
comment on column W_GLOBALLOG_ALL_H.operatecontent
  is '操作内容';
comment on column W_GLOBALLOG_ALL_H.currentvalue
  is '当前值';
comment on column W_GLOBALLOG_ALL_H.operateresult
  is '操作结果 1 成功  0 失败';
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
  is '日志分类，4位数字的编码，以日志模块ID开头。';
comment on column W_LOGCATALOG.catalogid
  is '日志分类ID：4位数字的编码，详见备注Notes。';
comment on column W_LOGCATALOG.catalogname
  is '日志分类名';
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
  is ' 规范：
1：开头两位为系统模块号
2: 第三四位为一级菜单
3：第五六位为二级菜单
4：第七八位为三级菜单
5：第九十位为页面中的增删改查
';
comment on column W_RIGHT.parentid
  is '父关联';
comment on column W_RIGHT.name
  is '权限名称';
comment on column W_RIGHT.icon
  is '图标';
comment on column W_RIGHT.authorityurl
  is '权限路径';
comment on column W_RIGHT.visiturl
  is '真实路径';
comment on column W_RIGHT.seq
  is '序号';
comment on column W_RIGHT.visible
  is '是否可见-1 不可见0 可见';
comment on column W_RIGHT.type
  is '类型-3:只检查session不检查权限的url -2：无需判断权限的URL -1： 父菜单类型 0：子菜单类型 1：页面内增删改查权限';
comment on column W_RIGHT.catalogid
  is '日志类型 0不写日志 其它对应表w_logcatalog 的CATALOGID字段';
comment on column W_RIGHT.iswritelog
  is '''Y''：写日志、''N''：不写日志';
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
  is '角色Id';
comment on column W_ROLE.name
  is '角色名称';
comment on column W_ROLE.description
  is '描述';
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
  is '权限Id';
comment on column W_ROLE_RIGHT.roleid
  is '角色Id';
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
comment on column W_TRADEMODULE.isfirmset
  is '‘Y’ 是 ‘N’ 否 (如果需要在公用前台我的平台中显示本系统，还需要在公用系统的 spring_sys_msg.xml 中配置上本系统的配置信息)';
comment on column W_TRADEMODULE.isbalancecheck
  is 'Y：是 N：否';
comment on column W_TRADEMODULE.isneedbreed
  is '本系统是否需要综合管理平台增加的商品   Y:是   N:否';
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
  is '管理员Id';
comment on column W_USER.name
  is '管理员名称';
comment on column W_USER.password
  is '密码';
comment on column W_USER.type
  is 'ADMIN：普通管理员角色DEFAULT_ADMIN：高级管理员角色DEFAULT_SUPER_ADMIN：默认超级管理员角色';
comment on column W_USER.description
  is '描述';
comment on column W_USER.isforbid
  is 'Y：禁用
N：不禁用
';
comment on column W_USER.skin
  is '皮肤';
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
  is '权限Id
权限Id';
comment on column W_USER_RIGHT.userid
  is '管理员Id';
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
  is '管理员Id';
comment on column W_USER_ROLE.roleid
  is '角色Id';
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
 * 转历史
 **/
begin
  --日志转历史
  insert into W_GLOBALLOG_ALL_H (ID,OPERATOR,warehouseID,OPERATETIME,OPERATETYPE,OPERATEIP,OPERATORTYPE,MARK,OPERATECONTENT,CURRENTVALUE,OPERATERESULT,LogType) select ID,OPERATOR,warehouseID,OPERATETIME,OPERATETYPE,OPERATEIP,OPERATORTYPE,MARK,OPERATECONTENT,CURRENTVALUE,OPERATERESULT,LogType from W_GLOBALLOG_ALL g where g.OPERATETIME<=p_EndDate;
  delete from W_GLOBALLOG_ALL g where g.OPERATETIME<=p_EndDate;
end;
/


spool off

--------------------------------------------------
-- Export file for user TRADE_GNNT@SPOT.DEV.183 --
-- Created by hxx on 2015/11/13, 21:36:56 --------
--------------------------------------------------

set define off
spool m.struct.log

prompt
prompt Creating table M_AGENTTRADER
prompt ============================
prompt
create table M_AGENTTRADER
(
  agenttraderid VARCHAR2(40) not null,
  name          VARCHAR2(16),
  password      VARCHAR2(64) not null,
  type          NUMBER(2) default 0 not null,
  status        NUMBER(2) default 0 not null,
  operatefirm   CLOB,
  createtime    DATE default sysdate,
  modifytime    DATE
)
;
comment on table M_AGENTTRADER
  is '代为委托员表';
comment on column M_AGENTTRADER.type
  is '0 代为委托员
1 强平员';
comment on column M_AGENTTRADER.status
  is '0 正常
1 禁止登陆';
comment on column M_AGENTTRADER.operatefirm
  is '空表示所有
否则交易商用逗号分隔，如 0001,0002,0003';
comment on column M_AGENTTRADER.modifytime
  is '最后一次修改时间';
alter table M_AGENTTRADER
  add constraint PK_M_CONSIGNER primary key (AGENTTRADERID);

prompt
prompt Creating table M_CATEGORY
prompt =========================
prompt
create table M_CATEGORY
(
  categoryid       NUMBER(10) not null,
  categoryname     VARCHAR2(64) not null,
  note             VARCHAR2(256),
  type             VARCHAR2(64) not null,
  sortno           NUMBER(10) not null,
  parentcategoryid NUMBER(10),
  status           NUMBER(1) default 1,
  isoffset         CHAR(1) default 'Y' not null,
  offsetrate       NUMBER(5,4) default 0.05 not null,
  belongmodule     VARCHAR2(30)
)
;
comment on column M_CATEGORY.type
  is 'breed：品种
category：分类
leaf：叶子节点';
comment on column M_CATEGORY.status
  is '1：正常 2：已删除';
comment on column M_CATEGORY.isoffset
  is 'Y:此品种可能出现损溢 N:此品种不可能出现损溢';
comment on column M_CATEGORY.offsetrate
  is '申请损益万分比<1';
comment on column M_CATEGORY.belongmodule
  is '分类所属模块 以|分割';
alter table M_CATEGORY
  add constraint PK_M_CATEGORY primary key (CATEGORYID);

prompt
prompt Creating table M_BREED
prompt ======================
prompt
create table M_BREED
(
  breedid      NUMBER(10) not null,
  breedname    VARCHAR2(32) not null,
  unit         VARCHAR2(16) not null,
  trademode    NUMBER(1) default 1 not null,
  categoryid   NUMBER(10) not null,
  status       NUMBER(1) default 1,
  picture      BLOB,
  belongmodule VARCHAR2(30),
  sortno       NUMBER(10)
)
;
comment on column M_BREED.trademode
  is '交易模式 1：诚信保障金模式 2：保证金模式';
comment on column M_BREED.status
  is '1：正常 2：已删除';
comment on column M_BREED.belongmodule
  is '分类所属模块 以|分割';
alter table M_BREED
  add constraint PK_M_BREED primary key (BREEDID);
alter table M_BREED
  add constraint REFM_CATEGORY22 foreign key (CATEGORYID)
  references M_CATEGORY (CATEGORYID)
  disable
  novalidate;

prompt
prompt Creating table M_PROPERTYTYPE
prompt =============================
prompt
create table M_PROPERTYTYPE
(
  propertytypeid NUMBER(15) not null,
  name           VARCHAR2(64) not null,
  status         NUMBER(2) default 0 not null,
  sortno         NUMBER(2) not null
)
;
comment on column M_PROPERTYTYPE.status
  is '0 可见 1 不可见';
alter table M_PROPERTYTYPE
  add constraint PK_M_PROPERTYTYPE primary key (PROPERTYTYPEID);

prompt
prompt Creating table M_PROPERTY
prompt =========================
prompt
create table M_PROPERTY
(
  propertyid     NUMBER(10) not null,
  categoryid     NUMBER(10) not null,
  propertyname   VARCHAR2(64) not null,
  hasvaluedict   CHAR(1) not null,
  stockcheck     CHAR(1) not null,
  searchable     CHAR(1) not null,
  sortno         NUMBER(10) not null,
  isnecessary    CHAR(1) default 'Y' not null,
  fieldtype      NUMBER(2) default 0 not null,
  propertytypeid NUMBER(15) not null
)
;
comment on column M_PROPERTY.hasvaluedict
  is 'Y：有值字典  N：无值字典';
comment on column M_PROPERTY.stockcheck
  is 'Y：检查  N：不检查 M：不完全检查(选择多个值，匹配其中之一)';
comment on column M_PROPERTY.searchable
  is 'Y：用于列表搜索 N：不用于搜索';
comment on column M_PROPERTY.isnecessary
  is 'Y：必填项；N：选填项';
comment on column M_PROPERTY.fieldtype
  is '0：字符串；1：数字';
create index UK_M_PROPERTY on M_PROPERTY (CATEGORYID, PROPERTYNAME);
alter table M_PROPERTY
  add constraint PK_M_PROPERTY primary key (PROPERTYID);
alter table M_PROPERTY
  add constraint REFM_CATEGORY25 foreign key (CATEGORYID)
  references M_CATEGORY (CATEGORYID)
  disable
  novalidate;
alter table M_PROPERTY
  add constraint REFM_PROPERTYTYPE32 foreign key (PROPERTYTYPEID)
  references M_PROPERTYTYPE (PROPERTYTYPEID)
  disable
  novalidate;

prompt
prompt Creating table M_BREEDPROPS
prompt ===========================
prompt
create table M_BREEDPROPS
(
  breedid       NUMBER(10) not null,
  propertyid    NUMBER(10) not null,
  propertyvalue VARCHAR2(64) not null,
  sortno        NUMBER(10) not null
)
;
comment on table M_BREEDPROPS
  is '品名对应的属性值列表，有哪些属性来自商品分类属性表
';
alter table M_BREEDPROPS
  add constraint PK_M_BREEDPROPS primary key (BREEDID, PROPERTYID, PROPERTYVALUE);
alter table M_BREEDPROPS
  add constraint REFM_BREED24 foreign key (BREEDID)
  references M_BREED (BREEDID)
  disable
  novalidate;
alter table M_BREEDPROPS
  add constraint REFM_PROPERTY23 foreign key (PROPERTYID)
  references M_PROPERTY (PROPERTYID)
  disable
  novalidate;

prompt
prompt Creating table M_CERTIFICATETYPE
prompt ================================
prompt
create table M_CERTIFICATETYPE
(
  code      NUMBER(2) not null,
  name      VARCHAR2(32) not null,
  isvisibal CHAR(1) default 'Y' not null,
  sortno    NUMBER(2) default 0 not null
)
;
comment on column M_CERTIFICATETYPE.isvisibal
  is 'Y 显示 N 不显示';
alter table M_CERTIFICATETYPE
  add constraint PK_M_CERTIFICATETYPE primary key (CODE);

prompt
prompt Creating table M_ERRORLOGINLOG
prompt ==============================
prompt
create table M_ERRORLOGINLOG
(
  traderid  VARCHAR2(40) not null,
  logindate DATE not null,
  moduleid  NUMBER(2) not null,
  ip        VARCHAR2(32) not null
)
;
comment on column M_ERRORLOGINLOG.moduleid
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

prompt
prompt Creating table M_FIRM
prompt =====================
prompt
create table M_FIRM
(
  firmid                  VARCHAR2(32) not null,
  name                    VARCHAR2(32) not null,
  fullname                VARCHAR2(128),
  type                    NUMBER(2) not null,
  contactman              VARCHAR2(32) not null,
  certificatetype         NUMBER(2) not null,
  certificateno           VARCHAR2(32) not null,
  phone                   VARCHAR2(32),
  mobile                  NUMBER(12) not null,
  fax                     VARCHAR2(16),
  address                 VARCHAR2(128),
  postcode                VARCHAR2(16),
  email                   VARCHAR2(64),
  zonecode                VARCHAR2(16) default 'none',
  industrycode            VARCHAR2(16) default 'none',
  firmcategoryid          NUMBER(10) default -1 not null,
  organizationcode        VARCHAR2(9),
  corporaterepresentative VARCHAR2(32),
  note                    VARCHAR2(1024),
  extenddata              VARCHAR2(4000),
  createtime              DATE default sysdate not null,
  modifytime              DATE,
  status                  CHAR(1) default 'N' not null,
  applyid                 NUMBER(10)
)
;
comment on column M_FIRM.type
  is '1：法人
2：代理
3：个人';
comment on column M_FIRM.firmcategoryid
  is '-1 表示未分类';
comment on column M_FIRM.status
  is 'N：正常 Normal
D：冻结 Disable
E：注销 Erase';
alter table M_FIRM
  add constraint PK_M_FIRM primary key (FIRMID);

prompt
prompt Creating table M_FIRMCATEGORY
prompt =============================
prompt
create table M_FIRMCATEGORY
(
  id        NUMBER(10) not null,
  name      VARCHAR2(128) default '未分类' not null,
  note      VARCHAR2(128),
  isvisibal CHAR(1) default 'Y' not null,
  sortno    NUMBER(2) default 0 not null
)
;
comment on column M_FIRMCATEGORY.isvisibal
  is 'Y 显示 N 不显示';
alter table M_FIRMCATEGORY
  add constraint PK_M_FIRMCATEGORY primary key (ID);

prompt
prompt Creating table M_FIRMMODULE
prompt ===========================
prompt
create table M_FIRMMODULE
(
  moduleid NUMBER(2) not null,
  firmid   VARCHAR2(32) not null,
  enabled  CHAR(1) default 'N' not null
)
;
comment on table M_FIRMMODULE
  is '交易商在各个交易模块是否可用';
comment on column M_FIRMMODULE.moduleid
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
comment on column M_FIRMMODULE.enabled
  is 'Y：启用  N：禁用';
alter table M_FIRMMODULE
  add constraint PK_M_FIRMMODULE primary key (MODULEID, FIRMID);

prompt
prompt Creating table M_FIRM_APPLY
prompt ===========================
prompt
create table M_FIRM_APPLY
(
  applyid                 NUMBER(10) not null,
  userid                  VARCHAR2(32) not null,
  password                VARCHAR2(32),
  name                    VARCHAR2(32) not null,
  fullname                VARCHAR2(128),
  type                    NUMBER(2),
  contactman              VARCHAR2(32),
  certificatetype         NUMBER(2),
  certificateno           VARCHAR2(32),
  phone                   VARCHAR2(32),
  mobile                  NUMBER(12),
  fax                     VARCHAR2(16),
  address                 VARCHAR2(128),
  postcode                VARCHAR2(16),
  email                   VARCHAR2(64),
  zonecode                VARCHAR2(16) default 'none',
  industrycode            VARCHAR2(16) default 'none',
  organizationcode        VARCHAR2(9),
  corporaterepresentative VARCHAR2(32),
  note                    VARCHAR2(1024),
  extenddata              VARCHAR2(4000),
  createtime              DATE default sysdate not null,
  modifytime              DATE,
  status                  NUMBER(1) default 0 not null,
  auditnote               VARCHAR2(256),
  brokerid                VARCHAR2(32),
  picture                 BLOB,
  picturecs               BLOB,
  pictureos               BLOB,
  yingyepic               BLOB,
  shuiwupic               BLOB,
  zuzhipic                BLOB,
  kaihupic                BLOB
)
;
comment on column M_FIRM_APPLY.type
  is '1：法人
2：代理
3：个人';
comment on column M_FIRM_APPLY.status
  is '0：待审核
1：审核通过
2：审核不通过';
alter table M_FIRM_APPLY
  add constraint PK_M_FIRM_APPLY primary key (APPLYID);

prompt
prompt Creating table M_INDUSTRY
prompt =========================
prompt
create table M_INDUSTRY
(
  code      VARCHAR2(16) not null,
  name      VARCHAR2(32) not null,
  isvisibal CHAR(1) default 'Y' not null,
  sortno    NUMBER(2) default 0 not null
)
;
comment on column M_INDUSTRY.isvisibal
  is 'Y 显示 N 不显示';
alter table M_INDUSTRY
  add constraint PK_M_INDUSTRY primary key (CODE);

prompt
prompt Creating table M_MESSAGE
prompt ========================
prompt
create table M_MESSAGE
(
  messageid    NUMBER(10) not null,
  message      VARCHAR2(256) not null,
  recievertype NUMBER(2) not null,
  traderid     VARCHAR2(40),
  createtime   DATE,
  userid       VARCHAR2(32) not null
)
;
comment on column M_MESSAGE.recievertype
  is '接收人类型：1 在线交易员 2 在线管理员 3 在线用户 4 指定交易员 5 指定管理员';
comment on column M_MESSAGE.userid
  is '管理员Id';
alter table M_MESSAGE
  add constraint PK_M_MESSAGE primary key (MESSAGEID);

prompt
prompt Creating table M_NOTICE
prompt =======================
prompt
create table M_NOTICE
(
  noticeid   NUMBER(10) not null,
  title      VARCHAR2(64) not null,
  content    VARCHAR2(4000),
  createtime DATE,
  userid     VARCHAR2(32) not null
)
;
comment on column M_NOTICE.userid
  is '管理员Id';
alter table M_NOTICE
  add constraint PK_M_NOTICE primary key (NOTICEID);

prompt
prompt Creating table M_PROCEDURES_ERRORCODE
prompt =====================================
prompt
create table M_PROCEDURES_ERRORCODE
(
  moduleid  NUMBER(2) not null,
  errorcode NUMBER(12) not null,
  errorinfo VARCHAR2(1024)
)
;
comment on table M_PROCEDURES_ERRORCODE
  is '交易商添加修改删除存储的错误码记录';
comment on column M_PROCEDURES_ERRORCODE.moduleid
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
alter table M_PROCEDURES_ERRORCODE
  add constraint PK_M_TRADERMODULE_1 primary key (MODULEID, ERRORCODE);

prompt
prompt Creating table M_SYSTEMPROPS
prompt ============================
prompt
create table M_SYSTEMPROPS
(
  key          VARCHAR2(32) not null,
  value        VARCHAR2(64) not null,
  runtimevalue VARCHAR2(64),
  note         VARCHAR2(128),
  firmidlength VARCHAR2(32) default '15' not null
)
;
comment on column M_SYSTEMPROPS.value
  is '手续费、保证金等参数设置';
alter table M_SYSTEMPROPS
  add constraint PK_M_SYSTEMPROPS primary key (KEY);

prompt
prompt Creating table M_TRADER
prompt =======================
prompt
create table M_TRADER
(
  traderid       VARCHAR2(40) not null,
  firmid         VARCHAR2(32) not null,
  name           VARCHAR2(32) not null,
  userid         VARCHAR2(32),
  password       VARCHAR2(32) not null,
  forcechangepwd NUMBER(1) default 1 not null,
  status         CHAR(1) default 'N' not null,
  type           CHAR(1) not null,
  createtime     DATE default sysdate,
  modifytime     DATE,
  keycode        VARCHAR2(32),
  enablekey      CHAR(1) not null,
  trustkey       VARCHAR2(64),
  lastip         VARCHAR2(16),
  lasttime       DATE,
  skin           VARCHAR2(16) default 'default' not null
)
;
comment on table M_TRADER
  is '交易员表，每个交易商有个与交易商ID相同的交易员作为默认交易员，不可删除。';
comment on column M_TRADER.forcechangepwd
  is '0：否
1：是';
comment on column M_TRADER.status
  is 'N：正常 Normal
D：禁用 Disable';
comment on column M_TRADER.type
  is 'A：管理员
N：一般交易员';
comment on column M_TRADER.modifytime
  is '最后一次修改时间';
comment on column M_TRADER.enablekey
  is 'Y：启用
N：不启用';
comment on column M_TRADER.trustkey
  is '客户端登录成功后，在本地和服务端记录一个信任Key，不限制重试次数。';
alter table M_TRADER
  add constraint PK_M_TRADER primary key (TRADERID);
alter table M_TRADER
  add constraint REFM_FIRM28 foreign key (FIRMID)
  references M_FIRM (FIRMID)
  disable
  novalidate;

prompt
prompt Creating table M_TRADERMODULE
prompt =============================
prompt
create table M_TRADERMODULE
(
  moduleid NUMBER(2) not null,
  traderid VARCHAR2(40) not null,
  enabled  CHAR(1) default 'N' not null
)
;
comment on table M_TRADERMODULE
  is '交易员在各个交易模块是否可用';
comment on column M_TRADERMODULE.moduleid
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
comment on column M_TRADERMODULE.enabled
  is 'Y：启用  N：禁用';
alter table M_TRADERMODULE
  add constraint PK_M_TRADERMODULE primary key (MODULEID, TRADERID);

prompt
prompt Creating table M_ZONE
prompt =====================
prompt
create table M_ZONE
(
  code      VARCHAR2(16) not null,
  name      VARCHAR2(32) not null,
  isvisibal CHAR(1) default 'Y' not null,
  sortno    NUMBER(2) default 0 not null
)
;
comment on column M_ZONE.isvisibal
  is 'Y 显示 N 不显示';
alter table M_ZONE
  add constraint PK_M_ZONE primary key (CODE);

prompt
prompt Creating sequence SEQ_M_BREED
prompt =============================
prompt
create sequence SEQ_M_BREED
minvalue 1
maxvalue 9999999999999999999999999999
start with 1320
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_M_CATEGORY
prompt ================================
prompt
create sequence SEQ_M_CATEGORY
minvalue 1
maxvalue 9999999999999999999999999999
start with 1180
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_M_FIRMCATEGORY
prompt ====================================
prompt
create sequence SEQ_M_FIRMCATEGORY
minvalue 1
maxvalue 9999999999999999999999999999
start with 61
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_M_FIRM_APPLY
prompt ==================================
prompt
create sequence SEQ_M_FIRM_APPLY
minvalue 1
maxvalue 9999999999999999999999999999
start with 602
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_M_MESSAGE
prompt ===============================
prompt
create sequence SEQ_M_MESSAGE
minvalue 1
maxvalue 9999999999999999999999999999
start with 41
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_M_NOTICE
prompt ==============================
prompt
create sequence SEQ_M_NOTICE
minvalue 1
maxvalue 9999999999999999999999999999
start with 61
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_M_PROPERTY
prompt ================================
prompt
create sequence SEQ_M_PROPERTY
minvalue 1
maxvalue 9999999999999999999999999999
start with 1180
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_M_PROPERTYTYPE
prompt ====================================
prompt
create sequence SEQ_M_PROPERTYTYPE
minvalue 1
maxvalue 9999999999999999999999999999
start with 160
increment by 1
cache 20;

prompt
prompt Creating view V_M_FIRM_CREATE_STAT
prompt ==================================
prompt
create or replace force view v_m_firm_create_stat as
select
       trunc(createtime) createdate,        --开户日期
       count(1) cnt                         --开户数量
  from m_firm group by trunc(createtime)
;

prompt
prompt Creating view V_M_FRONT_LOGON_STAT
prompt ==================================
prompt
create or replace force view v_m_front_logon_stat as
select operatrdate, ---登录日期
       sum(logsu) logsuccess, --登录成功数量
       sum(logcount) logcount, --交易商登录数量
       sum(logfail) logfail --登录失败数量
  from (select trunc(t.operatetime) operatrdate,
               count(*) logsu,
               0 logcount,
               0 logfail
          from c_globallog_all t
         where t.operatetype = '3201'
           and t.operateresult = 1
           and t.operatecontent like '%登录成功%'
         group by trunc(t.operatetime)
        union
        select trunc(t.operatetime) operatrdate,
               count(*) logsu,
               0 logcount,
               0 logfail
          from c_globallog_all_h t
         where t.operatetype = '3201'
           and t.operateresult = 1
           and t.operatecontent like '%登录成功%'
         group by trunc(t.operatetime)
        union
        select trunc(t.operatetime) operatrdate,
               0 logsu,
               count(distinct t.operator) logcount,
               0 logfail
          from c_globallog_all t
         where t.operatetype = '3201'
         group by trunc(t.operatetime)
        union
        select trunc(t.operatetime) operatrdate,
               0 logsu,
               count(distinct t.operator) logcount,
               0 logfail
          from c_globallog_all_h t
         where t.operatetype = '3201'
         group by trunc(t.operatetime)
        union
        select trunc(t.operatetime) operatrdate,
               0 logsu,
               0 logcount,
               count(*) logfail
          from c_globallog_all t
         where t.operatetype = '3201'
           and t.operateresult = 0
         group by trunc(t.operatetime)
        union
        select trunc(t.operatetime) operatrdate,
               0 logsu,
               0 logcount,
               count(*) logfail
          from c_globallog_all_h t
         where t.operatetype = '3201'
           and t.operateresult = 0
         group by trunc(t.operatetime))
 group by operatrdate
;

prompt
prompt Creating function FN_M_MD5
prompt ==========================
prompt
CREATE OR REPLACE FUNCTION FN_M_MD5 (p_str IN VARCHAR2)
RETURN VARCHAR2
/****
 * MD5加密算法
 * 返回MD5加密后的字符串
 ****/
IS
  raw_input RAW (128):=UTL_RAW.cast_to_raw (p_str);
  decrypted_raw RAW (2048);
BEGIN
  DBMS_OBFUSCATION_TOOLKIT.md5 (input => raw_input,checksum => decrypted_raw);
  RETURN LOWER (RAWTOHEX (decrypted_raw));
END;
/

prompt
prompt Creating function FN_M_FIRMADD
prompt ==============================
prompt
create or replace function FN_M_FirmAdd
(
    p_FirmID   m_firm.firmid%type, --交易商代码
    p_UserID   m_Trader.Userid%type, -- 用户名
    p_Password m_Trader.Password%type, -- 密码
    errorInfo OUT VARCHAR2--当某个模块添加交易商发生错的时候存放错误信息
)
return integer is
  /**
  * 同步交易商到各个模块
  * 返回值： 1 成功
  *          -900 交易商已经存在
  *          -901 用户名已经存在
  *          -902 某个交易模块发生错误
  **/
  v_cnt                number(4); --数字变量
  Module_RET           number(4); --模块添加交易商返回值
  IS_Error             boolean;--调用其它模块时是否发生错误
  CodeInfo_RET         varchar2(1024);--错误信息
  E_CNName             varchar2(64);--各个系统中文名称
  v_errorcode          number(4); --数字变量
  RET_FoundFirmID      integer := -900;
  RET_FoundUserID      integer := -901;
  RET_TradeModuleError integer := -902;--与errorInfo配合使用
begin
  --检查交易商是否已经存在
  select count(*) into v_cnt from m_trader where traderid = p_FirmID;
  if (v_cnt > 0) then
    return RET_FoundFirmID;
  end if;
  --检查用户是否存在
  select count(*) into v_cnt from m_trader where userID = p_UserID;
  if (v_cnt > 0) then
    return RET_FoundUserID;
  end if;

  IS_Error:=false;
  --循环调用每一个交易模块的添加交易商函数；从交易模块表中查询添加交易商函数长度大于5（FN_xx_）的字段
   for AddFirmFnStr in (select trim(AddFirmFn) as AddFirmFn,ModuleID from C_TradeModule where  lengthb(AddFirmFn)>5)
    loop
        --调试使用 dbms_output.put_line('BEGIN :Module_RET :='||AddFirmFnStr.AddFirmFn||'(:firmid); END;');
        --调用交易模块表中的添加交易商函数
        execute immediate 'BEGIN :Module_RET :='||AddFirmFnStr.AddFirmFn||'(:firmid); END;' using OUT Module_RET,IN p_FirmID;
        --如果返回值不是1则回滚返回交易模块发生错误
        if(Module_RET!=1)then
            IS_Error:=true;
            --获取错误信息
            select count(*) into v_errorcode from m_procedures_errorcode p where p.moduleid=AddFirmFnStr.Moduleid and p.errorcode=Module_RET;
            if(v_errorcode = 1)then
                select p.errorinfo into CodeInfo_RET from m_procedures_errorcode p where p.moduleid=AddFirmFnStr.Moduleid and p.errorcode=Module_RET;
                CodeInfo_RET:='错误信息:'||CodeInfo_RET;
            end if;
            select m.cnname into E_CNName from c_trademodule m where m.moduleid=AddFirmFnStr.Moduleid;
            errorInfo:=errorInfo||'\n'||E_CNName||'，返回码:'||Module_RET||CodeInfo_RET||';';
            CodeInfo_RET:='';

        end if;
    end loop;

    if(IS_Error)then
      rollback;
      return RET_TradeModuleError;
    end if;
    --写入交易商交易模块表
    --insert into m_firmmodule(moduleid, firmid, enabled)
        --select moduleid, p_FirmID, 'Y' from C_TradeModule where ISFirmSet='Y';
    --写入交易员交易模块表
    insert into m_tradermodule
            (moduleid, traderid, enabled)
        select moduleid, FirmID, enabled from m_firmmodule where FirmID=p_FirmID;
    --写入交易员表
    insert into m_trader
           (traderid, firmid, name, userid, password, status, type, createtime, modifytime, keycode, enablekey)
    values
           (p_FirmID, p_FirmID, p_FirmID, p_UserID, FN_M_MD5(p_FirmID||p_Password), 'N', 'A', sysdate, sysdate, '', 'N');

    return 1;
end;
/

prompt
prompt Creating function FN_M_FIRMDEL
prompt ==============================
prompt
create or replace function FN_M_FirmDel
(
    p_FirmID   m_firm.firmid%type, --交易商代码
    errorInfo OUT VARCHAR2--当某个模块删除交易商发生错的时候存放错误信息
)
return integer is
  /**
  * 删除交易商
  * 返回值： 1 成功
  *          -900 交易商不存在
  *          -901 某个交易模块发生错误
  **/
  v_cnt                number(4); --数字变量
  Module_RET           number(4); --模块删除交易商返回值
  IS_Error             boolean;--调用其它模块时是否发生错误
  CodeInfo_RET         varchar2(1024);--错误信息
  E_CNName             varchar2(64);--各个系统中文名称
  v_errorcode                number(4); --数字变量
  RET_NOFoundFirmID      integer := -900;
  RET_TradeModuleError integer := -901;--与errorInfo配合使用
begin
  --检查交易商是否存在
  select count(*) into v_cnt from m_firm where firmid=p_FirmID;
  if (v_cnt = 0) then
    return RET_NOFoundFirmID;
  end if;

  IS_Error:=false;
  --循环调用每一个交易模块的删除交易商函数；从交易模块表中查询删除交易商函数长度大于5（FN_xx_）的字段
   for DelFirmFnStr in (select trim(DelFirmFn) as DelFirmFn,ModuleID from C_TradeModule where  lengthb(DelFirmFn)>5)
    loop
        --调用交易模块表中的删除交易商函数
        execute immediate 'BEGIN :Module_RET :='||DelFirmFnStr.DelFirmFn||'(:firmid); END;' using OUT Module_RET,IN p_FirmID;
        --如果返回值不是1则回滚返回交易模块发生错误
        if(Module_RET!=1)then
            IS_Error:=true;
            --获取错误信息
            select count(*) into v_errorcode from m_procedures_errorcode p where p.moduleid=DelFirmFnStr.Moduleid and p.errorcode=Module_RET;
            if(v_errorcode = 1)then
                select p.errorinfo into CodeInfo_RET from m_procedures_errorcode p where p.moduleid=DelFirmFnStr.Moduleid and p.errorcode=Module_RET;
                CodeInfo_RET:='错误信息:'||CodeInfo_RET;
            end if;
            select m.cnname into E_CNName from c_trademodule m where m.moduleid=DelFirmFnStr.Moduleid;
            errorInfo:=errorInfo||'\n'||E_CNName||'，返回码:'||Module_RET||CodeInfo_RET||';';
            CodeInfo_RET:='';
        end if;
    end loop;

    if(IS_Error) then
      rollback;
      return RET_TradeModuleError;
    end if;

    delete from m_tradermodule where traderid in (select traderid from m_trader where firmid=p_firmid);
   --mengyu 2013.08.29 注销交易商不删除表数据
   -- delete from m_trader where firmid=p_firmid;
    delete from m_firmmodule where firmid=p_firmid;
    update m_firm set status=PKG_C_Base.FIRM_STATUS_ERASE where firmid=p_firmid;

    return 1;
end;
/

prompt
prompt Creating function FN_M_FIRMTOSTATUS
prompt ===================================
prompt
create or replace function FN_M_FirmToStatus
(
    p_FirmID m_firm.firmid%type,
    p_ToStatus m_firm.status%type,   -- 目标状态
    errorInfo OUT VARCHAR2--当某个模块修改交易商状态发生错的时候存放错误信息
)
return integer is
/**
 * 客户状态改变：冻结，解冻
 * 返回值： 1 成功
 *          -900 交易商状态不正确
 *          -901 不存在的交易商
 *          -920 某一个模块在修改交易商状态时发生错误
 **/
    v_cnt                number(4); --数字变量
    v_status       m_firm.status%type;--当前状态
    Module_RET           number(4); --模块修改交易商状态返回值
    IS_Error             boolean;--调用其它模块时是否发生错误
    CodeInfo_RET         varchar2(1024);--错误信息
    E_CNName             varchar2(64);--各个系统中文名称
    v_errorcode          number(4); --数字变量
    RET_StatusError integer := -900;
    RET_NotFoundError integer := -901;
    RET_TradeModuleError integer := -902;
begin
     --修改的目标状态只能是正常或者禁用
     if(p_ToStatus != PKG_C_Base.FIRM_STATUS_NORMAL and p_ToStatus!=PKG_C_Base.FIRM_STATUS_DISABLE) then
        return RET_StatusError;
     end if;

      --检查建议商是否已经存在
      select count(*) into v_cnt from m_firm where firmid = p_FirmID;
      if (v_cnt = 0) then
         return RET_NotFoundError;
      end if;

     --当前状态
    select status into v_status from m_firm t where t.firmid = p_FirmID for update;

    if(p_ToStatus = PKG_C_Base.FIRM_STATUS_DISABLE) then --客户冻结
        if(v_status != PKG_C_Base.FIRM_STATUS_NORMAL) then
            return RET_StatusError;
        end if;

    end if;

    if(p_ToStatus = PKG_C_Base.FIRM_STATUS_NORMAL) then --客户解冻
        if(v_status != PKG_C_Base.FIRM_STATUS_DISABLE) then
            return RET_StatusError;
        end if;
    end if;
    IS_Error:=false;
    --循环调用每一个交易模块的修改交易商状态函数；从交易模块表中查询修改交易商状态长度大于5（FN_xx_）的字段
    for UpdateFirmStatusFnStr in (select trim(UpdateFirmStatusFn) as UpdateFirmStatusFn,ModuleID from C_TradeModule where  lengthb(UpdateFirmStatusFn)>5)
       loop
           --调用交易模块表中的添加交易商函数
           execute immediate 'BEGIN :Module_RET :='||UpdateFirmStatusFnStr.UpdateFirmStatusFn||'(:firmid); END;' using OUT Module_RET,IN p_FirmID;
           --如果返回值不是1则回滚返回交易模块发生错误
           if(Module_RET!=1)then
              IS_Error:=true;
               --获取错误信息
              select count(*) into v_errorcode from m_procedures_errorcode p where p.moduleid=UpdateFirmStatusFnStr.Moduleid and p.errorcode=Module_RET;
              if(v_errorcode = 1)then
                  select p.errorinfo into CodeInfo_RET from m_procedures_errorcode p where p.moduleid=UpdateFirmStatusFnStr.Moduleid and p.errorcode=Module_RET;
                  CodeInfo_RET:='错误信息:'||CodeInfo_RET;
              end if;
              select m.cnname into E_CNName from c_trademodule m where m.moduleid=UpdateFirmStatusFnStr.Moduleid;
              errorInfo:=errorInfo||'\n'||E_CNName||'，返回码:'||Module_RET||CodeInfo_RET||';';
              CodeInfo_RET:='';

           end if;
     end loop;

     if(IS_Error)then
     rollback;
     return RET_TradeModuleError;
     end if;

     update m_firm set status = p_ToStatus where firmid = p_FirmID;

     return 1;
end;
/

prompt
prompt Creating procedure SP_M_MODULE
prompt ==============================
prompt
create or replace procedure SP_m_module
(
    p_FirmID   varchar2 --交易商代码
) as
begin
  insert into m_tradermodule
          (MODULEID, traderid, ENABLED)
        values
          (21, p_FirmID, 'Y');
end;
/


spool off

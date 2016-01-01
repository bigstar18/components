prompt PL/SQL Developer import file
prompt Created on 2015年11月11日 by hxx
set feedback off
set define off
prompt Dropping F_LEDGERFIELD...
drop table F_LEDGERFIELD cascade constraints;
prompt Creating F_LEDGERFIELD...
create table F_LEDGERFIELD
(
  code      VARCHAR2(16) not null,
  name      VARCHAR2(32) not null,
  fieldsign NUMBER(1) not null,
  moduleid  CHAR(2) not null,
  ordernum  NUMBER(5) not null,
  isinit    CHAR(1) default 'Y' not null
)
;
comment on column F_LEDGERFIELD.fieldsign
  is '1：增项 -1：减项';
comment on column F_LEDGERFIELD.moduleid
  is '10综合管理平台
11财务系统
13仓单管理系统
14融资系统
15订单交易
18投资类大宗商品交易系统
20做市商交易系统
21竞价系统
22银行接入及结算系统
23E现货';
comment on column F_LEDGERFIELD.ordernum
  is '前两位模块号后三位排序号
';
comment on column F_LEDGERFIELD.isinit
  is 'Y:是初始化数据,页面不允许删除和修改
N:不是初始化数据';
alter table F_LEDGERFIELD
  add constraint PK_F_LEDGERFIELD primary key (CODE);

prompt Disabling triggers for F_LEDGERFIELD...
alter table F_LEDGERFIELD disable all triggers;
prompt Loading F_LEDGERFIELD...
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Deposit', '入金', 1, '11', 1, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Fetch', '出金', -1, '11', 2, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('BankFee', '银转手续费', -1, '11', 3, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('OtherItem', '当日其他项', 1, '11', 4, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Margin_T', '订单保证金变动', 1, '15', 15000, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('FL_T', '订单浮亏变动', 1, '15', 15001, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('SettleMargin_T', '订单交收保证金变动', 1, '15', 15002, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('TradePL_T', '订单转让盈亏', 1, '15', 15003, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('SettlePL_T', '订单交收盈亏', 1, '15', 15004, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Income_T', '订单销售收入', 1, '15', 15005, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Payout_T', '订单购货支出', -1, '15', 15006, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('TradeFee_T', '订单交易手续费', -1, '15', 15007, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('SettleFee_T', '订单交收手续费', -1, '15', 15008, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('SettleCompens_T', '订单交割补偿费', 1, '15', 15009, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('OtherItem_T', '订单当日其他项', 1, '15', 15010, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('TradeFee_E', '现货收交易手续费', -1, '23', 23000, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Margin_E', '现货收交收保证金', -1, '23', 23001, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('MarginBack_E', '现货退交收保证金', 1, '23', 23002, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('SettleFee_E', '现货收交收费用', -1, '23', 23003, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Payout_E', '现货收交易商货款', -1, '23', 23004, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Income_E', '现货付交易商货款', 1, '23', 23005, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Subscirption_E', '诚信保障金', -1, '23', 23006, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('OtherItem_E', '现货当日其他项', 1, '23', 23007, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Income_V', '竞价销售收入', 1, '21', 21000, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Payout_V', '竞价购货支出', -1, '21', 21001, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('TradeFee_V', '竞价交易手续费', -1, '21', 21002, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Margin_V', '竞价保证金', -1, '21', 21003, 'Y');
commit;
prompt 27 records loaded
prompt Enabling triggers for F_LEDGERFIELD...
alter table F_LEDGERFIELD enable all triggers;
set feedback on
set define on
prompt Done.

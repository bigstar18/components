prompt PL/SQL Developer import file
prompt Created on 2015��11��11�� by hxx
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
  is '1������ -1������';
comment on column F_LEDGERFIELD.moduleid
  is '10�ۺϹ���ƽ̨
11����ϵͳ
13�ֵ�����ϵͳ
14����ϵͳ
15��������
18Ͷ���������Ʒ����ϵͳ
20�����̽���ϵͳ
21����ϵͳ
22���н��뼰����ϵͳ
23E�ֻ�';
comment on column F_LEDGERFIELD.ordernum
  is 'ǰ��λģ��ź���λ�����
';
comment on column F_LEDGERFIELD.isinit
  is 'Y:�ǳ�ʼ������,ҳ�治����ɾ�����޸�
N:���ǳ�ʼ������';
alter table F_LEDGERFIELD
  add constraint PK_F_LEDGERFIELD primary key (CODE);

prompt Disabling triggers for F_LEDGERFIELD...
alter table F_LEDGERFIELD disable all triggers;
prompt Loading F_LEDGERFIELD...
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Deposit', '���', 1, '11', 1, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Fetch', '����', -1, '11', 2, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('BankFee', '��ת������', -1, '11', 3, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('OtherItem', '����������', 1, '11', 4, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Margin_T', '������֤��䶯', 1, '15', 15000, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('FL_T', '���������䶯', 1, '15', 15001, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('SettleMargin_T', '�������ձ�֤��䶯', 1, '15', 15002, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('TradePL_T', '����ת��ӯ��', 1, '15', 15003, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('SettlePL_T', '��������ӯ��', 1, '15', 15004, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Income_T', '������������', 1, '15', 15005, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Payout_T', '��������֧��', -1, '15', 15006, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('TradeFee_T', '��������������', -1, '15', 15007, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('SettleFee_T', '��������������', -1, '15', 15008, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('SettleCompens_T', '�����������', 1, '15', 15009, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('OtherItem_T', '��������������', 1, '15', 15010, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('TradeFee_E', '�ֻ��ս���������', -1, '23', 23000, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Margin_E', '�ֻ��ս��ձ�֤��', -1, '23', 23001, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('MarginBack_E', '�ֻ��˽��ձ�֤��', 1, '23', 23002, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('SettleFee_E', '�ֻ��ս��շ���', -1, '23', 23003, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Payout_E', '�ֻ��ս����̻���', -1, '23', 23004, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Income_E', '�ֻ��������̻���', 1, '23', 23005, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Subscirption_E', '���ű��Ͻ�', -1, '23', 23006, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('OtherItem_E', '�ֻ�����������', 1, '23', 23007, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Income_V', '������������', 1, '21', 21000, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Payout_V', '���۹���֧��', -1, '21', 21001, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('TradeFee_V', '���۽���������', -1, '21', 21002, 'Y');
insert into F_LEDGERFIELD (code, name, fieldsign, moduleid, ordernum, isinit)
values ('Margin_V', '���۱�֤��', -1, '21', 21003, 'Y');
commit;
prompt 27 records loaded
prompt Enabling triggers for F_LEDGERFIELD...
alter table F_LEDGERFIELD enable all triggers;
set feedback on
set define on
prompt Done.

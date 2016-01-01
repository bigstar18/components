--------------------------------------------------
-- Export file for user TRADE_GNNT@SPOT.DEV.183 --
-- Created by hxx on 2015/11/10, 21:11:19 --------
--------------------------------------------------

set define off
spool br.all.struct.log

prompt
prompt Creating table BR_BROKER
prompt ========================
prompt
create table BR_BROKER
(
  brokerid      VARCHAR2(16) not null,
  password      VARCHAR2(64) not null,
  name          VARCHAR2(64) not null,
  telephone     VARCHAR2(20),
  mobile        VARCHAR2(20),
  email         VARCHAR2(20),
  address       VARCHAR2(64),
  note          CLOB,
  firmid        VARCHAR2(32),
  areaid        NUMBER(3),
  membertype    NUMBER(2) not null,
  timelimit     DATE,
  marketmanager VARCHAR2(20),
  modifytime    DATE
)
;
alter table BR_BROKER
  add constraint PK_BR_BROKER primary key (BROKERID);

prompt
prompt Creating table BR_BROKERAGE
prompt ===========================
prompt
create table BR_BROKERAGE
(
  brokerageid  VARCHAR2(32) not null,
  name         VARCHAR2(64) not null,
  idcard       VARCHAR2(32) not null,
  password     VARCHAR2(64) not null,
  telephone    VARCHAR2(20),
  mobile       VARCHAR2(20),
  email        VARCHAR2(20),
  address      VARCHAR2(64),
  postcode     VARCHAR2(16),
  note         CLOB,
  brokerid     VARCHAR2(16) not null,
  pbrokerageid VARCHAR2(32),
  creattime    DATE not null
)
;
alter table BR_BROKERAGE
  add constraint PK_BR_BROKERAGE primary key (BROKERAGEID);

prompt
prompt Creating table BR_BROKERAGEANDFIRM
prompt ==================================
prompt
create table BR_BROKERAGEANDFIRM
(
  brokerageid VARCHAR2(32) not null,
  firmid      VARCHAR2(32) not null,
  bindtype    NUMBER(2) not null,
  bindtime    DATE not null
)
;
alter table BR_BROKERAGEANDFIRM
  add constraint PK_BR_BROKERAGEANDFIRM primary key (BROKERAGEID, FIRMID);

prompt
prompt Creating table BR_BROKERAREA
prompt ============================
prompt
create table BR_BROKERAREA
(
  areaid NUMBER(3) not null,
  name   VARCHAR2(64) not null
)
;
alter table BR_BROKERAREA
  add constraint PK_BR_BROKERAREA primary key (AREAID);

prompt
prompt Creating table BR_BROKERMENU
prompt ============================
prompt
create table BR_BROKERMENU
(
  id             NUMBER(10) not null,
  parentid       NUMBER(10),
  name           VARCHAR2(128),
  icon           VARCHAR2(128),
  authorityurl   VARCHAR2(512),
  visiturl       VARCHAR2(512),
  moduleid       NUMBER(2) not null,
  seq            NUMBER(3),
  visible        NUMBER(1),
  type           NUMBER(1) not null,
  catalogid      NUMBER(4),
  iswritelog     VARCHAR2(1) default 'N',
  onlymember     NUMBER(2) default 0 not null,
  menubrokertype NUMBER(2) default 0 not null
)
;
alter table BR_BROKERMENU
  add constraint PK_BR_BROKERMENU primary key (ID);
alter table BR_BROKERMENU
  add constraint CHECK_BR_BROKERMENU_TYPE
  check (TYPE in (-3,-2,-1,0,1));
alter table BR_BROKERMENU
  add constraint CHECK_BR_BROKERMENU_VISIBLE
  check (VISIBLE in (-1,0));

prompt
prompt Creating table BR_BROKERREWARD
prompt ==============================
prompt
create table BR_BROKERREWARD
(
  brokerid   VARCHAR2(16) not null,
  occurdate  DATE not null,
  moduleid   NUMBER(2) not null,
  amount     NUMBER(15,2) not null,
  paidamount NUMBER(15,5) not null,
  paydate    DATE not null
)
;
alter table BR_BROKERREWARD
  add constraint PK_BR_BROKERREWARD primary key (BROKERID, OCCURDATE, MODULEID);

prompt
prompt Creating table BR_BROKERREWARDPROPS
prompt ===================================
prompt
create table BR_BROKERREWARDPROPS
(
  moduleid      NUMBER(2) not null,
  rewardtype    NUMBER(2) not null,
  brokerid      VARCHAR2(16) not null,
  commodityid   VARCHAR2(64) not null,
  rewardrate    NUMBER(6,4) not null,
  firstpayrate  NUMBER(6,4) default 0 not null,
  secondpayrate NUMBER(6,4) default 0 not null
)
;
alter table BR_BROKERREWARDPROPS
  add constraint PK_BR_BROKERREWARDPROPS primary key (MODULEID, REWARDTYPE, BROKERID, COMMODITYID);

prompt
prompt Creating table BR_BROKERRIGHT
prompt =============================
prompt
create table BR_BROKERRIGHT
(
  id       NUMBER(10) not null,
  brokerid VARCHAR2(16) not null
)
;
alter table BR_BROKERRIGHT
  add constraint PK_BR_BROKERRIGHT primary key (ID, BROKERID);

prompt
prompt Creating table BR_BROKERTYPE
prompt ============================
prompt
create table BR_BROKERTYPE
(
  borkertype NUMBER(2) not null,
  brokername VARCHAR2(64) not null
)
;
alter table BR_BROKERTYPE
  add constraint PK_BR_BROKERTYPE primary key (BORKERTYPE);

prompt
prompt Creating table BR_FIRMANDBROKER
prompt ===============================
prompt
create table BR_FIRMANDBROKER
(
  firmid   VARCHAR2(32) not null,
  brokerid VARCHAR2(16) not null,
  bindtime DATE not null
)
;
alter table BR_FIRMANDBROKER
  add constraint PK_BR_FIRMANDBROKER primary key (FIRMID);

prompt
prompt Creating table BR_FIRMAPPLY
prompt ===========================
prompt
create table BR_FIRMAPPLY
(
  applyid     NUMBER(10) not null,
  userid      VARCHAR2(32) not null,
  brokerageid VARCHAR2(32),
  brokerid    VARCHAR2(16) not null,
  applydate   DATE default sysdate
)
;
alter table BR_FIRMAPPLY
  add constraint PK_BR_FIRMAPPLY primary key (APPLYID);

prompt
prompt Creating table BR_REWARDPARAMETERPROPS
prompt ======================================
prompt
create table BR_REWARDPARAMETERPROPS
(
  autopay       CHAR(1),
  payperiod     NUMBER(1),
  payperioddate NUMBER(3)
)
;

prompt
prompt Creating table BR_TRADEMODULE
prompt =============================
prompt
create table BR_TRADEMODULE
(
  moduleid  NUMBER(2) not null,
  cnname    VARCHAR2(64) not null,
  enname    VARCHAR2(64),
  shortname VARCHAR2(16)
)
;
alter table BR_TRADEMODULE
  add constraint PK_BR_TRADEMODULE primary key (MODULEID);

prompt
prompt Creating sequence SEQ_BR_BROKERAREA
prompt ===================================
prompt
create sequence SEQ_BR_BROKERAREA
minvalue 1
maxvalue 9999999999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating function FN_BR_BROKEREVERYTRADEREWARD
prompt ==============================================
prompt
create or replace function FN_BR_BrokerEveryTradeReward(
    p_CommodityID    varchar2 ,--��ƷID
    p_Quantity       number ,--����
    p_FeeMoney       number ,--һ�ʳɽ��յ�������
    p_BarginMoney    number, --�ɽ�����
    p_AtClearDate       date,--����������������
    p_TradeAtClearDate  date,--�ɽ�������������
    p_BS_Flag        number,--������־
    p_OrderType      number,--ί������
    p_TradeType      number,--�ɽ�����
    p_type           number--����ֵ����  0 ����Ӷ��  1  �̶�������
)return number
  /**
  * ����ÿ�ʳɽ�Ӧ����Ա�ļ���Ӷ����Ա�ֳɵĹ̶�������
  * 2012-8-14 by jingwh
  **/
as
  v_brokerReward               number(15,2) default 0;
  v_feealgr                    number(1);
  v_feeRate_b                  number(15, 9);
  v_feeRate_s                  number(15, 9);
  v_todayclosefeerate_b        number(15, 9);
  v_todayclosefeerate_s        number(15, 9);
  v_historyclosefeerate_b      number(15, 9);
  v_historyclosefeerate_s      number(15, 9);
  v_forceclosefeerate_b        number(15, 9);
  v_forceclosefeerate_s        number(15, 9);
  v_rate                       number(15, 9);
  v_marketFee                  number(15,2);
  v_factmarketFee              number(15,2)  default 0;
begin
 --��ȡ��Ʒ��Ϣ���������㷨����
    select t.feealgr,t.FeeRate_b,t.feerate_s,t.todayclosefeerate_b,t.todayclosefeerate_s,t.historyclosefeerate_b,t.historyclosefeerate_s,t.forceclosefeerate_b,t.forceclosefeerate_s
     into    v_feealgr,v_feeRate_b,v_feeRate_s,v_todayclosefeerate_b,v_todayclosefeerate_s,v_historyclosefeerate_b,v_historyclosefeerate_s,v_forceclosefeerate_b,v_forceclosefeerate_s from t_commodity t where t.commodityid=p_CommodityID;
    --�Ƚ϶���ʱ��ͳɽ�ʱ��
    if(p_OrderType=1)then--����
          if(p_BS_Flag=1)then--����
                v_rate:=v_feeRate_b;
          elsif(p_BS_Flag=2)then--������
                v_rate:=v_feeRate_s;
          end if;
    elsif(p_OrderType=2)then--ƽ��
       -- �ж��Ƿ�ǿƽ  2013-12-18 by zhaodc
      if(p_TradeType=3)then
              if(p_BS_Flag=1)then--��ת��
                  v_rate:=v_forceclosefeerate_b;
              elsif(p_BS_Flag=2)then--��ת��
                  v_rate:=v_forceclosefeerate_s;
              end if;
      else
          if(trunc(p_TradeAtClearDate)=trunc(p_AtClearDate))then--�񿪽�ƽ
              if(p_BS_Flag=1)then--��ת��
                  v_rate:=v_todayclosefeerate_b;
              elsif(p_BS_Flag=2)then--��ת��
                  v_rate:=v_todayclosefeerate_s;
              end if;
          elsif(trunc(p_TradeAtClearDate)>trunc(p_AtClearDate))then  --ƽ��ʷ
              if(p_BS_Flag=1)then--��ת��
                  v_rate:=v_historyclosefeerate_b;
              elsif(p_BS_Flag=2)then--��ת��
                  v_rate:=v_historyclosefeerate_s;
              end if;
          end if;
      end if;
    end if;
    --�㷵�г�������
    if(v_feealgr=1)then
       v_marketFee:=v_rate*p_BarginMoney;
    elsif(v_feealgr=2)then
       v_marketFee:=v_rate*p_Quantity;
    end if;
    --�㷵��Ա�ļ���Ӷ�� ����г��������������ѣ��գ�>�г�Ӧ�������ѣ��̶���  ����Ӷ��=��-�̶� ��
    --����г��������������ѣ��գ�<=�г�Ӧ�������ѣ��̶���  ������ȫ�������г� ����Ӷ��=0
    --�����Ա�ֳ��õ��Ĺ̶�������  �����>�̶� ��Ա�ֳ�=�̶�*���� �����<�̶� ��Ա�ֳ�=��*������������10  �̶�100  ���� 30% �ù̶���ֳɵĻ��г��ͻ��Ǯ20  ��
    if(p_FeeMoney>v_marketFee)then
      v_brokerReward:=p_FeeMoney-v_marketFee;
      v_factmarketFee:=v_marketFee;
    elsif(p_FeeMoney<=v_marketFee)then
      v_brokerReward:=0;
      v_factmarketFee:=p_FeeMoney;
    end if;
    if(p_type=0)then
      return v_brokerReward;
    elsif(p_type=1)then
      return v_factmarketFee;
    end if;

end;
/

prompt
prompt Creating function FN_BR_BROKERPAYDATE
prompt =====================================
prompt
create or replace function FN_BR_BrokerPayDate(p_date date) return date is
/**
 * ���㸶��ԱӶ��β������
 **/
  v_paydate    date;             --����ԱӶ��β������
  v_dateString varchar2(32);
  v_payPeriod     number(1);     --��������
  v_payPeriodDate number(3);     --����������
begin

  select PayPeriod,PayPeriodDate into v_payPeriod,v_payPeriodDate from BR_RewardParameterProps ;
  if(v_payPeriod=1)then  --���¼���
     v_dateString := to_char(ADD_MONTHS(trunc(p_date), 1), 'yyyy-MM');
  --dbms_output.put_line('--v_dateString:'||v_dateString);
     v_dateString := v_dateString || '-'||v_payPeriodDate;
     v_paydate    := to_date(v_dateString, 'yyyy-MM-dd');
  elsif(v_payPeriod=2)then --���ܼ���
    -- if(v_payPeriodDate>6 and v_payPeriodDate<1)then

    -- end if;
     select next_day(p_date,v_payPeriodDate) into v_paydate from dual;
     v_paydate    := trunc(v_paydate);
  end if;
  return v_paydate;
end;
/

prompt
prompt Creating function FN_BR_BROKERREWARD
prompt ====================================
prompt
create or replace function FN_BR_BrokerReward
  return number is
  /**
   * ����ԱӶ��
  **/
  v_ret           number(15, 2);
  v_payDate       date;
  v_autopay       char(1);
  v_oprcode       varchar2(10):='15019';
  v_firstPayMoney number(15, 2);
  v_brokerFirmID  varchar2(32);
  v_rtn           varchar2(10);
  v_moduleId      number(2):=15;
  v_tradeDate     date;

begin
      --��ѯ��������
      select tradedate into v_tradeDate from t_systemstatus;
      --���㸶����
      v_payDate := FN_BR_BrokerPayDate(v_tradeDate);
      --��ѯ�Ƿ��Զ���Ӷ�� Y �� N ��
      select autopay into v_autopay from BR_RewardParameterProps;
      --ɾ�����׵���Ӷ����ϸ����֧����������
      delete from T_BR_FirmRewardDeail m where m.cleardate = trunc(v_tradeDate);
      --�鵱����ʷ�ɽ���¼����Ӷ����ϸ����
      execute immediate 'BEGIN :1:=FN_BR_FirmRewardDeail(:2); END;' using out v_rtn,v_tradeDate;
      --������ֶ���Ӷ�𣬽�����Ӷ����ϸ�׿���Ϊ0��β��Ϊ��Ӷ��
      if(v_autopay = 'N') then
            update T_BR_Firmrewarddeail m set m.firstpay = 0,m.secondpay = m.reward  where m.cleardate = trunc(v_tradeDate);
      end if;

     /**
     Forѭ���ǰ�BR_Brokerreward�Ļ�ԱID���Ѹ�Ӷ���ѯ������
     **/
     for brokerReward in (select t.brokerid,t.paidamount from BR_brokerReward t where t.Occurdate = trunc(v_tradeDate) and t.moduleid=v_moduleId) loop
        --��ѯ����Ա������ID
        select firmid into v_brokerFirmID from BR_broker where brokerid = brokerReward.brokerid;

        v_firstPayMoney := -brokerReward.paidamount;

        --д��ˮ��������Ա��Ӷ����������
        v_ret:= fn_f_updatefunds(v_brokerFirmID,v_oprcode,v_firstPayMoney,null);
     end loop;

     --ɾ�����մ���Ӷ���¼֧����������
     delete from BR_Brokerreward t where t.Occurdate = trunc(v_tradeDate) and moduleid = v_moduleId;

     --���ݻ�ԱID���ܵ���Ӷ����ϸӶ���׿��β��
     for broker in (select t.brokerid,sum(t.firstpay) firstpay,sum(t.secondpay) secondpay from T_BR_firmrewarddeail t
                  where t.cleardate = trunc(v_tradeDate) group by t.brokerid) loop
        --�������Ӷ��
        insert into BR_BrokerReward (BrokerID, moduleid, Occurdate, Amount, Paydate, Paidamount)
               values (broker.brokerid,v_moduleId,trunc(v_tradeDate),broker.secondpay,trunc(v_paydate),broker.firstpay);
        --��ѯ����Ա������ID
        select firmid into v_brokerFirmID from BR_broker where brokerid = broker.brokerid;
        --д��ˮ����ԱӶ���׿�
        v_ret := fn_f_updatefunds(v_brokerFirmID,v_oprcode,broker.firstpay,null);
    end loop;
    --������Զ���Ӷ�𣬱㽫������<=�����Ҵ���>0��Ӷ�𸶸���Ա�����»�Ա����Ӷ���
    if (v_autopay = 'Y') then
        for brokerReward in (select t.brokerid, t.amount, t.occurdate from BR_Brokerreward t where t.paydate <= trunc(v_tradeDate) and t.amount > 0 and t.moduleid=v_moduleId ) loop
            select firmid into v_brokerFirmID from BR_broker where brokerid = brokerReward.brokerid;
            v_ret := fn_f_updatefunds(v_brokerFirmID,v_oprcode,brokerReward.Amount,null);
            update BR_Brokerreward m set m.amount= 0,m.paidamount = m.paidamount + brokerReward.Amount
                where m.brokerid = brokerReward.Brokerid and m.occurdate = brokerReward.Occurdate and m.moduleid=v_moduleId;
        end loop;
   end if;

return 1;
end;
/

prompt
prompt Creating function FN_BR_FIRMADD
prompt ===============================
prompt
create or replace function FN_BR_FIRMADD(p_firmId m_firm.firmid%type)
  return number is
  /**
  * ��˽�����ʱ���ô˴洢�������̺ͻ�Ա���Ӽ��̰󶨹�ϵ
  * ����ֵ�� 1 �ɹ�
  **/

  v_brokerAgeId      varchar2(64);
  v_brokerId         varchar2(32);
  v_count            number(3);
  v_applyId          number(10);

begin

     select applyId into v_applyId from m_firm where firmId=p_firmId;
     --�ý�����������ID���ڻ�Ա�Ľ�����ע������м�¼���������򷵻سɹ�
     if(v_applyId is not null)then
        select count(*) into v_count from br_firmapply a where a.applyid=v_applyId;
        if(v_count>0)then
             --��ѯ������������м�¼�������Ӽ��̺ͻ�Ա
             select fa.brokerageid,fa.brokerid into v_brokerAgeId,v_brokerId from br_firmapply fa where fa.applyid=v_applyId;
             --�����̺ͻ�Ա������ϵ
             insert into br_firmandbroker (firmId,brokerid,bindtime) values (p_firmId,v_brokerId,sysdate);
             --�����̺;Ӽ��̽�����ϵ
             if(v_brokerAgeId is not null)then
                insert into br_brokerageandfirm (brokerageid,firmid,bindtype,bindtime) values (v_brokerAgeId,p_firmId,0,sysdate);
             end if;
             return 1;
         end if;
     end if;
return 1;
end;
/

prompt
prompt Creating function FN_BR_FIRMREWARDDEAIL
prompt =======================================
prompt
create or replace function FN_BR_FirmRewardDeail(p_tradeDate Date)
  return number is
  /**
  * ����ʷ�ɽ�������Ӷ����ϸ
  **/
  v_firstpayrate  number(6, 4);--����׸�����
  v_secondpayrate number(6, 4);--���β�����
  v_rewardrate    number(6, 4);--������Ӷ�����
  v_firstPay      number(15, 2);--����׸����
  v_secondPay     number(15, 2);--���β����
  v_reward        number(15, 2);--��Աʵ�������ѣ���Ա���ղ���������+�����������л�Ա���÷ֳ�
  v_feestandard   number(15, 2);--��Ʒ�̶�������
  v_rewardRemainder number(15, 2);--��Ա���ղ���������
  v_brokerEachDivide number(15, 2);--�����������л�Ա���÷ֳ�
  v_marketReward  number(15, 2);--�г�����
  v_brokerAgeId   varchar2(32);--������ֱ���Ӽ��̴���
  v_brokerAgeName varchar2(64);--������ֱ���Ӽ�������
  v_cnt            number(2);
begin

 --����Զ�ڻ�ð������̰���Ʒ��������Ϣ
  --��Ҫ���������̴��롢��Ȩ�̴��롢��Ʒ���롢����Ʒ��Ӧ�����н��������ѡ����������������׽��
  for firmRewardDeail in (select a.firmId,
                                 brokerid,
                                 brokername,
                                 commodityId,
                                 feeMoney,
                                 quantity,
                                 barginMoney,
                                 feestandard,
                                 brokerReward
                            from (select t.firmid,
                                         sum(t.tradefee) feeMoney,
                                         sum(t.quantity) quantity,
                                         sum(t.price*t.quantity*c.contractfactor) barginMoney,
                                         sum(FN_BR_BrokerEveryTradeReward(t.commodityid,t.quantity,t.tradefee,t.price*t.quantity*c.contractfactor,t.atcleardate, t.tradeatcleardate,t.bs_flag,t.ordertype, t.tradetype, 0)) brokerReward,
                                         sum(FN_BR_BrokerEveryTradeReward(t.commodityid,t.quantity,t.tradefee,t.price*t.quantity*c.contractfactor,t.atcleardate, t.tradeatcleardate,t.bs_flag,t.ordertype, t.tradetype, 1)) feestandard,
                                         c.commodityId
                                    from t_h_trade t,t_h_commodity c,BR_FirmAndBroker m
                                    where t.commodityid=c.commodityid and t.cleardate=c.cleardate
                                    and  t.cleardate = trunc(p_tradeDate) and t.tradefee<>0 and  m.firmid=t.firmid
                                   group by t.firmid, c.commodityId,t.cleardate,m.brokerid) a,
                                 (select m.firmid, m.brokerid,mb.name brokername
                                    from BR_firmandbroker m, BR_Broker mb
                                   where m.brokerid = mb.brokerid
                                     and mb.firmid is not null) b
                           where a.firmId = b.firmId order by b.brokerid, a.firmId) loop


    --�ӻ�ԱӶ�����ñ���������Ӷ�����������׸����������β�����
      select rewardrate, firstpayrate, secondpayrate
      into v_rewardrate, v_firstpayrate, v_secondpayrate
      from (select t.rewardrate,
                   t.firstpayrate,
                   t.secondpayrate
              from BR_brokerrewardprops t
             where (t.commodityId = firmRewardDeail.commodityId or t.commodityId = '-1')
               and (t.brokerid = firmRewardDeail.brokerid or t.brokerid = '-1')
               and(t.moduleid = '15' or t.moduleid = '-1')
               and(t.rewardType=0 or t.rewardType=-1 )
             order by t.brokerid desc, t.commodityId desc, t.moduleid ,t.rewardType desc)
     where rownum = 1;

    --�г��̶�������
    v_feestandard:=firmRewardDeail.feestandard;
    --��Ա���ղ���������
    v_rewardRemainder:=firmRewardDeail.brokerReward;
    --�����������л�Ա���÷ֳ�
    v_brokerEachDivide:=v_feestandard*v_rewardrate;
    --�г�����
    v_marketReward:= v_feestandard-v_brokerEachDivide;
    --��Աʵ��������
    v_reward:=v_rewardRemainder+v_feestandard*v_rewardrate;

    --����׸����
    v_firstPay:=v_reward*v_firstpayrate;
    --���β�����
    v_secondPay := v_reward-v_firstPay;

    --��ѯ������ֱ���Ӽ��̴��������
     select count(*) into v_cnt from  br_brokerageandfirm f,br_brokerage b where f.brokerageid=b.brokerageid and f.firmid=firmRewardDeail.firmId and f.bindtype=0;
     if(v_cnt>0)then
            select f.brokerageid,b.name into v_brokerAgeId,v_brokerAgeName from br_brokerageandfirm f,br_brokerage b where f.brokerageid=b.brokerageid and f.firmid=firmRewardDeail.firmId and f.bindtype=0;
     end if;
    --��������
    insert into T_BR_FirmRewardDeail m
      (firmId,
       commodityId,
       cleardate,
       rewardtype,
       brokerId,
       brokerName,
       firstPay,
       secondPay,
       reward,
       marketReward,
       brokerEachDivide,
       quantity,
       tradeMoney,
       brokerAgeID,
       brokerAgeName)
    values
      (firmRewardDeail.firmId,
       firmRewardDeail.commodityId,
       trunc(p_tradeDate),
       0,
       firmRewardDeail.brokerId,
        firmRewardDeail.brokername,
       v_firstPay,
       v_secondPay,
       v_reward,
       v_marketReward,
       v_brokerEachDivide,
       firmRewardDeail.quantity,
       firmRewardDeail.barginMoney,
       v_brokerAgeId,
       v_brokerAgeName);
  end loop;
  return 1;
end;
/


spool off

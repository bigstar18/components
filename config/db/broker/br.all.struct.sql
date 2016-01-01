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
    p_CommodityID    varchar2 ,--商品ID
    p_Quantity       number ,--数量
    p_FeeMoney       number ,--一笔成交收的手续费
    p_BarginMoney    number, --成交货款
    p_AtClearDate       date,--订货所属结算日期
    p_TradeAtClearDate  date,--成交所属结算日期
    p_BS_Flag        number,--买卖标志
    p_OrderType      number,--委托类型
    p_TradeType      number,--成交类型
    p_type           number--返回值类型  0 加收佣金  1  固定手续费
)return number
  /**
  * 计算每笔成交应返会员的加收佣金或会员分成的固定手续费
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
 --获取商品信息：手续费算法，。
    select t.feealgr,t.FeeRate_b,t.feerate_s,t.todayclosefeerate_b,t.todayclosefeerate_s,t.historyclosefeerate_b,t.historyclosefeerate_s,t.forceclosefeerate_b,t.forceclosefeerate_s
     into    v_feealgr,v_feeRate_b,v_feeRate_s,v_todayclosefeerate_b,v_todayclosefeerate_s,v_historyclosefeerate_b,v_historyclosefeerate_s,v_forceclosefeerate_b,v_forceclosefeerate_s from t_commodity t where t.commodityid=p_CommodityID;
    --比较订货时间和成交时间
    if(p_OrderType=1)then--开仓
          if(p_BS_Flag=1)then--买订立
                v_rate:=v_feeRate_b;
          elsif(p_BS_Flag=2)then--卖订立
                v_rate:=v_feeRate_s;
          end if;
    elsif(p_OrderType=2)then--平仓
       -- 判断是否强平  2013-12-18 by zhaodc
      if(p_TradeType=3)then
              if(p_BS_Flag=1)then--买转让
                  v_rate:=v_forceclosefeerate_b;
              elsif(p_BS_Flag=2)then--卖转让
                  v_rate:=v_forceclosefeerate_s;
              end if;
      else
          if(trunc(p_TradeAtClearDate)=trunc(p_AtClearDate))then--今开今平
              if(p_BS_Flag=1)then--买转让
                  v_rate:=v_todayclosefeerate_b;
              elsif(p_BS_Flag=2)then--卖转让
                  v_rate:=v_todayclosefeerate_s;
              end if;
          elsif(trunc(p_TradeAtClearDate)>trunc(p_AtClearDate))then  --平历史
              if(p_BS_Flag=1)then--买转让
                  v_rate:=v_historyclosefeerate_b;
              elsif(p_BS_Flag=2)then--卖转让
                  v_rate:=v_historyclosefeerate_s;
              end if;
          end if;
      end if;
    end if;
    --算返市场手续费
    if(v_feealgr=1)then
       v_marketFee:=v_rate*p_BarginMoney;
    elsif(v_feealgr=2)then
       v_marketFee:=v_rate*p_Quantity;
    end if;
    --算返会员的加收佣金 如果市场收上来的手续费（收）>市场应得手续费（固定）  加收佣金=收-固定 ；
    --如果市场收上来的手续费（收）<=市场应得手续费（固定）  手续费全部返给市场 加收佣金=0
    --计算会员分成用到的固定手续费  如果收>固定 会员分成=固定*比例 如果收<固定 会员分成=收*比例（例如收10  固定100  比例 30% 用固定算分成的话市场就会垫钱20  ）
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
 * 计算付会员佣金尾款日期
 **/
  v_paydate    date;             --付会员佣金尾款日期
  v_dateString varchar2(32);
  v_payPeriod     number(1);     --付款周期
  v_payPeriodDate number(3);     --付款周期日
begin

  select PayPeriod,PayPeriodDate into v_payPeriod,v_payPeriodDate from BR_RewardParameterProps ;
  if(v_payPeriod=1)then  --按月计算
     v_dateString := to_char(ADD_MONTHS(trunc(p_date), 1), 'yyyy-MM');
  --dbms_output.put_line('--v_dateString:'||v_dateString);
     v_dateString := v_dateString || '-'||v_payPeriodDate;
     v_paydate    := to_date(v_dateString, 'yyyy-MM-dd');
  elsif(v_payPeriod=2)then --按周计算
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
   * 付会员佣金
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
      --查询结算日期
      select tradedate into v_tradeDate from t_systemstatus;
      --计算付款日
      v_payDate := FN_BR_BrokerPayDate(v_tradeDate);
      --查询是否自动付佣金 Y 是 N 否
      select autopay into v_autopay from BR_RewardParameterProps;
      --删除交易当日佣金明细数据支持重做结算
      delete from T_BR_FirmRewardDeail m where m.cleardate = trunc(v_tradeDate);
      --查当日历史成交记录生成佣金明细数据
      execute immediate 'BEGIN :1:=FN_BR_FirmRewardDeail(:2); END;' using out v_rtn,v_tradeDate;
      --如果是手动付佣金，将当日佣金明细首款置为0，尾款为总佣金
      if(v_autopay = 'N') then
            update T_BR_Firmrewarddeail m set m.firstpay = 0,m.secondpay = m.reward  where m.cleardate = trunc(v_tradeDate);
      end if;

     /**
     For循环是把BR_Brokerreward的会员ID和已付佣金查询出来。
     **/
     for brokerReward in (select t.brokerid,t.paidamount from BR_brokerReward t where t.Occurdate = trunc(v_tradeDate) and t.moduleid=v_moduleId) loop
        --查询出会员交易商ID
        select firmid into v_brokerFirmID from BR_broker where brokerid = brokerReward.brokerid;

        v_firstPayMoney := -brokerReward.paidamount;

        --写流水将付给会员的佣金再收上来
        v_ret:= fn_f_updatefunds(v_brokerFirmID,v_oprcode,v_firstPayMoney,null);
     end loop;

     --删除当日待付佣金记录支持重做结算
     delete from BR_Brokerreward t where t.Occurdate = trunc(v_tradeDate) and moduleid = v_moduleId;

     --根据会员ID汇总当日佣金明细佣金首款和尾款
     for broker in (select t.brokerid,sum(t.firstpay) firstpay,sum(t.secondpay) secondpay from T_BR_firmrewarddeail t
                  where t.cleardate = trunc(v_tradeDate) group by t.brokerid) loop
        --插入待付佣金
        insert into BR_BrokerReward (BrokerID, moduleid, Occurdate, Amount, Paydate, Paidamount)
               values (broker.brokerid,v_moduleId,trunc(v_tradeDate),broker.secondpay,trunc(v_paydate),broker.firstpay);
        --查询出会员交易商ID
        select firmid into v_brokerFirmID from BR_broker where brokerid = broker.brokerid;
        --写流水付会员佣金首款
        v_ret := fn_f_updatefunds(v_brokerFirmID,v_oprcode,broker.firstpay,null);
    end loop;
    --如果是自动付佣金，便将付款日<=当日且待付>0的佣金付给会员；更新会员待付佣金表
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
  * 审核交易商时调用此存储；交易商和会员，居间商绑定关系
  * 返回值： 1 成功
  **/

  v_brokerAgeId      varchar2(64);
  v_brokerId         varchar2(32);
  v_count            number(3);
  v_applyId          number(10);

begin

     select applyId into v_applyId from m_firm where firmId=p_firmId;
     --该交易商有申请ID且在会员的交易商注册表中有记录继续，否则返回成功
     if(v_applyId is not null)then
        select count(*) into v_count from br_firmapply a where a.applyid=v_applyId;
        if(v_count>0)then
             --查询交易商申请表中记录的所属居间商和会员
             select fa.brokerageid,fa.brokerid into v_brokerAgeId,v_brokerId from br_firmapply fa where fa.applyid=v_applyId;
             --交易商和会员建立关系
             insert into br_firmandbroker (firmId,brokerid,bindtime) values (p_firmId,v_brokerId,sysdate);
             --交易商和居间商建立关系
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
  * 从历史成交中生成佣金明细
  **/
  v_firstpayrate  number(6, 4);--提成首付比例
  v_secondpayrate number(6, 4);--提成尾款比例
  v_rewardrate    number(6, 4);--手续费佣金比例
  v_firstPay      number(15, 2);--提成首付金额
  v_secondPay     number(15, 2);--提成尾款金额
  v_reward        number(15, 2);--会员实得手续费：会员加收部分手续费+交易手续费中会员所得分成
  v_feestandard   number(15, 2);--商品固定手续费
  v_rewardRemainder number(15, 2);--会员加收部分手续费
  v_brokerEachDivide number(15, 2);--交易手续费中会员所得分成
  v_marketReward  number(15, 2);--市场所得
  v_brokerAgeId   varchar2(32);--交易商直属居间商代码
  v_brokerAgeName varchar2(64);--交易商直属居间商名称
  v_cnt            number(2);
begin

 --从中远期获得按交易商按商品分组后的信息
  --主要包括交易商代码、授权商代码、商品代码、该商品对应的所有交易手续费、交易总数量、交易金额
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


    --从会员佣金设置表获得手续费佣金比例、提成首付比例、提成尾款比例
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

    --市场固定手续费
    v_feestandard:=firmRewardDeail.feestandard;
    --会员加收部分手续费
    v_rewardRemainder:=firmRewardDeail.brokerReward;
    --交易手续费中会员所得分成
    v_brokerEachDivide:=v_feestandard*v_rewardrate;
    --市场所得
    v_marketReward:= v_feestandard-v_brokerEachDivide;
    --会员实得手续费
    v_reward:=v_rewardRemainder+v_feestandard*v_rewardrate;

    --提成首付金额
    v_firstPay:=v_reward*v_firstpayrate;
    --提成尾款比例
    v_secondPay := v_reward-v_firstPay;

    --查询交易商直属居间商代码和名称
     select count(*) into v_cnt from  br_brokerageandfirm f,br_brokerage b where f.brokerageid=b.brokerageid and f.firmid=firmRewardDeail.firmId and f.bindtype=0;
     if(v_cnt>0)then
            select f.brokerageid,b.name into v_brokerAgeId,v_brokerAgeName from br_brokerageandfirm f,br_brokerage b where f.brokerageid=b.brokerageid and f.firmid=firmRewardDeail.firmId and f.bindtype=0;
     end if;
    --保存数据
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

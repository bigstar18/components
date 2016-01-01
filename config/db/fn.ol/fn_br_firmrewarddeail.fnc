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


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


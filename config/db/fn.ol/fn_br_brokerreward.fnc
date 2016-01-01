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


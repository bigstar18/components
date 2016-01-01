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


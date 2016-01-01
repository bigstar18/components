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


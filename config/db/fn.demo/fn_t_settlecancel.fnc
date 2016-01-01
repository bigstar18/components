create or replace function Fn_T_SettleCancel
(
    p_matchId varchar2, --��Ա��
    p_operator varchar2 --������
) return number
/****
 * ������Ե��ô˴洢
 * ����ֵ
 *  1 �ɹ�  ����ʧ��
 *  2 �������
 *  3 ����
 *  4 �ѻ�Ȩת��
****/
as
 v_status number;  --���״̬  0 δ���� 1 ������ 2 ������� 3 ����
 v_isTransfer number;--�Ƿ��Ȩת�� 0��δ��Ȩת�� 1���ѻ�Ȩת��
 v_Balance number(15,2):=0;
begin
     select status,isTransfer into v_status,v_isTransfer from t_settlematch where matchId=p_matchId for update;
     if(v_status=2 or v_status=3)then
        return v_status;
     elsif(v_status=1 and v_isTransfer=1)then
        return 4;
     else
         --��ѯ��Թ�������ԭ���ճֲ���ϸ����
         for rel in (select * from T_MatchSettleholdRelevance t where t.matchid=p_matchId)
         loop
           update t_settleholdposition set happenmatchqty=happenmatchqty-rel.quantity,happenMatchSettleMargin=happenMatchSettleMargin-rel.settlemargin,
           happenMatchPayout=happenMatchPayout-rel.settlePayOut,matchstatus=decode(happenmatchqty-rel.quantity,0,0,1) where id=rel.settleId;
         end loop;
          --��ѯ������Խ������ԭ��Դ���Ľ��
         for man in (select * from T_SettleMatchFundManage t where t.matchid=p_matchId)
         loop
           v_Balance := FN_F_UpdateFundsFull(man.firmId,man.summaryNo,-man.amount,p_matchId,man.commodityId,null,null);
           if(man.summaryNo='15013')then
              update T_Firm set RuntimeSettleMargin=RuntimeSettleMargin-man.amount where firmid = man.firmid;
           elsif(man.summaryNo='15014')then
              update T_Firm set RuntimeSettleMargin=RuntimeSettleMargin+man.amount where firmid = man.firmid;
           end if;
           insert into T_SettleMatchFundManage(id,MatchID,Firmid,Summaryno,Amount,Operatedate,Commodityid)
           values (SEQ_T_SettleMatchFundManage.Nextval,man.matchId,man.firmId,man.summaryNo,-man.amount,sysdate,man.commodityId);
         end loop;
         --����ʱ����Ӧ�ĳֲֵ����ϵ�˰�ѽ��д��� by ������ 2015/08/14
         for woman in (select * from t_Settleandhold t where t.matchid=p_matchId)
           loop
             if(woman.bs_flag='1')then
             update t_Settleholdposition  set SETTLEADDEDTAX=SETTLEADDEDTAX-woman.tax where ID = woman.settleholdpositionid;
             end if;
          end loop;

         --�޸����״̬Ϊ����
            update t_settlematch set status=3,modifier=p_operator,modifyTime=sysdate where matchId=p_matchId;
         --���뽻�������־
            insert into t_settlematchlog (id,matchid,operator,operatelog,updatetime)
            values (SEQ_t_settlematchlog.Nextval,p_matchId,p_operator,'���������ID:'||p_matchId,sysdate);
          --ɾ����Թ�����
          delete from T_MatchSettleholdRelevance where matchid=p_matchId;
          --ɾ���ֵ������
          --2014-01-21����ʱ��ɾ���ֵ���������㳷���󿴲ֵ���Ϣ
          --delete from T_billFrozen where Operation=p_matchId;
         return 1;
     end if;
end;
/


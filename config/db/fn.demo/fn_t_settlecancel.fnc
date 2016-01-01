create or replace function Fn_T_SettleCancel
(
    p_matchId varchar2, --配对编号
    p_operator varchar2 --操作人
) return number
/****
 * 撤销配对调用此存储
 * 返回值
 *  1 成功  其他失败
 *  2 处理完成
 *  3 撤销
 *  4 已货权转移
****/
as
 v_status number;  --配对状态  0 未处理 1 处理中 2 处理完成 3 撤销
 v_isTransfer number;--是否货权转移 0：未货权转移 1：已货权转移
 v_Balance number(15,2):=0;
begin
     select status,isTransfer into v_status,v_isTransfer from t_settlematch where matchId=p_matchId for update;
     if(v_status=2 or v_status=3)then
        return v_status;
     elsif(v_status=1 and v_isTransfer=1)then
        return 4;
     else
         --轮询配对关联表，还原交收持仓明细数据
         for rel in (select * from T_MatchSettleholdRelevance t where t.matchid=p_matchId)
         loop
           update t_settleholdposition set happenmatchqty=happenmatchqty-rel.quantity,happenMatchSettleMargin=happenMatchSettleMargin-rel.settlemargin,
           happenMatchPayout=happenMatchPayout-rel.settlePayOut,matchstatus=decode(happenmatchqty-rel.quantity,0,0,1) where id=rel.settleId;
         end loop;
          --轮询交收配对金额处理表，还原配对处理的金额
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
         --撤销时将对应的持仓单号上的税费进行处理 by 张天骥 2015/08/14
         for woman in (select * from t_Settleandhold t where t.matchid=p_matchId)
           loop
             if(woman.bs_flag='1')then
             update t_Settleholdposition  set SETTLEADDEDTAX=SETTLEADDEDTAX-woman.tax where ID = woman.settleholdpositionid;
             end if;
          end loop;

         --修改配对状态为撤销
            update t_settlematch set status=3,modifier=p_operator,modifyTime=sysdate where matchId=p_matchId;
         --插入交收配对日志
            insert into t_settlematchlog (id,matchid,operator,operatelog,updatetime)
            values (SEQ_t_settlematchlog.Nextval,p_matchId,p_operator,'撤销，配对ID:'||p_matchId,sysdate);
          --删除配对关联表
          delete from T_MatchSettleholdRelevance where matchid=p_matchId;
          --删除仓单冻结表
          --2014-01-21撤销时不删除仓单冻结表，方便撤销后看仓单信息
          --delete from T_billFrozen where Operation=p_matchId;
         return 1;
     end if;
end;
/


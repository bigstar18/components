create or replace procedure SP_T_ClearAction_Done
(
    p_ActionID   T_ClearStatus.ActionID%type
)
is
    PRAGMA AUTONOMOUS_TRANSACTION;
begin
    update T_ClearStatus
       set status = 'Y',
           FinishTime = sysdate
     where ActionID = p_ActionID;
    commit;
end;
/


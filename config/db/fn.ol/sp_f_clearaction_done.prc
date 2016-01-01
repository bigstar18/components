create or replace procedure SP_F_ClearAction_Done
(
    p_ActionID   F_ClearStatus.ActionID%type
)
is
    PRAGMA AUTONOMOUS_TRANSACTION;
begin
    update F_ClearStatus
       set status = 'Y',
           FinishTime = sysdate
     where ActionID = p_ActionID;
    commit;
end;
/


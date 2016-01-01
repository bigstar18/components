---------------------------------------------------------
-- Export file for user TRADE_GNNT@SPOT.OL.172.18.14.9 --
-- Created by hxx on 2015/11/11, 0:02:47 ----------------
---------------------------------------------------------

set define off
spool ol.modify.struct.log

prompt
prompt Creating procedure SP_F_COMPUTEFIRMRIGHTS
prompt =========================================
prompt
@@sp_f_computefirmrights.prc
prompt
prompt Creating function FN_F_BALANCE
prompt ==============================
prompt
@@fn_f_balance.fnc
prompt
prompt Creating function FN_F_BALANCE_OLD
prompt ==================================
prompt
@@fn_f_balance_old.fnc
prompt
prompt Creating procedure SP_F_COMPUTEFIRMRIGHTS_OLD
prompt =============================================
prompt
@@sp_f_computefirmrights_old.prc

spool off

--------------------------------------------------
-- Export file for user TRADE_GNNT@SPOT.DEV.183 --
-- Created by hxx on 2015/11/9, 18:01:19 ---------
--------------------------------------------------

set define off
spool ipo.ref.fn.log

prompt
prompt Creating function FN_F_GETREALFUNDS
prompt ===================================
prompt
@@fn_f_getrealfunds.fnc
prompt
prompt Creating function FN_F_UPDATEFROZENFUNDS
prompt ========================================
prompt
@@fn_f_updatefrozenfunds.fnc

spool off

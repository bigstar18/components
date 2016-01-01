---------------------------------------------------------
-- Export file for user TRADE_GNNT@SPOT.OL.172.18.14.9 --
-- Created by hxx on 2015/12/26, 23:29:06 ---------------
---------------------------------------------------------

set define off
spool fn.log

prompt
prompt Creating procedure SP_COMMON_MOVEHISTORY
prompt ========================================
prompt
@@sp_common_movehistory.prc
prompt
prompt Creating procedure SP_F_BALANCEACCOUNT
prompt ======================================
prompt
@@sp_f_balanceaccount.prc
prompt
prompt Creating procedure SP_F_CLEARACTION_DONE
prompt ========================================
prompt
@@sp_f_clearaction_done.prc
prompt
prompt Creating procedure SP_F_CLIENTLEDGER
prompt ====================================
prompt
@@sp_f_clientledger.prc
prompt
prompt Creating procedure SP_F_COMPUTEFIRMRIGHTS
prompt =========================================
prompt
@@sp_f_computefirmrights.prc
prompt
prompt Creating procedure SP_F_COMPUTEFIRMRIGHTS_OLD
prompt =============================================
prompt
@@sp_f_computefirmrights_old.prc
prompt
prompt Creating procedure SP_F_EXTRACTVOUCHERREDO
prompt ==========================================
prompt
@@sp_f_extractvoucherredo.prc
prompt
prompt Creating procedure SP_F_PUTVOUCHERTOBOOK
prompt ========================================
prompt
@@sp_f_putvouchertobook.prc
prompt
prompt Creating procedure SP_F_STATUSINIT
prompt ==================================
prompt
@@sp_f_statusinit.prc
prompt
prompt Creating procedure SP_F_SYNCHCOMMODITY
prompt ======================================
prompt
@@sp_f_synchcommodity.prc
prompt
prompt Creating procedure SP_F_UNFROZENALLFUNDS
prompt ========================================
prompt
@@sp_f_unfrozenallfunds.prc
prompt
prompt Creating procedure SP_TM_MOVEHISTORY
prompt ====================================
prompt
@@sp_tm_movehistory.prc
prompt
prompt Creating procedure SP_T_CLEARACTION_DONE
prompt ========================================
prompt
@@sp_t_clearaction_done.prc
prompt
prompt Creating procedure SP_W_MOVEHISTORY
prompt ===================================
prompt
@@sp_w_movehistory.prc

spool off

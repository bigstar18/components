--------------------------------------------------
-- Export file for user TRADE_GNNT@SPOT.DEV.183 --
-- Created by hxx on 2015/12/26, 23:31:47 --------
--------------------------------------------------

set define off
spool fn.log

prompt
prompt Creating function FN_M_MD5
prompt ==========================
prompt
@@fn_m_md5.fnc
prompt
prompt Creating function FN_BI_FIRMADD
prompt ===============================
prompt
@@fn_bi_firmadd.fnc
prompt
prompt Creating function FN_BI_FIRMDEL
prompt ===============================
prompt
@@fn_bi_firmdel.fnc
prompt
prompt Creating function FN_BI_UNFROZENBILL
prompt ====================================
prompt
@@fn_bi_unfrozenbill.fnc
prompt
prompt Creating function FN_BR_BROKEREVERYTRADEREWARD
prompt ==============================================
prompt
@@fn_br_brokereverytradereward.fnc
prompt
prompt Creating function FN_BR_BROKERPAYDATE
prompt =====================================
prompt
@@fn_br_brokerpaydate.fnc
prompt
prompt Creating function FN_F_UPDATEFUNDSFULL
prompt ======================================
prompt
@@fn_f_updatefundsfull.fnc
prompt
prompt Creating function FN_F_UPDATEFUNDS
prompt ==================================
prompt
@@fn_f_updatefunds.fnc
prompt
prompt Creating function FN_BR_BROKERREWARD
prompt ====================================
prompt
@@fn_br_brokerreward.fnc
prompt
prompt Creating function FN_BR_FIRMADD
prompt ===============================
prompt
@@fn_br_firmadd.fnc
prompt
prompt Creating function FN_BR_FIRMREWARDDEAIL
prompt =======================================
prompt
@@fn_br_firmrewarddeail.fnc
prompt
prompt Creating function FN_F_AUDITVOUCHERPASS
prompt =======================================
prompt
@@fn_f_auditvoucherpass.fnc
prompt
prompt Creating function FN_F_CREATEVOUCHER
prompt ====================================
prompt
@@fn_f_createvoucher.fnc
prompt
prompt Creating function FN_F_CREATEVOUCHERCOMP
prompt ========================================
prompt
@@fn_f_createvouchercomp.fnc
prompt
prompt Creating function FN_F_EXTRACTVOUCHER
prompt =====================================
prompt
@@fn_f_extractvoucher.fnc
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
prompt Creating function FN_F_B_FIRMADD
prompt ================================
prompt
@@fn_f_b_firmadd.fnc
prompt
prompt Creating function FN_F_B_FIRMDEL
prompt ================================
prompt
@@fn_f_b_firmdel.fnc
prompt
prompt Creating function FN_F_EXTRACTVOUCHERPRE
prompt ========================================
prompt
@@fn_f_extractvoucherpre.fnc
prompt
prompt Creating function FN_F_FIRMADD
prompt ==============================
prompt
@@fn_f_firmadd.fnc
prompt
prompt Creating function FN_F_FIRMDEL
prompt ==============================
prompt
@@fn_f_firmdel.fnc
prompt
prompt Creating function FN_F_FIRMTOSTATUS
prompt ===================================
prompt
@@fn_f_firmtostatus.fnc
prompt
prompt Creating function FN_F_GETREALFUNDS
prompt ===================================
prompt
@@fn_f_getrealfunds.fnc
prompt
prompt Creating function FN_F_SETVOUCHERBDATE
prompt ======================================
prompt
@@fn_f_setvoucherbdate.fnc
prompt
prompt Creating function FN_F_UPDATEFROZENFUNDS
prompt ========================================
prompt
@@fn_f_updatefrozenfunds.fnc
prompt
prompt Creating function FN_M_FIRMADD
prompt ==============================
prompt
@@fn_m_firmadd.fnc
prompt
prompt Creating function FN_M_FIRMDEL
prompt ==============================
prompt
@@fn_m_firmdel.fnc
prompt
prompt Creating function FN_M_FIRMTOSTATUS
prompt ===================================
prompt
@@fn_m_firmtostatus.fnc
prompt
prompt Creating function FN_T_ADDTRADEDAYS
prompt ===================================
prompt
@@fn_t_addtradedays.fnc
prompt
prompt Creating function FN_T_COMPUTEASSURE
prompt ====================================
prompt
@@fn_t_computeassure.fnc
prompt
prompt Creating function FN_T_COMPUTEMARGIN
prompt ====================================
prompt
@@fn_t_computemargin.fnc
prompt
prompt Creating function FN_T_COMPUTEPAYOUT
prompt ====================================
prompt
@@fn_t_computepayout.fnc
prompt
prompt Creating function FN_T_COMPUTESETTLEFEE
prompt =======================================
prompt
@@fn_t_computesettlefee.fnc
prompt
prompt Creating function FN_T_SUBHOLDSUM
prompt =================================
prompt
@@fn_t_subholdsum.fnc
prompt
prompt Creating function FN_T_AHEADSETTLEONE
prompt =====================================
prompt
@@fn_t_aheadsettleone.fnc
prompt
prompt Creating function FN_T_COMPUTEFPSUBTAX
prompt ======================================
prompt
@@fn_t_computefpsubtax.fnc
prompt
prompt Creating function FN_T_UPDATEFLOATINGLOSS
prompt =========================================
prompt
@@fn_t_updatefloatingloss.fnc
prompt
prompt Creating function FN_T_AHEADSETTLE
prompt ==================================
prompt
@@fn_t_aheadsettle.fnc
prompt
prompt Creating function FN_T_COMPUTESETTLEMARGIN
prompt ==========================================
prompt
@@fn_t_computesettlemargin.fnc
prompt
prompt Creating function FN_T_AHEADSETTLEONEQTY
prompt ========================================
prompt
@@fn_t_aheadsettleoneqty.fnc
prompt
prompt Creating function FN_T_AHEADSETTLEQTY
prompt =====================================
prompt
@@fn_t_aheadsettleqty.fnc
prompt
prompt Creating function FN_T_D_COMPUTEDELAYDAYS
prompt =========================================
prompt
@@fn_t_d_computedelaydays.fnc
prompt
prompt Creating function FN_T_D_PAYDELAYFUND
prompt =====================================
prompt
@@fn_t_d_paydelayfund.fnc
prompt
prompt Creating function FN_T_D_CHARGEDELAYFUND
prompt ========================================
prompt
@@fn_t_d_chargedelayfund.fnc
prompt
prompt Creating function FN_T_D_CLOSEPROCESS
prompt =====================================
prompt
@@fn_t_d_closeprocess.fnc
prompt
prompt Creating function FN_T_RECOMPUTEFLOATLOSS
prompt =========================================
prompt
@@fn_t_recomputefloatloss.fnc
prompt
prompt Creating function FN_T_COMPUTEASSUREBYARGS
prompt ==========================================
prompt
@@fn_t_computeassurebyargs.fnc
prompt
prompt Creating function FN_T_COMPUTEMARGINBYARGS
prompt ==========================================
prompt
@@fn_t_computemarginbyargs.fnc
prompt
prompt Creating function FN_T_COMPUTEFEE
prompt =================================
prompt
@@fn_t_computefee.fnc
prompt
prompt Creating function FN_T_RECOMPUTEFUNDS
prompt =====================================
prompt
@@fn_t_recomputefunds.fnc
prompt
prompt Creating function FN_T_UNFROZENBILL
prompt ===================================
prompt
@@fn_t_unfrozenbill.fnc
prompt
prompt Creating function FN_T_COMPUTESETTLEPRICE
prompt =========================================
prompt
@@fn_t_computesettleprice.fnc
prompt
prompt Creating function FN_T_SETTLEPROCESS
prompt ====================================
prompt
@@fn_t_settleprocess.fnc
prompt
prompt Creating function FN_T_TRADEFLOW
prompt ================================
prompt
@@fn_t_tradeflow.fnc
prompt
prompt Creating function FN_T_CLOSEMARKETPROCESS
prompt =========================================
prompt
@@fn_t_closemarketprocess.fnc
prompt
prompt Creating function FN_T_COMPUTEORDERNO
prompt =====================================
prompt
@@fn_t_computeorderno.fnc
prompt
prompt Creating function FN_T_CLOSEORDER
prompt =================================
prompt
@@fn_t_closeorder.fnc
prompt
prompt Creating function FN_T_COMPUTEFEEBYARGS
prompt =======================================
prompt
@@fn_t_computefeebyargs.fnc
prompt
prompt Creating function FN_T_COMPUTETRADENO
prompt =====================================
prompt
@@fn_t_computetradeno.fnc
prompt
prompt Creating function FN_T_CLOSETRADE
prompt =================================
prompt
@@fn_t_closetrade.fnc
prompt
prompt Creating function FN_T_COMPUTEFLOATINGLOSS
prompt ==========================================
prompt
@@fn_t_computefloatingloss.fnc
prompt
prompt Creating function FN_T_COMPUTEFLOATINGPROFIT
prompt ============================================
prompt
@@fn_t_computefloatingprofit.fnc
prompt
prompt Creating function FN_T_COMPUTEFORCECLOSEFEE
prompt ===========================================
prompt
@@fn_t_computeforceclosefee.fnc
prompt
prompt Creating function FN_T_COMPUTEFORCECLOSEQTY
prompt ===========================================
prompt
@@fn_t_computeforcecloseqty.fnc
prompt
prompt Creating function FN_T_COMPUTEHISTORYCLOSEFEE
prompt =============================================
prompt
@@fn_t_computehistoryclosefee.fnc
prompt
prompt Creating function FN_T_COMPUTEHOLDNO
prompt ====================================
prompt
@@fn_t_computeholdno.fnc
prompt
prompt Creating function FN_T_COMPUTETODAYCLOSEFEE
prompt ===========================================
prompt
@@fn_t_computetodayclosefee.fnc
prompt
prompt Creating function FN_T_CONFERCLOSEONE
prompt =====================================
prompt
@@fn_t_confercloseone.fnc
prompt
prompt Creating function FN_T_CONFERCLOSE
prompt ==================================
prompt
@@fn_t_conferclose.fnc
prompt
prompt Creating function FN_T_CONFERCLOSEAUDIT
prompt =======================================
prompt
@@fn_t_confercloseaudit.fnc
prompt
prompt Creating function FN_T_CREATEAPPLY
prompt ==================================
prompt
@@fn_t_createapply.fnc
prompt
prompt Creating function FN_T_DEDUCTDATA
prompt =================================
prompt
@@fn_t_deductdata.fnc
prompt
prompt Creating function FN_T_DEDUCTGO
prompt ===============================
prompt
@@fn_t_deductgo.fnc
prompt
prompt Creating function FN_T_D_BUYNEUTRALORDER
prompt ========================================
prompt
@@fn_t_d_buyneutralorder.fnc
prompt
prompt Creating function FN_T_D_BUYNEUTRALORDER_WD
prompt ===========================================
prompt
@@fn_t_d_buyneutralorder_wd.fnc
prompt
prompt Creating function FN_T_D_BUYSETTLEORDER
prompt =======================================
prompt
@@fn_t_d_buysettleorder.fnc
prompt
prompt Creating function FN_T_D_BUYSETTLEORDER_WD
prompt ==========================================
prompt
@@fn_t_d_buysettleorder_wd.fnc
prompt
prompt Creating function FN_T_D_CHECKANDFROZENBILL
prompt ===========================================
prompt
@@fn_t_d_checkandfrozenbill.fnc
prompt
prompt Creating function FN_T_D_CHGCUSTHOLDBYQTY
prompt =========================================
prompt
@@fn_t_d_chgcustholdbyqty.fnc
prompt
prompt Creating function FN_T_D_CHGFIRMHOLDBYQTY
prompt =========================================
prompt
@@fn_t_d_chgfirmholdbyqty.fnc
prompt
prompt Creating function FN_T_D_CHGFIRMMARGINBYQTY
prompt ===========================================
prompt
@@fn_t_d_chgfirmmarginbyqty.fnc
prompt
prompt Creating function FN_T_D_SETTLEONE
prompt ==================================
prompt
@@fn_t_d_settleone.fnc
prompt
prompt Creating function FN_T_D_TRADEBILL
prompt ==================================
prompt
@@fn_t_d_tradebill.fnc
prompt
prompt Creating function FN_T_D_NEUTRALMATCHONE
prompt ========================================
prompt
@@fn_t_d_neutralmatchone.fnc
prompt
prompt Creating function FN_T_D_NEUTRALMATCH
prompt =====================================
prompt
@@fn_t_d_neutralmatch.fnc
prompt
prompt Creating function FN_T_D_UNFROZENBILL
prompt =====================================
prompt
@@fn_t_d_unfrozenbill.fnc
prompt
prompt Creating function FN_T_D_SELLNEUTRALORDER_WD
prompt ============================================
prompt
@@fn_t_d_sellneutralorder_wd.fnc
prompt
prompt Creating function FN_T_D_SELLSETTLEORDER_WD
prompt ===========================================
prompt
@@fn_t_d_sellsettleorder_wd.fnc
prompt
prompt Creating function FN_T_D_ORDER_WD
prompt =================================
prompt
@@fn_t_d_order_wd.fnc
prompt
prompt Creating function FN_T_D_SELLNEUTRALORDER
prompt =========================================
prompt
@@fn_t_d_sellneutralorder.fnc
prompt
prompt Creating function FN_T_D_SELLSETTLEORDER
prompt ========================================
prompt
@@fn_t_d_sellsettleorder.fnc
prompt
prompt Creating function FN_T_D_SETTLEMATCHONE
prompt =======================================
prompt
@@fn_t_d_settlematchone.fnc
prompt
prompt Creating function FN_T_D_SETTLEMATCH
prompt ====================================
prompt
@@fn_t_d_settlematch.fnc
prompt
prompt Creating function FN_T_FIRMADD
prompt ==============================
prompt
@@fn_t_firmadd.fnc
prompt
prompt Creating function FN_T_FIRMDEL
prompt ==============================
prompt
@@fn_t_firmdel.fnc
prompt
prompt Creating function FN_T_FIRMEXITCHECK
prompt ====================================
prompt
@@fn_t_firmexitcheck.fnc
prompt
prompt Creating function FN_T_GAGECLOSEORDER
prompt =====================================
prompt
@@fn_t_gagecloseorder.fnc
prompt
prompt Creating function FN_T_GAGECLOSETRADE
prompt =====================================
prompt
@@fn_t_gageclosetrade.fnc
prompt
prompt Creating function FN_T_GAGEQTY
prompt ==============================
prompt
@@fn_t_gageqty.fnc
prompt
prompt Creating function FN_T_GAGEQTYCANCEL
prompt ====================================
prompt
@@fn_t_gageqtycancel.fnc
prompt
prompt Creating function FN_T_GETHOLDDEADLINE
prompt ======================================
prompt
@@fn_t_getholddeadline.fnc
prompt
prompt Creating function FN_T_UPDATEHOLDDAYS
prompt =====================================
prompt
@@fn_t_updateholddays.fnc
prompt
prompt Creating function FN_T_INITTRADE
prompt ================================
prompt
@@fn_t_inittrade.fnc
prompt
prompt Creating function FN_T_OPENORDER
prompt ================================
prompt
@@fn_t_openorder.fnc
prompt
prompt Creating function FN_T_OPENTRADE
prompt ================================
prompt
@@fn_t_opentrade.fnc
prompt
prompt Creating function FN_T_OUTSTOCKCONFIRM
prompt ======================================
prompt
@@fn_t_outstockconfirm.fnc
prompt
prompt Creating function FN_T_SELLBILLORDER
prompt ====================================
prompt
@@fn_t_sellbillorder.fnc
prompt
prompt Creating function FN_T_SELLBILLTRADE
prompt ====================================
prompt
@@fn_t_sellbilltrade.fnc
prompt
prompt Creating function FN_T_SETTLECANCEL
prompt ===================================
prompt
@@fn_t_settlecancel.fnc
prompt
prompt Creating function FN_T_SETTLEMATCH
prompt ==================================
prompt
@@fn_t_settlematch.fnc
prompt
prompt Creating function FN_T_TRADEDAYEND
prompt ==================================
prompt
@@fn_t_tradedayend.fnc
prompt
prompt Creating function FN_T_UNTRADETRANSFER
prompt ======================================
prompt
@@fn_t_untradetransfer.fnc
prompt
prompt Creating function FN_T_UPDATELASTPRICE
prompt ======================================
prompt
@@fn_t_updatelastprice.fnc
prompt
prompt Creating function FN_T_UPDATEQUOTATION
prompt ======================================
prompt
@@fn_t_updatequotation.fnc
prompt
prompt Creating function FN_T_UPDATERUNTIMESETTLEMARGIN
prompt ================================================
prompt
@@fn_t_updateruntimesettlemargin.fnc
prompt
prompt Creating function FN_T_UPDATETRADE
prompt ==================================
prompt
@@fn_t_updatetrade.fnc
prompt
prompt Creating function FN_T_WITHDRAW
prompt ===============================
prompt
@@fn_t_withdraw.fnc
prompt
prompt Creating function FN_V_CLOSEMARKET
prompt ==================================
prompt
@@fn_v_closemarket.fnc
prompt
prompt Creating function FN_V_COMPUTEFEE
prompt =================================
prompt
@@fn_v_computefee.fnc
prompt
prompt Creating function FN_V_COMPUTEMARGIN
prompt ====================================
prompt
@@fn_v_computemargin.fnc
prompt
prompt Creating function FN_V_FIRMADD
prompt ==============================
prompt
@@fn_v_firmadd.fnc
prompt
prompt Creating function FN_V_FIRMDEL
prompt ==============================
prompt
@@fn_v_firmdel.fnc
prompt
prompt Creating function FN_V_FIRMEXITCHECK
prompt ====================================
prompt
@@fn_v_firmexitcheck.fnc
prompt
prompt Creating function FN_V_ORDER
prompt ============================
prompt
@@fn_v_order.fnc
prompt
prompt Creating function FN_V_WITHDRAW
prompt ===============================
prompt
@@fn_v_withdraw.fnc
prompt
prompt Creating function FN_V_TRADEBUY
prompt ===============================
prompt
@@fn_v_tradebuy.fnc
prompt
prompt Creating function FN_V_TRADESELL
prompt ================================
prompt
@@fn_v_tradesell.fnc
prompt
prompt Creating function FN_V_TRADETENDER
prompt ==================================
prompt
@@fn_v_tradetender.fnc
prompt
prompt Creating function FN_V_TRADETENDERAUDIT
prompt =======================================
prompt
@@fn_v_tradetenderaudit.fnc

spool off

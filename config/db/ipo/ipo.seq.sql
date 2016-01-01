--------------------------------------------------
-- Export file for user TRADE_GNNT@SPOT.DEV.183 --
-- Created by hxx on 2015/11/9, 18:00:12 ---------
--------------------------------------------------

set define off
spool ipo.seq.log

prompt
prompt Creating sequence SEQ_IPO_BALLOTNO_INFO
prompt =======================================
prompt
create sequence SEQ_IPO_BALLOTNO_INFO
minvalue 1
maxvalue 9999999999999999999999999999
start with 461
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IPO_COMMODITY
prompt ===================================
prompt
create sequence SEQ_IPO_COMMODITY
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IPO_DISTRIBUTION
prompt ======================================
prompt
create sequence SEQ_IPO_DISTRIBUTION
minvalue 1
maxvalue 9999999999999999999999999999
start with 221
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IPO_NUMBEROFRECORDS
prompt =========================================
prompt
create sequence SEQ_IPO_NUMBEROFRECORDS
minvalue 1
maxvalue 9999999999999999999999999999
start with 221
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IPO_NUMBEROFRECORDS_H
prompt ===========================================
prompt
create sequence SEQ_IPO_NUMBEROFRECORDS_H
minvalue 1
maxvalue 9999999999999999999999999999
start with 41
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IPO_ORDER
prompt ===============================
prompt
create sequence SEQ_IPO_ORDER
minvalue 1
maxvalue 9999999999999999999999999999
start with 81
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_IPO_ORDER_H
prompt =================================
prompt
create sequence SEQ_IPO_ORDER_H
minvalue 1
maxvalue 9999999999999999999999999999
start with 61
increment by 1
cache 20;


spool off

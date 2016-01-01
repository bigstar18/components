create or replace function FN_T_ComputeForceCloseQty(
       p_firmid varchar2,
       p_commodityid varchar2,
       p_bs_flag number,--持仓买卖方向
       p_quantity number,
       p_price number,
       p_forceCloseprice number
) return number
is
	v_version varchar2(10):='1.0.0.6';
  v_lastprice number(15,2) default 0;--结算价
  v_contractfactor number(15,2) default 0;
  v_forceCloseprice number(15,2) default 0;--参考数量对应一手金额
  v_forceClosePL number(15,2) default 0;--平仓盈亏
  v_computemargin number(15,2) default 0;
  v_computefee number(15,2) default 0;
  v_computefloatingprofit number(15,2) default 0;
  v_addedtaxfactor number(15,6);

begin
    begin
       select price into v_lastprice from t_quotation where commodityID = p_commodityid;
    exception
        when NO_DATA_FOUND then
             return 0;
    end;
    begin
       select ContractFactor,addedtaxfactor into v_contractfactor,v_addedtaxfactor from t_commodity where commodityID = p_commodityid;
    exception
        when NO_DATA_FOUND then
             return 0;
    end;


  --平仓盈亏  xief  20150811
  if (p_bs_flag = 1) then
       v_forceClosePL := (p_forceCloseprice - p_price)*v_contractfactor;
   --  v_forceClosePL := (p_forceCloseprice - p_price)*v_contractfactor*(1 - v_addedtaxfactor);
     --保证金
     v_computemargin := FN_T_COMPUTEMARGIN(p_firmid,p_commodityid,1,p_quantity,v_lastprice);
     --手续费
     v_computefee := fn_t_computefee(p_firmid,p_commodityid,2,p_quantity,p_forceCloseprice);
     --浮动盈亏
     v_computefloatingprofit := fn_t_computefloatingprofit(p_price,v_lastprice,p_quantity,v_contractfactor,1);
     if (v_computefloatingprofit > 0) then
        v_computefloatingprofit := 0;
     end if;
  else
    -- v_forceClosePL := (p_price - p_forceCloseprice)*v_contractfactor*(1 - v_addedtaxfactor);
     v_forceClosePL := (p_price - p_forceCloseprice)*v_contractfactor;
     --保证金
     v_computemargin := FN_T_COMPUTEMARGIN(p_firmid,p_commodityid,2,p_quantity,v_lastprice);
     --手续费
     v_computefee := fn_t_computefee(p_firmid,p_commodityid,1,p_quantity,p_forceCloseprice);
     --浮动盈亏
     v_computefloatingprofit := fn_t_computefloatingprofit(p_price,v_lastprice,p_quantity,v_contractfactor,2);
     if (v_computefloatingprofit > 0) then
        v_computefloatingprofit := 0;
     end if;
  end if;
  v_forceCloseprice := v_computemargin - v_computefee - v_computefloatingprofit + v_forceClosePL;
  return v_forceCloseprice;
end;
/


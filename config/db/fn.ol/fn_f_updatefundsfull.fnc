create or replace function FN_F_UpdateFundsFull
(
  p_firmID varchar2,      --交易商代码
  p_oprcode char,         --业务代码
  p_amount number,        --发生额
  p_contractNo varchar2,  --成交合同号
  p_extraCode varchar2,   --中远期商品代码，银行为科目代码
  p_appendAmount number,  --中远期(增值税,担保金)
  p_voucherNo number      --凭证号(手工凭证使用)
) return number
/***
 * 更新资金
 * version 1.0.0.1 此方法公用
 *
 * 返回值：资金余额
 ****/
is
  v_fundsign number(1); -- 1 加项 -1 减项
  v_balance number(15,2);
  v_amount number(15,2):= p_amount;
begin
  begin
    select decode(funddcflag,'C',1,'D',-1,0) into v_fundsign from f_summary where summaryno=p_oprcode;
    if(v_fundsign=0) then
      Raise_application_error(-21003, 'Fund DCflag not defined in F_Summary!'); --未设置业务代码（摘要）资金借贷方向
    end if;
  exception when NO_DATA_FOUND then
    Raise_application_error(-21002, 'Undefined operation code(summaryNo)!'); --不存在的业务代码（摘要）
  end;

  update f_firmfunds set balance=balance + v_fundsign*v_amount where firmid=p_firmid
  returning balance into v_balance;
  if(SQL%ROWCOUNT = 0) then
    Raise_application_error(-21001, 'FirmID not existed !'); --不存在的交易商代码
  end if;

  --插入资金流水
  insert into f_fundflow
    (fundflowid, firmid, oprcode, contractno, commodityid, amount, balance,appendamount, voucherno, createtime)
  values
    (seq_f_fundflow.nextval, p_firmid, p_oprcode, p_contractno, p_extraCode, v_amount, v_balance,p_appendAmount,p_voucherNo, sysdate);

  return v_balance;
end;
/


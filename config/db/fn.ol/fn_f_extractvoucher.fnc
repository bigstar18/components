create or replace function FN_F_ExtractVoucher
return number
as
/***
 * 抽取电脑凭证
 * version 1.0.0.1
 *
 * 返回生成凭证数
 ****/
  v_voucherNo number(10);
  v_b_date date;

  v_fundflowid number(10);
  v_firmId varchar2(32);
  v_oprcode F_FundFlow.Oprcode%type;
  v_contractNo varchar2(16);
  v_commodityID varchar2(16);
  v_amount number(15,2);
  v_appendAmount number(15,2);
  v_createtime date;

  v_fundDCflag char(1);
  v_summary varchar2(32);
  v_accountcodeopp varchar2(38);
  v_appendAccount char(1);

  v_debitCode varchar2(38);
  v_creditCode varchar2(38);

  v_cnt number(10):=0;

  cursor c_FundFlow is
      select fundflowid, firmid, oprcode,contractNo,commodityID, amount, appendamount, createtime, b_date
      from f_fundflow
      where voucherno is null
      order by fundflowid;

begin
  delete from f_fundflow where amount=0 and appendamount=0;
  --通过交易资金流水和成交合同生成凭证
  open c_FundFlow;
  loop
     fetch c_FundFlow into v_fundflowid,v_firmId,v_oprcode,v_contractNo,v_commodityID,v_amount,v_appendAmount,v_createtime,v_b_date;
     exit when c_FundFlow%NOTFOUND;
     --将商品科目对应
     select funddcflag, replace(accountcodeopp,'*',v_commodityID),summary,appendAccount
     into v_funddcflag, v_accountcodeopp,v_summary,v_appendAccount
     from f_summary
     where summaryno = v_oprcode;

   --新增，用于诚信保证金 2012-5-10
   v_accountcodeopp := replace(v_accountcodeopp, '#', v_firmId);

     if(v_accountcodeopp = 'spec') then
       v_accountcodeopp := v_commodityID;
     end if;

     if(v_funddcflag='D') then
         v_debitCode:='200100'||v_firmId;
         v_creditCode:=v_accountcodeopp;
     elsif(v_funddcflag='C') then
         v_debitCode:=v_accountcodeopp;
         v_creditCode:='200100'||v_firmId;
     end if;

     if(v_contractNo is not null) then --合同号跟交易系统号
       v_contractno:=substr(v_oprcode,1,1)||'-'||v_contractNo;
     end if;

     v_voucherNo:=fn_f_createvoucherComp(v_oprcode,v_summary,v_debitCode,v_creditCode,v_amount,v_contractno,v_fundflowid,v_createtime,v_b_date);
     v_cnt:=v_cnt + 1;

     update F_FundFlow set voucherno=v_voucherNo where fundflowid=v_fundflowid;

     if(v_appendAmount is not null and v_appendAmount!=0 and v_appendAccount!='N') then --有附加账目
         v_fundflowid:=null;
         if(v_appendAccount='T') then
           if(v_funddcflag='D') then  --亏损，一部分来自返回增值税
             v_oprcode:='15098';
             v_debitCode:='1005' || substr(v_oprcode,0,2) || v_commodityID;
             v_creditCode:=v_accountcodeopp;
           elsif(v_funddcflag='C') then --盈利，一部分给增值税
             v_oprcode:='15099';
             v_debitCode:=v_accountcodeopp;
             v_creditCode:='1005' || substr(v_oprcode,0,2) || v_commodityID;
           end if;
           v_voucherNo:=fn_f_createvoucherComp(v_oprcode,null,v_debitCode,v_creditCode,v_appendAmount,v_contractno,v_fundflowid,v_createtime,v_b_date);
           v_cnt:=v_cnt + 1;
         elsif(v_appendAccount='W') then --担保金
           if(v_funddcflag='D') then --收保证金，加担保金
             v_oprcode:='15097';  --入担保金
             v_debitCode:='1006';
             v_creditCode:='200101'||v_firmId;
             v_voucherNo:=fn_f_createvoucherComp(v_oprcode,null,v_debitCode,v_creditCode,v_appendAmount,v_contractno,v_fundflowid,v_createtime,v_b_date);
             v_cnt:=v_cnt + 1;

             v_oprcode:='15095';  --收交易商担保金
             v_debitCode:='200101'||v_firmId;
             v_creditCode:='2099'|| substr(v_oprcode,0,2) ||v_commodityID;
             v_voucherNo:=fn_f_createvoucherComp(v_oprcode,null,v_debitCode,v_creditCode,v_appendAmount,v_contractno,v_fundflowid,v_createtime,v_b_date);
             v_cnt:=v_cnt + 1;
           elsif(v_funddcflag='C') then --退保证金
             v_oprcode:='15094';  --退交易商担保金
             v_debitCode:='2099'|| substr(v_oprcode,0,2) ||v_commodityID;
             v_creditCode:='200101'||v_firmId;
             v_voucherNo:=fn_f_createvoucherComp(v_oprcode,null,v_debitCode,v_creditCode,v_appendAmount,v_contractno,v_fundflowid,v_createtime,v_b_date);
             v_cnt:=v_cnt + 1;

             v_oprcode:='15096';  --出担保金
             v_debitCode:='200101'||v_firmId;
             v_creditCode:='1006';
             v_voucherNo:=fn_f_createvoucherComp(v_oprcode,v_summary,v_debitCode,v_creditCode,v_appendAmount,v_contractno,v_fundflowid,v_createtime,v_b_date);
             v_cnt:=v_cnt + 1;
           end if;
         end if;
     end if;
  end loop;
  close c_FundFlow;

  return v_cnt;
end;
/


create or replace function FN_T_DeductGo
 (
   p_deductID number  --强减ID
 )
return number  --返回 1 成功  -1:只能闭市操作状态强减；-2：强减日期不是当天
/***
 * 根据强减数据（强减明细表）执行强制减仓
 *
 ***/
as
  v_systemstatus number(2);
  v_deductDate date;
  v_cmdtyCode varchar2(16);  --强减的商品代码
  v_deductPrice number;
  v_loserBSflag number(1);
  v_selfCounteract char(1);
  v_customerid varchar2(40);

  v_customerid_l varchar2(40);
  v_deductqty number(10);
  v_CounteractQty number(10);

  v_customerid_w varchar2(40);

  v_num number(10);
  v_dnum number(10);

  v_ret number;
  v_TradeDate date;

  cursor c_counteract is --对冲
    select customerid,CounteractQty-CounteractedQty from T_E_DeductDetail
    where deductID=p_deductID and CounteractQty-CounteractedQty>0;

  cursor c_deduct is
    select customerid,deductqty-deductedqty from T_E_DeductDetail
    where deductID=p_deductID and wl='L' and deductqty-deductedqty>0
    order by deductqty desc;


begin
  select status,TradeDate into v_systemstatus,v_TradeDate from t_systemstatus;
  if(v_systemstatus<>1) then --只能闭市操作状态强减
    return -1;
  end if;

  --获得强减参数
  select deductdate,commodityid,deductprice,loserBSflag,selfcounteract
  into v_deductDate,v_cmdtyCode,v_deductPrice,v_loserBSflag,v_selfcounteract
  from T_E_DeductPosition where deductID=p_deductID;
  --判断日期是否当天
  if(v_deductDate!=trunc(v_TradeDate))then
    return -2;
  end if;
  --进行对冲
  if(v_selfcounteract>0) then
    open c_counteract;
    loop
      fetch c_counteract into v_customerid,v_counteractQty;
      exit when c_counteract%NOTFOUND;
      v_ret:=FN_T_ConferClose(v_cmdtyCode,v_deductPrice,v_customerid,v_CounteractQty,0,v_customerid,v_CounteractQty,0);
      if(v_ret = 1) then
        update T_E_DeductDetail set CounteractedQty=v_CounteractQty
        where deductID=p_deductID
          and customerid=v_customerid;
      else
        begin
          update T_E_DeductPosition set alert=alert||'Counteract customer:'||v_customerid_l||' err:'||v_ret where deductID=p_deductID;
        exception
          when OTHERS then
            null;
        end;
      end if;
    end loop;
  end if;
  --调用协议平仓进行强减
  open c_deduct;
  loop
    fetch c_deduct into v_customerid_l,v_deductqty;
    exit when c_deduct%NOTFOUND;

    loop
      exit when v_deductqty<=0;
      select customerid,deductqty-deductedqty into v_customerid_w,v_num from T_E_DeductDetail
      where deductID=p_deductID and wl='W'
        and (deductqty-deductedqty)>0 and rownum<2;
      if(v_deductqty>v_num) then
        v_dnum := v_num;
      else
        v_dnum := v_deductqty;
      end if;
      if(v_loserBSflag=1) then
        v_ret:=FN_T_ConferClose(v_cmdtyCode,v_deductPrice,v_customerid_l,v_dnum,0,v_customerid_w,v_dnum,0);
      else
        v_ret:=FN_T_ConferClose(v_cmdtyCode,v_deductPrice,v_customerid_w,v_dnum,0,v_customerid_l,v_dnum,0);
      end if;
      if(v_ret=1) then
        v_deductqty:=v_deductqty-v_dnum;
        update T_E_DeductDetail set deductedqty=deductedqty+v_dnum
        where deductID=p_deductID
          and customerid in (v_customerid_l,v_customerid_w);
      end if;
    end loop;

  end loop;
  update T_E_DeductPosition set deductstatus='Y',exectime=sysdate where deductID=p_deductID;
  return 1;
end;
/


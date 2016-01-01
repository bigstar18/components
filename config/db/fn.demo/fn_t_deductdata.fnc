create or replace function FN_T_DeductData
 (
    p_deductID number  --ǿ��ID
 )
return number     --���� 1 �ɹ� -1:ֻ�ܱ��в���״̬ǿ���� -2��û�з���������ӯ����
/**
 * ����ǿ������
 *
 **/
as
    v_systemstatus number(2);
    v_deductDate date;  --ǿ������
    v_cmdtyCode varchar2(16);  --ǿ������Ʒ����
    v_factor number;
    v_b_price number(15,2); --�����
    v_deductPrice number;
    v_loserBSflag number(1);
    v_loserSign number(1);

    v_loserMode number;
    v_lossRate number;
    v_selfCounteract char(1);
    v_profitLvl1 number;
    v_profitLvl2 number;
    v_profitLvl3 number;
    v_profitLvl4 number;
    v_profitLvl5 number;
    v_profitQty1 number;
    v_profitQty2 number;
    v_profitQty3 number;
    v_profitQty4 number;
    v_profitQty5 number;
    v_lossqty number(10);
    v_loserPct number;
    v_winerPct number;

    v_diff number(10);

    v_customerId varchar2(40);

    --������Ŀͻ�
    cursor c_deductRound is
    select customerid from T_E_DeductDetail
    where deductID=p_deductID and estimateQty-deductQty>0
    order by (estimateQty-deductQty) desc ,PL_ratio desc;

    v_errorcode      number;
    v_errormsg       varchar2(200);
begin
    select status into v_systemstatus from t_systemstatus;
    if(v_systemstatus<>1) then --ֻ�ܱ��в���״̬ǿ��
        return -1;
    end if;

    --����������
    delete from T_E_DeductDetail where deductID=p_deductID;

    --���ǿ������
    select deductDate,commodityid,deductprice,loserBSflag,decode(loserBSflag,2,-1,1),losermode, -lossrate, selfcounteract, profitlvl1, profitlvl2, profitlvl3, profitlvl4, profitlvl5
    into v_deductDate,v_cmdtyCode,v_deductPrice,v_loserBSflag,v_loserSign,v_losermode, v_lossrate, v_selfcounteract, v_profitlvl1, v_profitlvl2, v_profitlvl3, v_profitlvl4, v_profitlvl5
    from T_E_DeductPosition where deductID=p_deductID;

    select contractfactor into v_factor from t_commodity t where t.commodityid=v_cmdtyCode;
    --�õ�����ۣ����������ӯ����
    select decode(qt.price,0,qt.yesterbalanceprice,qt.price) into v_b_price from t_quotation qt where qt.commodityid=v_cmdtyCode;

    --������׿ͻ�ӯ��
    insert into T_E_DeductDetail(deductID,Customerid,Buyqty,Sellqty,Pureholdqty,Pl,Pl_Ratio,WL,buykeepqty,Sellkeepqty,counteractqty,Orderqty,deductableqty,Estimateqty,deductqty,Deductedqty,Counteractedqty)
    select p_deductID,customerid,buyqty,sellqty,pureholdqty,pl,decode(pureholdqty,0,0,pl/(abs(pureholdqty)*v_factor)/v_b_price) pl_ratio,
        decode(sign(pureholdqty),v_loserSign,'L','W'),0,0,0,0,0,0,0,0,0 from
       (
         select a.customerid,sum(decode(a.bs_flag,2,-1,1)*a.holdqty) pureholdqty,sum(decode(a.bs_flag,1,a.holdqty,0)) buyqty,
           sum(decode(a.bs_flag,2,a.holdqty,0)) sellqty,sum(decode(a.bs_flag,1,(a.holdqty*v_b_price*v_factor-(a.holdfunds-a.GageQty*a.EvenPrice*v_factor)),((a.holdfunds-a.GageQty*a.EvenPrice*v_factor)-a.holdqty*v_b_price*v_factor))) pl
         from T_CustomerHoldSum a
         where commodityid=v_cmdtyCode group by a.customerid
       );

    --��������
    update T_E_DeductDetail t set t.buykeepqty=
        nvl((
          select sum(df.keepqty) from T_E_DeductKeep df
          where deductID=p_deductID and df.bs_flag=1 and df.customerid=t.customerid
        ),0),
        t.sellkeepqty=
        nvl((
          select sum(df.keepqty) from T_E_DeductKeep df
          where deductID=p_deductID and df.bs_flag=2 and df.customerid=t.customerid
        ),0)
    where deductID=p_deductID ;
    ----------��ȫ������ͻ�ǿ��
    if(v_losermode=1) then
        --��������׿ͻ���ǿ������
        if(v_loserBSflag=1) then
          --����-�����������ֲ���   ȡ��С����Ϊ����ǿ����
          update T_E_DeductDetail t set t.deductableqty=least(buyqty-buykeepqty,PureHoldQty)
          where deductID=p_deductID and wl='L' and pl_ratio<=v_lossrate;
          --����-�������������ֲ���   ȡ��С����Ϊ����ǿ����
          update T_E_DeductDetail t set t.deductableqty=least(sellqty-sellkeepqty,-PureHoldQty)
          where deductID=p_deductID and wl='W' and pl_ratio>=v_profitlvl5;
        else
          --����-�������������ֲ���   ȡ��С����Ϊ����ǿ����
          update T_E_DeductDetail t set t.deductableqty=least(sellqty-sellkeepqty,-PureHoldQty)
          where deductID=p_deductID and wl='L' and pl_ratio<=v_lossrate;
          --����-�����������ֲ���   ȡ��С����Ϊ����ǿ����
          update T_E_DeductDetail t set t.deductableqty=least(buyqty-buykeepqty,PureHoldQty)
          where deductID=p_deductID and wl='W' and pl_ratio>=v_profitlvl5;
        end if;
    end if;
    ---------��ƽ��ί��ǿ��
    if(v_losermode=2) then
        --�ó��ͻ���ƽ��ί������
        update T_E_DeductDetail t set t.orderqty=
          nvl((select sum(quantity-tradeqty) from T_orders o
           where trunc(o.ordertime)=v_deductDate
           and o.commodityid=v_cmdtyCode and o.customerid=t.customerid and WithdrawType=4
           and o.bs_flag=decode(v_loserBSflag,1,2,1) and o.ordertype=2 and price=v_deductPrice),0)
         /* add by yukx 20100514 */
           -nvl((
              select sum(d.orderqty) from T_E_DeductDetail d,T_E_DeductPosition p
              where d.deductid=p.deductid and p.deductid<> p_deductID and d.customerid=t.customerid and p.deductstatus='Y'
               and p.commodityid=v_cmdtyCode and p.deductprice=v_deductPrice and p.loserbsflag=v_loserBSflag
               and p.deductdate=(select TradeDate from T_SystemStatus)),0)
        where deductID=p_deductID ;

        --��������׿ͻ���ǿ������
        if(v_loserBSflag=1) then
            --����-��������ί���������ֲ���   ȡ��С����Ϊ����ǿ����
            update T_E_DeductDetail t set t.deductableqty=least(buyqty-buykeepqty,orderqty,PureHoldQty)
            where deductID=p_deductID and wl='L' and pl_ratio<=v_lossrate;
            --����-�������������ֲ���   ȡ��С����Ϊ����ǿ����
            update T_E_DeductDetail t set t.deductableqty=least(sellqty-sellkeepqty,-PureHoldQty)
            where deductID=p_deductID and wl='W' and pl_ratio>=v_profitlvl5;
        else
            --����-����������ί���������ֲ���   ȡ��С����Ϊ����ǿ����
            update T_E_DeductDetail t set t.deductableqty=least(sellqty-sellkeepqty,orderqty,-PureHoldQty)
            where deductID=p_deductID and wl='L' and pl_ratio<=v_lossrate;
            --����-�����������ֲ���   ȡ��С����Ϊ����ǿ����
            update T_E_DeductDetail t set t.deductableqty=least(buyqty-buykeepqty,PureHoldQty)
            where deductID=p_deductID and wl='W' and pl_ratio>=v_profitlvl5;
        end if;
    end if;
    --���𷽿�ǿ��������
    select sum(deductableqty) into v_lossqty from T_E_DeductDetail d
    where deductID=p_deductID and wl='L' and pl_ratio<=v_lossrate;
    --ӯ��������������
    select sum(deductableqty) into v_profitqty1 from T_E_DeductDetail
    where pl_ratio>=v_profitlvl1 and deductID=p_deductID and wl='W';
    select sum(deductableqty) into v_profitqty2 from T_E_DeductDetail
    where pl_ratio>=v_profitlvl2 and pl_ratio<v_profitlvl1 and deductID=p_deductID and wl='W';
    select sum(deductableqty) into v_profitqty3 from T_E_DeductDetail
    where pl_ratio>=v_profitlvl3 and pl_ratio<v_profitlvl2 and deductID=p_deductID and wl='W';
    select sum(deductableqty) into v_profitqty4 from T_E_DeductDetail
    where pl_ratio>=v_profitlvl4 and pl_ratio<v_profitlvl3 and deductID=p_deductID and wl='W';
    select sum(deductableqty) into v_profitqty5 from T_E_DeductDetail
    where pl_ratio>=v_profitlvl5 and pl_ratio<v_profitlvl4 and deductID=p_deductID and wl='W';
    v_profitqty1:=nvl(v_profitqty1,0);
    v_profitqty2:=nvl(v_profitqty2,0);
    v_profitqty3:=nvl(v_profitqty3,0);
    v_profitqty4:=nvl(v_profitqty4,0);
    v_profitqty5:=nvl(v_profitqty5,0);
    if(v_profitqty1+v_profitqty2+v_profitqty3+v_profitqty4+v_profitqty5 = 0)then
        return -2; --û�з���������ӯ����
    end if;

    --�������ǿ������
    if(v_lossqty>v_profitqty1+v_profitqty2+v_profitqty3+v_profitqty4+v_profitqty5) then
        v_loserPct := (v_profitqty1+v_profitqty2+v_profitqty3+v_profitqty4+v_profitqty5)/v_lossqty;
        v_winerPct := 1;
        update T_E_DeductDetail set EstimateQty=deductableqty
        where pl_ratio>=v_profitlvl5 and deductID=p_deductID and wl='W';
    elsif(v_lossqty>v_profitqty1+v_profitqty2+v_profitqty3+v_profitqty4) then
        v_loserPct := 1;
        v_winerPct := (v_lossqty-(v_profitqty1+v_profitqty2+v_profitqty3+v_profitqty4))/v_profitqty5;
        update T_E_DeductDetail set EstimateQty=deductableqty
        where pl_ratio>=v_profitlvl4 and deductID=p_deductID and wl='W';
        update T_E_DeductDetail set EstimateQty=deductableqty*v_winerPct
        where pl_ratio>=v_profitlvl5 and pl_ratio<v_profitlvl4 and deductID=p_deductID and wl='W';
    elsif(v_lossqty>v_profitqty1+v_profitqty2+v_profitqty3) then
        v_loserPct := 1;
        v_winerPct := (v_lossqty-(v_profitqty1+v_profitqty2+v_profitqty3))/v_profitqty4;
        update T_E_DeductDetail set EstimateQty=deductableqty
        where pl_ratio>=v_profitlvl3 and deductID=p_deductID and wl='W';
        update T_E_DeductDetail set EstimateQty=deductableqty*v_winerPct
        where pl_ratio>=v_profitlvl4 and pl_ratio<v_profitlvl3 and deductID=p_deductID and wl='W';
    elsif(v_lossqty>v_profitqty1+v_profitqty2) then
        v_loserPct := 1;
        v_winerPct := (v_lossqty-(v_profitqty1+v_profitqty2))/v_profitqty3;
        update T_E_DeductDetail set EstimateQty=deductableqty
        where pl_ratio>=v_profitlvl2 and deductID=p_deductID and wl='W';
        update T_E_DeductDetail set EstimateQty=deductableqty*v_winerPct
        where pl_ratio>=v_profitlvl3 and pl_ratio<v_profitlvl2 and deductID=p_deductID and wl='W';
    elsif(v_lossqty>v_profitqty1) then
        v_loserPct := 1;
        v_winerPct := (v_lossqty-v_profitqty1)/v_profitqty2;
        update T_E_DeductDetail set EstimateQty=deductableqty
        where pl_ratio>=v_profitlvl1 and deductID=p_deductID and wl='W';
        update T_E_DeductDetail set EstimateQty=deductableqty*v_winerPct
        where pl_ratio>=v_profitlvl2 and pl_ratio<v_profitlvl1 and deductID=p_deductID and wl='W';
    else --(v_lossqty<=v_profitqty1)
        v_loserPct := 1;
        v_winerPct := v_lossqty/v_profitqty1;
        update T_E_DeductDetail set EstimateQty=deductableqty*v_winerPct
        where pl_ratio>=v_profitlvl1 and deductID=p_deductID and wl='W';
    end if;

    update T_E_DeductDetail set EstimateQty=deductableqty*v_loserPct where deductID=p_deductID and wl='L';

    --�Ƚ��������ּ���ǿ������
    update T_E_DeductDetail set deductqty=trunc(EstimateQty) where deductID=p_deductID;
    --�ó������ݿ��𷽺�ӯ�������ֲ��෴�ķ��ţ������������ӯ�����Ĳ�Ҳ����С������û�з����ǿ����
    select abs(sum(sign(pureHoldQty)*deductqty)) into v_diff from T_E_DeductDetail where deductID=p_deductID;
    --�Է������Ŀͻ�����ȡ��
    if(v_diff > 0) then
        open c_deductRound;
        loop
          fetch c_deductRound into v_customerid;
          exit when v_diff=0;
          update T_E_DeductDetail set deductqty=deductqty+1 where deductID=p_deductID and customerid=v_customerid;
          v_diff:=v_diff - 1;
        end loop;
        close c_deductRound;
    end if;

    --����Գ�����
    if(v_losermode=1) then
        if(v_selfcounteract=0) then   --���Գ�
            update T_E_DeductDetail set CounteractQty=0
            where deductID=p_deductID;
        else --ȫ��˫��ֲֶԳ�
            if(v_loserBSflag=1) then
                update T_E_DeductDetail set CounteractQty=least(buyqty-buykeepqty-deductqty,sellqty-sellkeepqty)
                where deductID=p_deductID and wl='L';
                update T_E_DeductDetail set CounteractQty=least(buyqty-buykeepqty,sellqty-sellkeepqty-deductqty)
                where deductID=p_deductID and wl='W';
            else
                update T_E_DeductDetail set CounteractQty=least(buyqty-buykeepqty,sellqty-sellkeepqty-deductqty)
                where deductID=p_deductID and wl='L';
                update T_E_DeductDetail set CounteractQty=least(buyqty-buykeepqty-deductqty,sellqty-sellkeepqty)
                where deductID=p_deductID and wl='W';
            end if;
        end if;
    elsif(v_losermode=2) then
        if(v_selfcounteract=0) then    --���Գ�
            update T_E_DeductDetail set CounteractQty=0
            where deductID=p_deductID;
        elsif(v_selfcounteract=1) then --ȫ��˫��ֲֶԳ�
            if(v_loserBSflag=1) then
                update T_E_DeductDetail set CounteractQty=least(buyqty-buykeepqty-deductqty,sellqty-sellkeepqty)
                where deductID=p_deductID and wl='L';
                update T_E_DeductDetail set CounteractQty=least(buyqty-buykeepqty,sellqty-sellkeepqty-deductqty)
                where deductID=p_deductID and wl='W';
            else
                update T_E_DeductDetail set CounteractQty=least(buyqty-buykeepqty,sellqty-sellkeepqty-deductqty)
                where deductID=p_deductID and wl='L';
                update T_E_DeductDetail set CounteractQty=least(buyqty-buykeepqty-deductqty,sellqty-sellkeepqty)
                where deductID=p_deductID and wl='W';
            end if;
        else --��������ƽ��ί�еģ�ί������-���ֲ�������Գ�
            if(v_loserBSflag=1) then
                update T_E_DeductDetail set CounteractQty=greatest(least(buyqty-deductqty-buykeepqty,sellqty-sellkeepqty,orderqty-pureholdqty),0)
                where deductID=p_deductID and wl='L';
            else
                update T_E_DeductDetail set CounteractQty=greatest(least(buyqty-buykeepqty,sellqty-sellkeepqty-deductqty,orderqty-(-pureholdqty)),0)
                where deductID=p_deductID and wl='L';
            end if;
        end if;
    end if;

    update T_E_deductposition set deductstatus='P' where deductID=p_deductID;

    commit;
    return 1;
end;
/


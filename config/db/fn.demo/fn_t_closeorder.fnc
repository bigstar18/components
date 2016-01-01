create or replace function FN_T_CloseOrder(
    p_FirmID     varchar2,   --交易商ID
    p_TraderID       varchar2,  --交易员ID
    p_CommodityID varchar2 default null,
    p_bs_flag        number default null,
    p_price          number default null,
    p_quantity       number default null,
    p_closeMode      number default null,
    p_specPrice      number default null,
    p_timeFlag       number default null,
    p_closeFlag      number default null,   --平仓标志
    p_CloseAlgr        number,    --平仓算法(0先开先平；1后开先平；2持仓均价平仓)，指定平仓时会传递此值否则为null
    p_CustomerID     varchar2,  --交易客户ID
    p_ConsignerID       varchar2,  --委托员ID
    p_specialOrderFlag       number  --是否特殊委托(0：正常委托 1：特殊委托) 特殊委托只能和特殊委托成交
) return number
/****
 * 平仓委托
 * 返回值
 * >0  成功提交，并返回委托单号
 * -21  持仓不足
 * -22  指定仓不足
 * -99  不存在相关数据
 * -100 其它错误
****/
as
    v_version varchar2(10):='1.0.2.2';
    v_HoldSum        number(10);   --持仓合计
    v_SpecHoldSum    number(10);   --指定持仓合计
    v_SpecHoldFrozen    number(10);   --当日持仓冻结
    v_A_OrderNo      number(15);   --委托号
    v_OrderType      number(2);    --委托类型
    v_errorcode number;
    v_errormsg  varchar2(200);
    v_sql  varchar2(1000);
    v_str1  varchar2(100);
    v_str2  varchar2(500);
    v_orderby  varchar2(50);
    v_A_HoldNo       number(15);
    v_unCloseQty     number(10):=p_quantity; --未平数量，用于中间计算
    type c_HoldPosition is ref cursor;
    v_HoldPosition c_HoldPosition;
    v_TradeDate date;
begin
    --1、判断总数量，并锁住持仓合计记录
    begin
        select nvl(holdQty - frozenQty, 0) into v_HoldSum
        from T_CustomerHoldSum
        where CustomerID = p_CustomerID
          and CommodityID = p_CommodityID
          and bs_flag != p_bs_flag for update;
    exception
        when NO_DATA_FOUND then
            rollback;
            return -21;  --持仓不足
    end;
    if(v_HoldSum < p_quantity) then
        rollback;
        return -21;  --持仓不足
    end if;
    --取结算日期
    select TradeDate into v_TradeDate from T_SystemStatus;
    --2、判断指定平仓数量
    if(p_closeMode != 1) then
        if(p_closeMode = 2) then  --指定时间平仓
            if(p_timeFlag = 1) then  --平今仓
                --从持仓信息表获得该客户当日该商品持仓合计
                v_str1 := ' and to_char(AtClearDate,''yyyy-MM-dd'')=''' || to_char(v_TradeDate,'yyyy-MM-dd') || ''' ';
            elsif(p_timeFlag = 2) then  --平历史仓
                    --从持仓信息表获得该客户非当日该商品持仓合计
                    v_str1 := ' and to_char(AtClearDate,''yyyy-MM-dd'')<>''' || to_char(v_TradeDate,'yyyy-MM-dd') || ''' ';
            else
                    rollback;
                    Raise_application_error(-20010, 'p_timeFlag ' || p_timeFlag || ' not exist!');
            end if;
        elsif(p_closeMode = 3) then  --指定价格平仓
                    --从持仓信息表获得该客户该价位该商品持仓合计
                    v_str1 := ' and Price =' || p_specPrice;
        else   --未知平仓
                    rollback;
                    Raise_application_error(-20011, 'p_closeMode ' || p_closeMode || ' not exist!');
        end if;
        v_str2 := ' and CustomerID=''' || p_CustomerID || ''' and CommodityID =''' || p_CommodityID || ''' and bs_flag != ' || p_bs_flag || ' ' || v_str1;
        v_sql := 'select nvl(sum(HoldQty),0)  from T_HoldPosition where 1=1 ' || v_str2;
        execute immediate v_sql into v_SpecHoldSum;

        v_sql := 'select nvl(sum(FrozenQty),0) from T_SpecFrozenHold where A_HoldNo in(select A_HoldNo  from T_HoldPosition where 1=1 ' || v_str2 || ')';
        execute immediate v_sql into v_SpecHoldFrozen;
        if(v_SpecHoldSum - v_SpecHoldFrozen < p_quantity) then
            rollback;
            return -22;  --指定仓不足
        end if;
    end if;
    --3、更新交易客户持仓合计的冻结数量
    update T_CustomerHoldSum set frozenQty = frozenQty + p_quantity
    where CustomerID = p_CustomerID
    and CommodityID = p_CommodityID
    and bs_flag != p_bs_flag;
    --4、产生委托单号并插入委托表
	--调用计算函数修改委托单号 2011-2-15 by feijl
    select FN_T_ComputeOrderNo(SEQ_T_Orders.nextval) into v_A_OrderNo from dual;
    insert into T_Orders
      ( a_orderno,  a_orderno_w,   CommodityID,   Firmid,    traderid,   bs_flag,   ordertype, status, quantity, price, closemode, specprice,       timeflag,tradeqty, frozenfunds, unfrozenfunds, ordertime, withdrawtime, ordererip, signature,closeFlag,   CustomerID,ConsignerID,specialOrderFlag)
    values
      (v_A_OrderNo,   null,        p_CommodityID, p_Firmid,  p_traderid, p_bs_flag,     2,        1,  p_quantity, p_price, p_closemode, p_specprice, p_timeflag, 0,        0,              0,         sysdate,      null,       null,     null,  p_closeFlag,p_CustomerID,p_ConsignerID,p_specialOrderFlag);
    --5、指定平仓时冻结持仓单号，委托单号，数量
    if(p_closeMode != 1) then
        v_sql := 'select a.A_HoldNo,(a.HoldQty-nvl(b.FrozenQty,0)) from T_HoldPosition a,(select A_HoldNo,nvl(sum(FrozenQty),0) FrozenQty from T_SpecFrozenHold group by A_HoldNo) b where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and nvl(b.FrozenQty,0)<a.HoldQty ' || v_str2 || ' ' ;
        --根据平仓算法(0先开先平；1后开先平；2持仓均价平仓(不排序)选择排序条件
        if(p_CloseAlgr = 0) then
            v_orderby := ' order by a.A_HoldNo ';
        elsif(p_CloseAlgr = 1) then
            v_orderby := ' order by a.A_HoldNo desc ';
        end if;
        v_sql := v_sql || v_orderby;
        open v_HoldPosition for v_sql;
        loop
            fetch v_HoldPosition into v_A_HoldNo, v_SpecHoldSum;
            exit when v_HoldPosition%NOTFOUND;
            if(v_SpecHoldSum <= v_unCloseQty) then
                v_SpecHoldFrozen := v_SpecHoldSum;
            else
                v_SpecHoldFrozen := v_unCloseQty;
            end if;
            insert into T_SpecFrozenHold(ID,    A_HoldNo,   A_OrderNo,  FrozenQty)
            values(SEQ_T_SpecFrozenHold.nextval,v_A_HoldNo,v_A_OrderNo,v_SpecHoldFrozen);
            v_unCloseQty := v_unCloseQty - v_SpecHoldFrozen;
            exit when v_unCloseQty=0;
        end loop;
        close v_HoldPosition;
    end if;
    commit;
    return v_A_OrderNo;
exception
    when NO_DATA_FOUND then
        rollback;
        return -99;  --不存在相关数据
    when others then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_CloseOrder',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/


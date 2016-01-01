create or replace function FN_T_Withdraw(
    p_WithdrawerID       varchar2,  --撤单员ID
    p_A_OrderNo_W   number,             --被撤单委托单号
    p_WithdrawType  number,              --撤单类型 1:委托撤单；4：闭市时自动撤单
    p_Quantity      number              --撤单成功数量
) return number
/****
 * 撤单
 * 1、如果是自动撤单则撤单员和撤单数量为null
 * 返回值
 * 1 成功
 * 2 已处理过
 * -100 其它错误
****/
as
    v_version varchar2(10):='1.0.0.1';
    v_a_orderno_w    number(15);
    v_status         number(2);
    v_CommodityID varchar2(16);
    v_FirmID     varchar2(32);
    v_CustomerID     varchar2(40);
    v_bs_flag        number(2);
    v_ordertype      number(2);
    v_quantity       number(10);
    v_price          number(15,2);
    v_tradeqty       number(10);
    v_frozenfunds    number(15,2);
    v_unfrozenfunds  number(15,2);
    v_closeMode      number(2);
    v_specPrice      number(15,2);
    v_timeFlag       number(1);
    v_to_unfrozenF   number(15,2);
    v_Margin         number(15,2);   --应收保证金
    v_Fee            number(15,2);   --应收费用
    v_FrozenQty      number(10);
    v_quantity_wd    number(10);
    v_unCloseQty     number(10); --未撤单数量，用于中间计算
    v_tradedAmount   number(10):=0;  --成交数量
    v_id       number(15);
    v_F_FrozenFunds   number(15,2);   --交易商冻结资金
    v_contractFactor T_Commodity.contractfactor%type;
    v_MarginPriceType         number(1);     --计算成交保证金结算价类型 0:实时和闭市时都按开仓价；1:实时按昨结算价，闭市按当日结算价
    v_marginAlgr         number(2);
    v_marginRate_b         number(10,4);
    v_marginRate_s         number(10,4);
    v_feeAlgr       number(2);
    v_feeRate_b         number(15,9);
    v_feeRate_s         number(15,9);
    v_YesterBalancePrice    number(15,2);
    v_BillTradeType number(1); --zhengxuan 仓单交易类型
    v_errorcode number;
    v_errormsg  varchar2(200);
    --当日指定平仓冻结表游标,用来删除冻结的持仓
    cursor c_T_SpecFrozenHold(c_A_OrderNo number) is select ID,FrozenQty from T_SpecFrozenHold where A_OrderNo=c_A_OrderNo order by ID;
begin
    v_a_orderno_w := p_A_OrderNo_W;
    --获取被撤单信息
    select CommodityID, Firmid, bs_flag, ordertype, status, quantity, price, tradeqty, frozenfunds, unfrozenfunds,closeMode,CustomerID,BillTradeType
    into v_CommodityID, v_Firmid, v_bs_flag, v_ordertype, v_status, v_quantity, v_price, v_tradeqty, v_frozenfunds, v_unfrozenfunds,v_closeMode,v_CustomerID,v_BillTradeType
    from T_Orders
    where a_orderno = v_a_orderno_w for update;

    if(v_status in (3,5,6)) then
        rollback;
        return 2;  --已处理过
    end if;

    if(p_WithdrawType = 4) then --自动撤单
        v_quantity_wd := v_quantity - v_tradeqty;
    else
        v_quantity_wd := p_Quantity;
    end if;
    if(v_ordertype=1) then    --开仓
        if(v_quantity - v_tradeQty = v_quantity_wd) then
            v_to_unfrozenF := v_frozenfunds - v_unfrozenfunds;
        else
            --获取商品信息
            select contractfactor,MarginPriceType,marginalgr,marginrate_b,marginrate_s,feealgr,feerate_b,feerate_s,LastPrice
            into v_contractFactor,v_MarginPriceType,v_marginAlgr,v_marginRate_b,v_marginRate_s,v_feeAlgr,v_feeRate_b,v_feeRate_s,v_YesterBalancePrice
            from T_Commodity where CommodityID=v_CommodityID;
            if(v_MarginPriceType = 1) then
                v_price := v_YesterBalancePrice;
            end if;
            --获取特户的交易保证金，保证金算法
            begin
                select marginalgr,marginrate_b,marginrate_s
                into v_marginAlgr,v_marginRate_b,v_marginRate_s
                from T_A_FirmMargin
                where FirmID=v_FirmID and CommodityID=v_CommodityID;
            exception
                when NO_DATA_FOUND then
                    null;
            end;

            --获取交易商对应套餐手续费系数，手续费算法
            begin
                select feealgr,feerate_b,feerate_s
                into v_feeAlgr,v_feeRate_b,v_feeRate_s
                from T_A_Tariff
                where TariffID=(select TariffID from t_firm where FirmID=v_FirmID) and CommodityID=v_CommodityID;

            exception
                when NO_DATA_FOUND then
                    null;
            end;

            --获取特户的交易手续费，手续费算法
            begin
                select feealgr,feerate_b,feerate_s
                into v_feeAlgr,v_feeRate_b,v_feeRate_s
                from T_A_FirmFee
                where FirmID=v_FirmID and CommodityID=v_CommodityID;
            exception
                when NO_DATA_FOUND then
                    null;
            end;
            -- tangzy 20100612 撤销卖仓单委托，不计算保证金；
            --开始
            if(v_BillTradeType = 1) then
                 v_Margin := 0;
            else
                 v_Margin := FN_T_ComputeMarginByArgs(v_bs_flag,v_quantity_wd,v_price,v_contractFactor,v_marginAlgr,v_marginRate_b,v_marginRate_s);
            end if;
            --结束
            if(v_Margin < 0) then
                Raise_application_error(-20040, 'computeMargin error');
            end if;
            v_Fee := FN_T_ComputeFeeByArgs(v_bs_flag,v_quantity_wd,v_price,v_contractFactor,v_feeAlgr,v_feeRate_b,v_feeRate_s);
            if(v_Fee < 0) then
                Raise_application_error(-20030, 'computeFee error');
            end if;
            v_to_unfrozenF := v_Margin + v_Fee;

        end if;
        -- tangzy 20100612 撤销卖仓单委托 生效仓单抵顶表释放冻结数量;
        --开始
        if(v_BillTradeType = 1) then
             update T_ValidGageBill set Frozenqty=Frozenqty-v_quantity_wd where FirmID=v_FirmID
                    and CommodityID=v_CommodityID;
                    --BreedID=(select BreedID from t_commodity where CommodityID=v_CommodityID);
        end if;
        --结束
        update T_Orders set unfrozenfunds = unfrozenfunds + v_to_unfrozenF
        where A_orderNo = v_a_orderno_w;
        --更新冻结资金
            v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,-v_to_unfrozenF,'15');
    elsif(v_ordertype=2) then    --平仓
        --zhengxuan 释放交易客户持仓合计表抵顶冻结数量；
        --开始
        if(v_BillTradeType = 2) then
           update T_CustomerHoldSum set GageFrozenQty = GageFrozenQty-v_quantity_wd
               where customerid = v_CustomerID and commodityid = v_CommodityID and bs_flag != v_bs_flag;
        else
           update T_CustomerHoldSum set frozenQty = frozenQty - v_quantity_wd
           where CustomerID = v_CustomerID
           and CommodityID = v_CommodityID
           and bs_flag != v_bs_flag;
        --指定平仓时要更新当日指定平仓冻结表中冻结的持仓，不能直接从此表中删除此委托号的记录，因为存在成交回报在撤单回报之后，会造成成交失败
           if(v_closeMode <> 1) then
                    v_unCloseQty := v_quantity_wd;
                  open c_T_SpecFrozenHold(v_a_orderno_w);
                    loop
                        fetch c_T_SpecFrozenHold into v_id,v_FrozenQty;
                        exit when c_T_SpecFrozenHold%notfound;
                        if(v_FrozenQty <= v_unCloseQty) then
                            v_tradedAmount:=v_FrozenQty;
                            delete from T_SpecFrozenHold where id=v_id;
                    else
                            v_tradedAmount:=v_unCloseQty;
                            update T_SpecFrozenHold set FrozenQty=FrozenQty-v_tradedAmount where id=v_id;
                    end if;
                    v_unCloseQty:=v_unCloseQty - v_tradedAmount;
                    exit when v_unCloseQty=0;
                       end loop;
                close c_T_SpecFrozenHold;
           end if;
        end if;
        --结束
    end if;

    --更新说明，1、对于委托撤单和本地撤单需要更新被撤委托的状态（5、6）和撤单类型（1、2），撤单委托的状态（7）和撤单类型（1、2）
    --        2、对于自动撤单需要更新被撤委托的状态（5、6）和撤单类型（3、4）
    if(p_WithdrawType = 4) then --自动撤单
          --更新委托状态
          if(v_tradeqty = 0) then
            v_status := 5; --全部撤单
          else
            v_status := 6; --部分成交后撤单
          end if;

    else
        --更新委托状态
        if(v_quantity = v_quantity_wd) then
            v_status := 5; --全部撤单
        elsif(v_quantity > v_quantity_wd) then
            v_status := 6; --部分成交后撤单
        else
            Raise_application_error(-20020, 'Parameter p_quantity > the order ''s available num');
        end if;

    end if;
      update T_Orders set status=v_status,WithdrawType=p_WithdrawType,WithdrawTime=sysdate,WithdrawerID=p_WithdrawerID,UpdateTime=systimestamp(3) where A_orderNo = v_a_orderno_w;
    commit;
    return 1;
exception
    when others then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_Withdraw',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/


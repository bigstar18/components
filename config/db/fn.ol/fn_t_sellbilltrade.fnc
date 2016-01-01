create or replace function FN_T_SellBillTrade (
    p_A_OrderNo     number,  --委托单号
    p_M_TradeNo     number,  --撮合成交号
    p_Price         number,  --成交价
    p_Quantity      number,   --成交数量
	  p_M_TradeNo_Opp     number,  --对方撮合成交号
    p_CommodityID varchar2,
    p_FirmID     varchar2,
    p_TraderID       varchar2,
    p_bs_flag        number,
    p_status         number,
    p_orderQty       number,--委托数量
    p_orderPrice          number,--委托价格
    p_orderTradeQty       number,--委托已成交数量
    p_frozenfunds    number,
    p_unfrozenfunds  number,
    p_CustomerID        varchar2,
    p_OrderType      number,
    p_contractFactor number,
	  p_MarginPriceType         number,     --计算成交保证金结算价类型 0:实时和闭市时都按开仓价；1:实时按昨结算价，闭市按当日结算价；2:盘中按订立价，闭市结算时按当日结算价；
    p_marginAlgr         number,
    p_marginRate_b         number,
    p_marginRate_s         number,
    p_marginAssure_b         number,
    p_marginAssure_s         number,
    p_feeAlgr       number,
    p_feeRate_b         number,
    p_feeRate_s         number,
    p_YesterBalancePrice    number,
    p_GageMode    number,
    p_TradeDate date,
    p_FirmID_opp     varchar2
) return number
/****
 * 卖仓单成交回报
 * 1、注意不要提交commit，因为别的函数要调用它；
 * 返回值
 * 1 成功
 * -1 成交数量大于未成交数量
 * -100 其它错误
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_num            number(10);
    v_to_unfrozenF   number(15,2):=0;
    v_Margin         number(15,2):=0;   --应收保证金
	v_Assure         number(15,2):=0;   --应收担保金
    v_Fee            number(15,2):=0;   --应收费用
    v_frozenMargin   number(15,2);   --应收保证金
    v_frozenFee      number(15,2);   --应收费用
    v_A_TradeNo      number(15);
    v_A_HoldNo       number(15);
    v_MarginPrice    number(15,2);  --计算成交保证金的价格
	v_unfrozenPrice    number(15,2);  --计算释放冻结保证金，手续费的价格
    v_TradeType      number(1);
	v_F_FrozenFunds   number(15,2);
begin
      --计算保证金价格
	  if(p_MarginPriceType = 1) then
	      v_MarginPrice := p_YesterBalancePrice;
	  else  -- default type is 0
		  v_MarginPrice := p_Price;
	  end if;
    --zhengxuan 增加的成交记录成交类型为卖仓单；
    v_TradeType := 7;  --类型为卖仓单

    if(p_Quantity = p_orderQty - p_orderTradeQty) then
        v_to_unfrozenF := p_frozenfunds - p_unfrozenfunds;
        --更新委托
        update T_Orders
        set unfrozenfunds=unfrozenfunds + v_to_unfrozenF,
            tradeqty=tradeqty + p_Quantity,
            Status=3,UpdateTime=systimestamp(3)
        where A_orderNo = p_A_OrderNo;
    elsif(p_Quantity < p_orderQty - p_orderTradeQty) then
        if(p_MarginPriceType = 1) then
            v_unfrozenPrice := p_YesterBalancePrice;
        else  -- default type is 0
         v_unfrozenPrice := p_orderPrice;
        end if;
        --zhengxuan 释放卖仓单委托冻结手续费
        v_frozenMargin := 0 ;
        --FN_T_ComputeMarginByArgs(p_bs_flag,p_Quantity,v_unfrozenPrice,p_contractFactor,p_marginAlgr,p_marginRate_b,p_marginRate_s);
        if(v_frozenMargin < 0) then
            Raise_application_error(-20040, 'computeMargin error');
        end if;
        v_frozenFee := FN_T_ComputeFeeByArgs(p_bs_flag,p_Quantity,v_unfrozenPrice,p_contractFactor,p_feeAlgr,p_feeRate_b,p_feeRate_s);
        if(v_frozenFee < 0) then
            Raise_application_error(-20030, 'computeFee error');
        end if;
        v_to_unfrozenF := v_frozenMargin + v_frozenFee;
        --更新委托
        if(p_status = 6) then  --状态为部分成交后撤单，如果部分成交回报在撤单回报之后，不用再更新状态了
           update T_Orders
           set unfrozenfunds=unfrozenfunds + v_to_unfrozenF,
               tradeqty=tradeqty + p_Quantity,UpdateTime=systimestamp(3)
           where A_orderNo = p_A_OrderNo;
        else
           update T_Orders
           set unfrozenfunds=unfrozenfunds + v_to_unfrozenF,
               tradeqty=tradeqty + p_Quantity,Status=2,UpdateTime=systimestamp(3)
           where A_orderNo = p_A_OrderNo;
        end if;
    else
        rollback;
        return -1;
    end if;
    --计算成交后应扣除的手续费
    v_Fee := FN_T_ComputeFeeByArgs(p_bs_flag,p_Quantity,p_Price,p_contractFactor,p_feeAlgr,p_feeRate_b,p_feeRate_s);
    if(v_Fee < 0) then
      Raise_application_error(-20030, 'computeFee error');
    end if;
    --插入成交记录
	--调用计算函数修改成交单号 2011-2-15 by feijl
    select FN_T_ComputeTradeNo(SEQ_T_Trade.nextval) into v_A_TradeNo from dual;
    insert into T_Trade
      (a_tradeno,    m_tradeno, a_orderno,   tradetime, Firmid, CommodityID,   bs_flag,    ordertype,     price, quantity, close_pl, tradefee,TradeType,CustomerID,M_TradeNo_Opp,TradeAtClearDate,oppFirmid)
    values
      (v_A_TradeNo, p_M_TradeNo, p_A_OrderNo, sysdate, p_FirmID, p_CommodityID,p_bs_flag, p_OrderType,   p_price, p_quantity, 0,       v_Fee,v_TradeType,p_CustomerID,p_M_TradeNo_Opp,p_TradeDate,p_FirmID_opp);

		-- zhengxuan 计算保证金 不算保证金  保证金为0
    v_Margin := 0;
    --FN_T_ComputeMarginByArgs(p_bs_flag,p_Quantity,v_MarginPrice,p_contractFactor,p_marginAlgr,p_marginRate_b,p_marginRate_s);
    if(v_Margin < 0) then
        Raise_application_error(-20040, 'computeMargin error');
    end if;
    --zhengxuan 计算担保金 不算担保金  担保金为0
    v_Assure := 0;
    --FN_T_ComputeAssureByArgs(p_bs_flag,p_Quantity,v_MarginPrice,p_contractFactor,p_marginAlgr,p_marginAssure_b,p_marginAssure_s);
    if(v_Assure < 0) then
        Raise_application_error(-20041, 'computeAssure error');
    end if;
    --保证金应加上担保金
    v_Margin := v_Margin + v_Assure;

    --插入持仓明细表
    --zhengxuan  持仓保证金，担保金都是0；
	--调用计算函数修改持仓单号 2011-2-15 by feijl
    select FN_T_ComputeHoldNo(SEQ_T_HoldPosition.nextval) into v_A_HoldNo from dual;
    insert into T_Holdposition
      (a_holdno,    a_tradeno,  CommodityID,    CustomerID , bs_flag,   price,    holdqty,    openqty, holdtime,HoldMargin,HoldAssure,Firmid,FloatingLoss,AtClearDate,gageQty)
    values
      (v_A_HoldNo, v_A_TradeNo, p_CommodityID, p_CustomerID, p_bs_flag, p_price, 0       ,p_quantity, sysdate,      0   ,   0      ,    p_FirmID,   0,     p_TradeDate,p_quantity);

    --更新交易客户持仓合计表
    --zhengxuan  持仓保证金，担保金都是0；
    select count(*) into v_num from T_CustomerHoldSum
    where CustomerID = p_CustomerID
      and CommodityID = p_CommodityID
      and bs_flag = p_bs_flag;
    if(v_num >0) then
        update T_CustomerHoldSum
        set holdQty = holdQty + 0,
        holdFunds = holdFunds + p_Price*p_Quantity*p_contractFactor,
        HoldMargin = HoldMargin + 0,
        HoldAssure = HoldAssure + 0,
        evenprice = (holdFunds + p_Price*p_Quantity*p_contractFactor)/((holdQty + GageQty + p_Quantity)*p_contractFactor),
         gageQty = gageQty+p_Quantity
        where CustomerID = p_CustomerID
        and CommodityID = p_CommodityID
        and bs_flag = p_bs_flag;
    else
        insert into T_CustomerHoldSum
              (CustomerID  , CommodityID  , bs_flag  , holdQty,         holdFunds                  ,FloatingLoss, evenprice,FrozenQty,HoldMargin,HoldAssure,FirmID  ,gageQty)
        values
              (p_CustomerID, p_CommodityID, p_bs_flag,    0   , p_Price*p_Quantity*p_contractFactor,    0       , p_Price  ,     0   ,     0    ,    0     ,p_FirmID,p_Quantity);
    end if;

    --更新交易商持仓合计表
    --zhengxuan 持仓保证金，担保金都是0 ；
    select count(*) into v_num from T_FirmHoldSum
    where Firmid = p_FirmID
    and CommodityID = p_CommodityID
    and bs_flag = p_bs_flag;

    if(v_num >0) then
        update T_FirmHoldSum
        set holdQty = holdQty + 0,
        holdFunds = holdFunds + decode(p_GageMode,1,p_Price*p_Quantity*p_contractFactor,0),--持仓金额
        HoldMargin = HoldMargin + 0,
        HoldAssure = HoldAssure + 0,
        evenprice = decode(holdQty + decode(p_GageMode,1,p_Quantity,0) + decode(p_GageMode,1,GageQty,0), 0,
                  0,
                  (holdFunds +decode(p_GageMode,1,p_Price*p_Quantity*p_contractFactor,0))/((holdQty + decode(p_GageMode,1,p_Quantity,0) + decode(p_GageMode,1,GageQty,0))*p_contractFactor) ), --均价
        gageQty = gageQty+p_Quantity
        where Firmid = p_FirmID
        and CommodityID = p_CommodityID
        and bs_flag = p_bs_flag;
    else
      insert into T_FirmHoldSum
        (FirmID  , CommodityID  ,   bs_flag, holdQty,                       holdFunds                           ,FloatingLoss,        evenprice                ,HoldMargin,HoldAssure,gageQty)
      values
        (p_FirmID, p_CommodityID, p_bs_flag,   0   , decode(p_GageMode,1,p_Price*p_Quantity*p_contractFactor,0) ,     0      ,   decode(p_GageMode,1,p_Price,0),  0       ,  0       ,p_Quantity);
    end if;

    --更新临时保证金和临时担保金
    update T_Firm
    set runtimemargin = runtimemargin + v_Margin,
        RuntimeAssure = RuntimeAssure + v_Assure
    where Firmid = p_FirmID;
    --更新冻结资金，包括个人部分的保证金
    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,-v_to_unfrozenF+v_Margin-v_Assure+v_Fee,'15');

    --zhengxuan 生效仓单抵顶表释放冻结数量并减少总数量；
    update T_ValidGageBill set Quantity=Quantity-p_Quantity,Frozenqty=Frozenqty-p_Quantity where FirmID=p_FirmID
           and CommodityID=p_CommodityID; --BreedID=(select BreedID from t_commodity where CommodityID=p_CommodityID);
    return 1;
end;
/


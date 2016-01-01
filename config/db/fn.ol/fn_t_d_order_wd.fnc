create or replace function FN_T_D_Order_WD(
	p_WithdrawerID       varchar2,  --撤单员ID
    p_A_OrderNo_W   number,             --被撤单委托单号
    p_WithdrawType  number,  			--撤单类型 1:委托撤单；4：闭市时自动撤单
    p_Quantity      number,              --撤单成功数量，如果是-1表示现查委托表来计算撤单数量
	p_DelayQuoShowType       number  --延期行情显示类型，0：交收申报结束和中立仓申报结束显示； 1：实时显示；
) return number
/****
 * 延期交易委托撤单
 * 1、如果是自动撤单则撤单员和撤单数量为null
 * 返回值
 * 1 成功
 * 2 已处理过
 * -99  不存在相关数据
 * -100 其它错误
****/
as
    v_version varchar2(10):='1.0.2.3';
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
    v_quantity_wd    number(10);
    v_ret  number(4);
    v_errorcode number;
    v_errormsg  varchar2(200);
begin
    v_a_orderno_w := p_A_OrderNo_W;
    --获取被撤单信息
    select CommodityID, Firmid, bs_flag, DelayOrderType, status, quantity, price, tradeqty, frozenfunds, unfrozenfunds,CustomerID
    into v_CommodityID, v_FirmID, v_bs_flag, v_ordertype, v_status, v_quantity, v_price, v_tradeqty, v_frozenfunds, v_unfrozenfunds,v_CustomerID
    from T_DelayOrders
    where a_orderno = v_a_orderno_w for update;

    if(v_status in (3,5,6)) then
        rollback;
        return 2;  --已处理过
    end if;

    if(p_WithdrawType = 4) then --自动撤单
    	v_quantity_wd := v_quantity - v_tradeqty;
    else
    	if(p_Quantity = -1) then  ---1表示现查委托表来计算撤单数量
    		v_quantity_wd := v_quantity - v_tradeqty;
    	else
        	v_quantity_wd := p_Quantity;
        end if;
    end if;
    if(v_ordertype=1) then    --交收申报
    	if(v_bs_flag = 1) then  --买
    		v_ret := FN_T_D_BuySettleOrder_WD(v_FirmID,v_CustomerID,v_CommodityID,v_Quantity,v_TradeQty,v_Price,v_A_OrderNo_W,v_quantity_wd,v_frozenfunds,v_unfrozenfunds);
    	else  --卖
            v_ret := FN_T_D_SellSettleOrder_WD(v_FirmID,v_CustomerID,v_CommodityID,v_Quantity,v_TradeQty,v_Price,v_A_OrderNo_W,v_quantity_wd,v_frozenfunds,v_unfrozenfunds);
    	end if;
    elsif(v_ordertype=2) then    --中立仓申报
    	-- add by tangzy 2010-08-07
		if(v_bs_flag = 1) then
            v_ret := FN_T_D_BuyNeutralOrder_WD(v_FirmID,v_CustomerID,v_CommodityID,v_Quantity,v_TradeQty,v_Price,v_A_OrderNo_W,v_quantity_wd,v_frozenfunds,v_unfrozenfunds);
		else
		    v_ret := FN_T_D_SellNeutralOrder_WD(v_FirmID,v_CustomerID,v_CommodityID,v_Quantity,v_TradeQty,v_Price,v_A_OrderNo_W,v_quantity_wd,v_frozenfunds,v_unfrozenfunds);
		end if;
    end if;

    --更新委托，1、对于委托撤单需要更新被撤委托的状态（5、6）和撤单类型（1、2）
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
	update T_DelayOrders set status=v_status,WithdrawType=p_WithdrawType,WithdrawTime=sysdate,WithdrawerID=p_WithdrawerID where A_orderNo = v_a_orderno_w;
    --行情实时显示则要更新行情
    --2010-01-21 解决自动撤单时不影响延期行情
    if(p_WithdrawType=1 and p_DelayQuoShowType = 1) then
	    if(v_ordertype=1) then    --交收申报
	    	if(v_bs_flag = 1) then  --买
	    		update T_DelayQuotation set BuySettleQty=BuySettleQty - v_quantity_wd,CreateTime=sysdate where CommodityID = v_CommodityID;
	    	else  --卖
	    		update T_DelayQuotation set SellSettleQty=SellSettleQty - v_quantity_wd,CreateTime=sysdate where CommodityID = v_CommodityID;
	    	end if;
	    elsif(v_ordertype=2) then    --中立仓申报
	    	-- add by tangzy 2010-08-07
			if(v_bs_flag = 1) then  --买
	    		update T_DelayQuotation set BuyNeutralQty=BuyNeutralQty - v_quantity_wd,CreateTime=sysdate where CommodityID = v_CommodityID;
	    	else  --卖
	    		update T_DelayQuotation set SellNeutralQty=SellNeutralQty - v_quantity_wd,CreateTime=sysdate where CommodityID = v_CommodityID;
	    	end if;
	    end if;
    end if;

    commit;
    return 1;

exception
    when NO_DATA_FOUND then
        rollback;
        return -99;  --不存在相关数据
    when others then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_D_Order_WD',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/


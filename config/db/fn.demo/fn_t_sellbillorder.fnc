create or replace function FN_T_SellBillOrder(
    p_FirmID     varchar2,  --交易商ID
    p_TraderID       varchar2,  --交易员ID
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_price          number,
    p_quantity       number,
  --p_Margin     number,     --委托应收保证金
    p_Fee   number,   --委托应收手续费
	p_CustomerID     varchar2,  --交易客户ID
	p_ConsignerID       varchar2 --委托员ID

) return number
/****
 * 卖仓单委托
 * 返回值
 * >0  成功提交，并返回委托单号
 * -1  资金余额不足
 * -2  超过交易商对此商品的最大订货量
 * -3  超过交易商总的最大订货量
 * -4  超过品种最大订货量
 * -5  超过商品最大订货量
 * -6  超过交易商对此商品的最大净订货量
 * -7  超过单笔最大委托量（改在java中判断）2009-09-18
 * -8  抵顶数量大于可用数量
 * -9  没有对应的生效仓单抵顶记录
 * -99  不存在相关数据
 * -100 其它错误
****/
as
	--v_version varchar2(10):='1.0.0.9';
    v_F_Funds        number(15,2):=0;   --应冻结资金
    v_VirtualFunds   number(15,2);   --虚拟资金
    v_A_Funds        number(15,2);   --可用资金
    v_HoldSum        number(15,0);   --持仓合计
	v_HoldSum_b        number(15,0);   --持仓合计b
	v_HoldSum_s        number(15,0);   --持仓合计s
    v_A_OrderNo      number(15,0);   --委托号
    v_NotTradeSum    number(15,0);   --开仓未成交合计
	v_NotTradeSum_b    number(15,0);   --开仓未成交合计b
	v_NotTradeSum_s    number(15,0);   --开仓未成交合计s
	v_BreedID      number(10,0);
	v_LimitBreedQty      number(10,0);
	v_LimitCmdtyQty      number(10,0);
	v_FirmCleanQty      number(10,0);
	v_FirmMaxHoldQty      number(10,0);
	v_MaxHoldQty      number(10,0); --交易商最大订货量
	v_MaxOverdraft        number(15,2):=0;   --最大透支额度
	v_F_FrozenFunds   number(15,2);   --冻结资金
    v_errorcode number;
    v_errormsg  varchar2(200);
  v_AvailableQuantity number(10);--可用数量 add by yukx 20100507
begin

      begin
        select Quantity-FrozenQty into v_AvailableQuantity from T_ValidGageBill
        where FirmID=p_FirmID
          and CommodityID = p_CommodityID;
          --and BreedID=(select BreedID from t_commodity where CommodityID=p_CommodityID);
        exception
          when NO_DATA_FOUND then
  	      return -9;--没有对应的生效仓单抵顶记录
      end;

      if(v_AvailableQuantity<p_Quantity) then
        return -8;--抵顶数量大于可用数量
      end if;

        --应冻结资金
        --zhengxuan 改为应冻结手续费不冻结保证金
        --v_F_Funds := p_Margin + p_Fee;
        v_F_Funds :=  p_Fee;

        --获得虚拟资金
        select VirtualFunds,MaxHoldQty,MaxOverdraft into v_VirtualFunds,v_MaxHoldQty,v_MaxOverdraft from T_Firm where FirmID = p_FirmID;
        --计算可用资金，并锁住财务资金
        v_A_Funds := FN_F_GetRealFunds(p_FirmID,1) + v_VirtualFunds + v_MaxOverdraft;
        if(v_A_Funds < v_F_Funds) then
            rollback;
            return -1;  --资金余额不足
        else
            --1、验证是否超过交易商总的最大持仓量
			if(v_MaxHoldQty <> -1) then
				select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum
	            from T_Orders
	            where FirmID = p_FirmID
				and OrderType=1 and Status in(1,2);

	            select nvl(sum(holdqty+GageQty),0) into v_HoldSum
	            from T_FirmHoldSum
	            where FirmID = p_FirmID;

	            if(v_HoldSum + v_NotTradeSum + p_quantity > v_MaxHoldQty) then
	                rollback;
	                return -3;  --超过总的最大持仓量
	            end if;
			end if;
			--在品种和商品属性中获取品种最大订货量，商品最大订货量，交易商最大净订货量，交易商最大订货量
			select a.BreedID,a.LimitBreedQty,b.LimitCmdtyQty,b.FirmCleanQty,b.FirmMaxHoldQty into v_BreedID,v_LimitBreedQty,v_LimitCmdtyQty,v_FirmCleanQty,v_FirmMaxHoldQty
			from T_A_Breed a,T_Commodity b
			where a.BreedID=b.BreedID and b.CommodityID=p_CommodityID;
			--获取交易商特殊订货量
		    begin
		        select CleanMaxHoldQty,MaxHoldQty
		    	into v_FirmCleanQty,v_FirmMaxHoldQty
		        from T_A_FirmMaxHoldQty
		        where FirmID=p_FirmID and CommodityID=p_CommodityID;
		    exception
		        when NO_DATA_FOUND then
		            null;
		    end;
			--2、验证是否超过品种最大订货量
			if(v_LimitBreedQty <> -1) then
	            select nvl(sum(a.Quantity-a.TradeQty),0) into v_NotTradeSum
	            from T_Orders a,T_Commodity b
	            where a.CommodityID=b.CommodityID and b.BreedID=v_BreedID
				and a.OrderType=1 and a.BS_Flag=p_bs_flag and a.Status in(1,2);

	            select nvl(sum(a.holdqty+a.GageQty),0) into v_HoldSum
	            from T_FirmHoldSum a,T_Commodity b
	            where a.CommodityID=b.CommodityID and b.BreedID=v_BreedID and a.BS_Flag=p_bs_flag;
	            if(v_HoldSum + v_NotTradeSum + p_quantity > v_LimitBreedQty) then
	                rollback;
	                return -4;  --超过品种最大订货量
	            end if;
			end if;
            --3、验证是否超过商品最大订货量
			if(v_LimitCmdtyQty <> -1) then
	            select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum
	            from T_Orders
	            where CommodityID=p_CommodityID
				and OrderType=1 and BS_Flag=p_bs_flag and Status in(1,2);

	            select nvl(sum(holdqty+GageQty),0) into v_HoldSum
	            from T_FirmHoldSum
	            where CommodityID=p_CommodityID and BS_Flag=p_bs_flag;
	            if(v_HoldSum + v_NotTradeSum + p_quantity > v_LimitCmdtyQty) then
	                rollback;
	                return -5;  --超过商品最大订货量
	            end if;
			end if;
            --4、验证是否超过交易商对此商品的最大订货量
			if(v_FirmMaxHoldQty <> -1) then
	            select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum
	            from T_Orders
	            where FirmID = p_FirmID and CommodityID=p_CommodityID
				and OrderType=1 and Status in(1,2);

	            select nvl(sum(holdqty+GageQty),0) into v_HoldSum
	            from T_FirmHoldSum
	            where FirmID = p_FirmID and CommodityID=p_CommodityID;

	            if(v_HoldSum + v_NotTradeSum + p_quantity > v_FirmMaxHoldQty) then
	                rollback;
	                return -2;  --超过交易商对此商品的最大订货量
	            end if;
			end if;
            --5、验证是否超过交易商对此商品的最大净订货量
			if(v_FirmCleanQty <> -1) then
	            select nvl(sum(holdqty+GageQty),0) into v_HoldSum_b
	            from T_FirmHoldSum
	            where FirmID = p_FirmID and CommodityID=p_CommodityID and BS_Flag=1;
	            select nvl(sum(holdqty+GageQty),0) into v_HoldSum_s
	            from T_FirmHoldSum
	            where FirmID = p_FirmID and CommodityID=p_CommodityID and BS_Flag=2;
	            if(p_bs_flag = 1) then
		            select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum_b
		            from T_Orders
		            where FirmID = p_FirmID and CommodityID=p_CommodityID and BS_Flag=1
					and OrderType=1 and Status in(1,2);
		            if(v_HoldSum_b + v_NotTradeSum_b + p_quantity - v_HoldSum_s > v_FirmCleanQty) then
		                rollback;
		                return -6;  --超过交易商对此商品的最大净订货量
		            end if;
		        else
		            select nvl(sum(Quantity-TradeQty),0) into v_NotTradeSum_s
		            from T_Orders
		            where FirmID = p_FirmID and CommodityID=p_CommodityID and BS_Flag=2
					and OrderType=1 and Status in(1,2);
		            if(v_HoldSum_s + v_NotTradeSum_s + p_quantity - v_HoldSum_b > v_FirmCleanQty) then
		                rollback;
		                return -6;  --超过交易商对此商品的最大净订货量
		            end if;
	            end if;
			end if;

       -- zhengxuan 增加生效仓单抵顶表冻结数量
       update T_ValidGageBill set Frozenqty=Frozenqty+p_quantity where FirmID=p_FirmID
               and CommodityID=p_CommodityID; --BreedID=(select BreedID from t_commodity where CommodityID=p_CommodityID);

        end if;

        --更新冻结资金
		v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,v_F_Funds,'15');
		--插入委托表，并返回委托单号
		--调用计算函数修改委托单号 2011-2-15 by feijl
	    select FN_T_ComputeOrderNo(SEQ_T_Orders.nextval) into v_A_OrderNo from dual;
	    --zhengxuan 增加仓单交易类型
      insert into T_Orders
	      (a_orderno,a_orderno_w, CommodityID, Firmid, traderid,    bs_flag, ordertype, status, quantity, price, closemode, specprice, timeflag, tradeqty, frozenfunds, unfrozenfunds, ordertime, withdrawtime, ordererip, signature, CustomerID,ConsignerID,BillTradeType)
	    values
	      (v_A_OrderNo,  null, p_CommodityID, p_Firmid, p_traderid, p_bs_flag,    1 ,      1, p_quantity, p_price, null,     null,      null,    0,         v_F_Funds,     0,           sysdate,      null,        null,     null,p_CustomerID,p_ConsignerID,  1    );
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
    values(sysdate,'FN_T_SellBillOrder',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/


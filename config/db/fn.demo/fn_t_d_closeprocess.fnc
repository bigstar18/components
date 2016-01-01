create or replace function FN_T_D_CloseProcess return number
/****
 * 延期交易结算处理
 * 返回值
 * 1  成功提交
 * 修改延期补偿费按买卖收取 2011-09-20 by chenxc
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_DelayRecoupRate        number(7,5);   --买方延期补偿比例
	v_DelayRecoupRate_S        number(7,5);   --卖方延期补偿比例,2011-09-05 by chenxc
    v_ContractFactor    number(12,2);   --合约因子
    v_DelayFeeWay    number(2);   --延期费收取方式
    v_DelayFunds      number(20,6):=0;   --延期补偿费
    v_Price      number(10,2);   --行情结算价
    v_ChargeDelayFund  number(15,2); --收延期费
    v_PayDelayFund       number(15,2); --付延期费
    v_DiffFund      number(15,2); --风险准备金
    v_Balance      number(15,2); --可用资金
    v_TradeDate date;
    v_DelayDays    number(5);   --延期天数
    v_errorcode number;
    v_errormsg  varchar2(200);
    v_StoreFunds number(20,6):=0;   --仓储补偿费
    v_StoreRecoupRate number(7,5);   --仓储补偿比例
begin
	--0、计算延期天数
	v_DelayDays := FN_T_D_ComputeDelayDays();
	--1、轮询商品计算延期补偿费＝交收申报差×合约因子×当日结算价×补偿比率
    for delayOrder in(select CommodityID,max(BS_Flag) BS_Flag,nvl(sum(DiffQty),0) DiffQty
                      from ((select CommodityID,max(decode(BS_Flag,1,2,1)) BS_Flag,nvl(sum(Quantity-TradeQty),0) DiffQty from T_DelayOrders where DelayOrderType=1 and Status in(5,6) and WithdrawType=4 group by CommodityID) union all
                           (select  CommodityID,max(BS_Flag) BS_Flag,nvl(sum(TradeQty),0) DiffQty from T_DelayOrders where DelayOrderType=2  group by CommodityID))
                      group by CommodityID)
    loop
    	select StoreRecoupRate,DelayRecoupRate,DelayRecoupRate_S,ContractFactor,DelayFeeWay into v_StoreRecoupRate, v_DelayRecoupRate,v_DelayRecoupRate_S,v_ContractFactor,v_DelayFeeWay from T_Commodity where CommodityID = delayOrder.CommodityID;
    	select Price into v_Price from T_Quotation where CommodityID = delayOrder.CommodityID;
    	if(v_DelayFeeWay = 1) then  --按自然日逐日收取
			--如果收买方的补偿费，则把卖方补偿比率赋给买方补偿比率，delayOrder.BS_Flag是指收交易商补偿费的方向，而不是付给交易商补偿费方向,2011-09-05 by chenxc
			if(delayOrder.BS_Flag = 1) then
				v_DelayRecoupRate := v_DelayRecoupRate_S;
			end if;
    		v_DelayFunds := delayOrder.DiffQty * v_ContractFactor * v_Price * v_DelayRecoupRate * v_DelayDays;
    		-- 增加仓储补偿费功能,当卖方大于买方数量时才收取即延期费方向等于买方 2011-2-23 by feijl
			if (delayOrder.BS_Flag = 1) then
			    v_StoreFunds := delayOrder.DiffQty * v_ContractFactor * v_StoreRecoupRate * v_DelayDays;
			else
			    v_StoreFunds := 0;
			end if;
			--2、收延期费
    		v_ChargeDelayFund := FN_T_D_ChargeDelayFund(delayOrder.CommodityID,delayOrder.BS_Flag,v_DelayFunds+v_StoreFunds);
    		--3、付延期费
    		v_PayDelayFund := FN_T_D_PayDelayFund(delayOrder.CommodityID,v_DelayFunds+v_StoreFunds);
    		/*
    		if(v_ChargeDelayFund < v_PayDelayFund) then
    			rollback;
    			return -1;--延期费收取不足
    		end if;
    		--4、多的钱计入风险准备金，改在财务中做
    		v_DiffFund := v_ChargeDelayFund - v_PayDelayFund;
    		if(v_DiffFund > 0) then
		        --付风险金 ，并写流水
	    		v_Balance := FN_F_UpdateFundsFull(null,'15022',v_DiffFund,null,delayOrder.CommodityID,null,null);
    		end if;
    		*/
    	end if;

    end loop;

	--5、获取结算日期
	select TradeDate into v_TradeDate from T_SystemStatus;
    --6、导入历史延期委托表并删除当日数据
    insert into T_H_DelayOrders select v_TradeDate,a.* from T_DelayOrders a;
    delete from T_DelayOrders;
    --7、导入历史延期成交表并删除当日数据
    insert into T_H_DelayTrade select v_TradeDate,a.* from T_DelayTrade a;
    delete from T_DelayTrade;
    --8、删除历史当日数据并导入历史延期行情
	delete from T_H_DelayQuotation where ClearDate=v_TradeDate;
    insert into T_H_DelayQuotation select v_TradeDate,a.* from T_DelayQuotation a;

    return 1;

end;
/


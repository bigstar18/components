create or replace function FN_T_ReComputeFloatLoss
return number
/****
 * 重算临时浮亏，但并不更新交易商冻结资金
 * 注意不要提交commit，因为闭市处理函数要调用它；
 * 返回值
 * 1 成功
 * -100 其它错误
****/
as
	v_version varchar2(10):='1.0.0.10';
	v_FloatingLossComputeType number(2);
	v_FloatingProfitSubTax number(1);
	v_F_FrozenFunds number(15,2);
	v_GageMode number(2);--抵顶模式，分0全抵顶和1半抵顶，半抵顶时要计算浮亏，2009-10-14
begin
	    --获取浮亏计算类型，盈亏是否扣税
	    select FloatingLossComputeType,FloatingProfitSubTax,GageMode into v_FloatingLossComputeType,v_FloatingProfitSubTax,v_GageMode from T_A_Market;
		--更新持仓明细上的浮动盈亏
        update
        (select /*+ BYPASS_UJVC */a.Price HoldPrice,HoldQty,GageQty,bs_flag,floatingloss,b.AddedTax,b.ContractFactor,b.price from T_HoldPosition a,
            (select c.AddedTax,c.ContractFactor,c.commodityid,q.price from T_Commodity c,T_Quotation q where c.CommodityID=q.CommodityID) b
        where a.commodityid=b.commodityid)
        --set floatingloss = decode(bs_flag,1,(Price-HoldPrice),(HoldPrice-Price))*HoldQty*ContractFactor;
        set floatingloss = FN_T_ComputeFPSubTax(HoldPrice,Price,HoldQty+decode(v_GageMode,1,GageQty,0),ContractFactor,bs_flag,AddedTax,v_FloatingProfitSubTax);

		--更新特殊商品持仓明细上的浮动盈亏
        update
        (
         select /*+ BYPASS_UJVC */floatingloss
         from T_HoldPosition a,T_Commodity b
         where a.bs_flag=1 and a.commodityid=b.commodityid
         and (b.marginrate_b=-1 or (b.MarginAlgr=1 and b.MarginRate_B >= 1))
        )
        set floatingloss = 0;
        update
        (
         select /*+ BYPASS_UJVC */floatingloss
         from T_HoldPosition a,T_Commodity b
         where a.bs_flag=2 and a.commodityid=b.commodityid
         and (b.marginrate_s=-1 or (b.MarginAlgr=1 and b.MarginRate_S >= 1))
        )
        set floatingloss = 0;

		--更新特殊交易商持仓明细上的浮动盈亏
        update
        (
         select /*+ BYPASS_UJVC */floatingloss
         from T_HoldPosition a,T_A_FirmMargin b
         where a.bs_flag=1 and a.commodityid=b.commodityid and a.firmid=b.firmid
         and (b.marginrate_b=-1 or (b.MarginAlgr=1 and b.MarginRate_B >= 1))
        )
        set floatingloss = 0;
        update
        (
         select /*+ BYPASS_UJVC */floatingloss
         from T_HoldPosition a,T_A_FirmMargin b
         where a.bs_flag=2 and a.commodityid=b.commodityid and a.firmid=b.firmid
         and (b.marginrate_s=-1 or (b.MarginAlgr=1 and b.MarginRate_S >= 1))
        )
        set floatingloss = 0;

      --更新交易客户持仓合计中的浮动盈亏
	  update T_CustomerHoldSum a
      set FloatingLoss=
      (
          select sum(x.FloatingLoss)
          from T_HoldPosition x
          where x.CustomerID = a.CustomerID and x.CommodityID = a.CommodityID and x.BS_Flag = a.BS_Flag
          group by x.CustomerID,x.CommodityID,x.BS_Flag
      );
      --更新交易商持仓合计中的浮动盈亏
	  update T_FirmHoldSum a
      set FloatingLoss=
      (
          select sum(x.FloatingLoss)
          from T_CustomerHoldSum x
          where x.FirmID = a.FirmID and x.CommodityID = a.CommodityID and x.BS_Flag = a.BS_Flag
          group by x.FirmID,x.CommodityID,x.BS_Flag
      );

      --更新交易商临时浮亏
	  if(v_FloatingLossComputeType = 0) then     --分商品分买卖
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                 from (select firmid,sum(case when FloatingLoss>0 then 0 else -FloatingLoss end) FloatingLoss from
                       T_FirmHoldSum group by firmid) a,
                       t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --更新冻结资金，释放或扣除变化的浮亏
      			    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                end if;
            end loop;
	  elsif(v_FloatingLossComputeType = 1) then  --分商品不分买卖
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                   from (select firmid,sum(case when FloatingLoss>0 then 0 else -FloatingLoss end) FloatingLoss from
                          (select firmid,sum(FloatingLoss) FloatingLoss from T_FirmHoldSum
                           group by firmid,commodityID) group by firmid
                        ) a,t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --更新冻结资金，释放或扣除变化的浮亏
      			    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                end if;
            end loop;
	  elsif(v_FloatingLossComputeType = 2) then  --不分商品
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                       from ( select firmid,case when sum(FloatingLoss)>0 then 0 else -sum(FloatingLoss) end FloatingLoss
                              from T_FirmHoldSum group by firmid) a,
                         t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --更新冻结资金，释放或扣除变化的浮亏
      			    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                end if;
            end loop;
	  elsif(v_FloatingLossComputeType = 3 or v_FloatingLossComputeType = 4) then  --盘中算盈亏或不算盈亏
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                       from ( select firmid,-sum(FloatingLoss) FloatingLoss
                              from T_FirmHoldSum group by firmid) a,
                         t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --更新冻结资金，释放或扣除变化的浮亏
      			    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                end if;
            end loop;
	  end if;

      return 1;

end;
/


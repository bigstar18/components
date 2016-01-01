create or replace function FN_T_UpdateFloatingLoss(
    p_b_firmid varchar2,  --起始交易商
    p_e_firmid varchar2,  --截止交易商
    p_LastTime timestamp  --上次更新时间，null表示全部更新
) return timestamp
/****
 * 更新浮亏
 * 返回更新时间
****/
as
    v_version varchar2(10):='1.0.0.10';
    v_b_firmid varchar2(32);    --起始交易商
    v_e_firmid varchar2(32);    --截止交易商
    v_price      number(15,2);  --行情结算价
    v_lasttime timestamp;
    v_FloatingLossComputeType number(2);
    v_FloatingProfitSubTax number(1);
    v_F_FrozenFunds number(15,2);
    v_fl number(15,2);
    v_Status         number(2);
    v_GageMode number(2);--抵顶模式，分0全抵顶和1半抵顶，半抵顶时要计算浮亏，2009-10-14
begin
	select FloatingLossComputeType,FloatingProfitSubTax,GageMode into v_FloatingLossComputeType,v_FloatingProfitSubTax,v_GageMode from T_A_Market;
	--2009-09-08 每日无负债方式，交易结算或财务结算后按当日结算价算盈亏，否则按昨结算价，所以需要状态
	--解决每日无负债方式在交易结算或财务结算后做抵顶，交收业务，调用此浮亏计算会出现按昨结算价计算的问题
    if(v_FloatingLossComputeType = 4) then
        select Status into v_Status from T_SystemStatus;
    end if;
    v_b_firmid := p_b_firmid;
    if(v_b_firmid is null) then
        v_b_firmid := '0';
    end if;
    v_e_firmid := p_e_firmid;
    if(v_e_firmid is null) then
        v_e_firmid := 'zzzzzzzzzz';
    end if;
    if(p_lasttime is null) then
        v_lasttime := to_date('2000-01-01','yyyy-MM-dd');
    else
        v_lasttime := p_lasttime;
    end if;

    for commodity in (select c.AddedTax,c.ContractFactor,c.MarginAlgr,c.MarginRate_B,c.MarginRate_S,c.lastprice,q.commodityid,q.price,q.createtime
                      from T_Commodity c,T_Quotation q where c.CommodityID=q.CommodityID and q.createtime>v_lasttime order by q.createtime)
    loop
        if(commodity.createtime>v_lasttime) then
            v_lasttime:=commodity.createtime;
        end if;

        if(v_FloatingLossComputeType = 4) then  --盘中不算盈亏，即每日无负债
        	if(v_Status=3 or v_Status=10) then  --交易结算或财务结算后按当日结算价算盈亏，否则按昨结算价
            	v_price := commodity.price;
            else
            	v_price := commodity.lastprice;
            end if;
    	else
      	    v_price := commodity.price;
        end if;

        for holdsum in (select rowid,floatingloss,bs_flag,HoldQty,GageQty,EvenPrice from T_Firmholdsum
                        where CommodityID=commodity.CommodityID and firmid>=v_b_firmid and firmid<=v_e_firmid)
        loop
            if(holdsum.bs_flag=1) then
                if(commodity.MarginRate_B = -1 or (commodity.MarginAlgr=1 and commodity.MarginRate_B >= 1)) then
                    v_fl := 0;
                else
                    --v_fl := (v_Price-holdsum.EvenPrice)*holdsum.HoldQty*commodity.ContractFactor;
                    if(v_GageMode=1) then --半抵顶
                    	v_fl := FN_T_ComputeFPSubTax(holdsum.EvenPrice,v_Price,holdsum.HoldQty+holdsum.GageQty,commodity.ContractFactor,holdsum.bs_flag,commodity.AddedTax,v_FloatingProfitSubTax);
                    else  --全抵顶
                    	v_fl := FN_T_ComputeFPSubTax(holdsum.EvenPrice,v_Price,holdsum.HoldQty,commodity.ContractFactor,holdsum.bs_flag,commodity.AddedTax,v_FloatingProfitSubTax);
                    end if;
                end if;
            end if;
            if(holdsum.bs_flag=2) then
                if(commodity.MarginRate_S = -1 or (commodity.MarginAlgr=1 and commodity.MarginRate_S >= 1)) then
                    v_fl := 0;
                else
                    --v_fl := (holdsum.EvenPrice-v_Price)*holdsum.HoldQty*commodity.ContractFactor;
                    if(v_GageMode=1) then --半抵顶
                    	v_fl := FN_T_ComputeFPSubTax(holdsum.EvenPrice,v_Price,holdsum.HoldQty+holdsum.GageQty,commodity.ContractFactor,holdsum.bs_flag,commodity.AddedTax,v_FloatingProfitSubTax);
                    else  --全抵顶
                    	v_fl := FN_T_ComputeFPSubTax(holdsum.EvenPrice,v_Price,holdsum.HoldQty,commodity.ContractFactor,holdsum.bs_flag,commodity.AddedTax,v_FloatingProfitSubTax);
                    end if;
                end if;
            end if;

            if(holdsum.floatingloss<>v_fl) then
                update T_Firmholdsum set floatingloss = v_fl where rowid=holdsum.rowid;
                commit;
            end if;
        end loop;
        /*
        --更新特殊交易商，暂时注释掉，一般不会出现此情况
		--买方
        for firmMargin_b in (
        	 select b.firmid,b.commodityid
             from T_A_FirmMargin b,(select commodityid from T_Quotation where createtime>v_lasttime order by createtime) c
             where b.firmid>=v_b_firmid and b.firmid<=v_e_firmid and b.commodityid=c.commodityid
             and (b.marginrate_b=-1 or (b.MarginAlgr=1 and b.MarginRate_B >= 1))
             )
        loop
        	select floatingloss into v_fl from T_Firmholdsum where firmid=firmMargin_b.firmid and commodityid=firmMargin_b.commodityid and bs_flag=1;
            if(v_fl<>0) then
                update T_Firmholdsum set floatingloss = 0 where firmid=firmMargin_b.firmid and commodityid=firmMargin_b.commodityid and bs_flag=1;
                commit;
            end if;
        end loop;
		--卖方
        for firmMargin_s in (
        	 select b.firmid,b.commodityid
             from T_A_FirmMargin b,(select commodityid from T_Quotation where createtime>v_lasttime order by createtime) c
             where b.firmid>=v_b_firmid and b.firmid<=v_e_firmid and b.commodityid=c.commodityid
             and (b.marginrate_s=-1 or (b.MarginAlgr=1 and b.MarginRate_S >= 1))
             )
        loop
        	select floatingloss into v_fl from T_Firmholdsum where firmid=firmMargin_s.firmid and commodityid=firmMargin_s.commodityid and bs_flag=2;
            if(v_fl<>0) then
                update T_Firmholdsum set floatingloss = 0 where firmid=firmMargin_s.firmid and commodityid=firmMargin_s.commodityid and bs_flag=2;
                commit;
            end if;
        end loop;
		*/
    end loop;

    if(p_lasttime is null or v_lasttime <> p_lasttime) then
        if(v_FloatingLossComputeType = 0) then     --商品分买卖
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                 from (select firmid,sum(case when FloatingLoss>0 then 0 else -FloatingLoss end) FloatingLoss from
                       T_FirmHoldSum where firmid>=v_b_firmid and firmid<=v_e_firmid group by firmid) a,
                       t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --更新冻结资金，释放或扣除变化的浮亏
      			        v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                    commit;
                end if;
            end loop;
        elsif(v_FloatingLossComputeType = 1) then  --商品不分买卖
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                   from (select firmid,sum(case when FloatingLoss>0 then 0 else -FloatingLoss end) FloatingLoss from
                          (select firmid,sum(FloatingLoss) FloatingLoss from T_FirmHoldSum
                           where firmid>=v_b_firmid and firmid<=v_e_firmid group by firmid,commodityID) group by firmid
                        ) a,t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --更新冻结资金，释放或扣除变化的浮亏
      			        v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                    commit;
                end if;
            end loop;
  			elsif(v_FloatingLossComputeType = 2) then  --不分商品
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                       from ( select firmid,case when sum(FloatingLoss)>0 then 0 else -sum(FloatingLoss) end FloatingLoss
                              from T_FirmHoldSum where firmid>=v_b_firmid and firmid<=v_e_firmid group by firmid) a,
                         t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --更新冻结资金，释放或扣除变化的浮亏
      			        v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                    commit;
                end if;
            end loop;
  			elsif(v_FloatingLossComputeType = 3 or v_FloatingLossComputeType = 4) then  --盘中算盈亏或不算盈亏
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                       from ( select firmid,-sum(FloatingLoss) FloatingLoss
                              from T_FirmHoldSum where firmid>=v_b_firmid and firmid<=v_e_firmid group by firmid) a,
                         t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --更新冻结资金，释放或扣除变化的浮亏
      			        v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                    commit;
                end if;
            end loop;
  			end if;
    end if;

    return v_lasttime;
end;
/


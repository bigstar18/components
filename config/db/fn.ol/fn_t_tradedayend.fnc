create or replace function FN_T_TradeDayEnd
return varchar2
/****
 * 交易日期变更结束，可多次做
 * 返回值 字符串
 * 成功 返回交易日期字符串，比如'2009-08-01'
 * '-1' 交易系统状态不是交易结算完成或财务结算完成
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_CommodityID varchar2(16);
    v_FirmID varchar2(32);
    v_Margin         number(15,2):=0;
    v_Assure         number(15,2):=0;
    v_FloatLoss         number(15,2):=0;        --计算持仓明细的浮动盈亏合计，正值为浮盈，负为浮亏
    v_TradeDate date;
    v_Status number(2);
	v_FloatingLossComputeType number(2);
	v_LastFloatingLossComputeType number(2);
	v_TradeFlowType number(2);
	v_Balance    number(15,2);
	v_num            number(10);
	v_ret           number(5);

    --按商品写流水游标
    type cur_CmdtyDaily is ref cursor;
	v_CmdtyDaily cur_CmdtyDaily;
	v_sql varchar2(500);

  -- add by yukx 20100428 用于记录交易客户持仓合计表的冻结数量和抵顶冻结数量
  v_c_customerid varchar2(40);
  v_c_commodityid varchar2(16);
  v_c_bs_flag number(5);
  v_c_frozenqty number(10);
  v_c_gagefrozenqty number(10);
  type cue_qtyAboutCustonerhold is ref cursor;
  v_qtyAboutCustonerhold cue_qtyAboutCustonerhold;

begin
      -- 一、获取交易日期、浮亏计算方式
	  select TradeDate,Status into v_TradeDate,v_Status from T_SystemStatus;
	  --判断能否做日期变更
	  if(v_Status <> 10 and v_Status <> 3) then
	  	  rollback;
	  	  return '-1';
	  end if;

	  --二、延期交易结算
	  v_ret := FN_T_D_CloseProcess();

      select FloatingLossComputeType,TradeFlowType into v_FloatingLossComputeType,v_TradeFlowType from T_A_Market;
      v_ret := FN_T_TradeFlow(v_TradeFlowType);
      -- 二、退、收资金并写流水
        --1退上日结算保证金
        v_sql := 'select FirmID,CommodityID,sum(HoldMargin)-sum(HoldAssure),sum(HoldAssure) from T_H_FirmHoldSum where ClearDate =(select max(ClearDate) from T_H_Market) group by FirmID,CommodityID';
        open v_CmdtyDaily for v_sql;
        loop
            fetch v_CmdtyDaily into v_FirmID,v_CommodityID,v_Margin,v_Assure;
            exit when v_CmdtyDaily%NOTFOUND;
			--更新资金余额，并写退上日结算保证金流水
			if(v_Margin <> 0) then
	    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15003',v_Margin,null,v_CommodityID,v_Assure,null);
	    	end if;
        end loop;
        close v_CmdtyDaily;

        --2扣除当天结算保证金
        v_sql := 'select FirmID,CommodityID,sum(HoldMargin)-sum(HoldAssure),sum(HoldAssure) from T_FirmHoldSum group by FirmID,CommodityID';
        open v_CmdtyDaily for v_sql;
        loop
            fetch v_CmdtyDaily into v_FirmID,v_CommodityID,v_Margin,v_Assure;
            exit when v_CmdtyDaily%NOTFOUND;
			--更新资金余额，并写退上日结算保证金流水
			if(v_Margin <> 0) then
	    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15002',v_Margin,null,v_CommodityID,v_Assure,null);
	    	end if;
        end loop;
        close v_CmdtyDaily;

        --3如果存在上日交易的数据则退上日浮亏
	    select count(*) into v_num from T_H_Market where ClearDate =(select max(ClearDate) from T_H_Market);
	    if(v_num >0) then
	        --获取上一交易日的浮亏计算方式
	        select FloatingLossComputeType into v_LastFloatingLossComputeType from T_H_Market where ClearDate =(select max(ClearDate) from T_H_Market);
		    if(v_LastFloatingLossComputeType = 0) then     --商品分买卖
		        v_sql := 'select FirmID,CommodityID,sum(case when FloatingLoss>0 then 0 else -FloatingLoss end) from T_H_FirmHoldSum where ClearDate =(select max(ClearDate) from T_H_Market) group by FirmID,CommodityID';
		        open v_CmdtyDaily for v_sql;
		        loop
		            fetch v_CmdtyDaily into v_FirmID,v_CommodityID,v_FloatLoss;
		            exit when v_CmdtyDaily%NOTFOUND;
					--更新资金余额，并写退上日浮亏流水
					if(v_FloatLoss <> 0) then
			    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15005',v_FloatLoss,null,v_CommodityID,null,null);
			    	end if;
		        end loop;
		        close v_CmdtyDaily;
		    elsif(v_LastFloatingLossComputeType = 1) then  --商品不分买卖
		        v_sql := 'select FirmID,CommodityID,sum(FloatingLoss) from T_H_FirmHoldSum where ClearDate =(select max(ClearDate) from T_H_Market) group by FirmID,CommodityID';
		        open v_CmdtyDaily for v_sql;
		        loop
		            fetch v_CmdtyDaily into v_FirmID,v_CommodityID,v_FloatLoss;
		            exit when v_CmdtyDaily%NOTFOUND;
		            if(v_FloatLoss <= 0) then
		            	v_FloatLoss := -v_FloatLoss;
						--更新资金余额，并写退上日浮亏流水
						if(v_FloatLoss <> 0) then
				    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15005',v_FloatLoss,null,v_CommodityID,null,null);
				    	end if;
			        end if;
		        end loop;
		        close v_CmdtyDaily;
		    elsif(v_LastFloatingLossComputeType = 2) then  --不分商品
		        v_sql := 'select FirmID,case when sum(FloatingLoss) >0 then 0 else  -sum(FloatingLoss) end from T_H_FirmHoldSum where ClearDate =(select max(ClearDate) from T_H_Market) group by FirmID ';
		        open v_CmdtyDaily for v_sql;
		        loop
		            fetch v_CmdtyDaily into v_FirmID,v_FloatLoss;
		            exit when v_CmdtyDaily%NOTFOUND;
					--更新资金余额，并写退上日浮亏流水
					if(v_FloatLoss <> 0) then
			    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15016',v_FloatLoss,null,null,null,null);
			    	end if;
		        end loop;
		        close v_CmdtyDaily;
		    elsif(v_LastFloatingLossComputeType = 3 or v_LastFloatingLossComputeType = 4) then  --盘中算盈亏或不算盈亏
		        v_sql := 'select FirmID,-sum(FloatingLoss) from T_H_FirmHoldSum where ClearDate =(select max(ClearDate) from T_H_Market) group by FirmID ';
		        open v_CmdtyDaily for v_sql;
		        loop
		            fetch v_CmdtyDaily into v_FirmID,v_FloatLoss;
		            exit when v_CmdtyDaily%NOTFOUND;
					--更新资金余额，并写退上日浮亏流水
					if(v_FloatLoss <> 0) then
			    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15016',v_FloatLoss,null,null,null,null);
			    	end if;
		        end loop;
		        close v_CmdtyDaily;
		    end if;
	    end if;

        --4扣除当天结算浮亏
	    if(v_FloatingLossComputeType = 0) then     --商品分买卖
	        v_sql := 'select FirmID,CommodityID,sum(case when FloatingLoss>0 then 0 else -FloatingLoss end) from T_FirmHoldSum group by FirmID,CommodityID';
	        open v_CmdtyDaily for v_sql;
	        loop
	            fetch v_CmdtyDaily into v_FirmID,v_CommodityID,v_FloatLoss;
	            exit when v_CmdtyDaily%NOTFOUND;
				--更新资金余额，并写扣除当日浮亏流水
				if(v_FloatLoss <> 0) then
		    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15004',v_FloatLoss,null,v_CommodityID,null,null);
		    	end if;
	        end loop;
	        close v_CmdtyDaily;
	    elsif(v_FloatingLossComputeType = 1) then  --商品不分买卖
	        v_sql := 'select FirmID,CommodityID,sum(FloatingLoss) from T_FirmHoldSum group by FirmID,CommodityID';
	        open v_CmdtyDaily for v_sql;
	        loop
	            fetch v_CmdtyDaily into v_FirmID,v_CommodityID,v_FloatLoss;
	            exit when v_CmdtyDaily%NOTFOUND;
	            if(v_FloatLoss <= 0) then
	            	v_FloatLoss := -v_FloatLoss;
					--更新资金余额，并写扣除当日浮亏流水
					if(v_FloatLoss <> 0) then
			    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15004',v_FloatLoss,null,v_CommodityID,null,null);
			    	end if;
		        end if;
	        end loop;
	        close v_CmdtyDaily;
	    elsif(v_FloatingLossComputeType = 2) then  --不分商品
	        v_sql := 'select FirmID,case when sum(FloatingLoss) >0 then 0 else -sum(FloatingLoss) end from T_FirmHoldSum group by FirmID ';
	        open v_CmdtyDaily for v_sql;
	        loop
	            fetch v_CmdtyDaily into v_FirmID,v_FloatLoss;
	            exit when v_CmdtyDaily%NOTFOUND;
				--更新资金余额，并写扣除当日浮亏流水
				if(v_FloatLoss <> 0) then
		    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15015',v_FloatLoss,null,null,null,null);
		    	end if;
	        end loop;
	        close v_CmdtyDaily;
	    elsif(v_FloatingLossComputeType = 3 or v_FloatingLossComputeType = 4) then  --盘中算盈亏或不算盈亏
	        v_sql := 'select FirmID,-sum(FloatingLoss) from T_FirmHoldSum group by FirmID ';
	        open v_CmdtyDaily for v_sql;
	        loop
	            fetch v_CmdtyDaily into v_FirmID,v_FloatLoss;
	            exit when v_CmdtyDaily%NOTFOUND;
				--更新资金余额，并写扣除当日浮亏流水
				if(v_FloatLoss <> 0) then
		    		v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15015',v_FloatLoss,null,null,null,null);
		    	end if;
	        end loop;
	        close v_CmdtyDaily;
	    end if;

        -- 三、更新交易商资金
        --1、更新虚拟资金为0,上日结算资金更新为当日结算资金，上日的交收保证金更新为当日的
        update T_Firm set VirtualFunds=0,ClearMargin=RuntimeMargin,ClearAssure=RuntimeAssure,ClearFL=RuntimeFL,ClearSettleMargin=RuntimeSettleMargin;
        --2、删除历史当日数据并导入历史交易商信息表
		delete from T_H_Firm where ClearDate=v_TradeDate;
        insert into T_H_Firm select v_TradeDate,a.* from T_Firm a;
        --3、更新当日历史交易商表中的上日的资金为上一交易日的当日资金
        --故意用sum求和(一个交易商只有一条记录)，解决更新时没有记录报错
	    update T_H_Firm a
        set (ClearFL,ClearMargin,ClearAssure,ClearSettleMargin) =
        (
          select nvl(sum(RuntimeFL),0),nvl(sum(RuntimeMargin),0),nvl(sum(RuntimeAssure),0),nvl(sum(RuntimeSettleMargin),0)
          from T_H_Firm
          where ClearDate =(select max(ClearDate) from T_H_Firm where ClearDate<v_TradeDate) and FirmID=a.FirmID
        )
        where a.ClearDate=v_TradeDate;

		-- 四、导入历史数据并删除当日数据
        --1、导入历史委托表并删除当日数据
        insert into T_H_Orders select v_TradeDate,a.* from T_Orders a;
        delete from T_Orders;
        --2、导入历史成交表并删除当日数据
        insert into T_H_Trade select v_TradeDate,a.* from T_Trade a;
        delete from T_Trade;

		-- 五、删除历史当日数据并导入当日历史数据
        --1、删除历史当日数据并导入历史市场参数表
		delete from T_H_Market where ClearDate=v_TradeDate;
        insert into T_H_Market select v_TradeDate,a.* from T_A_Market a;
	    --2、删除历史当日数据并导入历史行情
		delete from T_H_Quotation where ClearDate=v_TradeDate;
	    insert into T_H_Quotation select v_TradeDate,a.* from T_Quotation a;
        --3、删除历史当日数据并导入历史商品表
		delete from T_H_Commodity where ClearDate=v_TradeDate;
        insert into T_H_Commodity select v_TradeDate,a.* from T_Commodity a;
        --4、删除历史当日数据并导入历史持仓明细表
		delete from T_H_HoldPosition where ClearDate=v_TradeDate;
        insert into T_H_HoldPosition select v_TradeDate,a.* from T_HoldPosition a;
        --5、删除历史当日数据并导入历史交易客户持仓合计表
		delete from T_H_CustomerHoldSum where ClearDate=v_TradeDate;
        insert into T_H_CustomerHoldSum select v_TradeDate,a.* from T_CustomerHoldSum a;
        --6、删除历史当日数据并导入历史交易商持仓合计表
		delete from T_H_FirmHoldSum where ClearDate=v_TradeDate;
        insert into T_H_FirmHoldSum select v_TradeDate,a.* from T_FirmHoldSum a;
        --7、删除历史当日数据并导入历史交易商特殊保证金表
		delete from T_H_FirmMargin where ClearDate=v_TradeDate;
        insert into T_H_FirmMargin select v_TradeDate,a.* from T_A_FirmMargin a;
        --8、删除历史当日数据并导入历史交易商特殊手续费表
		delete from T_H_FirmFee where ClearDate=v_TradeDate;
        insert into T_H_FirmFee select v_TradeDate,a.* from T_A_FirmFee a;

		-- 六、释放冻结数据
	    --1、交易客户持仓合计表冻结数量清0
      -- mod by yukx 201040028 为支持提前交收冻结持仓注释下边sql
	    --update T_CustomerHoldSum set FrozenQty=0;
      -- mod by yukx 201040028 交易客户持仓合计表的冻结数量和抵顶冻结数量存在不为0的记录时，向系统日志表添加记录
      open v_qtyAboutCustonerhold for select customerid,commodityid,bs_flag,frozenqty,gagefrozenqty from t_customerholdsum order by customerid,commodityid,bs_flag;
      loop
        fetch v_qtyAboutCustonerhold into  v_c_customerid,v_c_commodityid,v_c_bs_flag,v_c_frozenqty,v_c_gagefrozenqty;
        exit when v_qtyAboutCustonerhold%NOTFOUND;
        if(v_c_frozenqty+v_c_gagefrozenqty>0) then
             insert into c_globallog_all(id,operator,operatetime,operatetype,operatecontent,operateresult,logtype)
              values(SEQ_C_GLOBALLOG.Nextval,'SYSTEM', sysdate,1502,'v_c_customerid='||v_c_customerid||',v_c_commodityid='||v_c_commodityid||',v_c_bs_flag='||v_c_bs_flag||',v_c_frozenqty='||v_c_frozenqty||',v_c_gagefrozenqty='||v_c_gagefrozenqty,2,3);
        end if;
      end loop;
      ---- add by tangzy 2010-06-21 交易客户持仓合计冻结数量修改，先清0，再根据提前交收申请的记录来更新冻结数量
      update T_CustomerHoldSum t
        set FrozenQty = 0,
            gagefrozenqty = 0;
      -- 计算买方冻结数量
      update T_CustomerHoldSum t
         set FrozenQty = nvl((select sum(quantity)
                               from t_e_applyaheadsettle
                              where customerid_b = t.customerid
                                and commodityid = t.commodityid
                                and status = 1),0)
       where bs_flag = 1;
      -- 计算卖方冻结数量
      update T_CustomerHoldSum t
         set FrozenQty = nvl((select sum(quantity) - sum(gageqty)
                               from t_e_applyaheadsettle
                              where customerid_s = t.customerid
                                and commodityid = t.commodityid
                                and status = 1),0),
            gagefrozenqty = nvl((select sum(gageqty)
                               from t_e_applyaheadsettle
                              where customerid_s = t.customerid
                                and commodityid = t.commodityid
                                and status = 1),0)
       where bs_flag = 2;
      ---- add by tangzy 2010-06-21 end

        --2、清空当日指定平仓冻结表
        delete from T_SpecFrozenHold;
        --3、释放所有冻结资金
		SP_F_UnFrozenAllFunds('15');

        -- 七、修改交易系统状态为财务结算完成
        update T_SystemStatus set TradeDate=v_TradeDate,Status=3,SectionID=null,Note=null,RecoverTime=null;
    --成功返回交易日期字符串
    return to_char(v_TradeDate,'yyyy-MM-dd');
end;
/


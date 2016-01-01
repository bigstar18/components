create or replace function FN_T_CloseMarketProcess
return number
/****
 * 闭市结算处理，可多次结算
 * 返回值
 * 1 成功
 * -2 交收处理出错
 * -100 其它错误
****/
as
  v_version varchar2(10):='1.0.0.1';
  v_b_date f_systemstatus.b_date%type;
  v_status f_systemstatus.status%type;
  v_CommodityID varchar2(16);
  v_TradeDate date;
  v_ret           number(5);
  v_SettleMode           number(2);
  v_errorcode number;
  v_errormsg  varchar2(200);
  --商品交收游标
  cursor cur_settle(c_TradeDate date) is select CommodityID from T_Commodity where SettleDate<=c_TradeDate;


  v_sql            varchar2(500);
  v_Balance        number(15,2);
  v_num            number(10);
  v_FirmID         varchar2(32);
  v_customerid     varchar2(40);
  v_Margin         number(15,2):=0;
  v_Assure         number(15,2):=0;
  v_FloatingLossComputeType number(2);
  v_TradeFlowType number(2);
  v_LastFloatingLossComputeType number(2);
  v_FloatLoss         number(15,2):=0;        --计算持仓明细的浮动盈亏合计，正值为浮盈，负为浮亏
  v_bs_flag number(5);
  v_frozenqty number(10);

  --按商品写流水游标
  type cur_CmdtyDaily is ref cursor;
  v_CmdtyDaily cur_CmdtyDaily;

  type cue_qtyAboutCustonerhold is ref cursor;
  v_qtyAboutCustonerhold cue_qtyAboutCustonerhold;

  type cur_HoldFrozen is ref cursor;
  v_HoldFrozen cur_HoldFrozen;

  v_c_customerid varchar2(40);
  v_c_commodityid varchar2(16);
  v_c_bs_flag number(5);
  v_c_frozenqty number(10);
  v_c_gagefrozenqty number(10);


begin
     --对订单系统状态表加锁，防止交易结算并发
   select t.tradedate,t.status into v_b_date,v_status from t_systemstatus t for update;
   update t_systemstatus t
           set t.status = 2,
               t.note = '结算中';
  commit; --此处提交是为了结算中状态外围能看到。



      -- 一、获取交易日期、获取交收模式、浮亏计算方式，结算开始
    select TradeDate into v_TradeDate from T_SystemStatus;
    select SettleMode into v_SettleMode from T_A_Market;
    SP_T_ClearAction_Done(p_actionid => 0);



    -- 二、交收处理
      --如果自动交收的话，则进行交收处理
    if(v_SettleMode = 0) then
        open cur_settle(v_TradeDate);
        loop
          fetch cur_settle into v_CommodityID;
          exit when cur_settle%notfound;
          v_ret := FN_T_SettleProcess(v_CommodityID,0);
          if(v_ret < 0) then
              rollback;
            return -2;
          end if;
       end loop;
        close cur_settle;
      end if;
      SP_T_ClearAction_Done(p_actionid => 1);



      -- 三、重算交易资金
      v_ret := FN_T_ReComputeFunds(0);
      if(v_ret < 0) then
          rollback;
          return -100;
      end if;
      SP_T_ClearAction_Done(p_actionid => 2);



      -- 四、重算浮亏
      v_ret := FN_T_ReComputeFloatLoss();
      if(v_ret < 0) then
          rollback;
          return -100;
      end if;
      SP_T_ClearAction_Done(p_actionid => 3);



      -- 五、延期交易结算
      v_ret := FN_T_D_CloseProcess();
      select FloatingLossComputeType,TradeFlowType into v_FloatingLossComputeType,v_TradeFlowType from T_A_Market;
      v_ret := FN_T_TradeFlow(v_TradeFlowType);
      SP_T_ClearAction_Done(p_actionid => 4);



      --六、退上日结算保证金
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
      SP_T_ClearAction_Done(p_actionid => 5);



      -- 七、扣当日结算保证金
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
      SP_T_ClearAction_Done(p_actionid => 6);




      -- 八、如果存在上日交易的数据则退上日浮亏
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
      SP_T_ClearAction_Done(p_actionid => 7);




      -- 九、扣除当天结算浮亏
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
      SP_T_ClearAction_Done(p_actionid => 8);



      -- 十、更新交易商资金
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
      SP_T_ClearAction_Done(p_actionid => 9);



      -- 十一、导入历史数据

        --导入历史数据并删除当日数据
        --1、导入历史委托表并删除当日数据
        insert into T_H_Orders select v_TradeDate,a.* from T_Orders a;
        delete from T_Orders;
        --2、导入历史成交表并删除当日数据
        insert into T_H_Trade select v_TradeDate,a.* from T_Trade a;
        delete from T_Trade;
        --3、导入历史广播消息并删除当日数据
        --insert into T_H_Broadcast select v_TradeDate,a.* from T_Broadcast a;
        --delete from T_Broadcast;

        --删除历史当日数据并导入当日历史数据
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
        SP_T_ClearAction_Done(p_actionid => 10);




      -- 十二、释放冻结数据
      --1、交易客户持仓合计表冻结数量清0
      -- mod by yukx 201040028 为支持提前交收冻结持仓注释下边sql
      --update T_CustomerHoldSum set FrozenQty=0;
      -- mod by yukx 201040028 交易客户持仓合计表的冻结数量和抵顶冻结数量存在不为0的记录时，向系统日志表添加记录
      open v_qtyAboutCustonerhold for select customerid,commodityid,bs_flag,frozenqty,gagefrozenqty from t_customerholdsum order by customerid,commodityid,bs_flag;
      loop
        fetch v_qtyAboutCustonerhold into  v_c_customerid,v_c_commodityid,v_c_bs_flag,v_c_frozenqty,v_c_gagefrozenqty;
        exit when v_qtyAboutCustonerhold%NOTFOUND;
        /*if(v_c_frozenqty+v_c_gagefrozenqty>0) then
             insert into T_SysLog(ID,UserID,Action,CreateTime,Note)
             values(SEQ_T_SYSLOG.Nextval,'SYSTEM','03',sysdate,'v_c_customerid='||v_c_customerid||',v_c_commodityid='||v_c_commodityid||',v_c_bs_flag='||v_c_bs_flag||',v_c_frozenqty='||v_c_frozenqty||',v_c_gagefrozenqty='||v_c_gagefrozenqty);
        end if;*/
      end loop;
      ---- add by tangzy 2010-06-21 交易客户持仓合计冻结数量修改，先清0，再根据提前交收申请的记录来更新冻结数量
      update T_CustomerHoldSum t
        set FrozenQty = 0,
            gagefrozenqty = 0;
      -- 计算买方冻结数量
      /*update T_CustomerHoldSum t
         set FrozenQty = nvl((select sum(quantity)
                               from t_e_applyaheadsettle
                              where customerid_b = t.customerid
                                and commodityid = t.commodityid
                                and status = 1),0)
       where bs_flag = 1;*/
      -- 计算卖方冻结数量
      /*update T_CustomerHoldSum t
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
       where bs_flag = 2;*/

       --2、清空当日指定平仓冻结表
       delete from T_SpecFrozenHold;
       --3、释放所有冻结资金
       SP_F_UnFrozenAllFunds('15');

       SP_T_ClearAction_Done(p_actionid => 11);


      -- 十三、返佣操作(调用返佣存储)

      v_ret := FN_BR_BrokerReward();

      SP_T_ClearAction_Done(p_actionid => 12);



      --十四、更新交易客户持仓合计表冻结数量
      open v_HoldFrozen for select customerid,commodityId,bs_flag,FrozenQTY from
        --提前交收
        (select th.customerid,th.commodityId commodityId,th.bs_flag bs_flag,sum(th.FrozenQTY)FrozenQTY from t_holdfrozen th,T_E_ApplyAheadSettle ta where ta.applyid = th.operation and th.frozentype = 0 and  ta.status=1
        group by th.customerid,th.commodityId,th.bs_flag)
        union all
        --协议交收
        (select th.customerid,th.commodityId commodityId,th.bs_flag bs_flag,sum(th.FrozenQTY)FrozenQTY from t_holdfrozen th,T_E_ApplyTreatySettle ta where ta.applyid = th.operation and th.frozentype = 1 and  ta.status=1
        group by th.customerid,th.commodityId,th.bs_flag)
        union all
        --非交易过户
        (select th.customerid,th.commodityId commodityId,th.bs_flag bs_flag,sum(th.FrozenQTY)FrozenQTY from t_holdfrozen th,T_UnTradeTransfer ta where ta.transferID = th.operation and th.frozentype = 2 and  ta.status=0
        group by th.customerid,th.commodityId,th.bs_flag)
        union all
        --抵顶
        (select th.customerid,th.commodityId commodityId,th.bs_flag bs_flag,sum(th.FrozenQTY)FrozenQTY from t_holdfrozen th,T_E_ApplyGage ta where ta.ApplyID = th.operation and th.frozentype = 3 and  ta.status=1 and ta.applytype=1
        group by th.customerid,th.commodityId,th.bs_flag);
      loop
          fetch v_HoldFrozen into v_customerid,v_CommodityID,v_bs_flag,v_frozenqty;
          exit when v_HoldFrozen%NOTFOUND;
               update t_customerholdsum  t set FrozenQty = FrozenQty + v_frozenqty where t.customerid = v_customerid and t.commodityid = v_CommodityID and t.bs_flag = v_bs_flag;
       end loop;
       close v_HoldFrozen;

      -- 十五、修改交易系统状态为交易结算完成
      update T_SystemStatus set TradeDate=v_TradeDate,Status=10,SectionID=null,Note=null,RecoverTime=null;
      SP_T_ClearAction_Done(p_actionid => 13);
    commit;
    return 1;
exception
    when others then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_CloseMarketProcess',v_errorcode,v_errormsg);
    -- 恢复状态为未结算
        update t_systemstatus t
           set t.status = 7,
               t.note = '交易结束';
        commit;
    commit;
    return -100;
end;
/


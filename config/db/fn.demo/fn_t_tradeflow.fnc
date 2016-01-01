create or replace function FN_T_TradeFlow(
    p_TradeFlowType number   --0：写汇总流水；1：写明细流水；
)
return number
/****
 * 写成交资金流水，交易日期变更结束函数要调用
 * 注意不要提交commit
 * 返回值
 * 1 成功
****/
as
  v_version varchar2(10):='1.0.0.1';
  v_A_TradeNo      number(15);
    v_CommodityID varchar2(16);
    v_FirmID varchar2(32);
    v_TradeFee         number(15,2);
    v_Close_PL         number(15,2);
    v_CloseAddedTax         number(15,2);
  v_Balance    number(15,2);
    --成交明细游标，写成交明细流水
    cursor cur_T_Trade is
        select A_TradeNo,FirmID,CommodityID,TradeFee,nvl(Close_PL,0),nvl(CloseAddedTax,0)
        from T_Trade order by A_TradeNo;
    --成交汇总手续费游标，每个交易商写一笔流水
    cursor cur_fee_sum is
        select FirmID,sum(TradeFee) from T_Trade group by FirmID;
    --成交汇总平仓盈亏游标，每个交易商每种商品写一笔流水
    cursor cur_Close_PL_sum is
        select FirmID,CommodityID,sum(nvl(Close_PL,0)),sum(nvl(CloseAddedTax,0))
        from T_Trade group by FirmID,CommodityID;
begin
  if(p_TradeFlowType = 0) then
        --成交汇总手续费游标
        open cur_fee_sum;
        loop
          fetch cur_fee_sum into v_FirmID,v_TradeFee;
          exit when cur_fee_sum%notfound;
      --更新资金余额，并写手续费流水
      if(v_TradeFee <> 0) then
          v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15001',v_TradeFee,null,null,null,null);
        end if;
      end loop;
        close cur_fee_sum;
        --成交汇总平仓盈亏游标
        open cur_Close_PL_sum;
        loop
          fetch cur_Close_PL_sum into v_FirmID,v_CommodityID,v_Close_PL,v_CloseAddedTax;
          exit when cur_Close_PL_sum%notfound;
      --更新资金余额，并写付交易盈利,收交易亏损 流水

      if(v_Close_PL > 0) then
        v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15006',v_Close_PL,null,v_CommodityID,v_CloseAddedTax,null);
      elsif(v_Close_PL < 0) then
        v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15007',-v_Close_PL,null,v_CommodityID,-v_CloseAddedTax,null);
      end if;


      end loop;
        close cur_Close_PL_sum;
  else
        --成交明细游标
        open cur_T_Trade;
        loop
          fetch cur_T_Trade into v_A_TradeNo,v_FirmID,v_CommodityID,v_TradeFee,v_Close_PL,v_CloseAddedTax;
          exit when cur_T_Trade%notfound;
      --更新资金余额，并写手续费流水
      if(v_TradeFee <> 0) then
          v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15001',v_TradeFee,v_A_TradeNo,v_CommodityID,null,null);
        end if;
      --更新资金余额，并写付交易盈利,收交易亏损 流水
      if(v_Close_PL > 0) then
        v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15006',v_Close_PL,v_A_TradeNo,v_CommodityID,v_CloseAddedTax,null);
      elsif(v_Close_PL < 0) then
        v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15007',-v_Close_PL,v_A_TradeNo,v_CommodityID,-v_CloseAddedTax,null);
      end if;
      end loop;
        close cur_T_Trade;
  end if;
    return 1;
end;
/


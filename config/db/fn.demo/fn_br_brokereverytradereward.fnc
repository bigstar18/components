create or replace function FN_BR_BrokerEveryTradeReward(
    p_CommodityID    varchar2 ,--商品ID
    p_Quantity       number ,--数量
    p_FeeMoney       number ,--一笔成交收的手续费
    p_BarginMoney    number, --成交货款
    p_AtClearDate       date,--订货所属结算日期
    p_TradeAtClearDate  date,--成交所属结算日期
    p_BS_Flag        number,--买卖标志
    p_OrderType      number,--委托类型
    p_TradeType      number,--成交类型
    p_type           number--返回值类型  0 加收佣金  1  固定手续费
)return number
  /**
  * 计算每笔成交应返会员的加收佣金或会员分成的固定手续费
  * 2012-8-14 by jingwh
  **/
as
  v_brokerReward               number(15,2) default 0;
  v_feealgr                    number(1);
  v_feeRate_b                  number(15, 9);
  v_feeRate_s                  number(15, 9);
  v_todayclosefeerate_b        number(15, 9);
  v_todayclosefeerate_s        number(15, 9);
  v_historyclosefeerate_b      number(15, 9);
  v_historyclosefeerate_s      number(15, 9);
  v_forceclosefeerate_b        number(15, 9);
  v_forceclosefeerate_s        number(15, 9);
  v_rate                       number(15, 9);
  v_marketFee                  number(15,2);
  v_factmarketFee              number(15,2)  default 0;
begin
 --获取商品信息：手续费算法，。
    select t.feealgr,t.FeeRate_b,t.feerate_s,t.todayclosefeerate_b,t.todayclosefeerate_s,t.historyclosefeerate_b,t.historyclosefeerate_s,t.forceclosefeerate_b,t.forceclosefeerate_s
     into    v_feealgr,v_feeRate_b,v_feeRate_s,v_todayclosefeerate_b,v_todayclosefeerate_s,v_historyclosefeerate_b,v_historyclosefeerate_s,v_forceclosefeerate_b,v_forceclosefeerate_s from t_commodity t where t.commodityid=p_CommodityID;
    --比较订货时间和成交时间
    if(p_OrderType=1)then--开仓
          if(p_BS_Flag=1)then--买订立
                v_rate:=v_feeRate_b;
          elsif(p_BS_Flag=2)then--卖订立
                v_rate:=v_feeRate_s;
          end if;
    elsif(p_OrderType=2)then--平仓
       -- 判断是否强平  2013-12-18 by zhaodc
      if(p_TradeType=3)then
              if(p_BS_Flag=1)then--买转让
                  v_rate:=v_forceclosefeerate_b;
              elsif(p_BS_Flag=2)then--卖转让
                  v_rate:=v_forceclosefeerate_s;
              end if;
      else
          if(trunc(p_TradeAtClearDate)=trunc(p_AtClearDate))then--今开今平
              if(p_BS_Flag=1)then--买转让
                  v_rate:=v_todayclosefeerate_b;
              elsif(p_BS_Flag=2)then--卖转让
                  v_rate:=v_todayclosefeerate_s;
              end if;
          elsif(trunc(p_TradeAtClearDate)>trunc(p_AtClearDate))then  --平历史
              if(p_BS_Flag=1)then--买转让
                  v_rate:=v_historyclosefeerate_b;
              elsif(p_BS_Flag=2)then--卖转让
                  v_rate:=v_historyclosefeerate_s;
              end if;
          end if;
      end if;
    end if;
    --算返市场手续费
    if(v_feealgr=1)then
       v_marketFee:=v_rate*p_BarginMoney;
    elsif(v_feealgr=2)then
       v_marketFee:=v_rate*p_Quantity;
    end if;
    --算返会员的加收佣金 如果市场收上来的手续费（收）>市场应得手续费（固定）  加收佣金=收-固定 ；
    --如果市场收上来的手续费（收）<=市场应得手续费（固定）  手续费全部返给市场 加收佣金=0
    --计算会员分成用到的固定手续费  如果收>固定 会员分成=固定*比例 如果收<固定 会员分成=收*比例（例如收10  固定100  比例 30% 用固定算分成的话市场就会垫钱20  ）
    if(p_FeeMoney>v_marketFee)then
      v_brokerReward:=p_FeeMoney-v_marketFee;
      v_factmarketFee:=v_marketFee;
    elsif(p_FeeMoney<=v_marketFee)then
      v_brokerReward:=0;
      v_factmarketFee:=p_FeeMoney;
    end if;
    if(p_type=0)then
      return v_brokerReward;
    elsif(p_type=1)then
      return v_factmarketFee;
    end if;

end;
/


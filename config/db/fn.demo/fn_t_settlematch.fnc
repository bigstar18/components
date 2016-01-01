create or replace function FN_T_SettleMatch
(
    p_commodityId varchar2, --商品代码
    p_quantity number,  --交收数量
    p_status number, --状态
    p_result number, --履约状态
    p_firmID_B varchar2,  --买方交易商代码
    p_firmID_S varchar2,  --卖方交易商代码
    p_settleDate varchar2, --交收日期
    p_matchId varchar2 ,--配对编号
    p_operator varchar2 --操作人
) return number
/****
 *
 *  轮询持仓时过滤交收类型不为提前交收即可（除延期商品交收申报当日下市外，交收持仓不会出现同时存在延期和到期交收的情况，这是遗留问题，暂时排除该情况）
 *  添加配对时交收类型只看商品设置的交收类型与持仓的交收类型无关
 * 返回值
 *  1 成功
 * -1 买方持仓不足
 * -2 卖方持仓不足
****/
as
 v_contractFactor number;  --合约因子
 v_buypayout_ref number(15,2):=0;--买方参考货款
 v_buyPayout number(15,2):=0;--已收买方货款
 v_sellincom_ref number(15,2):=0;--卖方参考货款
 v_buyMargin number(15,2):=0;--买方交收保证金
 v_sellMargin number(15,2):=0;--卖方交收保证金
 v_everybuyPayout number(15,2):=0;--买方每笔持仓已收货款
 v_everybuyMargin number(15,2):=0;--买方每笔持仓交收保证金
 v_everysellMargin number(15,2):=0;--卖方每笔持仓交收保证金
 v_price number;
 v_settleprice_b number:=0;
 v_settleprice_s number:=0;
 v_weight number(15,4);
 v_amountQty_s number(10);
 v_amountQty_b number(10);
 v_quantity number(10);
 v_settlePriceType number(2); --到期交收价格计算 0,1,3 统一价 2订立价
 v_delaySettlePriceType number(2);--延期交收申报交收价格类型 0统一价 1订立价
 v_settleType number(2);--配对表的交收方式 1到期 3延期
 v_settleDate varchar2(20);--交收日期 （到期交收取持仓明细的交收处理日期，延期为p_settleDate）
 v_settleWay number(2);--商品表交收方式0中远期（到期） 1连续现货（延期） 2专场交易 （到期）
 v_count number;
 v_taxIncluesive number(1);--商品价格中是否含税  1 不含税 0 含税
 v_addedtax number(10,4):=0;--商品增值税率
 v_buytax number(15,2):=0;--买方总税
 v_everytax number(15,2):=0;--每笔税费
 v_fundsflow number;--没用的流水返回值
begin
    --到历史商品表查询商品参数 如果历史查不到查当前商品（因为交易结算时商品导历史，所以在交易结算前做当天的延期申报配对时只能查当前商品表）
    select count(*) into v_count from t_h_commodity where commodityid=p_commodityId and trunc(cleardate)=to_date(p_settleDate,'yyyy-MM-dd');
    if v_count=0 then
       select settlepricetype,delaySettlePriceType,contractFactor,settleWay,TAXINCLUSIVE,addedtax into v_settlePriceType,v_delaySettlePriceType,v_contractFactor,v_settleWay,v_taxIncluesive,v_addedtax from t_commodity where commodityid=p_commodityId;
    else
       select settlepricetype,delaySettlePriceType,contractFactor,settleWay,TAXINCLUSIVE,addedtax into v_settlePriceType,v_delaySettlePriceType,v_contractFactor,v_settleWay,v_taxIncluesive,v_addedtax from t_h_commodity where commodityid=p_commodityId and trunc(cleardate)=to_date(p_settleDate,'yyyy-MM-dd');
    end if;
--延期交收还是到期交收，settleType =1为延期订立价交割，其他为到期交割
    if v_settleWay=1 then
       v_settleType:=3;
       if v_delaySettlePriceType=1 then
          v_settlePriceType:=2;
       end if;
    else
        v_settleType:=1;
    end if;
    --查询买卖双方的可配对数量
    select  nvl(sum(HoldQty+GageQty-happenMATCHQTY),0)  into v_amountQty_b from t_settleholdposition t where CommodityID=p_commodityId and BS_Flag=1 and FirmID=p_firmID_B and settletype<>2 and trunc(SettleProcessDate)=to_date(p_settleDate,'yyyy-MM-dd') ;
    select  nvl(sum(HoldQty+GageQty-happenMATCHQTY),0) into v_amountQty_s from t_settleholdposition t where CommodityID=p_commodityId and BS_Flag=2 and FirmID=p_firmID_S and settletype<>2 and trunc(SettleProcessDate)=to_date(p_settleDate,'yyyy-MM-dd') ;
    if(v_amountQty_b<p_quantity)then
        return -1;--买方持仓不足
    end if;
    if(v_amountQty_s<p_quantity)then
        return -2;--卖方持仓不足
    end if;

   --买方
   v_weight:=p_quantity;--配对数量
   for debit in (select * from t_settleholdposition t where CommodityID=p_commodityId and BS_Flag=1 and FirmID=p_firmID_B and settletype<>2 and trunc(SettleProcessDate)=to_date(p_settleDate,'yyyy-MM-dd') order by a_holdno asc)
    loop
       v_settleDate:=p_settleDate;
       v_quantity:=debit.HoldQty+debit.GageQty-debit.happenmatchqty;
       if(v_settlePriceType=2)then
          v_price:=debit.price;
       else
          v_price:=debit.settlePrice;
       end if;
      v_settleprice_b:=debit.settlePrice;
      --部分配对
      if v_quantity > v_weight  then
        --如果商品货款中含税
         if(v_taxIncluesive=0) then
         --税费
         v_everytax:=(v_price*v_weight*v_contractFactor)*(v_addedtax/(1+v_addedtax));
        --基准货款 = 货款 - 税费
          v_buypayout_ref:=v_buypayout_ref+(v_price*v_weight*v_contractFactor-v_everytax);
          --如果商品货款中不含税
         else
           --税费
           v_everytax:=(v_price*v_weight*v_contractFactor)*v_addedtax;
          --基准货款不变
          v_buypayout_ref:=v_buypayout_ref+v_price*v_weight*v_contractFactor;
         end if;
         --每笔交收货款
          v_everybuyPayout:=debit.Payout/(debit.HoldQty+debit.GageQty)*v_weight;
          --保证金
          v_everybuyMargin:=debit.SettleMargin/(debit.HoldQty+debit.GageQty)*v_weight;
          v_buyPayout:=v_buyPayout+v_everybuyPayout;
          v_buyMargin:=v_buyMargin+v_everybuyMargin;
          --税费
          v_buytax:=v_buytax + v_everytax;
          --修改交收持仓明细配对状态=部分配对，已配对数量，已配对货款，已配对保证金
          update T_SettleHoldPosition set MATCHStatus=1,happenmatchqty = happenmatchqty + v_weight,happenMatchPayout=happenMatchPayout+v_everybuyPayout ,
                 happenMatchSettleMargin=happenMatchSettleMargin+v_everybuyMargin,SETTLEADDEDTAX=debit.SETTLEADDEDTAX+v_everytax where id=debit.id;
          --插入交收配对关联表
          insert into T_MatchSettleholdRelevance (MatchID, SettleID, Quantity, Price, SettlePayOut, Settlemargin) values (p_matchId, debit.id, v_weight, v_price, v_everybuyPayout, v_everybuyMargin);
          v_weight:=0;
      else
        --全部配对的情况
         if v_quantity > 0 then
         --如果商品货款中含税
         if(v_taxIncluesive=0) then
         --税费
         v_everytax:=(v_price*v_quantity*v_contractFactor)*(v_addedtax/(1+v_addedtax));
        --基准货款 = 货款 - 税费
          v_buypayout_ref:=v_buypayout_ref+(v_price*v_quantity*v_contractFactor-v_everytax);
          --如果商品货款中不含税
         else
           --税费
           v_everytax:=(v_price*v_quantity*v_contractFactor)*v_addedtax;
          --基准货款不变
          v_buypayout_ref:=v_buypayout_ref+v_price*v_quantity*v_contractFactor;
         end if;
          v_weight:=v_weight - v_quantity;
          --最后一笔持仓用减法换算已配对货款和保证金
          v_everybuyPayout:=debit.Payout-debit.happenMatchPayout;
          v_everybuyMargin:=debit.SettleMargin-debit.happenMatchSettleMargin;
          v_buyPayout:=v_buyPayout+v_everybuyPayout;
          v_buyMargin:=v_buyMargin+v_everybuyMargin;
           --税费
          v_buytax:=v_buytax + v_everytax;
          --修改交收持仓明细配对状态=全部配对，已配对数量，已配对货款，已配对保证金
          update T_SettleHoldPosition set MATCHStatus=2,happenmatchqty = debit.HoldQty+debit.GageQty ,happenMatchPayout=happenMatchPayout+v_everybuyPayout ,
                 happenMatchSettleMargin=happenMatchSettleMargin+v_everybuyMargin,SETTLEADDEDTAX=debit.SETTLEADDEDTAX+v_everytax  where id=debit.id;
          --插入交收配对关联表
          insert into T_MatchSettleholdRelevance (MatchID, SettleID, Quantity, Price, SettlePayOut, Settlemargin) values (p_matchId, debit.id, v_quantity, v_price, v_everybuyPayout, v_everybuyMargin);
        end if;
      end if;
      exit when v_weight=0;
    end loop;

    --卖方
    v_weight:=p_quantity;--配对数量
    for debit in (select * from t_settleholdposition t where CommodityID=p_commodityId and BS_Flag=2 and FirmID=p_firmID_S and settletype<>2 and trunc(SettleProcessDate)=to_date(p_settleDate,'yyyy-MM-dd') order by a_holdno asc)
     loop
      v_settleDate:=p_settleDate;
      v_quantity:=debit.HoldQty+debit.GageQty-debit.happenmatchqty;
      if(v_settlePriceType=2)then
          v_price:=debit.price;
      else
          v_price:=debit.settlePrice;
      end if;
      v_settleprice_s:=debit.settlePrice;
      if v_quantity > v_weight  then
         --如果商品货款中含税
         if(v_taxIncluesive=0) then
         --税费
          v_everytax:=(v_price*v_weight*v_contractFactor)*(v_addedtax /(1+v_addedtax));
        --基准货款 = 货款 - 税费
           v_sellincom_ref:=v_sellincom_ref+(v_price*v_weight*v_contractFactor-v_everytax);
          --如果商品货款中不含税
         else
          --基准货款不变
            v_sellincom_ref:=v_sellincom_ref+v_price*v_weight*v_contractFactor;
         end if;
          v_everysellMargin:=debit.SettleMargin/(debit.HoldQty+debit.GageQty)*v_weight;
          v_sellMargin:=v_sellMargin+v_everysellMargin;
          --修改交收持仓明细配对状态=部分配对，已配对数量，已配对保证金
          update T_SettleHoldPosition set MATCHStatus=1,happenmatchqty = happenmatchqty + v_weight,
                 happenMatchSettleMargin=happenMatchSettleMargin+v_everysellMargin where id=debit.id;
          --插入交收配对关联表
          insert into T_MatchSettleholdRelevance (MatchID, SettleID, Quantity, Price, SettlePayOut, Settlemargin) values (p_matchId, debit.id, v_weight, v_price, 0, v_everysellMargin);
          v_weight:=0;
      else
         if v_quantity > 0 then
            --如果商品货款中含税
         if(v_taxIncluesive=0) then
          v_everytax:=(v_price*v_quantity*v_contractFactor)*(v_addedtax/(1+v_addedtax));
        --基准货款 = 货款 - 税费
          v_sellincom_ref:=v_sellincom_ref+(v_price*v_quantity*v_contractFactor-v_everytax);
          --如果商品货款中不含税
         else
           --税费
           --v_everytax:=(v_price*v_quantity*v_contractFactor)*v_addedtax;
          --基准货款不变
          v_sellincom_ref:=v_sellincom_ref+v_price*v_quantity*v_contractFactor;
         end if;
          v_everysellMargin:=debit.SettleMargin-debit.happenMatchSettleMargin;
          v_sellMargin:=v_sellMargin+v_everysellMargin;
          v_weight:=v_weight - v_quantity;
          --修改交收持仓明细配对状态=全部配对，已配对数量，已配对保证金
          update T_SettleHoldPosition set MATCHStatus=2,happenmatchqty = debit.HoldQty+debit.GageQty ,
                 happenMatchSettleMargin=happenMatchSettleMargin+v_everysellMargin where id=debit.id;
          --插入交收配对关联表
          insert into T_MatchSettleholdRelevance (MatchID, SettleID, Quantity, Price, SettlePayOut, Settlemargin) values (p_matchId, debit.id, v_quantity, v_price, 0, v_everysellMargin);
        end if;
      end if;
      exit when v_weight=0;
    end loop;
    --插入交收配对表
    insert into T_SettleMatch (MatchID,  CommodityID,  ContractFactor,  Quantity,Status,Result,SettleType, FirmID_B,  BuyPrice,  BuyPayout_Ref,  BuyPayout,  BuyMargin,
                               FirmID_S,SellPrice,SellIncome_Ref,SellIncome,SellMargin,CreateTime,ModifyTime,SettleDate, Modifier,buytax,taxIncluesive)
                         values(p_matchId,p_commodityId,v_contractFactor,p_quantity,p_status,p_result,v_settleType,p_firmID_B,v_settleprice_b,v_buypayout_ref,v_buyPayout,v_buyMargin,
                               p_firmID_S,v_settleprice_s,v_sellincom_ref,0,v_sellMargin,sysdate, sysdate,to_date(v_settleDate,'yyyy-MM-dd'),p_operator,v_buytax,v_taxIncluesive);
    --插入交收配对日志表
    insert into T_SettleMatchLog(id,Matchid,operator,Operatelog,Updatetime) values(seq_t_settlematchlog.nextval,p_matchId,p_operator,'添加交收配对：配对数量'||p_quantity||',买方：'||p_firmID_B||',价格：'||v_settleprice_b||',卖方:'||p_firmID_S||'价格：'||v_settleprice_s,sysdate);
     --配对成功后首先将税收付清 ,无论商品是否含税都会收费 ,收买方税费,如果不是履约，不进行税费收取
     if(p_result =1) then
       v_fundsflow:=fn_f_updatefundsfull(p_firmID_B,'15100',v_buytax,p_matchId,p_commodityId,null,null);
      insert into T_SettleMatchFundManage(Id,Matchid,Firmid,Summaryno,Amount,Operatedate,Commodityid) values(seq_t_settlematchfundmanage.nextval,p_matchId,p_firmID_B,'15100',v_buytax,sysdate,p_commodityId);
      --写配对日志
      insert into t_Settlematchlog(id,Matchid,Operator,Operatelog,Updatetime) values(seq_t_settlematchlog.nextval,p_matchId,'系统','收买方增值税,配对ID:'||p_matchId||' 金额:'||v_buytax,sysdate);
      --付卖方税费流水
       v_fundsflow:=fn_f_updatefundsfull(p_firmID_S,'15101',v_buytax,p_matchId,p_commodityId,null,null);
      insert into T_SettleMatchFundManage(Id,Matchid,Firmid,Summaryno,Amount,Operatedate,Commodityid) values(seq_t_settlematchfundmanage.nextval,p_matchId,p_firmID_S,'15101',v_buytax,sysdate,p_commodityId);
      insert into t_Settlematchlog(id,Matchid,Operator,Operatelog,Updatetime) values(seq_t_settlematchlog.nextval,p_matchId,'系统','付卖方增值税,配对ID:'||p_matchId||' 金额:'||v_buytax,sysdate);
      end if;
return 1;
end;
/


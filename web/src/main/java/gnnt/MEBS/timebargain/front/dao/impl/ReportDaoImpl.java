package gnnt.MEBS.timebargain.front.dao.impl;

import gnnt.MEBS.common.front.dao.StandardDao;
import gnnt.MEBS.timebargain.front.dao.ReportDao;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.springframework.stereotype.Repository;

@Repository("reportDao")
public class ReportDaoImpl
  extends StandardDao
  implements ReportDao
{
  public List<Map<Object, Object>> firmFundsQuery(Map<String, String> params)
  {
    StringBuffer sb = new StringBuffer();
    sb
      .append(
      "select distinct a.*, (b.ClearMargin-b.ClearAssure) ClearMargin,b.ClearFL,b.ClearSettleMargin,")
      .append(
      "(b.RuntimeMargin-b.RuntimeAssure) RuntimeMargin,RuntimeFL,RuntimeSettleMargin,MinClearDeposit,b.MaxOverdraft, ")
      .append(
      "nvl((select sum(floatingloss) from t_h_Firmholdsum where firmid = b.firmid and cleardate = a.B_Date),0) PL ")
      .append(
      "from F_FirmBalance a,t_h_firm b where a.firmID(+)=b.firmID and a.B_Date=b.cleardate ")
      .append(" and a.firmid='").append((String)params.get("firmid")).append(
      "' and a.b_date=to_date('")
      .append((String)params.get("b_date")).append("','yyyy-MM-dd')");
    
    this.logger.debug("资金结算报表查询sql1: " + sb.toString());
    List<Map<Object, Object>> fundList1 = queryBySql(sb.toString());
    
    StringBuffer sb2 = new StringBuffer();
    sb2
      .append(
      "select nvl(sum(case when f.fieldsign>0 then t.value else -t.value end),0) value from (select * from f_clientledger where firmId='")
      .append((String)params.get("firmid"))
      .append("' and b_date=to_date('")
      .append((String)params.get("b_date"))
      .append("','yyyy-MM-dd')) t,")
      .append(
      "f_ledgerfield f where f.code=t.code(+) and f.moduleid not in (22,15) order by f.moduleid,f.ordernum ");
    
    this.logger.debug("资金结算报表查询sql2: " + sb2.toString());
    List<Map<Object, Object>> fundList2 = queryBySql(sb2.toString());
    if ((fundList1 != null) && (fundList1.size() > 0)) {
      ((Map)fundList1.get(0)).putAll((Map)fundList2.get(0));
    }
    return fundList1;
  }
  
  public List<Map<Object, Object>> getFundFields(Map<String, String> params)
  {
    StringBuffer sb = new StringBuffer();
    sb
      .append(
      "select nvl(b.Value,0) Value,a.Name,a.FieldSign From F_LedgerField a,")
      .append("(select * from F_ClientLedger ")
      .append("where firmId='")
      .append((String)params.get("firmid"))
      .append("' and b_date=to_date('")
      .append((String)params.get("b_date"))
      .append("','yyyy-MM-dd')")
      .append(
      " ) b where  b.Code(+)=a.Code and a.moduleid in (22,15) order by moduleid,ordernum ");
    this.logger.debug("资金结算表中字段查询sql: " + sb.toString());
    return queryBySql(sb.toString());
  }
  
  public List<Map<Object, Object>> tradesQuery(Map<String, String> params)
  {
    StringBuffer sb = new StringBuffer();
    sb.append("select * from (select distinct rownum num, a.CUSTOMERID, a.A_TRADENO, a.PRICE, a.QUANTITY, a.TRADEFEE,")
      .append("a.tradeTime, b.OrderTime ,d.CommodityID, ")
      .append("(case when a.BS_Flag=1 then '买进' when a.BS_Flag=2 then '卖出' else '' end) || ")
      .append(" (case when a.OrderType=1 then '订货' when a.OrderType=2 then '转让' else '' end) BSOrderType ")
      .append("from T_H_Trade a,T_H_Orders b,T_H_Commodity d ")
      .append("where a.ClearDate = b.ClearDate(+) and a.ClearDate=d.ClearDate and a.A_OrderNo = b.A_OrderNo(+) and a.CommodityID=d.CommodityID  ")
      .append("and a.firmID='" + (String)params.get("a.firmID") + "' ").append("and a.ClearDate >= to_date('" + (String)params.get("startDate") + "', 'yyyy-MM-dd') ")
      .append("and a.ClearDate <= to_date('" + (String)params.get("endDate") + "', 'yyyy-MM-dd') ");
    
    sb.append(" order by a.A_TradeNo) ");
    sb.append("where num between " + (String)params.get("startCount") + " and " + (String)params.get("endCount"));
    this.logger.debug("sql: " + sb.toString());
    return queryBySql(sb.toString());
  }
  
  public int tradesQueryCount(Map<String, String> params)
  {
    StringBuffer sb = new StringBuffer();
    sb.append("select * from (select distinct rownum num, a.CUSTOMERID, a.A_TRADENO, a.PRICE, a.QUANTITY, a.TRADEFEE,")
      .append("a.tradeTime, b.OrderTime ,d.CommodityID, ")
      .append("(case when a.BS_Flag=1 then '买进' when a.BS_Flag=2 then '卖出' else '' end) || ")
      .append(" (case when a.OrderType=1 then '订货' when a.OrderType=2 then '转让' else '' end) BSOrderType ")
      .append("from T_H_Trade a,T_H_Orders b,T_H_Commodity d ")
      .append("where a.ClearDate = b.ClearDate(+) and a.ClearDate=d.ClearDate and a.A_OrderNo = b.A_OrderNo(+) and a.CommodityID=d.CommodityID  ")
      .append("and a.firmID='" + (String)params.get("a.firmID") + "' ").append("and a.ClearDate >= to_date('" + (String)params.get("startDate") + "', 'yyyy-MM-dd') ")
      .append("and a.ClearDate <= to_date('" + (String)params.get("endDate") + "', 'yyyy-MM-dd') ");
    
    sb.append(" order by a.A_TradeNo) ");
    this.logger.debug("sql: " + sb.toString());
    
    return queryBySql(sb.toString()).size();
  }
  
  public List<Map<Object, Object>> tradesQuerySum(Map<String, String> params)
  {
    StringBuffer sb = new StringBuffer();
    sb.append("select nvl(sum(QUANTITY),0) quantitySum, nvl(sum(TRADEFEE),0) tradefeeSum from (select distinct rownum num, a.CUSTOMERID, a.A_TRADENO, a.PRICE, a.QUANTITY, a.TRADEFEE,")
      .append("a.tradeTime, b.OrderTime ,d.CommodityID, ")
      .append("(case when a.BS_Flag=1 then '买进' when a.BS_Flag=2 then '卖出' else '' end) || ")
      .append(" (case when a.OrderType=1 then '订货' when a.OrderType=2 then '转让' else '' end) BSOrderType ")
      .append("from T_H_Trade a,T_H_Orders b,T_H_Commodity d ")
      .append("where a.ClearDate = b.ClearDate(+) and a.ClearDate=d.ClearDate and a.A_OrderNo = b.A_OrderNo(+) and a.CommodityID=d.CommodityID  ")
      .append("and a.firmID='" + (String)params.get("a.firmID") + "' ").append("and a.ClearDate >= to_date('" + (String)params.get("startDate") + "', 'yyyy-MM-dd') ")
      .append("and a.ClearDate <= to_date('" + (String)params.get("endDate") + "', 'yyyy-MM-dd') ");
    
    sb.append(" order by a.A_TradeNo) ");
    return queryBySql(sb.toString());
  }
  
  public List<Map<Object, Object>> firmHoldSumQuery(Map<String, String> params)
  {
    StringBuffer sb = new StringBuffer();
    sb.append("select * from (select  rownum num, a.*,a.HoldQty+a.GageQty HoldGageQty,b.Price LastPrice, ")
      .append("case when a.BS_Flag=1 then '买' when a.BS_Flag=2 then '卖' else '' end as sBS_Flag ")
      .append("from T_H_CustomerHoldSum a,T_H_Quotation b ")
      .append("where a.ClearDate=b.ClearDate and a.CommodityID=b.CommodityID ")
      .append("and a.firmID='" + (String)params.get("a.firmID") + "' ").append("and a.ClearDate=to_date('" + (String)params.get("a.ClearDate") + "', 'yyyy-MM-dd') ");
    
    sb.append(" order by a.CustomerID,b.CommodityID,a.BS_Flag )");
    sb.append("where num between " + (String)params.get("startCount") + " and " + (String)params.get("endCount"));
    this.logger.debug("sql: " + sb.toString());
    return queryBySql(sb.toString());
  }
  
  public List<Map<Object, Object>> transferProfitAndLossQuery(Map<String, String> params)
  {
    StringBuffer sb = new StringBuffer();
    sb.append("select * from (select  rownum num, a.*, ")
      .append("(case when a.BS_Flag=1 then '买进' when a.BS_Flag=2 then '卖出' else '' end) || ")
      .append(" (case when a.OrderType=1 then '订货' when a.OrderType=2 then '转让' else '' end) BSOrderType ")
      .append("from T_H_Trade a,T_H_Commodity b ")
      .append("where a.OrderType=2 and a.ClearDate=b.ClearDate and a.CommodityID=b.CommodityID ")
      .append("and a.firmID='" + (String)params.get("a.firmID") + "' ").append("and a.ClearDate=to_date('" + (String)params.get("a.ClearDate") + "','yyyy-MM-dd')");
    sb.append(" order by a.A_TradeNo)");
    sb.append("where num between " + (String)params.get("startCount") + " and " + (String)params.get("endCount"));
    this.logger.debug("sql: " + sb.toString());
    return queryBySql(sb.toString());
  }
  
  public List<Map<Object, Object>> tradeSettleQuery(Map<String, String> params)
  {
    StringBuffer sb = new StringBuffer();
    sb.append("select * from (select  rownum num, to_char(shp.settleprocessdate,'YYYY-MM-DD') settleprocessdate,shp.firmid,shp.commodityid, case when shp.bs_flag=1 then '买' when shp.bs_flag=2 then '卖' else '' end as bs_flag, (shp.HoldQty + shp.GageQty) settleQty, shp.a_HoldNo,shp.openQty,shp.settleMargin,shp.payout, shp.settleFee,shp.settle_PL,shp.SettleAddedTax,shp.Price, shp.HappenMatchTax, shp.SettlePrice from T_SettleHoldPosition shp where shp.firmID='" + 
    
      (String)params.get("shp.firmID") + "' " + 
      "and shp.settleprocessdate=to_date('" + (String)params.get("shp.settleprocessdate") + "','yyyy-MM-dd'))");
    sb.append("where num between " + (String)params.get("startCount") + " and " + (String)params.get("endCount"));
    this.logger.debug("sql: " + sb.toString());
    return queryBySql(sb.toString());
  }
  
  public List<Map<Object, Object>> validGageBillQuery(Map<String, String> params)
  {
    StringBuffer sb = new StringBuffer();
    
    System.out.println((String)params.get("a.commodityID"));
    if (((params.get("a.commodityID") == null ? 1 : 0) | (params.get("a.commodityID") == "" ? 1 : 0)) != 0)
    {
      sb.append(" select * from (select  rownum num, a.* from T_ValidGageBill a where firmid = '" + 
        (String)params.get("a.firmID") + "' order by a.commodityid ) ");
      sb.append("where num between " + (String)params.get("startCount") + " and " + (String)params.get("endCount"));
    }
    else
    {
      sb.append(" select * from (select  rownum num, a.* from T_ValidGageBill a where firmid = '" + 
        (String)params.get("a.firmID") + "' and a.commodityID='" + (String)params.get("a.commodityID") + "' order by a.commodityid ) ");
      sb.append("where num between " + (String)params.get("startCount") + " and " + (String)params.get("endCount"));
    }
    this.logger.debug("sql: " + sb.toString());
    
    System.out.println("================");
    System.out.println(sb.toString());
    
    return queryBySql(sb.toString());
  }
  
  public List<Map<Object, Object>> fundDetailQuery(Map<String, String> params)
  {
    StringBuffer sb = new StringBuffer();
    sb.append("select a.settleFee,a.settlePL,a.t_goodmoney,a.settleMargain,a.penal,tradefee ")
      .append("from (select max(firmid) firmid,")
      .append("sum(case when oprcode = '15010' then amount else 0 end) settleFee,")
      .append("(sum(case when oprcode = '15011' then amount else 0 end) - sum(case when oprcode = '15012' then amount else 0 end)) settlePL,")
      .append("(sum(case when oprcode = '15009' then amount else 0 end) - sum(case when oprcode = '15008' then amount else 0 end)) t_goodmoney,")
      .append("(sum(case when oprcode = '15014' then amount else 0 end) - sum(case when oprcode = '15013' then amount else 0 end)) settleMargain,")
      .append("(sum(case when oprcode = '15017' then amount else 0 end) - sum(case when oprcode = '15018' then amount else 0 end)) penal,")
      .append("sum(case when oprcode = '15001' then amount else 0 end) tradefee ")
      .append("from f_fundflow where firmid='" + (String)params.get("a.firmID") + "') a ")
      .append("where 1=1  ")
      .append("and a.firmID='" + (String)params.get("a.firmID") + "' ");
    this.logger.debug("sql: " + sb.toString());
    return queryBySql(sb.toString());
  }
  
  public List firm_info(String firmID, String traderID, String firmName)
  {
    List firmList = new ArrayList();
    StringBuffer sb = new StringBuffer();
    sb.append("select a.lastbalance,a.balance,")
      .append("nvl((select sum(amount) from f_fundflow where firmid=b.firmid and oprcode in ('11001','11003')),0) inAmount,")
      .append("nvl((select sum(amount) from f_fundflow where firmid=b.firmid and oprcode in ('11002','11004')),0) outAmount,")
      .append("nvl((select sum(close_pl) from t_trade where firmid=b.firmid and close_pl is not null),0) close_pl,")
      .append("nvl((select sum(tradefee) from t_trade where firmid=b.firmid),0) tradefee,")
      .append("b.ClearMargin,b.clearfl,b.runtimemargin,b.runtimefl,b.ClearAssure,b.MaxOverdraft,b.RuntimeSettleMargin,")
      .append("nvl((select sum(frozenfunds - unfrozenfunds) from t_orders where firmid = b.firmid),0) orderFrozen,")
      .append("(a.frozenfunds-nvl(c.frozenfunds,0)) otherFrozen,(a.balance - a.frozenfunds) usefulFund,b.virtualfunds,nvl((select sum(floatingloss) from t_Firmholdsum where firmid = b.firmid),0) PL,b.runtimeassure ")
      .append("from F_FIRMFUNDS a,T_Firm b, (select firmid,frozenfunds from f_Frozenfunds where moduleid='15' and firmID='" + firmID + "') c ")
      .append("where a.firmid = b.firmid and a.firmid = c.firmid(+) and b.firmID = '" + firmID + "'");
    List<Map<Object, Object>> lst = queryBySql(sb.toString());
    Map map1 = (Map)lst.get(0);
    
    String ids = null;
    
    String sql = "select OperateCode from T_Trader where TraderID = '" + traderID + "'";
    List list = queryBySql(sql);
    if ((list != null) && (list.size() > 0))
    {
      Map map = (Map)list.get(0);
      String id = (String)map.get("OperateCode");
      if (id != null) {
        ids = id;
      } else {
        ids = getCustomersOfMFirm(firmID);
      }
    }
    else
    {
      ids = getCustomersOfMFirm(firmID);
    }
    map1.put("FirmID", firmID);
    map1.put("Name", firmName);
    map1.put("OperateCode", ids);
    firmList.add(map1);
    
    return firmList;
  }
  
  private String getCustomersOfMFirm(String firmID)
  {
    List idList = queryBySql("select Code from T_Customer where FirmID='" + firmID + "'");
    StringBuffer idSB = new StringBuffer();
    for (Object o : idList)
    {
      Map idmap = (Map)o;
      idSB.append((String)idmap.get("Code")).append(",");
    }
    String ids = idSB.toString();
    if ((ids != null) && (!ids.equals(""))) {
      ids = ids.substring(0, ids.length() - 1);
    }
    return ids;
  }
}

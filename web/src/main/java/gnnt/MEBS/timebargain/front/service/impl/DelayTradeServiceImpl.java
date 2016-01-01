package gnnt.MEBS.timebargain.front.service.impl;

import gnnt.MEBS.common.front.service.StandardService;
import gnnt.MEBS.timebargain.front.dao.DelayTradeDao;
import gnnt.MEBS.timebargain.front.service.DelayTradeService;
import gnnt.MEBS.timebargain.server.model.DelayOrder;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("delayTradeService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false)
public class DelayTradeServiceImpl
  extends StandardService
  implements DelayTradeService
{
  @Autowired
  @Qualifier("delayTradeDao")
  private DelayTradeDao delayDao;
  
  public void setDelayDao(DelayTradeDao delayDao)
  {
    this.delayDao = delayDao;
  }
  
  public List<Map<Object, Object>> delayQuotation_query()
  {
    StringBuilder sb = new StringBuilder();
    sb.append(" select a.commodityid,a.Price, a.totalamount,a.reservecount, b.buysettleqty, b.sellsettleqty ")
      .append(" ,b.BuyNeutralQty,b.SellNeutralQty,decode(b.NeutralSide,1,'买',2,'卖','-') as NeutralSide")
      .append(" from t_quotation a, t_delayquotation b")
      .append(" where a.commodityid = b.commodityid")
      .append(" order by  a.commodityid");
    return getListBySql(sb.toString());
  }
  
  public List<Map<Object, Object>> delayOrderQuery(String firmId, String commodityId)
  {
    StringBuilder sb = new StringBuilder();
    sb.append("select A_OrderNo,to_char(OrderTime,'hh24:mi:ss') time,CommodityID,CustomerID, ")
      .append("case when BS_Flag=1 then '买' when BS_Flag=2 then '卖' end as flag, ")
      .append("Price,Quantity,(Quantity-TradeQty) noTradeQty,Status, ")
      .append("case when DelayOrderType=1 then '交收申报' when DelayOrderType=2 then '中立仓' end as Type ")
      .append("from T_DelayOrders where CustomerID = '").append(firmId).append("00' ");
    if ((commodityId != null) && (!commodityId.equals("")))
    {
      commodityId = commodityId.trim();
      sb.append(" and CommodityID='").append(commodityId).append("'");
    }
    sb.append(" order by A_OrderNo,OrderTime");
    this.logger.debug("delay_order_query:" + sb.toString());
    return getListBySql(sb.toString());
  }
  
  public List<Map<Object, Object>> delayCommodityHoldingQuery(String firmId, String commodityId)
  {
    String sql = "select s.CustomerID,s.CommodityID,s.HoldQty,s.FrozenQty,  case when s.BS_Flag=1 then '买' when s.BS_Flag=2 then '卖' end as flag   from T_CustomerHoldSum s, T_Commodity c where s.commodityid = c.commodityid and c.settleway = 1 ";
    if (firmId != null) {
      sql = sql + " and s.CustomerID='" + firmId + "00'";
    }
    if ((commodityId != null) && (!commodityId.equals("")))
    {
      commodityId = commodityId.trim();
      sql = sql + " and s.CommodityID='" + commodityId + "'";
    }
    this.logger.debug("delayCommodityHoldingQuery:" + sql);
    return getListBySql(sql);
  }
  
  public String getNeutralSideById(String commodityId)
  {
    List<Map<Object, Object>> neutralSideList = getListBySql("select d.NeutralSide from T_DelayQuotation d where d.commodityId = '" + commodityId + "'");
    if ((neutralSideList == null) || (neutralSideList.size() == 0)) {
      return "0";
    }
    return String.valueOf(((Map)neutralSideList.get(0)).get("NEUTRALSIDE"));
  }
  
  public DelayOrder getDelayOrderById(String orderNo)
  {
    return this.delayDao.getDelayOrderById(orderNo);
  }
}

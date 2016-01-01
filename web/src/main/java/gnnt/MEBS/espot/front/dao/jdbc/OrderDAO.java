package gnnt.MEBS.espot.front.dao.jdbc;

import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.espot.front.model.trade.Order;
import gnnt.MEBS.espot.front.model.trade.Trade;
import gnnt.MEBS.espot.front.vo.ShopVO;

public abstract interface OrderDAO
  extends DAO
{
  public abstract Page<ShopVO> getFirmByParamter(String paramString, PageRequest<QueryConditions> paramPageRequest);
  
  public abstract Page<Order> getOrdersByCommodity(long paramLong, String paramString, PageRequest<QueryConditions> paramPageRequest);
  
  public abstract Page<Trade> getTradesByCommodity(long paramLong, String paramString, PageRequest<QueryConditions> paramPageRequest);
  
  public abstract Page<Order> getOrderByFirmID(PageRequest<QueryConditions> paramPageRequest, String paramString);
}

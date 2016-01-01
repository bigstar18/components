package gnnt.MEBS.vendue.front.model;

import gnnt.MEBS.priceranking.server.model.CommodityOrder;
import java.util.List;

public class QuantionPage
{
  List<CommodityOrder> list;
  long count;
  int currentPage = 1;
  int totalPage = 1;
  int pageNumber = 15;
  int rowNumber = 0;
  
  public List<CommodityOrder> getList()
  {
    return this.list;
  }
  
  public void setList(List<CommodityOrder> paramList)
  {
    this.list = paramList;
  }
  
  public long getCount()
  {
    return this.count;
  }
  
  public void setCount(long paramLong)
  {
    this.count = paramLong;
  }
  
  public int getCurrentPage()
  {
    return this.currentPage;
  }
  
  public void setCurrentPage(int paramInt)
  {
    this.currentPage = paramInt;
  }
  
  public int getTotalPage()
  {
    return this.totalPage;
  }
  
  public void setTotalPage(int paramInt)
  {
    this.totalPage = paramInt;
  }
  
  public int getPageNumber()
  {
    return this.pageNumber;
  }
  
  public void setPageNumber(int paramInt)
  {
    this.pageNumber = paramInt;
  }
  
  public int getRowNumber()
  {
    return this.rowNumber;
  }
  
  public void setRowNumber(int paramInt)
  {
    this.rowNumber = paramInt;
  }
}

package gnnt.MEBS.bill.core.vo;

public class AddStockResultVO
  extends ResultVO
{
  private static final long serialVersionUID = 183417122999747317L;
  private String stockID = "-1";
  
  public String getStockID()
  {
    return this.stockID;
  }
  
  public void setStockID(String paramString)
  {
    this.stockID = paramString;
  }
}

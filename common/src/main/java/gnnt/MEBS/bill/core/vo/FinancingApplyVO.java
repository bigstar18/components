package gnnt.MEBS.bill.core.vo;

public class FinancingApplyVO
  extends ResultVO
{
  private static final long serialVersionUID = 8577690642779533367L;
  private long financingStockID;
  
  public long getFinancingStockID()
  {
    return this.financingStockID;
  }
  
  public void setFinancingStockID(long paramLong)
  {
    this.financingStockID = paramLong;
  }
}

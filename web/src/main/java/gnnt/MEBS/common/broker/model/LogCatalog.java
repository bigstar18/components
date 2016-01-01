package gnnt.MEBS.common.broker.model;

public class LogCatalog
  extends StandardModel
{
  private static final long serialVersionUID = -4112756031753238119L;
  private Integer catalogID;
  private String catalogName;
  private TradeModule tradeModule;
  
  public Integer getCatalogID()
  {
    return this.catalogID;
  }
  
  public void setCatalogID(Integer catalogID)
  {
    this.catalogID = catalogID;
  }
  
  public String getCatalogName()
  {
    return this.catalogName;
  }
  
  public void setCatalogName(String catalogName)
  {
    this.catalogName = catalogName;
  }
  
  public TradeModule getTradeModule()
  {
    return this.tradeModule;
  }
  
  public void setTradeModule(TradeModule tradeModule)
  {
    this.tradeModule = tradeModule;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo(  "catalogID", this.catalogID);
  }
}

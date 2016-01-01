package gnnt.MEBS.priceranking.server.model;

public class TradeAuthority
{
  private String code;
  private String firmId;
  
  public String getFirmId()
  {
    return this.firmId;
  }
  
  public void setFirmId(String firmId)
  {
    this.firmId = firmId;
  }
  
  public void setCode(String code)
  {
    this.code = code;
  }
  
  public String getCode()
  {
    return this.code;
  }
}

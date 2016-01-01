package gnnt.MEBS.espot.front.vo;

import java.io.Serializable;

public class ShopVO
  implements Serializable
{
  private static final long serialVersionUID = 6091341820961097454L;
  private String firmID;
  private String name;
  private String shopName;
  private String contactMan;
  private String phone;
  private String description;
  private String level;
  
  public String getFirmID()
  {
    return this.firmID;
  }
  
  public void setFirmID(String paramString)
  {
    this.firmID = paramString;
  }
  
  public String getName()
  {
    return this.name;
  }
  
  public void setName(String paramString)
  {
    this.name = paramString;
  }
  
  public String getShopName()
  {
    return this.shopName;
  }
  
  public void setShopName(String paramString)
  {
    this.shopName = paramString;
  }
  
  public String getContactMan()
  {
    return this.contactMan;
  }
  
  public void setContactMan(String paramString)
  {
    this.contactMan = paramString;
  }
  
  public String getPhone()
  {
    return this.phone;
  }
  
  public void setPhone(String paramString)
  {
    this.phone = paramString;
  }
  
  public String getDescription()
  {
    return this.description;
  }
  
  public void setDescription(String paramString)
  {
    this.description = paramString;
  }
  
  public String getLevel()
  {
    return this.level;
  }
  
  public void setLevel(String paramString)
  {
    this.level = paramString;
  }
}

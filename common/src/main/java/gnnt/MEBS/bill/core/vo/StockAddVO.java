package gnnt.MEBS.bill.core.vo;

import gnnt.MEBS.bill.core.po.GoodsPropertyPO;
import java.util.List;

public class StockAddVO
  extends ResultVO
{
  private static final long serialVersionUID = -4254490545343840639L;
  private String firmID;
  private String firmName;
  private String wareHousePassword;
  private String categoryName;
  private String breedName;
  private String unit;
  private double quantity;
  private String stockID;
  private String wareHouseName;
  private List<GoodsPropertyPO> propertyList;
  
  public String getFirmID()
  {
    return this.firmID;
  }
  
  public void setFirmID(String paramString)
  {
    this.firmID = paramString;
  }
  
  public String getFirmName()
  {
    return this.firmName;
  }
  
  public void setFirmName(String paramString)
  {
    this.firmName = paramString;
  }
  
  public String getWareHousePassword()
  {
    return this.wareHousePassword;
  }
  
  public void setWareHousePassword(String paramString)
  {
    this.wareHousePassword = paramString;
  }
  
  public String getCategoryName()
  {
    return this.categoryName;
  }
  
  public void setCategoryName(String paramString)
  {
    this.categoryName = paramString;
  }
  
  public String getBreedName()
  {
    return this.breedName;
  }
  
  public void setBreedName(String paramString)
  {
    this.breedName = paramString;
  }
  
  public String getUnit()
  {
    return this.unit;
  }
  
  public void setUnit(String paramString)
  {
    this.unit = paramString;
  }
  
  public double getQuantity()
  {
    return this.quantity;
  }
  
  public void setQuantity(double paramDouble)
  {
    this.quantity = paramDouble;
  }
  
  public String getStockID()
  {
    return this.stockID;
  }
  
  public void setStockID(String paramString)
  {
    this.stockID = paramString;
  }
  
  public String getWareHouseName()
  {
    return this.wareHouseName;
  }
  
  public void setWareHouseName(String paramString)
  {
    this.wareHouseName = paramString;
  }
  
  public List<GoodsPropertyPO> getPropertyList()
  {
    return this.propertyList;
  }
  
  public void setPropertyList(List<GoodsPropertyPO> paramList)
  {
    this.propertyList = paramList;
  }
}

package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class XShop
  extends StandardModel
{
  private static final long serialVersionUID = 5002039308356318430L;
  @ClassDiscription(name="交易商代码", description="")
  private String firmID;
  @ClassDiscription(name="所属交易商", description="")
  private MFirm belongtoFirm;
  @ClassDiscription(name="店铺名称", description="")
  private String shopName;
  @ClassDiscription(name="店铺等级", description="")
  private Integer shopLevel;
  @ClassDiscription(name="店铺说明", description="")
  private String description;
  @ClassDiscription(name="店铺图片", description="")
  private byte[] headImage;
  
  public String getFirmID()
  {
    return this.firmID;
  }
  
  public void setFirmID(String paramString)
  {
    this.firmID = paramString;
  }
  
  public MFirm getBelongtoFirm()
  {
    return this.belongtoFirm;
  }
  
  public void setBelongtoFirm(MFirm paramMFirm)
  {
    this.belongtoFirm = paramMFirm;
  }
  
  public String getShopName()
  {
    return this.shopName;
  }
  
  public void setShopName(String paramString)
  {
    this.shopName = paramString;
  }
  
  public Integer getShopLevel()
  {
    return this.shopLevel;
  }
  
  public void setShopLevel(Integer paramInteger)
  {
    this.shopLevel = paramInteger;
  }
  
  public String getDescription()
  {
    return this.description;
  }
  
  public void setDescription(String paramString)
  {
    this.description = paramString;
  }
  
  public byte[] getHeadImage()
  {
    return this.headImage;
  }
  
  public void setHeadImage(byte[] paramArrayOfByte)
  {
    this.headImage = paramArrayOfByte;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("firmID", this.firmID);
  }
}

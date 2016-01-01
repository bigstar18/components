package gnnt.MEBS.espot.mgr.model.shopmanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import gnnt.MEBS.espot.mgr.model.firmmanage.MFirm;

public class Shop
  extends StandardModel
{
  private static final long serialVersionUID = 1143108019859496293L;
  @ClassDiscription(name="交易商代码", description="")
  private String firmId;
  @ClassDiscription(name="店铺名称", description="")
  private String shopName;
  @ClassDiscription(name="店铺等级", description="")
  private Integer shopLevel;
  @ClassDiscription(name="店铺说明", description="")
  private String description;
  @ClassDiscription(name="店铺图片路径", description="")
  private byte[] headImage;
  @ClassDiscription(name="关联交易商", description="")
  private MFirm firm;
  
  public MFirm getFirm()
  {
    return this.firm;
  }
  
  public void setFirm(MFirm paramMFirm)
  {
    this.firm = paramMFirm;
  }
  
  public String getFirmId()
  {
    return this.firmId;
  }
  
  public void setFirmId(String paramString)
  {
    this.firmId = paramString;
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
    return new StandardModel.PrimaryInfo("firmId", this.firmId);
  }
}

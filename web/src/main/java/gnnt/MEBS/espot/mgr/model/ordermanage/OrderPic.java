package gnnt.MEBS.espot.mgr.model.ordermanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;

public class OrderPic
  extends StandardModel
{
  private static final long serialVersionUID = -8591359624670519774L;
  @ClassDiscription(name="主键", description="")
  private Long id;
  @ClassDiscription(name="委托I", description="")
  private Long orderID;
  @ClassDiscription(name="委托图片", description="")
  private byte[] picture;
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long paramLong)
  {
    this.id = paramLong;
  }
  
  public Long getOrderID()
  {
    return this.orderID;
  }
  
  public void setOrderID(Long paramLong)
  {
    this.orderID = paramLong;
  }
  
  public byte[] getPicture()
  {
    return this.picture;
  }
  
  public void setPicture(byte[] paramArrayOfByte)
  {
    this.picture = paramArrayOfByte;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("id", this.id);
  }
}

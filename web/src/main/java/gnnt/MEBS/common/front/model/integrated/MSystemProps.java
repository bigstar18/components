package gnnt.MEBS.common.front.model.integrated;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class MSystemProps
  extends StandardModel
{
  private static final long serialVersionUID = -5395993769556465143L;
  @ClassDiscription(name="参数名", description="")
  private String key;
  @ClassDiscription(name="参数值", description="")
  private String value;
  @ClassDiscription(name="运行时值", description="")
  private String runtimeValue;
  @ClassDiscription(name="参数说明", description="")
  private String note;
  
  public String getKey()
  {
    return this.key;
  }
  
  public void setKey(String key)
  {
    this.key = key;
  }
  
  public String getValue()
  {
    return this.value;
  }
  
  public void setValue(String value)
  {
    this.value = value;
  }
  
  public String getRuntimeValue()
  {
    return this.runtimeValue;
  }
  
  public void setRuntimeValue(String runtimeValue)
  {
    this.runtimeValue = runtimeValue;
  }
  
  public String getNote()
  {
    return this.note;
  }
  
  public void setNote(String note)
  {
    this.note = note;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo(  "key", this.key);
  }
}

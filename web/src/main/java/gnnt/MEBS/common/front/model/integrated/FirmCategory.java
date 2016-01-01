package gnnt.MEBS.common.front.model.integrated;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class FirmCategory
  extends StandardModel
{
  @ClassDiscription(name="类别编号", description="")
  private Long id;
  @ClassDiscription(name="类别名称", description="")
  private String name;
  @ClassDiscription(name="是否显示", description="是否显示 Y：显示 N：不显示")
  private String isvisibal;
  @ClassDiscription(name="排序号", description="")
  private Integer sortNo;
  @ClassDiscription(name="类别描述", description="")
  private String note;
  private static final long serialVersionUID = 1L;
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long id)
  {
    this.id = id;
  }
  
  public String getName()
  {
    return this.name;
  }
  
  public void setName(String name)
  {
    this.name = name;
  }
  
  public String getIsvisibal()
  {
    return this.isvisibal;
  }
  
  public void setIsvisibal(String isvisibal)
  {
    this.isvisibal = isvisibal;
  }
  
  public Integer getSortNo()
  {
    return this.sortNo;
  }
  
  public void setSortNo(Integer sortNo)
  {
    this.sortNo = sortNo;
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
    return new StandardModel.PrimaryInfo(  "id", this.id);
  }
}

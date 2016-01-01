package gnnt.MEBS.common.front.model;

import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import java.util.Date;

public class Audit
  extends StandardModel
{
  private static final long serialVersionUID = -6336810614832268885L;
  @ClassDiscription(name="审核编号", description="")
  private Long id;
  @ClassDiscription(name="申请单ID", description="")
  private Apply apply;
  @ClassDiscription(name="状态", description="状态 1：审核通过 2：驳回申请")
  private Integer status;
  @ClassDiscription(name="审核人", description="")
  private String auditUser;
  @ClassDiscription(name="修改时间", description="")
  private Date modTime;
  
  public Long getId()
  {
    return this.id;
  }
  
  public void setId(Long id)
  {
    this.id = id;
  }
  
  public Apply getApply()
  {
    return this.apply;
  }
  
  public void setApply(Apply apply)
  {
    this.apply = apply;
  }
  
  public Integer getStatus()
  {
    return this.status;
  }
  
  public void setStatus(Integer status)
  {
    this.status = status;
  }
  
  public String getAuditUser()
  {
    return this.auditUser;
  }
  
  public void setAuditUser(String auditUser)
  {
    this.auditUser = auditUser;
  }
  
  public Date getModTime()
  {
    return this.modTime;
  }
  
  public void setModTime(Date modTime)
  {
    this.modTime = modTime;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo(  "id", this.id);
  }
}

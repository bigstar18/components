package gnnt.MEBS.espot.mgr.model.firmmanage;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;
import gnnt.MEBS.common.mgr.model.translate.ClassDiscription;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class MFirm
  extends StandardModel
{
  private static final long serialVersionUID = -2128172735312930898L;
  @ClassDiscription(name="交易商ID", description="")
  private String firmId;
  @ClassDiscription(name="交易商名称", description="")
  private String name;
  @ClassDiscription(name="交易商全称", description="")
  private String fullName;
  @ClassDiscription(name="交易商类型", description="交易商类型 1：法人 2：代理3：个人")
  private Integer type;
  @ClassDiscription(name="开户银行名", description="")
  private String bank;
  @ClassDiscription(name="交易商状态", description="交易商状态 N：正常 D：冻结 E：注销")
  private String status;
  @ClassDiscription(name="交易商地址", description="")
  private String address;
  @ClassDiscription(name="联系人", description="")
  private String contactMan;
  @ClassDiscription(name="联系电话", description="")
  private String phone;
  @ClassDiscription(name="传真", description="")
  private String fax;
  @ClassDiscription(name="邮编", description="")
  private String postCode;
  @ClassDiscription(name="电子邮箱", description="")
  private String email;
  @ClassDiscription(name="备注信息", description="")
  private String note;
  @ClassDiscription(name="交易商所在区域代码", description="")
  private String zoneCode;
  @ClassDiscription(name="交易商所在行业代码", description="")
  private String industryCode;
  @ClassDiscription(name="扩展信息", description="")
  private String extendData;
  @ClassDiscription(name="交易商修改时间", description="")
  private Date createTime;
  @ClassDiscription(name="交易商修改时间", description="")
  private Date modifyTime;
  @ClassDiscription(name="扩展信息", description="")
  private Map<String, String> extendMap = new HashMap();
  @ClassDiscription(name="组织结构代码", description="")
  private String organizationCode;
  @ClassDiscription(name="交易商对应模块权限集合", description="")
  private Set<MFirmModule> firmModules = new HashSet();
  
  public Set<MFirmModule> getFirmModules()
  {
    return this.firmModules;
  }
  
  public void setFirmModules(Set<MFirmModule> paramSet)
  {
    this.firmModules = paramSet;
  }
  
  public Map<String, String> getExtendMap()
  {
    return this.extendMap;
  }
  
  public void setExtendMap(Map<String, String> paramMap)
  {
    this.extendMap = paramMap;
  }
  
  public String getOrganizationCode()
  {
    return this.organizationCode;
  }
  
  public void setOrganizationCode(String paramString)
  {
    this.organizationCode = paramString;
  }
  
  public String getFirmId()
  {
    return this.firmId;
  }
  
  public void setFirmId(String paramString)
  {
    this.firmId = paramString;
  }
  
  public String getName()
  {
    return this.name;
  }
  
  public void setName(String paramString)
  {
    this.name = paramString;
  }
  
  public String getFullName()
  {
    return this.fullName;
  }
  
  public void setFullName(String paramString)
  {
    this.fullName = paramString;
  }
  
  public Integer getType()
  {
    return this.type;
  }
  
  public void setType(Integer paramInteger)
  {
    this.type = paramInteger;
  }
  
  public String getBank()
  {
    return this.bank;
  }
  
  public void setBank(String paramString)
  {
    this.bank = paramString;
  }
  
  public String getStatus()
  {
    return this.status;
  }
  
  public void setStatus(String paramString)
  {
    this.status = paramString;
  }
  
  public String getAddress()
  {
    return this.address;
  }
  
  public void setAddress(String paramString)
  {
    this.address = paramString;
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
  
  public String getFax()
  {
    return this.fax;
  }
  
  public void setFax(String paramString)
  {
    this.fax = paramString;
  }
  
  public String getPostCode()
  {
    return this.postCode;
  }
  
  public void setPostCode(String paramString)
  {
    this.postCode = paramString;
  }
  
  public String getEmail()
  {
    return this.email;
  }
  
  public void setEmail(String paramString)
  {
    this.email = paramString;
  }
  
  public String getNote()
  {
    return this.note;
  }
  
  public void setNote(String paramString)
  {
    this.note = paramString;
  }
  
  public String getZoneCode()
  {
    return this.zoneCode;
  }
  
  public void setZoneCode(String paramString)
  {
    this.zoneCode = paramString;
  }
  
  public String getIndustryCode()
  {
    return this.industryCode;
  }
  
  public void setIndustryCode(String paramString)
  {
    this.industryCode = paramString;
  }
  
  public String getExtendData()
  {
    return this.extendData;
  }
  
  public void setExtendData(String paramString)
  {
    this.extendData = paramString;
  }
  
  public Date getCreateTime()
  {
    return this.createTime;
  }
  
  public void setCreateTime(Date paramDate)
  {
    this.createTime = paramDate;
  }
  
  public Date getModifyTime()
  {
    return this.modifyTime;
  }
  
  public void setModifyTime(Date paramDate)
  {
    this.modifyTime = paramDate;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("firmId", this.firmId);
  }
}

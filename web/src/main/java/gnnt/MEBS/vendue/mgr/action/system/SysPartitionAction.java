package gnnt.MEBS.vendue.mgr.action.system;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.vendue.mgr.model.system.sysPartition.VSyspartition;
import gnnt.MEBS.vendue.mgr.model.system.sysPartition.VTempletclassset;
import gnnt.MEBS.vendue.mgr.model.system.sysPartition.VTrademodeparams;
import gnnt.MEBS.vendue.mgr.service.system.syspartition.SysPartitionService;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.util.WebUtils;

@Controller("sysPartitionAction")
@Scope("request")
public class SysPartitionAction
  extends EcsideAction
{
  private static final long serialVersionUID = -1490830868929380678L;
  @Autowired
  @Qualifier("sysPartitionService")
  private SysPartitionService sysPartitionService;
  @Resource(name="sysPartition_validflagMap")
  private Map<Short, String> sysPartition_validflagMap;
  @Resource(name="sysPartition_isshowquotationMap")
  private Map<Byte, String> sysPartition_isshowquotationMap;
  @Resource(name="sysPartition_countmodeMap")
  private Map<Byte, String> sysPartition_countmodeMap;
  @Resource(name="sysPartition_ismargincountMap")
  private Map<Byte, String> sysPartition_ismargincountMap;
  @Resource(name="sysPartition_issplittargetMap")
  private Map<Short, String> sysPartition_issplittargetMap;
  @Resource(name="sysPartition_isshowpriceMap")
  private Map<Short, String> sysPartition_isshowpriceMap;
  
  public Map<Short, String> getSysPartition_validflagMap()
  {
    return this.sysPartition_validflagMap;
  }
  
  public Map<Byte, String> getSysPartition_isshowquotationMap()
  {
    return this.sysPartition_isshowquotationMap;
  }
  
  public Map<Byte, String> getSysPartition_countmodeMap()
  {
    return this.sysPartition_countmodeMap;
  }
  
  public Map<Byte, String> getSysPartition_ismargincountMap()
  {
    return this.sysPartition_ismargincountMap;
  }
  
  public Map<Short, String> getSysPartition_issplittargetMap()
  {
    return this.sysPartition_issplittargetMap;
  }
  
  public Map<Short, String> getSysPartition_isshowpriceMap()
  {
    return this.sysPartition_isshowpriceMap;
  }
  
  public String list()
  {
    this.logger.debug("========== list 系统板块配置列表 ==========");
    try
    {
      PageRequest localPageRequest = getPageRequest(this.request);
      Page localPage = getService().getPage(localPageRequest, new VSyspartition());
      this.request.setAttribute("pageInfo", localPage);
      Map localMap = WebUtils.getParametersStartingWith(this.request, "gnnt_");
      this.request.setAttribute("oldParams", localMap);
    }
    catch (Exception localException)
    {
      addReturnValue(-1, 213001L);
      this.logger.error("读取系统板块配置列表失败");
      localException.printStackTrace();
    }
    return "success";
  }
  
  public String viewById()
  {
    this.logger.debug("========== enter 修改系统板块配置跳转 ==========");
    VSyspartition localVSyspartition = (VSyspartition)this.entity;
    localVSyspartition = (VSyspartition)getService().get(localVSyspartition);
    this.request.setAttribute("entity", localVSyspartition);
    try
    {
      Page localPage = getService().getPage(getPageRequest(this.request), new VTrademodeparams());
      this.request.setAttribute("pageInfo", localPage);
    }
    catch (Exception localException)
    {
      addReturnValue(-1, 213002L);
      this.logger.error("读取交易模式列表失败");
      localException.printStackTrace();
    }
    return "success";
  }
  
  public String update()
  {
    this.logger.debug("========== enter 修改系统板块配置 ==========");
    VSyspartition localVSyspartition = (VSyspartition)this.entity;
    try
    {
      int i = localVSyspartition.getIssplittarget().byteValue();
      VTempletclassset localVTempletclassset = new VTempletclassset();
      if (i == 0) {
        localVTempletclassset.setId(Long.valueOf(6L));
      } else if (i == 1) {
        localVTempletclassset.setId(Long.valueOf(5L));
      }
      if (localVSyspartition.getTrademode().getId().longValue() == 3L) {
        localVTempletclassset.setId(Long.valueOf(7L));
      }
      localVTempletclassset = (VTempletclassset)getService().get(localVTempletclassset);
      String str = "update v_syspartition set description = '" + localVSyspartition.getDescription() + "'," + "selfrate = '" + localVSyspartition.getSelfrate() + "'," + "isshowquotation = '" + localVSyspartition.getIsshowquotation() + "'," + "maxshowqty = '" + localVSyspartition.getMaxshowqty() + "'," + "validflag = '" + localVSyspartition.getValidflag() + "'," + "countmode = '" + localVSyspartition.getCountmode() + "'," + "issplittarget = '" + localVSyspartition.getIssplittarget() + "'," + "isshowprice = '" + localVSyspartition.getIsshowprice() + "'," + "ismargincount = '" + localVSyspartition.getIsmargincount() + "'," + "traderuleclass = '" + localVTempletclassset.getClass_() + "'" + "where partitionid = '" + localVSyspartition.getPartitionid() + "'";
      getService().executeUpdateBySql(str);
      addReturnValue(1, 211000L);
      this.logger.error("修改成功");
      writeOperateLog(2103, "系统板块配置修改成功", 1, "");
    }
    catch (Exception localException)
    {
      addReturnValue(-1, 213000L);
      this.logger.error("修改失败");
      writeOperateLog(2103, "系统板块配置修改失败", 0, "");
      localException.printStackTrace();
    }
    return "success";
  }
}

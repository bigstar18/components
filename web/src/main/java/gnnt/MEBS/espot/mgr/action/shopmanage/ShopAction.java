package gnnt.MEBS.espot.mgr.action.shopmanage;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.common.mgr.statictools.ApplicationContextInit;
import gnnt.MEBS.espot.mgr.model.shopmanage.RecommendShop;
import gnnt.MEBS.espot.mgr.model.shopmanage.Shop;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Calendar;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("shopAction")
@Scope("request")
public class ShopAction
  extends EcsideAction
{
  private static final long serialVersionUID = 5731194101358409038L;
  private String fileNameFileName;
  private File fileName;
  @Autowired
  @Resource(name="imageTypeList")
  private List<String> imageTypeList;
  
  public List<String> getImageTypeList()
  {
    return this.imageTypeList;
  }
  
  public void setImageTypeList(List<String> paramList)
  {
    this.imageTypeList = paramList;
  }
  
  public File getFileName()
  {
    return this.fileName;
  }
  
  public void setFileName(File paramFile)
  {
    this.fileName = paramFile;
  }
  
  public String getFileNameFileName()
  {
    return this.fileNameFileName;
  }
  
  public void setFileNameFileName(String paramString)
  {
    this.fileNameFileName = paramString;
  }
  
  public String shopList()
    throws Exception
  {
    PageRequest localPageRequest = getPageRequest(this.request);
    QueryConditions localQueryConditions = (QueryConditions)localPageRequest.getFilters();
    localQueryConditions.addCondition(" ", " ", "(select count(m.firmId) from primary.firm.firmModules as m where m.moduleID=23 and m.enabled='Y')>0");
    localQueryConditions.addCondition("primary.firm.status", "!=", "E");
    listByLimit(localPageRequest);
    return "success";
  }
  
  public String deleteRecommendShop()
  {
    String[] arrayOfString1 = this.request.getParameterValues("ids");
    super.getService().deleteBYBulk(new RecommendShop(), arrayOfString1);
    addReturnValue(1, 230000L);
    String str1 = "";
    for (String str2 : arrayOfString1) {
      str1 = str1 + str2 + ",";
    }
    str1 = str1.substring(0, str1.length() - 1);
    writeOperateLog(2310, "删除推荐商铺：(" + str1 + ")", 1, "");
    return "success";
  }
  
  public String toAddRecommendShop()
  {
    return "success";
  }
  
  public String addRecommendShop()
  {
    RecommendShop localRecommendShop = (RecommendShop)this.entity;
    localRecommendShop.setRecommendTime(Calendar.getInstance().getTime());
    try
    {
      super.getService().add(this.entity);
      addReturnValue(1, 230000L);
      writeOperateLog(2310, "添加推荐商铺：" + localRecommendShop.getFirmId() + "", 1, "");
      return "success";
    }
    catch (Exception localException)
    {
      addReturnValue(-1, 230001L);
      writeOperateLog(2310, "添加推荐商铺", 0, localException.getMessage());
    }
    return "success";
  }
  
  public String updateShop()
    throws IOException
  {
    this.logger.debug("enter updateShop");
    String str1 = (String)ServletActionContext.getRequest().getAttribute("ExceededError");
    if (str1 != null)
    {
      this.logger.debug(str1);
      addReturnValue(-1, 231100L, new Object[] { str1 });
      return "success";
    }
    Shop localShop = (Shop)this.entity;
    localShop = (Shop)getService().get(localShop);
    if ((this.fileName != null) && (this.fileNameFileName != null))
    {
      String[] arrayOfString = this.fileNameFileName.split("\\.");
      String str2 = arrayOfString[(arrayOfString.length - 1)];
      if (this.imageTypeList.contains(str2.toLowerCase()))
      {
        FileInputStream localFileInputStream = new FileInputStream(this.fileName);
        byte[] arrayOfByte = new byte[localFileInputStream.available()];
        localFileInputStream.read(arrayOfByte);
        localShop.setHeadImage(arrayOfByte);
        getService().update(localShop);
        super.update();
        addReturnValue(1, 230000L);
        writeOperateLog(2310, "修改商铺：" + localShop.getFirmId(), 1, "");
      }
      else
      {
        addReturnValue(-1, 231101L);
        writeOperateLog(2310, "修改商铺", 0, ApplicationContextInit.getErrorInfo("-1205"));
      }
    }
    else
    {
      super.update();
      addReturnValue(1, 230000L);
      writeOperateLog(2310, "修改商铺：" + localShop.getFirmId(), 1, "");
    }
    return "success";
  }
  
  public String showImages()
    throws IOException
  {
    this.logger.debug("enter showImages");
    HttpServletResponse localHttpServletResponse = ServletActionContext.getResponse();
    ServletOutputStream localServletOutputStream = null;
    Shop localShop = (Shop)this.entity;
    localShop = (Shop)getService().get(localShop);
    try
    {
      localHttpServletResponse.setContentType("text/html");
      localServletOutputStream = localHttpServletResponse.getOutputStream();
      localServletOutputStream.write(localShop.getHeadImage());
      localServletOutputStream.flush();
      localServletOutputStream.close();
      localServletOutputStream = null;
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
    finally
    {
      if (localServletOutputStream != null)
      {
        localServletOutputStream.close();
        localServletOutputStream = null;
      }
    }
    return null;
  }
}

package gnnt.MEBS.espot.mgr.action.comoditymanage;

import gnnt.MEBS.common.mgr.action.StandardAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.User;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.common.mgr.statictools.Arith;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.espot.core.kernel.IKernelService;
import gnnt.MEBS.espot.core.kernel.IOrderAndPickoffOrder;
import gnnt.MEBS.espot.mgr.model.commoditymanage.Breed;
import gnnt.MEBS.espot.mgr.model.commoditymanage.Category;
import gnnt.MEBS.espot.mgr.model.ordermanage.Order;
import gnnt.MEBS.espot.mgr.model.parametermanage.DeliveryFee;
import gnnt.MEBS.espot.mgr.model.parametermanage.DeliveryMargin;
import gnnt.MEBS.espot.mgr.model.parametermanage.TradeFee;
import gnnt.MEBS.espot.mgr.model.preordermanage.GoodsResource;
import gnnt.MEBS.espot.mgr.model.preordermanage.GoodsTemplate;
import java.io.PrintStream;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("preserveCommodityAction")
@Scope("request")
public class PreserveCommodityAction
  extends StandardAction
{
  private static final long serialVersionUID = 1L;
  public static volatile Long codeID = Long.valueOf(230000L);
  @Autowired
  @Qualifier("kernelService")
  private IKernelService kernelService;
  @Autowired
  @Qualifier("orderService")
  private IOrderAndPickoffOrder orderService;
  private String template;
  private String goodsResource;
  private String tradeFee;
  private String deliveryFee;
  private String deliveryMargin;
  private int orderNum;
  
  public int getOrderNum()
  {
    return this.orderNum;
  }
  
  public void setOrderNum(int paramInt)
  {
    this.orderNum = paramInt;
  }
  
  public String getTemplate()
  {
    return this.template;
  }
  
  public void setTemplate(String paramString)
  {
    this.template = paramString;
  }
  
  public String getGoodsResource()
  {
    return this.goodsResource;
  }
  
  public void setGoodsResource(String paramString)
  {
    this.goodsResource = paramString;
  }
  
  public String getTradeFee()
  {
    return this.tradeFee;
  }
  
  public void setTradeFee(String paramString)
  {
    this.tradeFee = paramString;
  }
  
  public String getDeliveryFee()
  {
    return this.deliveryFee;
  }
  
  public void setDeliveryFee(String paramString)
  {
    this.deliveryFee = paramString;
  }
  
  public String getDeliveryMargin()
  {
    return this.deliveryMargin;
  }
  
  public void setDeliveryMargin(String paramString)
  {
    this.deliveryMargin = paramString;
  }
  
  public IKernelService getKernelService()
  {
    return this.kernelService;
  }
  
  public void setKernelService(IKernelService paramIKernelService)
  {
    this.kernelService = paramIKernelService;
  }
  
  public IOrderAndPickoffOrder getOrderService()
  {
    return this.orderService;
  }
  
  public void setOrderService(IOrderAndPickoffOrder paramIOrderAndPickoffOrder)
  {
    this.orderService = paramIOrderAndPickoffOrder;
  }
  
  public String performCommodity()
  {
    User localUser = (User)this.request.getSession().getAttribute("CurrentUser");
    Long localLong = Long.valueOf(Tools.strToLong(this.request.getParameter("breedId"), -1000L));
    this.logger.debug("---删除品名下的所有关于交易的数据---categoryAction---performCommodity--" + localLong);
    Breed localBreed = new Breed();
    localBreed.setBreedId(localLong);
    localBreed = (Breed)getService().get(localBreed);
    if (localBreed == null)
    {
      codeID = Long.valueOf(235105L);
      return "success";
    }
    PageRequest localPageRequest = new PageRequest(" and primary.breed.breedId=" + localLong);
    Page localPage1 = getService().getPage(localPageRequest, new GoodsTemplate());
    if ((localPage1.getResult() != null) && (localPage1.getResult().size() > 0))
    {
      this.template = "Y";
      getService().deleteBYBulk(localPage1.getResult());
    }
    this.template = "N";
    localPageRequest = new PageRequest(" and primary.breed.breedId=" + localLong);
    Page localPage2 = getService().getPage(localPageRequest, new GoodsResource());
    if ((localPage2.getResult() != null) && (localPage2.getResult().size() > 0))
    {
      this.goodsResource = "Y";
      getService().deleteBYBulk(localPage2.getResult());
    }
    this.goodsResource = "N";
    localPageRequest = new PageRequest(" and primary.category.categoryId=" + localBreed.getCategory().getCategoryId() + " and ((primary.category.belongModule like '%23%' and primary.category.status=2) or primary.category.belongModule not like '%23%' or primary.category.belongModule is null ) ");
    Page localPage3 = getService().getPage(localPageRequest, new TradeFee());
    if ((localPage3.getResult() != null) && (localPage3.getResult().size() > 0))
    {
      this.tradeFee = "Y";
      getService().deleteBYBulk(localPage3.getResult());
    }
    this.tradeFee = "N";
    localPageRequest = new PageRequest(" and primary.category.categoryId=" + localBreed.getCategory().getCategoryId() + " and ((primary.category.belongModule like '%23%' and primary.category.status=2) or primary.category.belongModule not like '%23%'  or primary.category.belongModule is null) ");
    Page localPage4 = getService().getPage(localPageRequest, new DeliveryFee());
    if ((localPage4.getResult() != null) && (localPage4.getResult().size() > 0))
    {
      this.deliveryFee = "Y";
      getService().deleteBYBulk(localPage4.getResult());
    }
    this.deliveryFee = "N";
    localPageRequest = new PageRequest(" and primary.category.categoryId=" + localBreed.getCategory().getCategoryId() + " and ((primary.category.belongModule like '%23%' and primary.category.status=2) or primary.category.belongModule not like '%23%'  or primary.category.belongModule is null) ");
    Page localPage5 = getService().getPage(localPageRequest, new DeliveryMargin());
    if ((localPage5.getResult() != null) && (localPage5.getResult().size() > 0))
    {
      this.deliveryMargin = "Y";
      getService().deleteBYBulk(localPage5.getResult());
    }
    this.deliveryMargin = "N";
    try
    {
      localPageRequest = new PageRequest(" and primary.breed.breedId=" + localLong);
      Page localPage6 = getService().getPage(localPageRequest, new Order());
      if ((localPage6.getResult() != null) && (localPage6.getResult().size() > 0))
      {
        int i = localPage6.getResult().size();
        int j = 0;
        Iterator localIterator = localPage6.getResult().iterator();
        while (localIterator.hasNext())
        {
          StandardModel localStandardModel = (StandardModel)localIterator.next();
          Order localOrder = (Order)localStandardModel;
          j++;
          this.orderService.withdrawOrder(localOrder.getOrderId().longValue(), localUser.getUserId());
          this.orderNum = new Double(Arith.mul(Arith.div(j, i), 100.0F)).intValue();
        }
      }
    }
    catch (Exception localException)
    {
      addReturnValue(-1, 230004L, new Object[] { "维护品名，撤销委托的操作" });
      this.logger.error(Tools.getExceptionTrace(localException));
    }
    this.orderNum = -1;
    codeID = Long.valueOf(230000L);
    return "success";
  }
  
  public void setServletRequest(HttpServletRequest paramHttpServletRequest)
  {
    this.request = paramHttpServletRequest;
    System.out.println(codeID);
    addReturnValue(1, codeID.longValue());
  }
}

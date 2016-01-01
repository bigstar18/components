package gnnt.MEBS.espot.mgr.action.trademanage;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.model.User;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.espot.core.kernel.IFundsProcess;
import gnnt.MEBS.espot.core.kernel.ITradeProcess;
import gnnt.MEBS.espot.core.vo.ResultVO;
import gnnt.MEBS.espot.mgr.model.holdingmanage.Holding;
import gnnt.MEBS.espot.mgr.model.parametermanage.SystemProps;
import gnnt.MEBS.espot.mgr.model.trademanage.GoodsMoneyApply;
import gnnt.MEBS.espot.mgr.model.trademanage.GoodsMoneyApplyHis;
import gnnt.MEBS.espot.mgr.model.trademanage.TradeContract;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("goodsMoneyApplyAction")
@Scope("request")
public class GoodsMoneyApplyAction
  extends EcsideAction
{
  private static final long serialVersionUID = 4024558621252699662L;
  @Autowired
  @Qualifier("tradeProcessService")
  private ITradeProcess tradeProcessService;
  @Autowired
  @Qualifier("processService")
  private IFundsProcess processService;
  @Resource(name="goodsMoneyApplyMap")
  protected Map<Integer, String> goodsMoneyApplyMap;
  @Resource(name="goodsMoneyTypeMap")
  protected Map<Integer, String> goodsMoneyTypeMap;
  
  public IFundsProcess getProcessService()
  {
    return this.processService;
  }
  
  public void setProcessService(IFundsProcess paramIFundsProcess)
  {
    this.processService = paramIFundsProcess;
  }
  
  public ITradeProcess getTradeProcessService()
  {
    return this.tradeProcessService;
  }
  
  public void setTradeProcessService(ITradeProcess paramITradeProcess)
  {
    this.tradeProcessService = paramITradeProcess;
  }
  
  public Map<Integer, String> getGoodsMoneyApplyMap()
  {
    return this.goodsMoneyApplyMap;
  }
  
  public Map<Integer, String> getGoodsMoneyTypeMap()
  {
    return this.goodsMoneyTypeMap;
  }
  
  public String goodsMoneyApplyList()
    throws Exception
  {
    String str = this.request.getParameter("type");
    this.logger.debug("=================  goodsMoneyApplyList===type=" + str);
    if ((str != null) && (str.equals("H")))
    {
      this.entity = new GoodsMoneyApplyHis();
      str = "H";
    }
    else
    {
      this.entity = new GoodsMoneyApply();
      str = "D";
    }
    PageRequest localPageRequest = super.getPageRequest(this.request);
    localPageRequest.setSortColumns(" order by id desc");
    listByLimit(localPageRequest);
    this.request.setAttribute("type", str);
    return "success";
  }
  
  public String performAskLastGM()
  {
    Long localLong = Long.valueOf(Tools.strToLong(this.request.getParameter("tradeNo"), -1000L));
    TradeContract localTradeContract = new TradeContract();
    localTradeContract.setTradeNo(localLong);
    localTradeContract = (TradeContract)getService().get(localTradeContract);
    GoodsMoneyApply localGoodsMoneyApply = (GoodsMoneyApply)this.entity;
    if ((localTradeContract.getBelongToHolding() != null) && (localTradeContract.getBelongToHolding().size() > 0) && (localGoodsMoneyApply != null) && (localGoodsMoneyApply.getType() != null))
    {
      Iterator localIterator = localTradeContract.getBelongToHolding().iterator();
      while (localIterator.hasNext())
      {
        Holding localHolding = (Holding)localIterator.next();
        if (localTradeContract.getBFirmId().equals(localHolding.getFirmId()))
        {
          ResultVO localResultVO = new ResultVO();
          localResultVO.setResult(-1L);
          String str = "";
          SystemProps localSystemProps;
          if (localGoodsMoneyApply.getType().intValue() == 0)
          {
            localSystemProps = new SystemProps();
            localSystemProps.setPropsKey("FirstPaymentRate");
            localSystemProps = (SystemProps)getService().get(localSystemProps);
            localResultVO = this.processService.paymentFirstMoneyToSell(localHolding.getHoldingId().longValue(), Tools.strToDouble(localSystemProps.getRunTimeValue(), 0.0D));
            str = "处理合同号为：" + localLong + "的合同追缴首款审核";
          }
          else if (localGoodsMoneyApply.getType().intValue() == 1)
          {
            localSystemProps = new SystemProps();
            localSystemProps.setPropsKey("SecondPaymentRate");
            localSystemProps = (SystemProps)getService().get(localSystemProps);
            localResultVO = this.processService.paymentSecondMoneyToSell(localHolding.getHoldingId().longValue(), Tools.strToDouble(localSystemProps.getRunTimeValue(), 0.0D));
            str = "处理合同号为：" + localLong + "的合同追缴第二次货款审核";
          }
          else
          {
            localResultVO = this.processService.paymentBalanceToSell(localHolding.getHoldingId().longValue());
            str = "处理合同号为：" + localLong + "的合同追缴尾款审核";
          }
          if (localResultVO.getResult() < 0L)
          {
            addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo() });
            writeOperateLog(2309, str, 0, localResultVO.getErrorInfo());
          }
          else
          {
            addReturnValue(1, 233106L);
            writeOperateLog(2309, str, 1, "");
          }
        }
      }
    }
    return "success";
  }
  
  public String performWithdrawLastGM()
  {
    Long localLong = Long.valueOf(Tools.strToLong(this.request.getParameter("tradeNo"), -1000L));
    User localUser = (User)this.request.getSession().getAttribute("CurrentUser");
    ResultVO localResultVO = this.tradeProcessService.performWithdrawGoodsMoney(localLong.longValue(), localUser.getUserId());
    if (localResultVO.getResult() < 0L)
    {
      addReturnValue(-1, 230003L, new Object[] { localResultVO.getErrorInfo() });
      writeOperateLog(2309, "撤销合同号为：" + localLong + "的合同追缴货款审核", 0, localResultVO.getErrorInfo());
    }
    else
    {
      addReturnValue(1, 233107L);
      writeOperateLog(2309, "撤销合同号为：" + localLong + "的合同追缴货款审核", 1, "");
    }
    return "success";
  }
}

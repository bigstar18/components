package gnnt.MEBS.vendue.mgr.action.system;

import gnnt.MEBS.common.mgr.action.StandardAction;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.priceranking.server.rmi.ServerRMI;
import gnnt.MEBS.vendue.mgr.model.system.trademgr.SysCurStatus;
import java.io.PrintStream;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("tradeMgr")
@Scope("request")
public class TradeMgr
  extends StandardAction
{
  private static final long serialVersionUID = -1446954035954317808L;
  private String partitionid;
  private String trademode;
  private String clickOpt;
  @Resource(name="tradeMgr_sysCurStatus")
  private Map<Integer, String> tradeMgr_sysCurStatus;
  @Autowired
  @Qualifier("serverRMIService")
  private ServerRMI serverRMIService;
  
  public String fetchCurrSysState()
  {
    this.logger.debug("------------取得版块" + this.partitionid + "当前系统状态--------------");
    this.entity = getService().get(this.entity);
    return "success";
  }
  
  public String tradeProcess()
    throws Exception
  {
    this.logger.debug("------------交易管理操作处理--------------");
    String str1 = "startSys";
    String str2 = "handStart";
    String str3 = "mandatoryStart";
    String str4 = "paseTrade";
    String str5 = "resumeTrade";
    String str6 = "closeAndBargain";
    String str7 = "close";
    String str8 = "closeAndProcess";
    short s = Short.valueOf(this.partitionid).shortValue();
    if (str1.equals(this.clickOpt))
    {
      try
      {
        ((SysCurStatus)this.entity).setTradePartition(Integer.valueOf(this.partitionid));
        this.entity = getService().get(this.entity);
        SysCurStatus localSysCurStatus = null;
        if (this.entity != null) {
          localSysCurStatus = (SysCurStatus)this.entity;
        }
        if (localSysCurStatus != null)
        {
          int i2 = localSysCurStatus.getIsClose().intValue();
          System.out.println("========================" + i2);
          if (i2 == 1)
          {
            List localList = getService().getListBySql("select count(commodityID) coSize  from v_curCommodity c where c.tradePartition = " + this.partitionid + " and c.section is not null");
            if (Integer.valueOf(String.valueOf(((Map)localList.get(0)).get("COSIZE"))).intValue() == 0)
            {
              writeOperateLog(2103, "没有可以交易的交易节，请到当前商品列表中为商品指定交易节。", 0, "");
              addReturnValue(0, 213041L);
            }
            else
            {
              int i4 = this.serverRMIService.openSystem(s);
              if (i4 == 2)
              {
                writeOperateLog(2103, "启动系统成功", 1, "");
                addReturnValue(1, 211006L);
              }
              else
              {
                writeOperateLog(2103, "启动系统失败", 0, "");
                addReturnValue(-1, 213014L);
              }
            }
          }
          else
          {
            writeOperateLog(2103, "未做闭市处理,启动失败", 0, "");
            addReturnValue(-1, 213035L);
          }
        }
        else
        {
          throw new Exception("系统状态表没有初始化数据！");
        }
      }
      catch (Exception localException1)
      {
        localException1.printStackTrace();
        writeOperateLog(2103, "启动系统失败", 0, "");
        addReturnValue(-1, 213014L);
        throw localException1;
      }
    }
    else if (str2.equals(this.clickOpt))
    {
      try
      {
        int i = this.serverRMIService.startSystem(s);
        if (i == 2)
        {
          writeOperateLog(2103, "手动开市成功", 1, "");
          addReturnValue(1, 211007L);
        }
        else
        {
          writeOperateLog(2103, "手动开市失败", 0, "");
          addReturnValue(1, 213020L);
        }
      }
      catch (Exception localException2)
      {
        localException2.printStackTrace();
        writeOperateLog(2103, "手动开市失败", 0, "");
        throw localException2;
      }
    }
    else if (str3.equals(this.clickOpt))
    {
      try
      {
        int j = this.serverRMIService.forceStartTrade(s);
        if (j == 2)
        {
          writeOperateLog(2103, "强制开市成功", 1, "");
          addReturnValue(1, 211008L);
        }
        else
        {
          writeOperateLog(2103, "强制开市失败", 1, "");
          addReturnValue(1, 213021L);
        }
      }
      catch (Exception localException3)
      {
        localException3.printStackTrace();
        writeOperateLog(2103, "强制开市失败", 0, "");
        throw localException3;
      }
    }
    else if (str4.equals(this.clickOpt))
    {
      try
      {
        int k = this.serverRMIService.ctlSystem(s, 4);
        if (k == 2)
        {
          writeOperateLog(2103, "暂停交易成功", 1, "");
          addReturnValue(1, 211009L);
        }
        else
        {
          writeOperateLog(2103, "暂停交易失败", 0, "");
          addReturnValue(1, 213022L);
        }
      }
      catch (Exception localException4)
      {
        localException4.printStackTrace();
        writeOperateLog(2103, "暂停交易失败", 0, "");
        addReturnValue(1, 213022L);
        throw localException4;
      }
    }
    else if (str5.equals(this.clickOpt))
    {
      try
      {
        int m = this.serverRMIService.ctlSystem(s, 8);
        if (m == 2)
        {
          writeOperateLog(2103, "恢复交易成功", 1, "");
          addReturnValue(1, 211010L);
        }
        else
        {
          writeOperateLog(2103, "恢复交易失败", 0, "");
          addReturnValue(1, 213023L);
        }
      }
      catch (Exception localException5)
      {
        localException5.printStackTrace();
        writeOperateLog(2103, "恢复交易失败", 0, "");
        throw localException5;
      }
    }
    else if (str6.equals(this.clickOpt))
    {
      try
      {
        int n = this.serverRMIService.endSystemUpdateTrade(s);
        if (n == 2)
        {
          writeOperateLog(2103, "闭市成交成功", 1, "");
          addReturnValue(1, 211011L);
        }
        else
        {
          writeOperateLog(2103, "闭市成交失败", 0, "");
          addReturnValue(1, 213024L);
        }
      }
      catch (Exception localException6)
      {
        localException6.printStackTrace();
        writeOperateLog(2103, "闭市成交失败", 0, "");
        throw localException6;
      }
    }
    else if (str7.equals(this.clickOpt))
    {
      try
      {
        int i1 = this.serverRMIService.endSystem(s);
        if (i1 == 2)
        {
          writeOperateLog(2103, "闭市成功", 1, "");
          addReturnValue(1, 211012L);
        }
        else
        {
          writeOperateLog(2103, "闭市失败", 0, "");
          addReturnValue(1, 213025L);
        }
      }
      catch (Exception localException7)
      {
        localException7.printStackTrace();
        writeOperateLog(2103, "闭市失败", 0, "");
        throw localException7;
      }
    }
    else if (str8.equals(this.clickOpt))
    {
      Object[] arrayOfObject = { this.partitionid };
      Object localObject = getService().executeProcedure("{?=call FN_V_CloseMarket(?) }", arrayOfObject);
      int i3 = Integer.valueOf(String.valueOf(localObject)).intValue();
      if (i3 == 1)
      {
        writeOperateLog(2103, "版块 " + this.partitionid + "闭市处理成功", 1, "");
        addReturnValue(1, 211013L);
      }
      else
      {
        writeOperateLog(2103, "版块 " + this.partitionid + "闭市处理失败", 0, "");
        addReturnValue(1, 213017L);
      }
    }
    return "success";
  }
  
  public String goFetchCurrSysState()
  {
    ((SysCurStatus)this.entity).setTradePartition(Integer.valueOf(this.partitionid));
    this.entity = getService().get(this.entity);
    return "success";
  }
  
  public String getPartitionid()
  {
    return this.partitionid;
  }
  
  public void setPartitionid(String paramString)
  {
    this.partitionid = paramString;
  }
  
  public String getTrademode()
  {
    return this.trademode;
  }
  
  public void setTrademode(String paramString)
  {
    this.trademode = paramString;
  }
  
  public Map<Integer, String> getTradeMgr_sysCurStatus()
  {
    return this.tradeMgr_sysCurStatus;
  }
  
  public void setTradeMgr_sysCurStatus(Map<Integer, String> paramMap)
  {
    this.tradeMgr_sysCurStatus = paramMap;
  }
  
  public String getClickOpt()
  {
    return this.clickOpt;
  }
  
  public void setClickOpt(String paramString)
  {
    this.clickOpt = paramString;
  }
  
  public ServerRMI getServerRMIService()
  {
    return this.serverRMIService;
  }
  
  public void setServerRMIService(ServerRMI paramServerRMI)
  {
    this.serverRMIService = paramServerRMI;
  }
}

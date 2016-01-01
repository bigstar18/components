package gnnt.MEBS.vendue.front.service.impl;

import gnnt.MEBS.priceranking.server.model.Commodity;
import gnnt.MEBS.priceranking.server.model.SystemStatus;
import gnnt.MEBS.priceranking.server.rmi.ServerRMI;
import gnnt.MEBS.priceranking.server.rmi.TradeRMI;
import gnnt.MEBS.vendue.front.dao.TradeDAO;
import gnnt.MEBS.vendue.front.model.BreedProperty;
import gnnt.MEBS.vendue.front.model.BroadcastVO;
import gnnt.MEBS.vendue.front.model.Commodityparams;
import gnnt.MEBS.vendue.front.model.CurSubmitVO;
import gnnt.MEBS.vendue.front.model.QuantionPage;
import gnnt.MEBS.vendue.front.model.SectionAttribute;
import gnnt.MEBS.vendue.front.model.SettleParams;
import gnnt.MEBS.vendue.front.model.TradeUser;
import gnnt.MEBS.vendue.front.service.TradeService;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class TradeServiceImpl
  implements TradeService
{
  private TradeDAO tradeDAO;
  
  public void setTradeDAO(TradeDAO paramTradeDAO)
  {
    this.tradeDAO = paramTradeDAO;
  }
  
  public int addCode(String paramString1, int paramInt, String paramString2)
  {
    return this.tradeDAO.addCode(paramString1, paramInt, paramString2);
  }
  
  public int cancelCode(String paramString1, int paramInt, String paramString2)
  {
    return this.tradeDAO.cancelCode(paramString1, paramInt, paramString2);
  }
  
  public double getBalance(String paramString)
  {
    return this.tradeDAO.getBalance(paramString);
  }
  
  public String getChoiceCode(int paramInt, String paramString)
  {
    return this.tradeDAO.getChoiceCode(paramInt, paramString);
  }
  
  public List getCodeNums(String paramString)
  {
    return this.tradeDAO.getCodeNums(paramString);
  }
  
  public List getSysPartitions(String paramString, Object[] paramArrayOfObject)
  {
    return this.tradeDAO.getSysPartitions(paramString, paramArrayOfObject);
  }
  
  public List<SectionAttribute> getSectionAttribute(int paramInt)
  {
    return this.tradeDAO.getSectionAttribute(paramInt);
  }
  
  public SystemStatus getSystemStatus(int paramInt)
  {
    return this.tradeDAO.getSystemStatus(paramInt);
  }
  
  public CurSubmitVO[] getCurSubmitList(String paramString)
  {
    return this.tradeDAO.getCurSubmitList(paramString);
  }
  
  public double getFrozenFundsByMID(String paramString)
  {
    return this.tradeDAO.getFrozenFundsByMID(paramString);
  }
  
  public BroadcastVO getBroadcast(long paramLong)
  {
    return this.tradeDAO.getBroadcast(paramLong);
  }
  
  public BroadcastVO[] getBroadcastList(String paramString)
  {
    return this.tradeDAO.getBroadcastList(paramString);
  }
  
  public String getLastXML(String paramString1, String paramString2, int paramInt)
  {
    String str1 = "";
    String str2 = "";
    SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    DecimalFormat localDecimalFormat = (DecimalFormat)NumberFormat.getNumberInstance();
    localDecimalFormat.applyPattern("###0.00");
    CurSubmitVO[] arrayOfCurSubmitVO = this.tradeDAO.getCurSubmitList("and To_date('" + paramString2 + "','yyyy-MM-dd HH24:mi:ss')<modifytime and cs.userID='" + paramString1 + "' and cs.tradepartition=" + paramInt + " order by modifytime desc");
    StringBuffer localStringBuffer = new StringBuffer();
    localStringBuffer.append("<R>");
    if (arrayOfCurSubmitVO != null) {
      for (int i = 0; i < arrayOfCurSubmitVO.length; i++)
      {
        CurSubmitVO localCurSubmitVO = arrayOfCurSubmitVO[i];
        if (str2.equals("")) {
          str2 = localSimpleDateFormat.format(localCurSubmitVO.modifytime);
        }
        localStringBuffer.append("<S>");
        localStringBuffer.append("<SID>" + localCurSubmitVO.iD + "</SID>");
        localStringBuffer.append("<C>" + localCurSubmitVO.code + "</C>");
        localStringBuffer.append("<P>" + localDecimalFormat.format(localCurSubmitVO.price) + "</P>");
        localStringBuffer.append("<A>" + localCurSubmitVO.amount + "</A>");
        localStringBuffer.append("<VA>" + localCurSubmitVO.validAmount + "</VA>");
        localStringBuffer.append("<ST>" + localSimpleDateFormat.format(localCurSubmitVO.submitTime) + "</ST>");
        localStringBuffer.append("<MT>" + localSimpleDateFormat.format(localCurSubmitVO.modifytime) + "</MT>");
        localStringBuffer.append("<FM>" + localDecimalFormat.format(localCurSubmitVO.frozenMargin) + "</FM>");
        localStringBuffer.append("<FF>" + localDecimalFormat.format(localCurSubmitVO.frozenFee) + "</FF>");
        localStringBuffer.append("<UM>" + localDecimalFormat.format(localCurSubmitVO.unFrozenMargin) + "</UM>");
        localStringBuffer.append("<UF>" + localDecimalFormat.format(localCurSubmitVO.unFrozenFee) + "</UF>");
        localStringBuffer.append("<WT>" + localCurSubmitVO.withdrawType + "</WT>");
        localStringBuffer.append("<OT>" + localCurSubmitVO.orderType + "</OT>");
        localStringBuffer.append("</S>");
      }
    }
    if (str2.equals("")) {
      str2 = paramString2;
    }
    localStringBuffer.append("<T>" + str2 + "</T>");
    localStringBuffer.append("</R>");
    str1 = localStringBuffer.toString();
    return str1;
  }
  
  public QuantionPage getPageQuotations(short paramShort, String paramString1, String paramString2, String paramString3)
  {
    return this.tradeDAO.getPageQuotations(paramShort, paramString1, paramString2, paramString3);
  }
  
  public String getSysdate()
  {
    return this.tradeDAO.getSysdate();
  }
  
  public Map<Long, String> getBreeds()
  {
    return this.tradeDAO.getBreeds();
  }
  
  public List<BreedProperty> getBreedProperty(String paramString)
  {
    return this.tradeDAO.getBreedProperty(paramString);
  }
  
  public Commodityparams getCommodityParams(int paramInt, Long paramLong)
  {
    return this.tradeDAO.getCommodityParams(paramInt, paramLong);
  }
  
  public int addCodeApply(Commodity paramCommodity, List<SettleParams> paramList)
  {
    int i = -1;
    int j = this.tradeDAO.addCodeApply(paramCommodity);
    if (j > 0)
    {
      Iterator localIterator = paramList.iterator();
      while (localIterator.hasNext())
      {
        SettleParams localSettleParams = (SettleParams)localIterator.next();
        localSettleParams.setCode(j + "");
        if ((localSettleParams.getValue() != null) && (!localSettleParams.getValue().equals(""))) {
          this.tradeDAO.addSettleParams(localSettleParams);
        }
      }
      i = 1;
    }
    return i;
  }
  
  public QuantionPage getQuotations(short paramShort, String paramString)
  {
    return this.tradeDAO.getQuotations(paramShort, paramString);
  }
  
  public Map getRMIUrl()
    throws SQLException
  {
    return this.tradeDAO.getRMIUrl();
  }
  
  public TradeRMI getTradeRMI()
  {
    return this.tradeDAO.getTradeRMI();
  }
  
  public ServerRMI getServerRMI()
  {
    return this.tradeDAO.getServerRMI();
  }
  
  public CurSubmitVO[] getSubmit(String paramString, int paramInt)
  {
    CurSubmitVO[] arrayOfCurSubmitVO = this.tradeDAO.getCurSubmitList("and cs.userID='" + paramString + "' and cs.tradepartition=" + paramInt + " and ordertype!=3 order by cs.id desc");
    return arrayOfCurSubmitVO;
  }
  
  public TradeUser getTradeUserInfo(String paramString)
  {
    return this.tradeDAO.getTradeUserInfo(paramString);
  }
  
  public List<String> getCodeAuth(String paramString)
  {
    return this.tradeDAO.getCodeAuth(paramString);
  }
  
  public Commodity getCode(String paramString)
  {
    return this.tradeDAO.getCode(paramString);
  }
}

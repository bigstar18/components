package gnnt.MEBS.vendue.mgr.action.firmSet;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.logging.Log;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("tradeUserAction")
@Scope("request")
public class TradeUserAction
  extends EcsideAction
{
  private static final long serialVersionUID = 1L;
  @Resource(name="tradeUser_isEntryMap")
  private Map<Integer, String> tradeUser_isEntryMap;
  @Resource(name="tradeUser_limitsMap")
  private Map<Integer, String> tradeUser_limitsMap;
  @Resource(name="tradeUser_isContinueOrderMap")
  private Map<Integer, String> tradeUser_isContinueOrderMap;
  
  public Map<Integer, String> getTradeUser_isEntryMap()
  {
    return this.tradeUser_isEntryMap;
  }
  
  public void setTradeUser_isEntryMap(Map<Integer, String> paramMap)
  {
    this.tradeUser_isEntryMap = paramMap;
  }
  
  public Map<Integer, String> getTradeUser_limitsMap()
  {
    return this.tradeUser_limitsMap;
  }
  
  public void setTradeUser_limitsMap(Map<Integer, String> paramMap)
  {
    this.tradeUser_limitsMap = paramMap;
  }
  
  public Map<Integer, String> getTradeUser_isContinueOrderMap()
  {
    return this.tradeUser_isContinueOrderMap;
  }
  
  public void setTradeUser_isContinueOrderMap(Map<Integer, String> paramMap)
  {
    this.tradeUser_isContinueOrderMap = paramMap;
  }
  
  public String getTradeUserList()
    throws Exception
  {
    this.logger.debug("------------getTradeUserList 跳转到交易商信息列表页面--------------");
    return listByLimit();
  }
  
  public String updateTradeUserForward()
    throws Exception
  {
    this.logger.debug("------------updateTradeUserForward 跳转到设置交易商信息页面--------------");
    return viewById();
  }
  
  public String updateTradeUser()
  {
    this.logger.debug("------------updateTradeUser 设置交易商信息--------------");
    String str = "";
    try
    {
      str = update();
      writeOperateLog(2104, "设置交易商成功", 1, "");
    }
    catch (Exception localException)
    {
      writeOperateLog(2104, "设置交易商失败", 0, "");
      localException.printStackTrace();
    }
    return str;
  }
}

package gnnt.MEBS.bill.core.vo;

import gnnt.MEBS.bill.core.util.GnntBeanFactory;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ResultVO
  implements Serializable
{
  private static final long serialVersionUID = -2731335665181453151L;
  private Log log = LogFactory.getLog(ResultVO.class);
  private long result = 1L;
  private Map<Long, String> errorInfoMap = new HashMap();
  
  public long getResult()
  {
    return this.result;
  }
  
  public void setResult(long paramLong)
  {
    this.result = paramLong;
  }
  
  public Map<Long, String> getInfoMap()
  {
    return this.errorInfoMap;
  }
  
  public String getErrorInfo()
  {
    StringBuffer localStringBuffer = new StringBuffer();
    Iterator localIterator = this.errorInfoMap.entrySet().iterator();
    while (localIterator.hasNext())
    {
      Map.Entry localEntry = (Map.Entry)localIterator.next();
      localStringBuffer.append((String)localEntry.getValue()).append(";");
    }
    return localStringBuffer.toString();
  }
  
  public String getErrorDetailInfo()
  {
    StringBuffer localStringBuffer = new StringBuffer();
    Iterator localIterator = this.errorInfoMap.entrySet().iterator();
    while (localIterator.hasNext())
    {
      Map.Entry localEntry = (Map.Entry)localIterator.next();
      localStringBuffer.append("错误码【" + localEntry.getKey() + "】错误信息【" + (String)localEntry.getValue()).append("】\n");
    }
    return localStringBuffer.toString();
  }
  
  public void addErrorInfo(long paramLong)
  {
    this.errorInfoMap.put(Long.valueOf(paramLong), GnntBeanFactory.getErrorInfo(paramLong + ""));
  }
  
  public String getErrorCode()
  {
    StringBuffer localStringBuffer = new StringBuffer();
    Iterator localIterator = this.errorInfoMap.entrySet().iterator();
    while (localIterator.hasNext())
    {
      Map.Entry localEntry = (Map.Entry)localIterator.next();
      localStringBuffer.append(localEntry.getKey()).append(" ");
    }
    return localStringBuffer.toString();
  }
  
  public void addErrorInfo(long paramLong, Object[] paramArrayOfObject)
  {
    String str1 = GnntBeanFactory.getErrorInfo(paramLong + "");
    String str2 = str1;
    try
    {
      str2 = String.format(str1, paramArrayOfObject);
    }
    catch (Exception localException)
    {
      this.log.debug("errorCode:" + paramLong + ";Format Exception!");
      this.log.debug("formatStr:" + str1);
      for (Object localObject : paramArrayOfObject) {
        this.log.debug("Object:" + localObject.toString());
      }
      this.log.debug(localException.toString());
    }
    this.errorInfoMap.put(Long.valueOf(paramLong), str2);
  }
}

package gnnt.MEBS.trademonitor.mgr.beanforajax;

import gnnt.MEBS.common.mgr.service.StandardService;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("ajaxCheckBean")
@Scope("request")
public class AjaxCheck
{
  @Autowired
  @Qualifier("com_standardService")
  private StandardService standardService;
  protected JSONArray jsonValidateReturn;
  
  public StandardService getService()
  {
    return this.standardService;
  }
  
  public JSONArray getJsonValidateReturn()
  {
    return this.jsonValidateReturn;
  }
  
  public JSONArray genJSON(ArrayList<AjaxValidationFormResponse> paramArrayList)
  {
    JSONArray localJSONArray = new JSONArray();
    for (int i = 0; i < paramArrayList.size(); i++)
    {
      AjaxValidationFormResponse localAjaxValidationFormResponse = (AjaxValidationFormResponse)paramArrayList.get(i);
      localJSONArray.add(localAjaxValidationFormResponse.toJSONArray());
    }
    return localJSONArray;
  }
  
  public static String getEncoding(String paramString1, String paramString2)
  {
    if ((paramString1 == null) || (paramString1.trim().length() <= 0)) {
      return paramString1;
    }
    if ((!"GBK".equalsIgnoreCase(paramString2)) && (!"UTF-8".equalsIgnoreCase(paramString2))) {
      paramString2 = "GBK";
    }
    try
    {
      return new String(paramString1.getBytes(), "UTF-8");
    }
    catch (UnsupportedEncodingException localUnsupportedEncodingException) {}
    return "";
  }
  
  public class AjaxValidationFormResponse
  {
    private String id;
    private Boolean status;
    private String error;
    
    public AjaxValidationFormResponse(String paramString1, Boolean paramBoolean, String paramString2)
    {
      this.id = paramString1;
      this.status = paramBoolean;
      this.error = paramString2;
    }
    
    public JSONArray toJSONArray()
    {
      JSONArray localJSONArray = new JSONArray();
      localJSONArray.add(this.id);
      localJSONArray.add(this.status);
      localJSONArray.add(this.error);
      return localJSONArray;
    }
  }
  
  public class AjaxValidationFieldResponse
  {
    private String id;
    private Boolean status;
    
    public AjaxValidationFieldResponse(String paramString, Boolean paramBoolean)
    {
      this.id = paramString;
      this.status = paramBoolean;
    }
    
    public JSONArray toJSONArray()
    {
      JSONArray localJSONArray = new JSONArray();
      localJSONArray.add(this.id);
      localJSONArray.add(this.status);
      return localJSONArray;
    }
  }
}

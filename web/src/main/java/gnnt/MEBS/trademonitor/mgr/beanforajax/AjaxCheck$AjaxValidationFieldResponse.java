package gnnt.MEBS.trademonitor.mgr.beanforajax;

import net.sf.json.JSONArray;

public class AjaxCheck$AjaxValidationFieldResponse
{
  private String id;
  private Boolean status;
  
  public AjaxCheck$AjaxValidationFieldResponse(AjaxCheck paramAjaxCheck, String paramString, Boolean paramBoolean)
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

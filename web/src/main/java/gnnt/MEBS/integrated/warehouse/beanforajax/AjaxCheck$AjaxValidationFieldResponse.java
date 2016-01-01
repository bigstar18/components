package gnnt.MEBS.integrated.warehouse.beanforajax;

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
  
  public AjaxCheck$AjaxValidationFieldResponse(AjaxCheck paramAjaxCheck, String paramString1, boolean paramBoolean, String paramString2) {}
  
  public JSONArray toJSONArray()
  {
    JSONArray localJSONArray = new JSONArray();
    localJSONArray.add(this.id);
    localJSONArray.add(this.status);
    return localJSONArray;
  }
}

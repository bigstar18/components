package gnnt.MEBS.integrated.warehouse.beanforajax;

import net.sf.json.JSONArray;

public class AjaxCheck$AjaxValidationFormResponse
{
  private String id;
  private Boolean status;
  private String error;
  
  public AjaxCheck$AjaxValidationFormResponse(AjaxCheck paramAjaxCheck, String paramString1, Boolean paramBoolean, String paramString2)
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

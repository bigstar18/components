package gnnt.MEBS.vendue.mgr.model.commodity.commext;

import java.io.Serializable;

public class MBreedpropsId
  implements Serializable
{
  private MBreed MBreed;
  private MProperty MProperty;
  private String propertyvalue;
  
  public MBreedpropsId() {}
  
  public MBreedpropsId(MBreed paramMBreed, MProperty paramMProperty, String paramString)
  {
    this.MBreed = paramMBreed;
    this.MProperty = paramMProperty;
    this.propertyvalue = paramString;
  }
  
  public MBreed getMBreed()
  {
    return this.MBreed;
  }
  
  public void setMBreed(MBreed paramMBreed)
  {
    this.MBreed = paramMBreed;
  }
  
  public MProperty getMProperty()
  {
    return this.MProperty;
  }
  
  public void setMProperty(MProperty paramMProperty)
  {
    this.MProperty = paramMProperty;
  }
  
  public String getPropertyvalue()
  {
    return this.propertyvalue;
  }
  
  public void setPropertyvalue(String paramString)
  {
    this.propertyvalue = paramString;
  }
  
  public boolean equals(Object paramObject)
  {
    if (this == paramObject) {
      return true;
    }
    if (paramObject == null) {
      return false;
    }
    if (!(paramObject instanceof MBreedpropsId)) {
      return false;
    }
    MBreedpropsId localMBreedpropsId = (MBreedpropsId)paramObject;
    return ((getMBreed() == localMBreedpropsId.getMBreed()) || ((getMBreed() != null) && (localMBreedpropsId.getMBreed() != null) && (getMBreed().equals(localMBreedpropsId.getMBreed())))) && ((getMProperty() == localMBreedpropsId.getMProperty()) || ((getMProperty() != null) && (localMBreedpropsId.getMProperty() != null) && (getMProperty().equals(localMBreedpropsId.getMProperty())))) && ((getPropertyvalue() == localMBreedpropsId.getPropertyvalue()) || ((getPropertyvalue() != null) && (localMBreedpropsId.getPropertyvalue() != null) && (getPropertyvalue().equals(localMBreedpropsId.getPropertyvalue()))));
  }
  
  public int hashCode()
  {
    int i = 17;
    i = 37 * i + (getMBreed() == null ? 0 : getMBreed().hashCode());
    i = 37 * i + (getMProperty() == null ? 0 : getMProperty().hashCode());
    i = 37 * i + (getPropertyvalue() == null ? 0 : getPropertyvalue().hashCode());
    return i;
  }
}

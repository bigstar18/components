package gnnt.MEBS.vendue.mgr.model.commodity.commext;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.StandardModel.PrimaryInfo;

public class MBreedprops
  extends StandardModel
{
  private static final long serialVersionUID = 8571063990844866397L;
  private MBreedpropsId id;
  private Long sortno;
  
  public MBreedprops() {}
  
  public MBreedprops(MBreedpropsId paramMBreedpropsId, Long paramLong)
  {
    this.id = paramMBreedpropsId;
    this.sortno = paramLong;
  }
  
  public MBreedpropsId getId()
  {
    return this.id;
  }
  
  public void setId(MBreedpropsId paramMBreedpropsId)
  {
    this.id = paramMBreedpropsId;
  }
  
  public Long getSortno()
  {
    return this.sortno;
  }
  
  public void setSortno(Long paramLong)
  {
    this.sortno = paramLong;
  }
  
  public StandardModel.PrimaryInfo fetchPKey()
  {
    return new StandardModel.PrimaryInfo("id", this.id);
  }
}

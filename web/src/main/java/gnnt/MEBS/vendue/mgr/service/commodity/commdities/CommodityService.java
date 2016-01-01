package gnnt.MEBS.vendue.mgr.service.commodity.commdities;

import gnnt.MEBS.vendue.mgr.model.commodity.commext.VCommext;
import gnnt.MEBS.vendue.mgr.model.commodity.commodities.VCommodity;
import java.util.List;

public abstract interface CommodityService
{
  public abstract int deleteList(String[] paramArrayOfString);
  
  public abstract List<Integer> addToCur(String[] paramArrayOfString);
  
  public abstract int add(VCommodity paramVCommodity, List<VCommext> paramList);
  
  public abstract int update(VCommodity paramVCommodity, List<VCommext> paramList);
}

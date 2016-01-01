package gnnt.MEBS.common.front.service;

import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.integrated.User;
import java.util.List;
import java.util.Set;
import org.apache.commons.logging.Log;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("com_userService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false)
public class UserService
  extends StandardService
{
  public User getTraderByID(String traderID)
  {
    return getTraderByID(traderID, true, true);
  }
  
  public User getTraderByID(String traderID, boolean loadRight, boolean loadRole)
  {
    this.logger.debug("enter getUserByID");
    User entity = new User();
    entity.setTraderID(traderID);
    User user = (User)super.get(entity);
    user.getBelongtoFirm().getFirmModuleSet();
    if (user != null)
    {
      if (loadRight) {
        user.getRightSet().size();
      }
      if (loadRole) {
        user.getRoleSet().size();
      }
    }
    return user;
  }
  
  public User getTraderByUserID(String userID, boolean loadRight, boolean loadRole)
  {
    this.logger.debug("enter getTraderByUserID");
    
    QueryConditions qc = new QueryConditions();
    qc.addCondition("userID", "=", userID);
    PageRequest<QueryConditions> pageRequest = new PageRequest(1, 2, qc, "");
    
    Page<StandardModel> page = getPage(pageRequest, new User());
    User result = null;
    if ((page != null) && (page.getResult() != null) && (page.getResult().size() > 0)) {
      result = (User)page.getResult().get(0);
    }
    if (result != null)
    {
      result.getBelongtoFirm().getFirmModuleSet();
      if (loadRight) {
        result.getRightSet().size();
      }
      if (loadRole) {
        result.getRoleSet().size();
      }
    }
    return result;
  }
}

package gnnt.MEBS.common.broker.service;

import gnnt.MEBS.common.broker.common.Global;
import gnnt.MEBS.common.broker.common.Page;
import gnnt.MEBS.common.broker.common.PageRequest;
import gnnt.MEBS.common.broker.dao.RightDao;
import gnnt.MEBS.common.broker.dao.StandardDao;
import gnnt.MEBS.common.broker.model.Right;
import gnnt.MEBS.common.broker.model.StandardModel;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("com_rightService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false, rollbackFor={Exception.class})
public class RightService
  extends StandardService
{
  @Autowired
  @Qualifier("com_rightDao")
  private RightDao rightDao;
  
  public StandardDao getDao()
  {
    return this.rightDao;
  }
  
  public Right getRightBySubFilter(long id)
  {
    return this.rightDao.getRightBySubFilter(id, -1, 0);
  }
  
  public Right loadRightTree()
  {
    return this.rightDao.loadRightTree(Global.ROOTRIGHTID, -2, 0);
  }
  
  public Set<Right> getAllRight()
  {
    Set<Right> allRightSet = new HashSet();
    
    PageRequest<String> pageRequest = new PageRequest(
      " and type!=-2 ");
    pageRequest.setPageSize(100000);
    Page<StandardModel> page = getPage(pageRequest, new Right());
    List<StandardModel> allRoleList = page.getResult();
    for (StandardModel model : allRoleList) {
      allRightSet.add((Right)model);
    }
    return allRightSet;
  }
}

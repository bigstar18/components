package gnnt.MEBS.common.front.service;

import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.dao.RightDao;
import gnnt.MEBS.common.front.dao.StandardDao;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.front.Right;
import gnnt.MEBS.common.front.model.integrated.User;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("com_rightService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false)
public class RightService
  extends StandardService
{
  @Autowired
  @Qualifier("com_rightDao")
  private RightDao com_rightDao;
  
  public StandardDao getDao()
  {
    return this.com_rightDao;
  }
  
  public Right getRightBySubFilter(long id)
  {
    return this.com_rightDao.getRightBySubFilter(id, -1, 0);
  }
  
  public Right loadRightTree()
  {
    return this.com_rightDao.loadRightTree(0L, -2, 0);
  }
  
  public void saveUserRights(User user, String[] rightIDArr)
  {
    if ((rightIDArr != null) && (rightIDArr.length > 0))
    {
      Set<Right> rightSet = new HashSet();
      for (int i = 0; i < rightIDArr.length; i++)
      {
        Right right = new Right();
        right.setId(Long.valueOf(Long.parseLong(rightIDArr[i])));
        right = (Right)get(right);
        if (right != null) {
          rightSet.add(right);
        }
      }
      user.setRightSet(rightSet);
    }
    else
    {
      user.setRightSet(null);
    }
    update(user);
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

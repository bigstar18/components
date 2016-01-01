package gnnt.MEBS.common.front.service;

import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.dao.StandardDao;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.front.Right;
import gnnt.MEBS.common.front.model.front.Role;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("com_roleService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false)
public class RoleService
  extends StandardService
{
  public Role getRoleById(long id, boolean rightSign)
  {
    Role role = new Role();
    role.setId(Long.valueOf(id));
    role = (Role)getDao().get(role);
    if (rightSign) {
      role.getRightSet().size();
    }
    return role;
  }
  
  public void saveRoleRights(Role role, String[] rightIDArr)
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
      role.setRightSet(rightSet);
    }
    else
    {
      role.setRightSet(null);
    }
    update(role);
  }
  
  public Set<Role> getAllRole()
  {
    Set<Role> allRoleSet = new HashSet();
    
    PageRequest<String> pageRequest = new PageRequest(" ");
    pageRequest.setPageSize(100000);
    Page<StandardModel> page = getPage(pageRequest, new Role());
    List<StandardModel> allRoleList = page.getResult();
    for (StandardModel model : allRoleList) {
      allRoleSet.add((Role)model);
    }
    return allRoleSet;
  }
}

package gnnt.MEBS.integrated.warehouse.dao;

import gnnt.MEBS.common.warehouse.dao.StandardDao;
import gnnt.MEBS.common.warehouse.model.Role;
import org.springframework.stereotype.Repository;

@Repository("roleDao")
public class RoleDao
  extends StandardDao
{
  public Role getRoleById(Long paramLong)
  {
    Role localRole = new Role();
    localRole.setId(paramLong);
    return (Role)super.get(localRole);
  }
}

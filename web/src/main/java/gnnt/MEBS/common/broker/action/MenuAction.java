package gnnt.MEBS.common.broker.action;

import gnnt.MEBS.common.broker.common.Global;
import gnnt.MEBS.common.broker.model.Broker;
import gnnt.MEBS.common.broker.model.BrokerAge;
import gnnt.MEBS.common.broker.model.Menu;
import gnnt.MEBS.common.broker.model.Right;
import gnnt.MEBS.common.broker.model.User;
import gnnt.MEBS.common.broker.service.MenuService;
import gnnt.MEBS.common.broker.service.StandardService;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("com_menuAction")
@Scope("request")
public class MenuAction
  extends StandardAction
{
  private static final long serialVersionUID = 6951086182615239337L;
  @Autowired
  @Qualifier("com_menuService")
  private MenuService menuService;
  
  public MenuAction()
  {
    super.setEntityName(Menu.class.getName());
  }
  
  public void setEntityName(String entityName) {}
  
  public StandardService getService()
  {
    return this.menuService;
  }
  
  public String menuList()
  {
    User user = (User)this.request.getSession().getAttribute(
      "CurrentUser");
    if (user != null)
    {
      Menu allMenu = Global.getRootMenu();
      
      Map<Long, Menu> menuMap = null;
      
      Map<Long, Right> rightMap = null;
      if (user.getType().equals("0")) {
        rightMap = user.getBroker().getRightMap();
      } else {
        rightMap = user.getBrokerAge().getRightMap();
      }
      Menu menu = this.menuService.getHaveRightMenu(allMenu, rightMap);
      this.request.setAttribute("HaveRightMenu", menu);
      menuMap = getMenuMap(menu, menuMap);
      
      return "success";
    }
    return "error";
  }
  
  private Map<Long, Menu> getMenuMap(Menu menu, Map<Long, Menu> map)
  {
    if (menu == null) {
      return map;
    }
    if (map == null) {
      map = new LinkedHashMap();
    }
    map.put(menu.getId(), menu);
    if (menu.getChildMenuSet() != null) {
      for (Menu child : menu.getChildMenuSet()) {
        getMenuMap(child, map);
      }
    }
    return map;
  }
  
  public String modMyMenu()
  {
    return "success";
  }
}

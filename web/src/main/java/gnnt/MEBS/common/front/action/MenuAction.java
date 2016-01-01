package gnnt.MEBS.common.front.action;

import gnnt.MEBS.common.front.common.Global;
import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.front.Menu;
import gnnt.MEBS.common.front.model.front.MyMenu;
import gnnt.MEBS.common.front.model.front.Right;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.integrated.MFirmModule;
import gnnt.MEBS.common.front.model.integrated.TraderModule;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.service.MenuService;
import gnnt.MEBS.common.front.service.StandardService;
import gnnt.MEBS.common.front.statictools.Tools;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
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
  private MenuService com_menuService;
  
  public MenuAction()
  {
    super.setEntityName(Menu.class.getName());
  }
  
  public void setEntityName(String entityName) {}
  
  public StandardService getService()
  {
    return this.com_menuService;
  }
  
  public String menuList()
  {
    this.logger.debug("获取当前用户的菜单列表");
    User user = (User)this.request.getSession().getAttribute(
      "CurrentUser");
    if (user != null)
    {
      boolean isSuperAdminRole = false;
      isSuperAdminRole = ((Boolean)this.request.getSession().getAttribute(
        "IsSuperAdmin")).booleanValue();
      
      Menu allMenu = (Menu)Global.getRootMenu().clone();
      
      Set<Menu> childMenuSet = new LinkedHashSet();
      MFirmModule firmModule;
      for (Menu childMenu : allMenu.getChildMenuSet()) {
        for (Iterator localIterator2 = user.getBelongtoFirm().getFirmModuleSet().iterator(); localIterator2.hasNext();)
        {
          firmModule = (MFirmModule)localIterator2.next();
          if ((firmModule.getModuleID() != null) && (firmModule.getModuleID().equals(childMenu.getModuleId())) && ("Y".equalsIgnoreCase(firmModule.getEnabled())))
          {
            childMenuSet.add(childMenu);
            break;
          }
        }
      }
      allMenu.setChildMenuSet(childMenuSet);
      
      Set<Menu> childMenuSet2 = new LinkedHashSet();
      for (Menu childMenu : allMenu.getChildMenuSet()) {
        for (TraderModule traderModule : user.getTraderModule()) {
          if ((traderModule.getModuleID() != null) && (traderModule.getModuleID().equals(childMenu.getModuleId())) && ("Y".equalsIgnoreCase(traderModule.getEnabled())))
          {
            childMenuSet2.add(childMenu);
            break;
          }
        }
      }
      allMenu.setChildMenuSet(childMenuSet2);
      if (isSuperAdminRole)
      {
        this.request.setAttribute("HaveRightMenu", allMenu);
      }
      else
      {
        Object rightMap = user.getRightMap();
        Menu menu = this.com_menuService.getHaveRightMenu(allMenu, (Map)rightMap);
        this.request.setAttribute("HaveRightMenu", menu);
      }
      Menu nowMenu = (Menu)this.request.getAttribute("HaveRightMenu");
      Map<Long, Menu> map = getMenuMap(nowMenu, null);
      Object pageRequest = new PageRequest(1, 1000, " and userID='" + user.getTraderID() + "'", null);
      Object page = getService().getPage((PageRequest)pageRequest, new MyMenu());
      List<StandardModel> myStandardModel = ((Page)page).getResult();
      Map<Long, Right> myRight = new LinkedHashMap();
      if (myStandardModel != null) {
        for (StandardModel sm : myStandardModel)
        {
          MyMenu mymenu = (MyMenu)sm;
          if (map.get(mymenu.getBelongtoRight().getId()) != null) {
            myRight.put(mymenu.getBelongtoRight().getId(), mymenu.getBelongtoRight());
          }
        }
      }
      this.request.setAttribute("mymenu", myRight);
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
  
  public String changemymenu()
  {
    User user = (User)this.request.getSession().getAttribute("CurrentUser");
    if (user != null)
    {
      List<MyMenu> list = new ArrayList();
      String[] rightIDs = this.request.getParameterValues("mymenu");
      if ((rightIDs != null) && (rightIDs.length > 0))
      {
        Right rt = null;
        MyMenu value = null;
        String[] arrayOfString1;
        int j = (arrayOfString1 = rightIDs).length;
        for (int i = 0; i < j; i++)
        {
          String rightID = arrayOfString1[i];
          long l = Tools.strToLong(rightID, -1000L);
          if (l > 0L)
          {
            rt = new Right();
            rt.setId(Long.valueOf(l));
            value = new MyMenu();
            value.setUserID(user.getTraderID());
            value.setBelongtoRight(rt);
            list.add(value);
          }
        }
      }
      PageRequest<String> pageRequest = new PageRequest(1, 1000, " and userID='" + user.getTraderID() + "'", null);
      
      this.com_menuService.changemymenu(pageRequest, list);
      
      addReturnValue(1, 9910401L, null, 11);
      return "success";
    }
    addReturnValue(-1, 9930401L);
    return "error";
  }
}

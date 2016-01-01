package gnnt.MEBS.common.front.service;

import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.dao.MenuDao;
import gnnt.MEBS.common.front.dao.StandardDao;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.front.Menu;
import gnnt.MEBS.common.front.model.front.MyMenu;
import gnnt.MEBS.common.mgr.model.Right;

@Service("com_menuService")
@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
public class MenuService extends StandardService {
	@Autowired
	@Qualifier("com_menuDao")
	private MenuDao com_menuDao;

	public StandardDao getDao() {
		return this.com_menuDao;
	}

	public List<Menu> getMenuBySubFilter(int type1, int type2, int visible) {
		return this.com_menuDao.getMenuBySubFilter(type1, type2, visible);
	}

	public Menu getMenuById(long id, List<Integer> moduleIds) {
		return this.com_menuDao.getMenuById(id, moduleIds, -1, 0, 0);
	}

	public Menu getHaveRightMenu(Menu allMenu, Map<Long, Right> rightMap) {
		// 新菜单对象 将有权限的菜单复制到新菜单对象
		Menu newMenu = (Menu) allMenu.clone();

		// 因为是克隆过来的所以 子菜单有内容，清空子菜单;子菜单使用seq排序
		newMenu.setChildMenuSet(new TreeSet<Menu>(new Comparator<Menu>() {
			public int compare(Menu menu1, Menu menu2) {
				if (menu1.getSeq() == menu2.getSeq()) {
					return 0;
				} else if (menu1.getSeq() > menu2.getSeq()) {
					return 1;
				} else {
					return -1;
				}
			}
		}));

		// 源菜单的子菜单集合
		Set<Menu> childMenuSet = allMenu.getChildMenuSet();

		// 新菜单子菜单集合
		Set<Menu> newChildMenuSet = newMenu.getChildMenuSet();

		// 遍历子菜单 查看是否有权限 有权限则添加到新菜单
		for (Menu childMenu : childMenuSet) {
			// 权限中是否包含菜单权限标志
			boolean includeFlag = false;
			for (Long rightID : rightMap.keySet()) {
				if (childMenu.getId().longValue() == rightID.longValue()) {
					includeFlag = true;
					break;
				}
			}
			// 如果有权限
			if (includeFlag) {
				// 新子菜单对象
				Menu newChildMenu = (Menu) childMenu.clone();
				// 递归判断子菜单是否还有子菜单 如果有递归
				if (newChildMenu.getChildMenuSet() != null && newChildMenu.getChildMenuSet().size() > 0) {
					newChildMenu = getHaveRightMenu(newChildMenu, rightMap);
				}
				newChildMenuSet.add(newChildMenu);
			}

		}

		return newMenu;
	}

	public int changemymenu(PageRequest<String> pageRequest, List<MyMenu> list) {
		Page<StandardModel> page = getPage(pageRequest, new MyMenu());

		deleteBYBulk(page.getResult());
		if (list != null) {
			for (MyMenu menu : list) {
				add(menu);
			}
		}
		return 1;
	}
}

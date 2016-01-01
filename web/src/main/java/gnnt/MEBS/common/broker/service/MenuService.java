package gnnt.MEBS.common.broker.service;

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

import gnnt.MEBS.common.broker.common.Page;
import gnnt.MEBS.common.broker.dao.MenuDao;
import gnnt.MEBS.common.broker.dao.StandardDao;
import gnnt.MEBS.common.broker.model.Broker;
import gnnt.MEBS.common.broker.model.Menu;
import gnnt.MEBS.common.broker.model.MyMenu;
import gnnt.MEBS.common.broker.model.Right;
import gnnt.MEBS.common.broker.model.StandardModel;
import gnnt.MEBS.common.broker.statictools.Tools;

@Service("com_menuService")
@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = { Exception.class })
public class MenuService extends StandardService {
	@Autowired
	@Qualifier("com_menuDao")
	private MenuDao menuDao;

	public StandardDao getDao() {
		return this.menuDao;
	}

	public List<Menu> getMenuBySubFilter(int type1, int type2, int visible) {
		return this.menuDao.getMenuBySubFilter(type1, type2, visible);
	}

	public Menu getMenuById(long id, List<Integer> moduleList) {
		return this.menuDao.getMenuById(id, -1, 0, 0, moduleList);
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

	public void modMyMenu(Broker broker, String[] rightId, Page<StandardModel> page) {
		if ((page.getResult() != null) && (page.getResult().size() > 0)) {
			getDao().deleteBYBulk(page.getResult());
		}
		if ((rightId != null) && (rightId.length != 0)) {
			String[] arrayOfString;
			int j = (arrayOfString = rightId).length;
			for (int i = 0; i < j; i++) {
				String id = arrayOfString[i];
				MyMenu menu = new MyMenu();
				Right right = new Right();
				right.setId(Long.valueOf(Tools.strToLong(id)));
				menu.setRight((Right) getDao().get(right));
				menu.setBroker(broker);
				getDao().add(menu);
			}
		}
	}
}

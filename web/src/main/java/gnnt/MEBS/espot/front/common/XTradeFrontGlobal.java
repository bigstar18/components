package gnnt.MEBS.espot.front.common;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.TreeSet;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.service.StandardService;
import gnnt.MEBS.common.front.statictools.ApplicationContextInit;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.core.kernel.IKernelService;
import gnnt.MEBS.espot.core.vo.CoreValueVO;
import gnnt.MEBS.espot.front.model.commodity.Breed;
import gnnt.MEBS.espot.front.model.commodity.Category;
import gnnt.MEBS.espot.front.model.trade.SystemProps;

public class XTradeFrontGlobal implements ServletContextListener {
	private final transient Log logger = LogFactory.getLog(getClass());
	public static final String PAYTIMESSTR = "PayTimes";
	private static Page<Category> categoryPage;
	private static Page<Category> categoryFirstPage;
	public static int sysStatus;
	ReloadCategoryThread reloadCategoryThread;
	public static int PAYTIMES;
	public static String breedStr;

	public void contextDestroyed(ServletContextEvent paramServletContextEvent) {
		if (this.reloadCategoryThread != null) {
			this.reloadCategoryThread.shutdown();
		}
	}

	public void contextInitialized(ServletContextEvent paramServletContextEvent) {
		categoryPage = getCategoryPageFromDB();
		categoryFirstPage = getCategoryFirstPageFromDB();
		StandardService localStandardService = (StandardService) ApplicationContextInit.getBean("com_standardService");
		SystemProps localSystemProps = new SystemProps();
		localSystemProps.setPropsKey("PayTimes");
		localSystemProps = (SystemProps) localStandardService.get(localSystemProps);
		PAYTIMES = Tools.strToInt(localSystemProps.getRunTimeValue());
		this.reloadCategoryThread = new ReloadCategoryThread();
		this.reloadCategoryThread.start();
	}

	private static Page<Category> getCategoryPageFromDB() {
		PageRequest localPageRequest = new PageRequest(1, 100, " and primary.type='leaf' and primary.status=1 and primary.belongModule like '%23%' ",
				" order by primary.sortNo ");
		StandardService localStandardService = (StandardService) ApplicationContextInit.getBean("com_standardService");
		Page localPage2 = localStandardService.getPage(localPageRequest, new Category());
		Page localPage1 = new Page(localPage2.getPageNumber(), localPage2.getPageSize(), localPage2.getTotalCount());
		ArrayList localArrayList = new ArrayList();
		List localList = localPage2.getResult();
		TreeSet localTreeSet = new TreeSet(new Comparator<Category>() {
			public int compare(Category paramAnonymousCategory1, Category paramAnonymousCategory2) {
				if ((paramAnonymousCategory1.getParentCategory().getCategoryID().longValue() == -1L)
						&& (paramAnonymousCategory2.getParentCategory().getCategoryID().longValue() != -1L)) {
					if (paramAnonymousCategory1.getSortNo().longValue() > paramAnonymousCategory2.getParentCategory().getSortNo().longValue()) {
						return 1;
					}
					return -1;
				}
				if ((paramAnonymousCategory1.getParentCategory().getCategoryID().longValue() != -1L)
						&& (paramAnonymousCategory2.getParentCategory().getCategoryID().longValue() == -1L)) {
					if (paramAnonymousCategory1.getParentCategory().getSortNo().longValue() < paramAnonymousCategory2.getSortNo().longValue()) {
						return -1;
					}
					return 1;
				}
				if ((paramAnonymousCategory1.getParentCategory().getCategoryID().longValue() == -1L)
						&& (paramAnonymousCategory2.getParentCategory().getCategoryID().longValue() == -1L)) {
					if (paramAnonymousCategory1.getSortNo().longValue() > paramAnonymousCategory2.getSortNo().longValue()) {
						return 1;
					}
					return -1;
				}
				if ((paramAnonymousCategory1.getParentCategory().getCategoryID().longValue() != -1L)
						&& (paramAnonymousCategory2.getParentCategory().getCategoryID().longValue() != -1L)) {
					if (paramAnonymousCategory1.getParentCategory().getSortNo().longValue() < paramAnonymousCategory2.getParentCategory().getSortNo()
							.longValue()) {
						return -1;
					}
					if (paramAnonymousCategory1.getParentCategory().getSortNo() == paramAnonymousCategory2.getParentCategory().getSortNo()) {
						if (paramAnonymousCategory1.getSortNo().longValue() > paramAnonymousCategory2.getSortNo().longValue()) {
							return 1;
						}
						return -1;
					}
					if (paramAnonymousCategory1.getParentCategory().getSortNo().longValue() > paramAnonymousCategory2.getParentCategory().getSortNo()
							.longValue()) {
						return 1;
					}
				}
				return 1;
			}

		});
		String str = "";
		Iterator localIterator1 = localList.iterator();
		Object localObject;
		while (localIterator1.hasNext()) {
			localObject = (StandardModel) localIterator1.next();
			Category localCategory = (Category) localObject;
			Iterator localIterator2 = localCategory.getContainBreed().iterator();
			while (localIterator2.hasNext()) {
				Breed localBreed = (Breed) localIterator2.next();
				if (!"".equals(str)) {
					str = str + ",";
				}
				str = str + localBreed.getBreedID();
			}
			localTreeSet.add((Category) localObject);
		}
		breedStr = str;
		localIterator1 = localTreeSet.iterator();
		while (localIterator1.hasNext()) {
			localObject = (Category) localIterator1.next();
			localArrayList.add((Category) localObject);
		}
		localPage1.setResult(localArrayList);
		return localPage1;
	}

	private static Page<Category> getCategoryFirstPageFromDB() {
		PageRequest localPageRequest = new PageRequest(1, 100,
				" and parentCategory.categoryID=-1 and primary.status=1 and primary.belongModule like '%23%' ", " order by sortNo ");
		StandardService localStandardService = (StandardService) ApplicationContextInit.getBean("com_standardService");
		Page localPage2 = localStandardService.getPage(localPageRequest, new Category());
		Page localPage1 = new Page(localPage2.getPageNumber(), localPage2.getPageSize(), localPage2.getTotalCount());
		ArrayList localArrayList = new ArrayList();
		List localList = localPage2.getResult();
		Iterator localIterator = localList.iterator();
		while (localIterator.hasNext()) {
			StandardModel localStandardModel = (StandardModel) localIterator.next();
			localArrayList.add((Category) localStandardModel);
		}
		localPage1.setResult(localArrayList);
		return localPage1;
	}

	public static void reloadCategoryPage() {
		categoryPage = getCategoryPageFromDB();
		categoryFirstPage = getCategoryFirstPageFromDB();
	}

	public static Page<Category> getCategoryPage() {
		return categoryPage;
	}

	public static Page<Category> getCategoryFirstPage() {
		return categoryFirstPage;
	}

	public static void setCategoryFirstPage(Page<Category> paramPage) {
		categoryFirstPage = paramPage;
	}

	class ReloadCategoryThread extends Thread {
		boolean isRun = true;
		int flag = -1;

		ReloadCategoryThread() {
		}

		public void run() {
			for (;;) {
				if (this.isRun) {
					try {
						CoreValueVO localCoreValueVO = ((IKernelService) ApplicationContextInit.getBean("kernelService")).getCoreValueVO();
						XTradeFrontGlobal.sysStatus = localCoreValueVO.getSysStatus();
						int i = localCoreValueVO.getReloadCategoryFlag();
						if ((this.flag != i) && (this.flag != -1)) {
							XTradeFrontGlobal.reloadCategoryPage();
						}
						this.flag = i;
						try {
							sleep(2000L);
						} catch (InterruptedException localInterruptedException1) {
							localInterruptedException1.printStackTrace();
						}
					} catch (Exception localException) {
						XTradeFrontGlobal.this.logger.error("警告：当前无法连接现货核心");
					} finally {
						try {
							sleep(2000L);
						} catch (InterruptedException localInterruptedException3) {
							localInterruptedException3.printStackTrace();
						}
					}
				}
			}
		}

		public void shutdown() {
			this.isRun = false;
			try {
				interrupt();
			} catch (Exception localException) {
			}
		}
	}
}

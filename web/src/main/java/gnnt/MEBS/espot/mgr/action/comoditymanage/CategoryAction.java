package gnnt.MEBS.espot.mgr.action.comoditymanage;

import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.mgr.action.StandardAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.User;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.espot.core.kernel.IKernelService;
import gnnt.MEBS.espot.core.kernel.IOrderAndPickoffOrder;
import gnnt.MEBS.espot.mgr.model.commoditymanage.Breed;
import gnnt.MEBS.espot.mgr.model.commoditymanage.Category;
import gnnt.MEBS.espot.mgr.model.ordermanage.Order;
import gnnt.MEBS.espot.mgr.model.parametermanage.DeliveryFee;
import gnnt.MEBS.espot.mgr.model.parametermanage.DeliveryMargin;
import gnnt.MEBS.espot.mgr.model.parametermanage.TradeFee;
import gnnt.MEBS.espot.mgr.model.preordermanage.GoodsResource;
import gnnt.MEBS.espot.mgr.model.preordermanage.GoodsTemplate;
import net.sf.json.JSONArray;

@Controller("categoryAction")
@Scope("request")
public class CategoryAction extends StandardAction {
	private static final long serialVersionUID = 1L;
	@Autowired
	@Qualifier("kernelService")
	private IKernelService kernelService;
	@Autowired
	@Qualifier("orderService")
	private IOrderAndPickoffOrder orderService;
	private JSONArray jsonReturn;
	private String template;
	private String goodsResource;
	private String tradeFee;
	private String deliveryFee;
	private String deliveryMargin;
	private int orderNum;

	public int getOrderNum() {
		return this.orderNum;
	}

	public void setOrderNum(int paramInt) {
		this.orderNum = paramInt;
	}

	public String getTemplate() {
		return this.template;
	}

	public void setTemplate(String paramString) {
		this.template = paramString;
	}

	public String getGoodsResource() {
		return this.goodsResource;
	}

	public void setGoodsResource(String paramString) {
		this.goodsResource = paramString;
	}

	public String getTradeFee() {
		return this.tradeFee;
	}

	public void setTradeFee(String paramString) {
		this.tradeFee = paramString;
	}

	public String getDeliveryFee() {
		return this.deliveryFee;
	}

	public void setDeliveryFee(String paramString) {
		this.deliveryFee = paramString;
	}

	public String getDeliveryMargin() {
		return this.deliveryMargin;
	}

	public void setDeliveryMargin(String paramString) {
		this.deliveryMargin = paramString;
	}

	public JSONArray getJsonReturn() {
		return this.jsonReturn;
	}

	public void setJsonReturn(JSONArray paramJSONArray) {
		this.jsonReturn = paramJSONArray;
	}

	public IKernelService getKernelService() {
		return this.kernelService;
	}

	public void setKernelService(IKernelService paramIKernelService) {
		this.kernelService = paramIKernelService;
	}

	public IOrderAndPickoffOrder getOrderService() {
		return this.orderService;
	}

	public void setOrderService(IOrderAndPickoffOrder paramIOrderAndPickoffOrder) {
		this.orderService = paramIOrderAndPickoffOrder;
	}

	public String forwardCommodity() {
		this.logger.debug("============维护跳转==========forwardCommodity=====");
		PageRequest localPageRequest = new PageRequest(" and primary.type='leaf'");
		localPageRequest.setPageSize(100000);
		localPageRequest.setSortColumns(" order by primary.status,primary.sortNo");
		Page localPage = getService().getPage(localPageRequest, new Category());
		List localList = localPage.getResult();
		TreeSet localTreeSet = new TreeSet(new Comparator<Category>() {
			public int compare(Category paramAnonymousCategory1, Category paramAnonymousCategory2) {
				if ((paramAnonymousCategory1.getStatus().intValue() == 2) && (paramAnonymousCategory2.getStatus().intValue() == 1)) {
					return 1;
				}
				if ((paramAnonymousCategory1.getParentCategory().getCategoryId().longValue() == -1L)
						&& (paramAnonymousCategory2.getParentCategory().getCategoryId().longValue() != -1L)) {
					if (paramAnonymousCategory1.getSortNo().intValue() > paramAnonymousCategory2.getParentCategory().getSortNo().intValue()) {
						if ((paramAnonymousCategory1.getBelongModule() != null) && (paramAnonymousCategory1.getBelongModule().contains("23"))
								&& ((paramAnonymousCategory2.getBelongModule() == null) || ((paramAnonymousCategory2.getBelongModule() != null)
										&& (!paramAnonymousCategory2.getBelongModule().contains("23"))))) {
							return -1;
						}
						return 1;
					}
					if ((paramAnonymousCategory2.getBelongModule() != null) && (paramAnonymousCategory2.getBelongModule().contains("23"))
							&& ((paramAnonymousCategory1.getBelongModule() == null) || ((paramAnonymousCategory1.getBelongModule() != null)
									&& (!paramAnonymousCategory1.getBelongModule().contains("23"))))) {
						return 1;
					}
					return -1;
				}
				if ((paramAnonymousCategory1.getParentCategory().getCategoryId().longValue() != -1L)
						&& (paramAnonymousCategory2.getParentCategory().getCategoryId().longValue() == -1L)) {
					if (paramAnonymousCategory1.getParentCategory().getSortNo().intValue() < paramAnonymousCategory2.getSortNo().intValue()) {
						if ((paramAnonymousCategory2.getBelongModule() != null) && (paramAnonymousCategory2.getBelongModule().contains("23"))
								&& ((paramAnonymousCategory1.getBelongModule() == null) || ((paramAnonymousCategory1.getBelongModule() != null)
										&& (!paramAnonymousCategory1.getBelongModule().contains("23"))))) {
							return 1;
						}
						return -1;
					}
					if ((paramAnonymousCategory1.getBelongModule() != null) && (paramAnonymousCategory1.getBelongModule().contains("23"))
							&& ((paramAnonymousCategory2.getBelongModule() == null) || ((paramAnonymousCategory2.getBelongModule() != null)
									&& (!paramAnonymousCategory2.getBelongModule().contains("23"))))) {
						return -1;
					}
					return 1;
				}
				if ((paramAnonymousCategory1.getParentCategory().getCategoryId().longValue() == -1L)
						&& (paramAnonymousCategory2.getParentCategory().getCategoryId().longValue() == -1L)) {
					if (paramAnonymousCategory1.getSortNo().intValue() > paramAnonymousCategory2.getSortNo().intValue()) {
						if ((paramAnonymousCategory1.getBelongModule() != null) && (paramAnonymousCategory1.getBelongModule().contains("23"))
								&& ((paramAnonymousCategory2.getBelongModule() == null) || ((paramAnonymousCategory2.getBelongModule() != null)
										&& (!paramAnonymousCategory2.getBelongModule().contains("23"))))) {
							return -1;
						}
						return 1;
					}
					if ((paramAnonymousCategory2.getBelongModule() != null) && (paramAnonymousCategory2.getBelongModule().contains("23"))
							&& ((paramAnonymousCategory1.getBelongModule() == null) || ((paramAnonymousCategory1.getBelongModule() != null)
									&& (!paramAnonymousCategory1.getBelongModule().contains("23"))))) {
						return 1;
					}
					return -1;
				}
				if ((paramAnonymousCategory1.getParentCategory().getCategoryId().longValue() != -1L)
						&& (paramAnonymousCategory2.getParentCategory().getCategoryId().longValue() != -1L)) {
					if (paramAnonymousCategory1.getParentCategory().getSortNo().intValue() < paramAnonymousCategory2.getParentCategory().getSortNo()
							.intValue()) {
						if ((paramAnonymousCategory2.getBelongModule() != null) && (paramAnonymousCategory2.getBelongModule().contains("23"))
								&& ((paramAnonymousCategory1.getBelongModule() == null) || ((paramAnonymousCategory1.getBelongModule() != null)
										&& (!paramAnonymousCategory1.getBelongModule().contains("23"))))) {
							return 1;
						}
						return -1;
					}
					if (paramAnonymousCategory1.getParentCategory().getSortNo() == paramAnonymousCategory2.getParentCategory().getSortNo()) {
						if (paramAnonymousCategory1.getSortNo().intValue() > paramAnonymousCategory2.getSortNo().intValue()) {
							if ((paramAnonymousCategory1.getBelongModule() != null) && (paramAnonymousCategory1.getBelongModule().contains("23"))
									&& ((paramAnonymousCategory2.getBelongModule() == null) || ((paramAnonymousCategory2.getBelongModule() != null)
											&& (!paramAnonymousCategory2.getBelongModule().contains("23"))))) {
								return -1;
							}
							return 1;
						}
						if ((paramAnonymousCategory2.getBelongModule() != null) && (paramAnonymousCategory2.getBelongModule().contains("23"))
								&& ((paramAnonymousCategory1.getBelongModule() == null) || ((paramAnonymousCategory1.getBelongModule() != null)
										&& (!paramAnonymousCategory1.getBelongModule().contains("23"))))) {
							return 1;
						}
						return -1;
					}
					if (paramAnonymousCategory1.getParentCategory().getSortNo().intValue() > paramAnonymousCategory2.getParentCategory().getSortNo()
							.intValue()) {
						if ((paramAnonymousCategory1.getBelongModule() != null) && (paramAnonymousCategory1.getBelongModule().contains("23"))
								&& ((paramAnonymousCategory2.getBelongModule() == null) || ((paramAnonymousCategory2.getBelongModule() != null)
										&& (!paramAnonymousCategory2.getBelongModule().contains("23"))))) {
							return -1;
						}
						return 1;
					}
				}
				if ((paramAnonymousCategory1.getBelongModule() != null) && (paramAnonymousCategory1.getBelongModule().contains("23"))
						&& ((paramAnonymousCategory2.getBelongModule() == null) || ((paramAnonymousCategory2.getBelongModule() != null)
								&& (!paramAnonymousCategory2.getBelongModule().contains("23"))))) {
					return -1;
				}
				return 1;
			}
		});
		Iterator localIterator = localList.iterator();
		while (localIterator.hasNext()) {
			StandardModel localStandardModel = (StandardModel) localIterator.next();
			localTreeSet.add((Category) localStandardModel);
		}
		this.request.setAttribute("categoryList", localTreeSet);
		return "success";
	}

	public String performCommodity() {
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Long localLong = Long.valueOf(Tools.strToLong(this.request.getParameter("breedId"), -1000L));
		this.logger.debug("---删除品名下的所有关于交易的数据---categoryAction---performCommodity--" + localLong);
		Breed localBreed = new Breed();
		localBreed.setBreedId(localLong);
		localBreed = (Breed) getService().get(localBreed);
		if (localBreed == null) {
			addReturnValue(-1, 230002L, new Object[] { "操作失败，ID为" + localLong + "的品名不存在" });
			return "success";
		}
		if (localBreed.getStatus().intValue() == 1) {
			addReturnValue(-1, 230002L, new Object[] { "操作失败，ID为" + localLong + "的品名未删除" });
			return "success";
		}
		PageRequest localPageRequest = new PageRequest(" and primary.breed.breedId=" + localLong);
		Page localPage1 = getService().getPage(localPageRequest, new GoodsTemplate());
		if ((localPage1.getResult() != null) && (localPage1.getResult().size() > 0)) {
			this.template = "Y";
			getService().deleteBYBulk(localPage1.getResult());
		}
		this.template = "N";
		try {
			Thread.sleep(2000L);
		} catch (InterruptedException localInterruptedException1) {
			localInterruptedException1.printStackTrace();
		}
		localPageRequest = new PageRequest(" and primary.breed.breedId=" + localLong);
		Page localPage2 = getService().getPage(localPageRequest, new GoodsResource());
		if ((localPage2.getResult() != null) && (localPage2.getResult().size() > 0)) {
			this.goodsResource = "Y";
			getService().deleteBYBulk(localPage2.getResult());
		}
		this.goodsResource = "N";
		try {
			Thread.sleep(2000L);
		} catch (InterruptedException localInterruptedException2) {
			localInterruptedException2.printStackTrace();
		}
		localPageRequest = new PageRequest(" and primary.category.categoryId=" + localBreed.getCategory().getCategoryId()
				+ " and ((primary.category.belongModule like '%23%' and primary.category.status=2) or (primary.category.belongModule not like '%23%')) ");
		Page localPage3 = getService().getPage(localPageRequest, new TradeFee());
		if ((localPage3.getResult() != null) && (localPage3.getResult().size() > 0)) {
			this.tradeFee = "Y";
			getService().deleteBYBulk(localPage3.getResult());
		}
		this.tradeFee = "N";
		try {
			Thread.sleep(2000L);
		} catch (InterruptedException localInterruptedException3) {
			localInterruptedException3.printStackTrace();
		}
		localPageRequest = new PageRequest(" and primary.category.categoryId=" + localBreed.getCategory().getCategoryId()
				+ " and ((primary.category.belongModule like '%23%' and primary.category.status=2) or (primary.category.belongModule not like '%23%')) ");
		Page localPage4 = getService().getPage(localPageRequest, new DeliveryFee());
		if ((localPage4.getResult() != null) && (localPage4.getResult().size() > 0)) {
			this.deliveryFee = "Y";
			getService().deleteBYBulk(localPage4.getResult());
		}
		this.deliveryFee = "N";
		try {
			Thread.sleep(2000L);
		} catch (InterruptedException localInterruptedException4) {
			localInterruptedException4.printStackTrace();
		}
		localPageRequest = new PageRequest(" and primary.category.categoryId=" + localBreed.getCategory().getCategoryId()
				+ " and ((primary.category.belongModule like '%23%' and primary.category.status=2) or (primary.category.belongModule not like '%23%')) ");
		Page localPage5 = getService().getPage(localPageRequest, new DeliveryMargin());
		if ((localPage5.getResult() != null) && (localPage5.getResult().size() > 0)) {
			this.deliveryMargin = "Y";
			getService().deleteBYBulk(localPage5.getResult());
		}
		this.deliveryMargin = "N";
		try {
			Thread.sleep(2000L);
		} catch (InterruptedException localInterruptedException5) {
			localInterruptedException5.printStackTrace();
		}
		try {
			localPageRequest = new PageRequest(" and primary.breed.breedId=" + localLong);
			Page localPage6 = getService().getPage(localPageRequest, new Order());
			if ((localPage6.getResult() != null) && (localPage6.getResult().size() > 0)) {
				int i = localPage6.getResult().size();
				int j = 0;
				Iterator localIterator = localPage6.getResult().iterator();
				while (localIterator.hasNext()) {
					StandardModel localStandardModel = (StandardModel) localIterator.next();
					Order localOrder = (Order) localStandardModel;
					j++;
					this.orderService.withdrawOrder(localOrder.getOrderId().longValue(), localUser.getUserId());
					this.orderNum = Tools.strToInt(j / i * 100 + "");
				}
			}
		} catch (Exception localException) {
			addReturnValue(-1, 230004L, new Object[] { "维护品名，撤销委托的操作" });
			this.logger.error(Tools.getExceptionTrace(localException));
		}
		this.orderNum = -1;
		return "success";
	}

	public String synCommodity() {
		this.kernelService.updateCommdityInfo();
		addReturnValue(1, 230000L);
		return "success";
	}

	public String getBreedByCategoryID() {
		this.logger.debug("---通过商品分类ID查询品种信息并加入到json中---categoryAction---getBreedByCategoryID--");
		this.jsonReturn = new JSONArray();
		long l = Tools.strToLong(this.request.getParameter("categoryId"), -1000L);
		if (l < 0L) {
			return "success";
		}
		PageRequest localPageRequest = new PageRequest(" and primary.type='leaf'");
		localPageRequest.setSortColumns(" order by sortNo");
		Page localPage = getService().getPage(localPageRequest, new Category());
		if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
			Iterator localIterator1 = localPage.getResult().iterator();
			while (localIterator1.hasNext()) {
				StandardModel localStandardModel = (StandardModel) localIterator1.next();
				Category localCategory = (Category) localStandardModel;
				if (l == localCategory.getCategoryId().longValue()) {
					Iterator localIterator2 = localCategory.getBreedSet().iterator();
					while (localIterator2.hasNext()) {
						Breed localBreed = (Breed) localIterator2.next();
						JSONArray localJSONArray = new JSONArray();
						localJSONArray.add(localBreed.getBreedId());
						localJSONArray.add(localBreed.getBreedName());
						localJSONArray.add(localBreed.getUnit());
						localJSONArray.add(localBreed.getBelongModule());
						localJSONArray.add(localBreed.getStatus());
						this.jsonReturn.add(localJSONArray);
					}
					break;
				}
			}
		}
		return "success";
	}
}

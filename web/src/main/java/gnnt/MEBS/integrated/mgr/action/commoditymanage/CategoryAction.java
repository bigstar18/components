package gnnt.MEBS.integrated.mgr.action.commoditymanage;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.mgr.action.StandardAction;
import gnnt.MEBS.common.mgr.common.Global;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.model.TradeModule;
import gnnt.MEBS.common.mgr.statictools.ApplicationContextInit;
import gnnt.MEBS.common.mgr.statictools.Arith;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.integrated.mgr.model.SystemProps;
import gnnt.MEBS.integrated.mgr.model.commodity.Breed;
import gnnt.MEBS.integrated.mgr.model.commodity.Category;
import net.sf.json.JSONArray;

@Controller("categoryAction")
@Scope("request")
public class CategoryAction extends StandardAction {
	private static final long serialVersionUID = 1L;
	@Resource(name = "categoryPropTypeMap")
	protected Map<Integer, String> categoryPropTypeMap;
	@Resource(name = "isPickOrSubOrderMap")
	protected Map<String, String> isPickOrSubOrderMap;
	private JSONArray jsonReturn;
	private Category category;

	public JSONArray getJsonReturn() {
		return this.jsonReturn;
	}

	public Map<Integer, String> getCategoryPropTypeMap() {
		return this.categoryPropTypeMap;
	}

	public void setCategoryPropTypeMap(Map<Integer, String> paramMap) {
		this.categoryPropTypeMap = paramMap;
	}

	public Map<String, String> getIsPickOrSubOrderMap() {
		return this.isPickOrSubOrderMap;
	}

	public void setIsPickOrSubOrderMap(Map<String, String> paramMap) {
		this.isPickOrSubOrderMap = paramMap;
	}

	public Category getCategory() {
		return this.category;
	}

	public void setCategory(Category paramCategory) {
		this.category = paramCategory;
	}

	public String categoryShow() {
		Category localCategory = new Category();
		localCategory.setCategoryId(Long.valueOf(-1L));
		this.category = ((Category) getService().get(localCategory));
		String str = this.category.getJsons(this.category.findTreeJsons());
		str = "[" + str + "]";
		this.request.setAttribute("json", str);
		return "success";
	}

	public String breedShow() {
		Category localCategory = new Category();
		localCategory.setCategoryId(Long.valueOf(-1L));
		this.category = ((Category) getService().get(localCategory));
		String str = this.category.getJsons(this.category.findBreedTreeJsons());
		str = "[" + str + "]";
		this.request.setAttribute("json", str);
		return "success";
	}

	public String addForwardCategory() {
		String str = this.request.getParameter("categoryId");
		PageRequest localPageRequest = new PageRequest(" and primary.parentCategory.categoryId=" + Tools.strToLong(str) + " and primary.status=1");
		Page localPage = getService().getPage(localPageRequest, new Category());
		if ("-1".equals(str)) {
			this.request.setAttribute("belongModuleMap", getBelongModuleMap("-1"));
		} else {
			this.request.setAttribute("belongModuleMap", getBelongModuleMap(str));
		}
		SystemProps localSystemProps = new SystemProps();
		localSystemProps.setPropsKey("Offset");
		localSystemProps = (SystemProps) getService().get(localSystemProps);
		double d = Tools.strToDouble(localSystemProps.getRunTimeValue(), 20.0D);
		this.request.setAttribute("OffSet", Tools.fmtDouble2(Arith.mul(d, 100.0F)));
		this.request.setAttribute("categoryList", localPage.getResult());
		this.request.setAttribute("parentId", str);
		return "success";
	}

	public String addCategory() {
		this.logger.debug("enter add");
		Category localCategory = (Category) this.entity;
		String[] arrayOfString = this.request.getParameterValues("belongModule");
		int i = 1;
		String str = "";
		Map localMap1 = getBelongModuleMap("-1");
		Map localMap2 = getBelongModuleMap(localCategory.getParentCategory().getCategoryId() + "");
		if ((arrayOfString != null) && (arrayOfString.length > 0)) {
			for (String localObject2 : arrayOfString) {
				if (!"".equals(str)) {
					str = str + "|";
				}
				str = str + (String) localObject2;
				if (localCategory.getParentCategory().getCategoryId().longValue() == -1L) {
					if (localMap1.get(Integer.valueOf(Tools.strToInt((String) localObject2))) == null) {
						i = 0;
						break;
					}
				} else if (localMap2.get(Integer.valueOf(Tools.strToInt((String) localObject2))) == null) {
					i = 0;
					break;
				}
			}
			localCategory.setBelongModule(str);
		}
		PageRequest pageRequest = new PageRequest(
				" and primary.parentCategory.categoryId=" + localCategory.getParentCategory().getCategoryId() + " and primary.status=1");
		Page localPage = getService().getPage((PageRequest) pageRequest, new Category());
		this.request.setAttribute("belongModuleMap", getBelongModuleMap(localCategory.getParentCategory().getCategoryId() + ""));
		this.request.setAttribute("categoryList", localPage.getResult());
		if (i == 0) {
			addReturnValue(-1, 111605L);
			writeOperateLog(1071, "添加名称为：" + localCategory.getCategoryName() + "的分类", 0, ApplicationContextInit.getErrorInfo("111605"));
			return "success";
		}
		if (localCategory.getIsOffSet().equals("N")) {
			localCategory.setOffSetRate_v(new BigDecimal(0));
		}
		int r = 1;
		if (localCategory.getParentCategory().getCategoryId().longValue() != -1L) {
			Category localObject2 = new Category();
			((Category) localObject2).setCategoryId(localCategory.getParentCategory().getCategoryId());
			localObject2 = (Category) getService().get((StandardModel) localObject2);
			if ((((Category) localObject2).getBreedSet() != null) && (((Category) localObject2).getBreedSet().size() > 0)) {
				Iterator localIterator = ((Category) localObject2).getBreedSet().iterator();
				while (localIterator.hasNext()) {
					Breed localBreed = (Breed) localIterator.next();
					if (localBreed.getStatus().intValue() == 1) {
						r = 0;
						break;
					}
				}
				if (r == 0) {
					addReturnValue(-1, 111600L);
					writeOperateLog(1071, "添加名称为：" + localCategory.getCategoryName() + "的分类", 0, ApplicationContextInit.getErrorInfo("111608"));
				} else {
					((Category) localObject2).setType("category");
					getService().update((StandardModel) localObject2);
					getService().add(localCategory);
					addReturnValue(1, 119901L);
					writeOperateLog(1071, "添加名称为：" + localCategory.getCategoryName() + "的分类", 1, "");
				}
			} else {
				((Category) localObject2).setType("category");
				getService().update((StandardModel) localObject2);
				getService().add(localCategory);
				addReturnValue(1, 119901L);
				writeOperateLog(1071, "添加名称为：" + localCategory.getCategoryName() + "的分类", 1, "");
			}
		} else {
			localCategory.setType("leaf");
			getService().add(localCategory);
			addReturnValue(1, 119901L);
			writeOperateLog(1071, "添加名称为：" + localCategory.getCategoryName() + "的分类", 1, "");
		}
		return "success";
	}

	public String viewByIdCategory() throws Exception {
		this.entity = getService().get(this.entity);
		Category localCategory = (Category) this.entity;
		if ("category".equals(localCategory.getType())) {
			PageRequest localObject = new PageRequest(
					" and primary.parentCategory.categoryId=" + localCategory.getCategoryId() + " and primary.status=1");
			((PageRequest) localObject).setSortColumns(" order by primary.sortNo");
			Page localPage = getService().getPage((PageRequest) localObject, new Category());
			this.request.setAttribute("categoryList", localPage.getResult());
		}
		if (localCategory.getCategoryId().longValue() == -1L) {
			this.request.setAttribute("belongModuleMap", null);
		} else if (localCategory.getParentCategory().getCategoryId().longValue() == -1L) {
			this.request.setAttribute("belongModuleMap", getBelongModuleMap("-1"));
		} else {
			this.request.setAttribute("belongModuleMap", getBelongModuleMap(localCategory.getParentCategory().getCategoryId() + ""));
		}
		Object localObject = new SystemProps();
		((SystemProps) localObject).setPropsKey("Offset");
		localObject = (SystemProps) getService().get((StandardModel) localObject);
		double d = Tools.strToDouble(((SystemProps) localObject).getRunTimeValue(), 20.0D);
		this.request.setAttribute("OffSet", Tools.fmtDouble2(Arith.mul(d, 100.0F)));
		this.request.setAttribute("propSet", localCategory.getPropertySet());
		this.request.setAttribute("categoryId", this.entity.fetchPKey().getValue());
		return "success";
	}

	public String updateCategory() throws Exception {
		Category localCategory1 = (Category) this.entity;
		Category localCategory2 = (Category) getService().get(this.entity);
		localCategory1.setChildCategorySet(localCategory2.getChildCategorySet());
		localCategory1.setBreedSet(localCategory2.getBreedSet());
		if ("N".equals(localCategory1.getIsOffSet())) {
			localCategory1.setOffSetRate_v(new BigDecimal(0));
		}
		String[] arrayOfString = this.request.getParameterValues("belongModule");
		Object localObject2;
		if (localCategory2.getCategoryId().longValue() == -1L) {
			getService().update(localCategory1);
			addReturnValue(1, 119902L);
		} else {
			Map localObject1 = getBelongModuleMap("-1");
			localObject2 = getBelongModuleMap(localCategory2.getParentCategory().getCategoryId() + "");
			int i = 1;
			Object localObject3;
			if ((arrayOfString != null) && (arrayOfString.length > 0)) {
				localObject3 = "";
				for (String str : arrayOfString) {
					if (!"".equals(localObject3)) {
						localObject3 = (String) localObject3 + "|";
					}
					localObject3 = (String) localObject3 + str;
					if (localCategory2.getParentCategory().getCategoryId().longValue() == -1L) {
						if (((Map) localObject1).get(Integer.valueOf(Tools.strToInt(str))) == null) {
							i = 0;
							break;
						}
					} else if (((Map) localObject2).get(Integer.valueOf(Tools.strToInt(str))) == null) {
						i = 0;
						break;
					}
				}
				localCategory1.setBelongModule((String) localObject3);
			} else {
				localCategory1.setBelongModule("");
			}
			if (i == 0) {
				addReturnValue(-1, 111605L);
				writeOperateLog(1071, "添加名称为：" + localCategory2.getCategoryName() + "的分类", 0, ApplicationContextInit.getErrorInfo("111605"));
			} else {
				if (localCategory1.getParentCategory().getCategoryId().longValue() == -1L) {
					if (!localCategory1.getBelongModule().equals(localCategory2.getBelongModule())) {
						localObject3 = getCategoryListByCategoryId(localCategory1, localCategory1.getBelongModule());
						List breed = getBreedListByCategoryId(localCategory1, localCategory1.getBelongModule());
						updateCategoryByCategory(localCategory1, (List) localObject3);
						updateBreedByCategory(localCategory1, (List) breed);
					}
				} else if (!localCategory1.getBelongModule().equals(localCategory2.getBelongModule())) {
					localObject3 = getBreedListByCategoryId(localCategory1, localCategory1.getBelongModule());
					updateBreedByCategory(localCategory1, (List) localObject3);
				}
				getService().update(localCategory1);
				addReturnValue(1, 119902L);
			}
			if (localCategory1.getParentCategory().getCategoryId().longValue() == -1L) {
				this.request.setAttribute("belongModuleMap", localObject1);
			} else {
				this.request.setAttribute("belongModuleMap", localObject2);
			}
		}
		if ("category".equals(localCategory2.getType())) {
			PageRequest localObject1 = new PageRequest(
					" and primary.parentCategory.categoryId=" + localCategory2.getCategoryId() + " and primary.status=1");
			((PageRequest) localObject1).setSortColumns(" order by primary.sortNo");
			localObject2 = getService().getPage((PageRequest) localObject1, new Category());
			this.request.setAttribute("categoryList", ((Page) localObject2).getResult());
		}
		Object localObject1 = new SystemProps();
		((SystemProps) localObject1).setPropsKey("Offset");
		localObject1 = (SystemProps) getService().get((StandardModel) localObject1);
		double d = Tools.strToDouble(((SystemProps) localObject1).getRunTimeValue(), 20.0D);
		this.request.setAttribute("OffSet", Tools.fmtDouble2(Arith.mul(d, 100.0F)));
		this.request.setAttribute("propSet", localCategory2.getPropertySet());
		this.request.setAttribute("categoryId", localCategory1.getCategoryId());
		writeOperateLog(1071, "修改代码为：" + localCategory2.getCategoryId() + "的分类", 1, "");
		this.entity = localCategory2;
		return "success";
	}

	public String removeCategory() {
		this.logger.debug("enter removeCategory");
		int i = 1;
		Category localCategory1 = (Category) getService().get(this.entity);
		int j = 0;
		Object localObject1;
		Object localObject2;
		if ((localCategory1.getChildCategorySet() != null) && (localCategory1.getChildCategorySet().size() > 0)) {
			localObject1 = localCategory1.getChildCategorySet().iterator();
			while (((Iterator) localObject1).hasNext()) {
				localObject2 = (Category) ((Iterator) localObject1).next();
				if (((Category) localObject2).getStatus().intValue() == 1) {
					j = 1;
					break;
				}
			}
		}
		if (j != 0) {
			addReturnValue(-1, 111601L);
			writeOperateLog(1071, "删除代码为：" + localCategory1.getCategoryId() + "的分类", 0, ApplicationContextInit.getErrorInfo("-1007"));
		} else {
			if ((localCategory1.getBreedSet() != null) && (localCategory1.getBreedSet().size() > 0)) {
				localObject1 = localCategory1.getBreedSet().iterator();
				while (((Iterator) localObject1).hasNext()) {
					localObject2 = (Breed) ((Iterator) localObject1).next();
					if (((Breed) localObject2).getStatus().intValue() == 1) {
						i = 0;
						break;
					}
				}
			} else {
				i = 1;
			}
			if (i == 0) {
				addReturnValue(-1, 111602L);
				writeOperateLog(1071, "删除代码为：" + localCategory1.getCategoryId() + "的分类", 0, ApplicationContextInit.getErrorInfo("-1012"));
			} else {
				localCategory1.setStatus(Integer.valueOf(2));
				getService().update(localCategory1);
				System.out.println("已删除子分类的名称：" + localCategory1.getCategoryName() + " 已删除子分类的状态：" + localCategory1.getStatus() + " 已删除子分类的类型："
						+ localCategory1.getType());
				if (localCategory1.getParentCategory().getCategoryId().longValue() != -1L) {
					localObject1 = localCategory1.getParentCategory();
					System.out.println("分类的分类号：" + ((Category) localObject1).getCategoryId() + " name：" + ((Category) localObject1).getCategoryName()
							+ " type：" + ((Category) localObject1).getType());
					if ((((Category) localObject1).getChildCategorySet() == null) || (((Category) localObject1).getChildCategorySet().size() <= 0)) {
						((Category) localObject1).setType("leaf");
						getService().update((StandardModel) localObject1);
					} else {
						if ((((Category) localObject1).getChildCategorySet() != null)
								&& (((Category) localObject1).getChildCategorySet().size() > 0)) {
							localObject2 = ((Category) localObject1).getChildCategorySet().iterator();
							while (((Iterator) localObject2).hasNext()) {
								Category localCategory2 = (Category) ((Iterator) localObject2).next();
								if (localCategory2.getStatus().intValue() == 1) {
									i = 0;
									break;
								}
							}
						} else {
							i = 1;
						}
						if (i == 0) {
							writeOperateLog(1071, "删除代码为：" + localCategory1.getCategoryId() + "的分类", 1, "");
						} else {
							((Category) localObject1).setType("leaf");
							getService().update((StandardModel) localObject1);
						}
					}
				}
				addReturnValue(1, 111609L);
				writeOperateLog(1071, "删除代码为：" + localCategory1.getCategoryId() + "的分类", 1, "");
			}
		}
		return "success";
	}

	public String getCommodityInfoByCategoryId() {
		this.logger.debug("---------通过分类ID获取其分类下的子分类以及品名------------getCommodityInfoByCategoryId------------");
		long l = Tools.strToLong(this.request.getParameter("categoryId"), -1000L);
		String str1 = this.request.getParameter("module");
		System.out.println(str1);
		this.jsonReturn = new JSONArray();
		Category localCategory1 = new Category();
		localCategory1.setCategoryId(Long.valueOf(l));
		localCategory1 = (Category) getService().get(localCategory1);
		if ((localCategory1 != null) && (localCategory1.getCategoryId().longValue() != -1L) && (localCategory1.getStatus().intValue() == 1)) {
			Object localObject1;
			if (localCategory1.getParentCategory().getCategoryId().longValue() == -1L) {
				localObject1 = new ArrayList();
				if ((localCategory1.getChildCategorySet() != null) && (localCategory1.getChildCategorySet().size() > 0)) {
					Iterator localObject2 = localCategory1.getChildCategorySet().iterator();
					while (((Iterator) localObject2).hasNext()) {
						Category localCategory2 = (Category) ((Iterator) localObject2).next();
						if ((localCategory2.getStatus().intValue() == 1) && (localCategory2.getBelongModule() != null)
								&& (!"".equals(localCategory2.getBelongModule()))) {
							String[] arrayOfString1 = localCategory2.getBelongModule().split("\\/");
							int i = 1;
							for (String str2 : arrayOfString1) {
								if (!str1.contains(str2)) {
									i = 0;
									break;
								}
							}
							if (i == 0) {
								((List) localObject1).add(localCategory2);
							}
						}
					}
				}
				Object localObject2 = getBreedListByCategoryId(localCategory1, str1);
				this.jsonReturn.add(Integer.valueOf(((List) localObject1).size()));
				this.jsonReturn.add(Integer.valueOf(((List) localObject2).size()));
			} else {
				localObject1 = getBreedListByCategoryId(localCategory1, str1);
				this.jsonReturn.add(Integer.valueOf(0));
				this.jsonReturn.add(Integer.valueOf(((List) localObject1).size()));
			}
		}
		return "success";
	}

	private Map<Integer, TradeModule> getBelongModuleMap(String paramString) {
		LinkedHashMap localLinkedHashMap = new LinkedHashMap();
		if ((Global.modelContextMap != null) && (Global.modelContextMap.size() > 0)) {
			Set localSet = Global.modelContextMap.keySet();
			Iterator localIterator = localSet.iterator();
			while (localIterator.hasNext()) {
				Integer localInteger = (Integer) localIterator.next();
				Map localMap = (Map) Global.modelContextMap.get(localInteger);
				if ("Y".equalsIgnoreCase(localMap.get("ISNEEDBREED").toString())) {
					TradeModule localTradeModule = new TradeModule();
					if ("-1".equals(paramString)) {
						localTradeModule.setAddFirmFn((String) localMap.get("addFirmFn"));
						localTradeModule.setCnName((String) localMap.get("cnName"));
						localTradeModule.setDelFirmFn((String) localMap.get("delFirmFn"));
						localTradeModule.setEnName((String) localMap.get("enName"));
						localTradeModule.setIsFirmSet((String) localMap.get("isFirmSet"));
						localTradeModule.setModuleId(localInteger);
						localTradeModule.setShortName((String) localMap.get("shortName"));
						localTradeModule.setUpdateFirmStatusFn((String) localMap.get("updateFirmStatusFn"));
						localLinkedHashMap.put(localInteger, localTradeModule);
					} else {
						Category localCategory = new Category();
						localCategory.setCategoryId(Long.valueOf(Tools.strToLong(paramString)));
						localCategory = (Category) getService().get(localCategory);
						String str = localCategory.getBelongModule();
						if ((str != null) && (str.contains(localInteger + ""))) {
							localTradeModule.setAddFirmFn((String) localMap.get("addFirmFn"));
							localTradeModule.setCnName((String) localMap.get("cnName"));
							localTradeModule.setDelFirmFn((String) localMap.get("delFirmFn"));
							localTradeModule.setEnName((String) localMap.get("enName"));
							localTradeModule.setIsFirmSet((String) localMap.get("isFirmSet"));
							localTradeModule.setModuleId(localInteger);
							localTradeModule.setShortName((String) localMap.get("shortName"));
							localTradeModule.setUpdateFirmStatusFn((String) localMap.get("updateFirmStatusFn"));
							localLinkedHashMap.put(localInteger, localTradeModule);
						}
					}
				}
			}
		}
		return localLinkedHashMap;
	}

	private List<Category> getCategoryListByCategoryId(Category paramCategory, String paramString) {
		ArrayList localArrayList = new ArrayList();
		if ((paramCategory.getChildCategorySet() != null) && (paramCategory.getChildCategorySet().size() > 0)) {
			Iterator localIterator = paramCategory.getChildCategorySet().iterator();
			while (localIterator.hasNext()) {
				Category localCategory = (Category) localIterator.next();
				if ((localCategory.getStatus().intValue() == 1) && (localCategory.getBelongModule() != null)
						&& (!"".equals(localCategory.getBelongModule()))) {
					String[] arrayOfString1 = localCategory.getBelongModule().split("\\|");
					int i = 1;
					for (String str : arrayOfString1) {
						if (!paramString.contains(str)) {
							i = 0;
							break;
						}
					}
					if (i == 0) {
						localArrayList.add(localCategory);
					}
				}
			}
		}
		return localArrayList;
	}

	private List<Breed> getBreedListByCategoryId(Category paramCategory, String paramString) {
		ArrayList localArrayList = new ArrayList();
		Iterator localIterator;
		Object localObject1;
		int j;
		if ((paramCategory.getChildCategorySet() != null) && (paramCategory.getChildCategorySet().size() > 0)) {
			localIterator = paramCategory.getChildCategorySet().iterator();
			while (localIterator.hasNext()) {
				localObject1 = (Category) localIterator.next();
				if ((((Category) localObject1).getStatus().intValue() == 1) && (((Category) localObject1).getBreedSet() != null)
						&& (((Category) localObject1).getBreedSet().size() > 0)) {
					Iterator localObject2 = ((Category) localObject1).getBreedSet().iterator();
					while (((Iterator) localObject2).hasNext()) {
						Breed localBreed = (Breed) ((Iterator) localObject2).next();
						if ((localBreed.getStatus().intValue() == 1) && (localBreed.getBelongModule() != null)
								&& (!"".equals(localBreed.getBelongModule()))) {
							String[] localObject3 = localBreed.getBelongModule().split("\\|");
							j = 1;
							for (String localCharSequence2 : localObject3) {
								if (!paramString.contains(localCharSequence2)) {
									j = 0;
									break;
								}
							}
							if (j == 0) {
								localArrayList.add(localBreed);
							}
						}
					}
				}
			}
		}
		if ((paramCategory.getBreedSet() != null) && (paramCategory.getBreedSet().size() > 0)) {
			localIterator = paramCategory.getBreedSet().iterator();
			while (localIterator.hasNext()) {
				localObject1 = (Breed) localIterator.next();
				if ((((Breed) localObject1).getStatus().intValue() == 1) && (((Breed) localObject1).getBelongModule() != null)
						&& (!"".equals(((Breed) localObject1).getBelongModule()))) {
					String[] localObject2 = ((Breed) localObject1).getBelongModule().split("\\|");
					int i = 1;
					for (String localCharSequence1 : localObject2) {
						if (!paramString.contains(localCharSequence1)) {
							i = 0;
							break;
						}
					}
					if (i == 0) {
						localArrayList.add(localObject1);
					}
				}
			}
		}
		return localArrayList;
	}

	private void updateCategoryByCategory(Category paramCategory, List<Category> paramList) {
		if ((paramList != null) && (paramList.size() > 0)) {
			Iterator localIterator = paramList.iterator();
			while (localIterator.hasNext()) {
				Category localCategory = (Category) localIterator.next();
				String str1 = paramCategory.getBelongModule();
				if ((str1 != null) && (!"".equals(str1)) && (localCategory.getBelongModule() != null)) {
					String[] arrayOfString1 = str1.split("\\|");
					String str2 = "";
					for (String str3 : arrayOfString1) {
						if (localCategory.getBelongModule().contains(str3)) {
							if (!"".equals(str2)) {
								str2 = str2 + "|";
							}
							str2 = str2 + str3;
						}
					}
					if (!localCategory.getBelongModule().equals(str2)) {
						localCategory.setBelongModule(str2);
						getService().update(localCategory);
					}
				} else {
					localCategory.setBelongModule("");
					getService().update(localCategory);
				}
			}
		}
	}

	private void updateBreedByCategory(Category paramCategory, List<Breed> paramList) {
		if ((paramList != null) && (paramList.size() > 0)) {
			Iterator localIterator = paramList.iterator();
			while (localIterator.hasNext()) {
				Breed localBreed = (Breed) localIterator.next();
				String str1 = paramCategory.getBelongModule();
				if ((str1 != null) && (!"".equals(str1)) && (localBreed.getBelongModule() != null)) {
					String[] arrayOfString1 = str1.split("\\|");
					String str2 = "";
					for (String str3 : arrayOfString1) {
						if (localBreed.getBelongModule().contains(str3)) {
							if (!"".equals(str2)) {
								str2 = str2 + "|";
							}
							str2 = str2 + str3;
						}
					}
					if (!localBreed.getBelongModule().equals(str2)) {
						localBreed.setBelongModule(str2);
						getService().update(localBreed);
					}
				} else {
					localBreed.setBelongModule("");
					getService().update(localBreed);
				}
			}
		}
	}
}

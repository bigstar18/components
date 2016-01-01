package gnnt.MEBS.espot.front.action.commodity;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.front.action.StandardAction;
import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.common.ReturnValue;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.service.UserService;
import gnnt.MEBS.common.front.statictools.ActionUtil;
import gnnt.MEBS.common.front.statictools.ApplicationContextInit;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.core.bo.OrderBO;
import gnnt.MEBS.espot.core.kernel.IKernelService;
import gnnt.MEBS.espot.core.kernel.IOrderAndPickoffOrder;
import gnnt.MEBS.espot.core.vo.FeeComputeArithmeticVO;
import gnnt.MEBS.espot.core.vo.OrderResultVO;
import gnnt.MEBS.espot.front.model.commodity.Category;
import gnnt.MEBS.espot.front.model.commodity.GoodsResource;
import gnnt.MEBS.espot.front.model.commodity.GoodsResourcePic;
import gnnt.MEBS.espot.front.model.commodity.GoodsResourceProperty;
import gnnt.MEBS.espot.front.model.commodity.PropertyType;
import gnnt.MEBS.espot.front.model.trade.OrderPic;
import gnnt.MEBS.espot.front.model.trade.TradeRight;
import gnnt.MEBS.espot.front.model.warehousestock.WareHouse;
import net.sf.json.JSONArray;

@Controller("goodsResourceAction")
@Scope("request")
public class GoodsResourceAction extends StandardAction {
	private static final long serialVersionUID = -3441045262960260289L;
	private File[] fileName;
	private String[] fileNameFileName;
	@Autowired
	@Qualifier("com_userService")
	private UserService userService;
	private List<GoodsResourceProperty> goodsPropertys;
	@Resource(name = "bsFlagMap")
	Map<String, String> bsFlagMap;
	@Resource(name = "deliveryType")
	Map<String, String> deliveryType;
	@Resource(name = "orderStatus")
	Map<String, String> orderStatus;
	@Resource(name = "suborderStatus")
	Map<String, String> suborderStatus;
	@Resource(name = "kernelService")
	private IKernelService kernelService;
	@Autowired
	@Qualifier("orderAndPickoffOrderService")
	private IOrderAndPickoffOrder orderAndPickoffOrderService;
	private JSONArray jsonReturn;
	@Autowired
	@Resource(name = "imageTypeList")
	private List<String> imageTypeList;
	private File uploadFile;
	private String uploadFileFileName;
	private String uploadFileContentType;

	public UserService getUserService() {
		return this.userService;
	}

	public void setUserService(UserService paramUserService) {
		this.userService = paramUserService;
	}

	public String[] getFileNameFileName() {
		return this.fileNameFileName;
	}

	public void setFileNameFileName(String[] paramArrayOfString) {
		this.fileNameFileName = paramArrayOfString;
	}

	public File[] getFileName() {
		return this.fileName;
	}

	public void setFileName(File[] paramArrayOfFile) {
		this.fileName = paramArrayOfFile;
	}

	public Map<String, String> getBsFlagMap() {
		return this.bsFlagMap;
	}

	public Map<String, String> getDeliveryType() {
		return this.deliveryType;
	}

	public Map<String, String> getOrderStatus() {
		return this.orderStatus;
	}

	public Map<String, String> getSuborderStatus() {
		return this.suborderStatus;
	}

	public IOrderAndPickoffOrder getOrderAndPickoffOrderService() {
		return this.orderAndPickoffOrderService;
	}

	public List<GoodsResourceProperty> getGoodsPropertys() {
		return this.goodsPropertys;
	}

	public void setGoodsPropertys(List<GoodsResourceProperty> paramList) {
		this.goodsPropertys = paramList;
	}

	public JSONArray getJsonReturn() {
		return this.jsonReturn;
	}

	public List<String> getImageTypeList() {
		return this.imageTypeList;
	}

	public void setImageTypeList(List<String> paramList) {
		this.imageTypeList = paramList;
	}

	public String commodityList() {
		this.logger.debug("商品列表查询");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str = this.request.getParameter("flag");
		PageRequest localPageRequest = null;
		try {
			localPageRequest = ActionUtil.getPageRequest(this.request);
		} catch (Exception localException) {
			this.logger.error(Tools.getExceptionTrace(localException));
		}
		QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
		localQueryConditions.addCondition("primary.belongtoMFirm.firmID", "=", localUser.getBelongtoFirm().getFirmID());
		if ((str != null) && (!str.equals(""))) {
			localQueryConditions.addCondition("isOrdered", "=", Integer.valueOf(str));
		}
		localQueryConditions.addCondition("primary.belongtoBreed.belongtoCategory.status", "=", Integer.valueOf(1));
		if ("".equals(localPageRequest.getSortColumns())) {
			localPageRequest.setSortColumns(" order by primary.resourceID desc");
		}
		Page localPage = getService().getPage(localPageRequest, new GoodsResource());
		this.request.setAttribute("pageInfo", localPage);
		this.request.setAttribute("flag", str);
		this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
		return "success";
	}

	public String commodityDetails() {
		logger.debug("商品详情查询");
		String s = "select t.runtimevalue from E_SYSTEMPROPS t where t.key = 'TradePreTime'";
		List list = getService().getDao().queryBySql(s);
		Integer integer = Integer.valueOf(((Map) list.get(0)).get("RUNTIMEVALUE").toString());
		request.setAttribute("tradePreHoure", integer);
		long l = Tools.strToLong(request.getParameter("resourceID"), -1000L);
		GoodsResource goodsresource = (GoodsResource) entity;
		if (l > 0L) {
			goodsresource.setResourceID(Long.valueOf(l));
			goodsresource = (GoodsResource) getService().get(goodsresource);
			request.setAttribute("order", goodsresource);
			PageRequest pagerequest = new PageRequest((new StringBuilder()).append(" and primary.resourceId=").append(l).toString());
			pagerequest.setPageSize(100);
			Page page = getService().getPage(pagerequest, new GoodsResourcePic());
			request.setAttribute("imagePicPage", page);
			PageRequest pagerequest1 = new PageRequest((new StringBuilder()).append(" and primary.status=1 and primary.categoryID=")
					.append(((GoodsResource) entity).getCategoryID()).toString());
			Page page1 = getService().getPage(pagerequest1, new Category());
			request.setAttribute("page", page1);
			String s2 = "select * from BI_WareHouse where status=0 order by id";
			List list2 = super.getService().getListBySql(s2, new WareHouse());
			logger.debug((new StringBuilder()).append("wareHouses: ").append(list2.size()).toString());
			request.setAttribute("wareHouses", list2);
			if (goodsresource != null)
				putResourcePropertys(goodsresource.getGoodsResourceProperties());
		}
		User user = (User) request.getSession().getAttribute("CurrentUser");
		String s1 = (new StringBuilder()).append("select * from E_TRADERIGHT t where t.firmid='").append(user.getBelongtoFirm().getFirmID())
				.append("'").toString();
		List list1 = getService().getListBySql(s1, new TradeRight());
		if (null != list1 && list1.size() == 1) {
			request.setAttribute("tradeRight", list1.get(0));
			logger.debug((new StringBuilder()).append("=====TRADERIGHT:").append(list1.get(0)).toString());
		}
		try {
			FeeComputeArithmeticVO feecomputearithmeticvo = kernelService.getDeliveryMarginArithmetic(user.getBelongtoFirm().getFirmID(),
					goodsresource.getCategoryID().longValue());
			FeeComputeArithmeticVO feecomputearithmeticvo1 = kernelService.getDeliveryMarginArithmetic("", goodsresource.getCategoryID().longValue());
			request.setAttribute("deliveryMargin", feecomputearithmeticvo);
			request.setAttribute("delistDeliveryMargin", feecomputearithmeticvo1);
		} catch (RemoteException remoteexception) {
			remoteexception.printStackTrace();
		}
		return "success";
	}

	public int ifhasRight(int paramInt, String paramString) {
		if ((paramInt != 2) && (paramInt != 3)) {
			paramInt = 1;
		}
		if (!"B".equalsIgnoreCase(paramString)) {
			paramString = "S";
		}
		User localUser1 = (User) this.request.getSession().getAttribute("CurrentUser");
		User localUser2 = this.userService.getTraderByID(localUser1.getTraderID());
		MFirm localMFirm = localUser2.getBelongtoFirm();
		if ("D".equalsIgnoreCase(localMFirm.getStatus())) {
			addReturnValue(-1, 2310101L);
			return -1;
		}
		if ("E".equalsIgnoreCase(localMFirm.getStatus())) {
			addReturnValue(-1, 2300002L, new Object[] { "交易商已删除" });
			return -1;
		}
		if ("D".equalsIgnoreCase(localUser2.getStatus())) {
			addReturnValue(-1, 2310102L);
			return -1;
		}
		QueryConditions localQueryConditions = new QueryConditions();
		localQueryConditions.addCondition("firmID", "=", localMFirm.getFirmID());
		PageRequest localPageRequest = new PageRequest(1, 2, localQueryConditions);
		Page localPage = getService().getPage(localPageRequest, new TradeRight());
		if ((localPage.getResult() != null) && (localPage.getResult().size() == 1)) {
			TradeRight localTradeRight = (TradeRight) localPage.getResult().get(0);
			if (paramInt == 1) {
				if (("B".equalsIgnoreCase(paramString)) && (localTradeRight.getBuyOrder().intValue() == 0)) {
					addReturnValue(-1, 2300002L, new Object[] { "您没有买委托的权限" });
					return -1;
				}
				if (("S".equalsIgnoreCase(paramString)) && (localTradeRight.getSellOrder().intValue() == 0)) {
					addReturnValue(-1, 2300002L, new Object[] { "您没有卖委托的权限" });
					return -1;
				}
			}
			if (paramInt == 2) {
				if (("B".equalsIgnoreCase(paramString)) && (localTradeRight.getBuyPick().intValue() == 0)) {
					addReturnValue(-1, 2300002L, new Object[] { "您没有购买的权限" });
					return -1;
				}
				if (("S".equalsIgnoreCase(paramString)) && (localTradeRight.getSellPick().intValue() == 0)) {
					addReturnValue(-1, 2300002L, new Object[] { "您没有销售的权限" });
					return -1;
				}
			}
		}
		return 1;
	}

	public String addCommodityToOrders() {
		String str1 = "对预备委托执行委托";
		this.logger.debug(str1 + "操作");
		String[] arrayOfString1 = this.request.getParameterValues("ids");
		if (arrayOfString1 == null) {
			writeOperateLog(2309, str1, 0, "未传入的预备委托编号");
			return "error";
		}
		OrderResultVO localOrderResultVO = new OrderResultVO();
		String str2 = "";
		String str3 = "";
		String str4 = "";
		String str5 = "";
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str6 = localUser.getBelongtoFirm().getFirmID();
		HashMap localHashMap = new HashMap();
		for (String str7 : arrayOfString1) {
			try {
				GoodsResource localGoodsResource = new GoodsResource();
				localGoodsResource.setResourceID(Long.valueOf(Tools.strToLong(str7)));
				localGoodsResource = (GoodsResource) getService().get(localGoodsResource);
				Object localObject1;
				if (ifhasRight(1, localGoodsResource.getBsFlag()) < 0) {
					if (this.request.getAttribute("ReturnValue") != null) {
						localObject1 = (ReturnValue) this.request.getAttribute("ReturnValue");
						if (str3.length() > 0) {
							str3 = str3 + ",";
							str5 = str5 + ";";
						}
						if (str5.length() > 0) {
							str5 = str5 + ";";
						}
						str3 = str3 + str7;
						str5 = str5 + str7 + "：" + ((ReturnValue) localObject1).getInfo();
					}
				} else {
					localObject1 = "select * from E_TRADERIGHT t where t.firmid='" + localUser.getBelongtoFirm().getFirmID() + "'";
					List localList1 = getService().getListBySql((String) localObject1, new TradeRight());
					Object localObject2;
					if ((null != localList1) && (localList1.size() == 1)) {
						localObject2 = (TradeRight) localList1.get(0);
						if ((((TradeRight) localObject2).getIsPickoff().intValue() == 0) && ("Y".equals(localGoodsResource.getIsSuborder()))
								&& ("N".equals(localGoodsResource.getIsPickOff()))) {
							if (str3.length() > 0) {
								str3 = str3 + ",";
							}
							if (str5.length() > 0) {
								str5 = str5 + ";";
							}
							str3 = str3 + str7;
							str5 = str5 + str7 + "：您没有成交方式为(必须议价成交)的权限";
						}
					}
					if ((localList1 == null)
							|| ((localList1 != null) && (localList1.size() == 1) && (((TradeRight) localList1.get(0)).getIsPickoff().intValue() == 1))
							|| (!"Y".equals(localGoodsResource.getIsSuborder())) || (!"N".equals(localGoodsResource.getIsPickOff()))) {
						localObject2 = null;
						FeeComputeArithmeticVO localFeeComputeArithmeticVO = null;
						if (localHashMap.get(localGoodsResource.getCategoryID()) == null) {
							localObject2 = this.kernelService.getDeliveryMarginArithmetic(str6, localGoodsResource.getCategoryID().longValue());
							localFeeComputeArithmeticVO = this.kernelService.getDeliveryMarginArithmetic("",
									localGoodsResource.getCategoryID().longValue());
							localHashMap.put(localGoodsResource.getCategoryID(),
									new FeeComputeArithmeticVO[] { (FeeComputeArithmeticVO) localObject2, localFeeComputeArithmeticVO });
						} else {
							localObject2 = ((FeeComputeArithmeticVO[]) localHashMap.get(localGoodsResource.getCategoryID()))[0];
							localFeeComputeArithmeticVO = ((FeeComputeArithmeticVO[]) localHashMap.get(localGoodsResource.getCategoryID()))[1];
						}
						Double localDouble1 = Double.valueOf(0.0D);
						Double localDouble2 = Double.valueOf(0.0D);
						Double localDouble3 = Double.valueOf(0.0D);
						Double localDouble4 = Double.valueOf(0.0D);
						if ((localObject2 != null) && (localFeeComputeArithmeticVO != null)) {
							localDouble3 = Double.valueOf(((FeeComputeArithmeticVO) localObject2).getMode() == 1
									? ((FeeComputeArithmeticVO) localObject2).getRate() * localGoodsResource.getQuantity().doubleValue()
									: ((FeeComputeArithmeticVO) localObject2).getRate() * localGoodsResource.getQuantity().doubleValue()
											* localGoodsResource.getPrice().doubleValue());
							localDouble4 = Double.valueOf(localFeeComputeArithmeticVO.getMode() == 1
									? localFeeComputeArithmeticVO.getRate() * localGoodsResource.getQuantity().doubleValue()
									: localFeeComputeArithmeticVO.getRate() * localGoodsResource.getQuantity().doubleValue()
											* localGoodsResource.getPrice().doubleValue());
						}
						localDouble3 = Double.valueOf(new BigDecimal(localDouble3.doubleValue()).setScale(2, 4).doubleValue());
						localDouble4 = Double.valueOf(new BigDecimal(localDouble4.doubleValue()).setScale(2, 4).doubleValue());
						if (localGoodsResource.getBsFlag().equals("B")) {
							localDouble1 = localGoodsResource.getDeliveryMargin_B();
							localDouble2 = localGoodsResource.getDeliveryMargin_S();
						} else {
							localDouble1 = localGoodsResource.getDeliveryMargin_S();
							localDouble2 = localGoodsResource.getDeliveryMargin_B();
						}
						if ((localDouble3.doubleValue() > localDouble1.doubleValue()) || (localDouble4.doubleValue() > localDouble2.doubleValue())) {
							if (str4.length() > 0) {
								str4 = str4 + ",";
							}
							str4 = str4 + str7;
						} else {
							String str8 = "select t.runtimevalue from E_SYSTEMPROPS t where t.key = 'TradePreTime'";
							List localList2 = getService().getDao().queryBySql(str8);
							Long localLong = Long.valueOf(((Map) localList2.get(0)).get("RUNTIMEVALUE").toString());
							OrderBO localOrderBO = localGoodsResource.getOrderBO();
							Double localDouble5 = Double.valueOf(this.kernelService.getOneTradeMargin());
							localOrderBO.orderPO.setTradeMargin_b(localDouble5.doubleValue());
							localOrderBO.orderPO.setTradeMargin_s(localDouble5.doubleValue());
							localOrderBO.orderPO.setTradePreTime(localLong.longValue() * 60L * 60L);
							localOrderResultVO = getOrderAndPickoffOrderService().performOrder(localOrderBO);
							if (localOrderResultVO.getResult() == 1L) {
								localGoodsResource.setIsOrdered(Integer.valueOf(1));
								if (str2.length() > 0) {
									str2 = str2 + ",";
								}
								str2 = str2 + str7;
								PageRequest localPageRequest = new PageRequest(" and primary.resourceId=" + localGoodsResource.getResourceID());
								Page localPage = getService().getPage(localPageRequest, new GoodsResourcePic());
								if ((localPage.getResult() != null) && (localPage.getResult().size() > 0)) {
									Iterator localIterator = localPage.getResult().iterator();
									while (localIterator.hasNext()) {
										StandardModel localStandardModel = (StandardModel) localIterator.next();
										GoodsResourcePic localGoodsResourcePic = (GoodsResourcePic) localStandardModel;
										OrderPic localOrderPic = new OrderPic();
										localOrderPic.setOrderID(Long.valueOf(localOrderResultVO.getOrderID()));
										localOrderPic.setPicture(localGoodsResourcePic.getPicture());
										getService().add(localOrderPic);
									}
								}
							} else {
								if (str3.length() > 0) {
									str3 = str3 + ",";
								}
								if ((str5.length() > 0) && (!str5.endsWith(";"))) {
									str5 = str5 + ";";
								}
								str3 = str3 + str7;
								str5 = str5 + str7 + "：" + localOrderResultVO.getErrorInfo();
							}
						}
					}
				}
			} catch (Exception localException) {
				if (str3.length() > 0) {
					str3 = str3 + ",";
				}
				if (str5.length() > 0) {
					str5 = str5 + ";";
				}
				str3 = str3 + str7;
				str5 = str5 + "预备委托号为" + str7 + "委托失败:" + localException.getMessage();
				this.logger.error(Tools.getExceptionTrace(localException));
			}
		}
		if (str2.length() > 0) {
			str1 = str1 + "[" + str2 + "]成功";
		}
		if (str3.length() > 0) {
			str1 = str1 + "[" + str3 + "]失败";
		}
		if (str4.length() > 0) {
			str1 = str1 + "[" + str4 + "]履约保证金低于最低履约保证金";
		}
		if (str5.length() > 0) {
			addReturnValue(-1, 2300002L, new Object[] { str5 });
			writeOperateLog(2309, str1, 0, str5);
		} else if (str4.length() > 0) {
			addReturnValue(1, 2300000L, new Object[] { "其中预备委托号为：" + str4 + "的预备委托履约保证金低于最低履约保证金，操作失败！" });
			writeOperateLog(2309, str1, 0, "");
		} else {
			addReturnValue(1, 2310105L);
			writeOperateLog(2309, str1, 1, "");
		}
		return "success";
	}

	public String addCommodity() throws Exception {
		String s = "添加预备委托";
		logger.debug((new StringBuilder()).append(s).append("操作").toString());
		User user = (User) request.getSession().getAttribute("CurrentUser");
		GoodsResource goodsresource = (GoodsResource) entity;
		String s1 = request.getParameter("tradeWay");
		if ("1".equals(s1)) {
			goodsresource.setIsSuborder("N");
			goodsresource.setIsPickOff("Y");
		} else if ("2".equals(s1)) {
			goodsresource.setIsSuborder("Y");
			goodsresource.setIsPickOff("Y");
		} else if ("3".equals(s1)) {
			goodsresource.setIsSuborder("Y");
			goodsresource.setIsPickOff("N");
		}
		goodsresource.setBelongtoMFirm(user.getBelongtoFirm());
		goodsresource.setTraderID(user.getTraderID());
		String s2 = (String) ServletActionContext.getRequest().getAttribute("ExceededError");
		if (s2 != null) {
			logger.debug(s2);
			addReturnValue(-1, 0x231863L, new Object[] { s2 });
			return "success";
		}
		if (fileNameFileName != null) {
			for (int i = 0; i < fileNameFileName.length; i++) {
				if (fileNameFileName[i] == null)
					continue;
				String as[] = fileNameFileName[i].split("\\.");
				String s4 = as[as.length - 1];
				if (!imageTypeList.contains(s4.toLowerCase())) {
					addReturnValue(-1, 0x233f74L);
					return "success";
				}
			}

		}
		String s3 = request.getParameter("warehouseID");
		String as1[] = s3.split("-");
		if (as1 != null && as1.length > 0)
			goodsresource.setWarehouseID(as1[0]);
		s = (new StringBuilder()).append(s).append("，分类编号 ").append(goodsresource.getCategoryID()).append(" 品名编号 ")
				.append(goodsresource.getBelongtoBreed().getBreedID()).toString();
		if (goodsPropertys == null) {
			addReturnValue(-1, 0x238e59L);
			writeOperateLog(2309, s, 0, ApplicationContextInit.getErrorInfo("2330201"));
		} else {
			GoodsResourceProperty goodsresourceproperty;
			for (Iterator iterator = goodsPropertys.iterator(); iterator.hasNext(); goodsresource.addGoodsResourceProperty(goodsresourceproperty)) {
				goodsresourceproperty = (GoodsResourceProperty) iterator.next();
				logger.debug((new StringBuilder()).append("property[").append(goodsresourceproperty.getPropertyName()).append("][")
						.append(goodsresourceproperty.getPropertyValue()).append("]").toString());
				goodsresourceproperty.setGoodsResource(goodsresource);
			}

			getService().add(goodsresource);
			logger.debug((new StringBuilder()).append("   goodsResource   ID:  ").append(goodsresource.getResourceID()).toString());
			if (fileName != null) {
				for (int j = 0; j < fileName.length; j++)
					if (fileName[j] != null) {
						FileInputStream fileinputstream = null;
						fileinputstream = new FileInputStream(fileName[j]);
						byte abyte0[] = new byte[fileinputstream.available()];
						fileinputstream.read(abyte0);
						GoodsResourcePic goodsresourcepic = new GoodsResourcePic();
						goodsresourcepic.setResourceId(goodsresource.getResourceID());
						goodsresourcepic.setPicture(abyte0);
						getService().add(goodsresourcepic);
					}

			}
			addReturnValue(1, 0x9736f2L);
			writeOperateLog(2309, s, 1, "");
		}
		return "success";
	}

	public String showImages() throws IOException {
		this.logger.debug("enter showImages");
		HttpServletResponse localHttpServletResponse = ServletActionContext.getResponse();
		ServletOutputStream localServletOutputStream = null;
		GoodsResourcePic localGoodsResourcePic = new GoodsResourcePic();
		localGoodsResourcePic.setId(Long.valueOf(Tools.strToLong(this.request.getParameter("id"), -1000L)));
		localGoodsResourcePic = (GoodsResourcePic) getService().get(localGoodsResourcePic);
		try {
			localHttpServletResponse.setContentType("text/html");
			localServletOutputStream = localHttpServletResponse.getOutputStream();
			localServletOutputStream.write(localGoodsResourcePic.getPicture());
			localServletOutputStream.flush();
			localServletOutputStream.close();
			localServletOutputStream = null;
		} catch (Exception localException) {
			localException.printStackTrace();
		} finally {
			if (localServletOutputStream != null) {
				localServletOutputStream.close();
				localServletOutputStream = null;
			}
		}
		return null;
	}

	public String updateCommodity() {
		this.logger.debug("enter updateCommodity");
		GoodsResource localGoodsResource = (GoodsResource) this.entity;
		String str = this.request.getParameter("tradeWay");
		if ("1".equals(str)) {
			localGoodsResource.setIsSuborder("N");
			localGoodsResource.setIsPickOff("Y");
		} else if ("2".equals(str)) {
			localGoodsResource.setIsSuborder("Y");
			localGoodsResource.setIsPickOff("Y");
		} else if ("3".equals(str)) {
			localGoodsResource.setIsSuborder("Y");
			localGoodsResource.setIsPickOff("N");
		}
		getService().update(localGoodsResource);
		addReturnValue(1, 9910003L);
		return "success";
	}

	private void putResourcePropertys(Set set) {
		if (set != null && set.size() > 0) {
			LinkedHashMap linkedhashmap = new LinkedHashMap();
			QueryConditions queryconditions = new QueryConditions();
			queryconditions.addCondition("status", "=", Integer.valueOf(0));
			PageRequest pagerequest = new PageRequest(1, 100, queryconditions, " order by sortNo ");
			Page page = getService().getPage(pagerequest, new PropertyType());
			if (page != null && page.getResult() != null) {
				for (int i = 0; i < page.getResult().size(); i++) {
					PropertyType propertytype = (PropertyType) page.getResult().get(i);
					linkedhashmap.put(propertytype, new ArrayList());
				}

			}
			ArrayList arraylist = new ArrayList();
			GoodsResourceProperty goodsresourceproperty;
			Object obj;
			for (Iterator iterator = set.iterator(); iterator.hasNext(); ((List) (obj)).add(goodsresourceproperty)) {
				goodsresourceproperty = (GoodsResourceProperty) iterator.next();
				obj = null;
				Iterator iterator2 = linkedhashmap.keySet().iterator();
				do {
					if (!iterator2.hasNext())
						break;
					PropertyType propertytype3 = (PropertyType) iterator2.next();
					if (goodsresourceproperty.getPropertyTypeID() != null
							&& goodsresourceproperty.getPropertyTypeID().equals(propertytype3.getPropertyTypeID()))
						obj = (List) linkedhashmap.get(propertytype3);
				} while (true);
				if (obj == null)
					obj = arraylist;
			}

			LinkedHashMap linkedhashmap1 = new LinkedHashMap();
			Iterator iterator1 = linkedhashmap.keySet().iterator();
			do {
				if (!iterator1.hasNext())
					break;
				PropertyType propertytype2 = (PropertyType) iterator1.next();
				if (((List) linkedhashmap.get(propertytype2)).size() > 0)
					linkedhashmap1.put(propertytype2, linkedhashmap.get(propertytype2));
			} while (true);
			if (arraylist.size() > 0) {
				PropertyType propertytype1 = new PropertyType();
				propertytype1.setName("其它属性");
				propertytype1.setPropertyTypeID(Long.valueOf(-1L));
				linkedhashmap1.put(propertytype1, arraylist);
			}
			request.setAttribute("tpmap", linkedhashmap1);
		}
	}

	public File getUploadFile() {
		return this.uploadFile;
	}

	public void setUploadFile(File paramFile) {
		this.uploadFile = paramFile;
	}

	public String getUploadFileFileName() {
		return this.uploadFileFileName;
	}

	public void setUploadFileFileName(String paramString) {
		this.uploadFileFileName = paramString;
	}

	public String getUploadFileContentType() {
		return this.uploadFileContentType;
	}

	public void setUploadFileContentType(String paramString) {
		this.uploadFileContentType = paramString;
	}
}

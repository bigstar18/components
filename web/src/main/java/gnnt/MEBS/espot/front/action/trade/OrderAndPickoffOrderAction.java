package gnnt.MEBS.espot.front.action.trade;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
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
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.service.UserService;
import gnnt.MEBS.common.front.statictools.ActionUtil;
import gnnt.MEBS.common.front.statictools.ApplicationContextInit;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.core.kernel.IKernelService;
import gnnt.MEBS.espot.core.kernel.IOrderAndPickoffOrder;
import gnnt.MEBS.espot.core.vo.FeeComputeArithmeticVO;
import gnnt.MEBS.espot.core.vo.OrderResultVO;
import gnnt.MEBS.espot.core.vo.PickoffResultVO;
import gnnt.MEBS.espot.core.vo.ResultVO;
import gnnt.MEBS.espot.front.common.XTradeFrontGlobal;
import gnnt.MEBS.espot.front.model.commodity.Breed;
import gnnt.MEBS.espot.front.model.commodity.BreedProps;
import gnnt.MEBS.espot.front.model.commodity.Category;
import gnnt.MEBS.espot.front.model.commodity.GoodsTemplate;
import gnnt.MEBS.espot.front.model.commodity.GoodsTemplateProperty;
import gnnt.MEBS.espot.front.model.commodity.Property;
import gnnt.MEBS.espot.front.model.commodity.PropertyType;
import gnnt.MEBS.espot.front.model.trade.GoodsProperty;
import gnnt.MEBS.espot.front.model.trade.GoodsPropertyBase;
import gnnt.MEBS.espot.front.model.trade.GoodsPropertyHis;
import gnnt.MEBS.espot.front.model.trade.Order;
import gnnt.MEBS.espot.front.model.trade.OrderBase;
import gnnt.MEBS.espot.front.model.trade.OrderHis;
import gnnt.MEBS.espot.front.model.trade.OrderPic;
import gnnt.MEBS.espot.front.model.trade.OrderPicHis;
import gnnt.MEBS.espot.front.model.trade.Reserve;
import gnnt.MEBS.espot.front.model.trade.Trade;
import gnnt.MEBS.espot.front.model.trade.TradeRight;
import gnnt.MEBS.espot.front.model.warehousestock.WareHouse;
import net.sf.json.JSONArray;

@Controller("orderAndPickoffOrderAction")
@Scope("request")
public class OrderAndPickoffOrderAction extends StandardAction {
	private static final long serialVersionUID = -3441045262960260289L;
	private String[] fileNameFileName;
	private File[] fileName;
	private List<GoodsProperty> goodsPropertys;
	@Autowired
	@Qualifier("com_userService")
	private UserService userService;
	@Resource(name = "kernelService")
	private IKernelService kernelService;
	@Resource(name = "bsFlagMap")
	Map<String, String> bsFlagMap;
	@Resource(name = "deliveryType")
	Map<String, String> deliveryType;
	@Resource(name = "deliveryDayTypeMap")
	Map<Integer, String> deliveryDayType;
	@Resource
	Map<String, String> isPermit;
	@Resource
	Map<String, String> isNo;
	@Resource
	Map<String, String> orderTradeTypeMap;
	@Resource(name = "orderStatus")
	Map<String, String> orderStatus;
	@Resource(name = "suborderStatus")
	Map<String, String> suborderStatus;
	@Autowired
	@Qualifier("orderAndPickoffOrderService")
	private IOrderAndPickoffOrder orderAndPickoffOrderService;
	@Autowired
	@Resource(name = "imageTypeList")
	private List<String> imageTypeList;
	private JSONArray jsonReturn;

	public Map<String, String> getIsPermit() {
		return this.isPermit;
	}

	public Map<String, String> getIsNo() {
		return this.isNo;
	}

	public Map<String, String> getOrderTradeTypeMap() {
		return this.orderTradeTypeMap;
	}

	public UserService getUserService() {
		return this.userService;
	}

	public Map<String, String> getBsFlagMap() {
		return this.bsFlagMap;
	}

	public Map<String, String> getDeliveryType() {
		return this.deliveryType;
	}

	public Map<Integer, String> getDeliveryDayType() {
		return this.deliveryDayType;
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

	public List<GoodsProperty> getGoodsPropertys() {
		return this.goodsPropertys;
	}

	public void setGoodsPropertys(List<GoodsProperty> paramList) {
		this.goodsPropertys = paramList;
	}

	public List<String> getImageTypeList() {
		return this.imageTypeList;
	}

	public void setImageTypeList(List<String> paramList) {
		this.imageTypeList = paramList;
	}

	public JSONArray getJsonReturn() {
		return this.jsonReturn;
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

	public String performOrder() {
		String str1 = "发布委托";
		this.logger.debug(str1);
		Order localOrder = getOrderByRequest();
		try {
			if (ifhasRight(1, localOrder.getBsFlag()) < 0) {
				if (this.request.getAttribute("ReturnValue") != null) {
					writeOperateLog(2309, str1 + "失败", 0, String.valueOf(this.request.getAttribute("ReturnValue")));
				}
				return "success";
			}
			String str2 = (String) ServletActionContext.getRequest().getAttribute("ExceededError");
			if (str2 != null) {
				this.logger.debug(str2);
				addReturnValue(-1, 2310103L, new Object[] { str2 });
				return "success";
			}
			String[] arrayOfString = this.request.getParameterValues("filePath1");
			int i;
			if (arrayOfString != null) {
				this.fileNameFileName = new String[arrayOfString.length];
				this.fileName = new File[arrayOfString.length];
				if (arrayOfString.length > 0) {
					for (i = 0; i < arrayOfString.length; i++) {
						this.fileNameFileName[i] = arrayOfString[i];
						this.fileName[i] = new File(arrayOfString[i]);
					}
				}
			}
			if (this.fileNameFileName != null) {
				for (i = 0; i < this.fileNameFileName.length; i++) {
					if (this.fileNameFileName[i] != null) {
						String[] localObject1 = this.fileNameFileName[i].split("\\.");
						Object localObject2 = localObject1[(localObject1.length - 1)];
						if (!this.imageTypeList.contains(((String) localObject2).toLowerCase())) {
							addReturnValue(-1, 2310104L);
							return "success";
						}
					}
				}
			}
			String str3 = this.request.getParameter("addToTemplate");
			if ("true".equalsIgnoreCase(str3)) {
				templateAdd(localOrder);
			}
			Object localObject1 = getOrderAndPickoffOrderService().performOrder(localOrder.getOrderBO());
			if (((OrderResultVO) localObject1).getResult() < 0L) {
				addReturnValue(-1, 2300002L, new Object[] { ((OrderResultVO) localObject1).getErrorInfo().replace("\n", "") });
				writeOperateLog(2309, str1 + "失败，分类编号 " + localOrder.getCategoryID() + " 品名编号 " + localOrder.getBelongtoBreed().getBreedID(), 0,
						((OrderResultVO) localObject1).getErrorInfo().replace("\n", ""));
			} else if (((OrderResultVO) localObject1).getResult() == 0L) {
				addReturnValue(-1, 2300003L, new Object[] { ((OrderResultVO) localObject1).getErrorInfo().replaceAll("\n", "") });
				writeOperateLog(2309, str1 + "失败，分类编号 " + localOrder.getCategoryID() + " 品名编号 " + localOrder.getBelongtoBreed().getBreedID(), 0,
						((OrderResultVO) localObject1).getErrorInfo().replace("\n", ""));
			} else {
				if (this.fileName != null) {
					FileInputStream localFileInputStream;
					Object localObject3;
					Object localObject4;
					for (int j = 0; j < this.fileName.length; j++) {
						if (this.fileName[j] != null) {
							localFileInputStream = new FileInputStream(this.fileName[j]);
							localObject3 = new byte[localFileInputStream.available()];
							localFileInputStream.read((byte[]) localObject3);
							localObject4 = new OrderPic();
							((OrderPic) localObject4).setOrderID(Long.valueOf(((OrderResultVO) localObject1).getOrderID()));
							((OrderPic) localObject4).setPicture((byte[]) localObject3);
							getService().add((StandardModel) localObject4);
						}
					}
					for (int j = 0; j < this.fileName.length; j++) {
						if ((this.fileName[j] != null) && (this.fileName[j].isFile())) {
							localFileInputStream = new FileInputStream(this.fileName[j]);
							localObject3 = new File(
									this.fileName[j].getPath().substring(0, this.fileName[j].getPath().lastIndexOf(File.separator) + 1));
							File[] localObject41 = ((File) localObject3).listFiles();
							for (int k = 0; k < localObject41.length; k++) {
								if (!localObject41[j].isDirectory()) {
									localFileInputStream.close();
									localObject41[k].delete();
								}
							}
						}
					}
				}
				addReturnValue(1, 2310105L);
				writeOperateLog(2309, str1 + "成功，委托号：" + ((OrderResultVO) localObject1).getOrderID(), 1, "");
			}
		} catch (Exception localException) {
			addReturnValue(-1, 2300004L, new Object[] { "委托发布操作" });
			writeOperateLog(2309, str1 + "失败", 0, localException.getMessage());
			this.logger.error(Tools.getExceptionTrace(localException));
		}
		return "success";
	}

	private String templateAdd(Order paramOrder) {
		this.logger.debug("模板添加");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		GoodsTemplate localGoodsTemplate = new GoodsTemplate();
		localGoodsTemplate.setTemplateType(Integer.valueOf(1));
		localGoodsTemplate.setBelongTOUser(localUser.getBelongtoFirm().getFirmID());
		localGoodsTemplate.setBreed(paramOrder.getBelongtoBreed());
		localGoodsTemplate.setBsFlag(paramOrder.getBsFlag());
		localGoodsTemplate.setCategoryID(paramOrder.getCategoryID());
		localGoodsTemplate.setTradeUnit(paramOrder.getTradeUnit());
		localGoodsTemplate.setDeliveryAddress(paramOrder.getDeliveryAddress());
		localGoodsTemplate.setDeliveryDay(paramOrder.getDeliveryDay());
		localGoodsTemplate.setDeliveryDayType(paramOrder.getDeliveryDayType());
		localGoodsTemplate.setDeliveryMargin_b(paramOrder.getDeliveryMargin_B());
		localGoodsTemplate.setDeliveryMargin_s(paramOrder.getDeliveryMargin_S());
		localGoodsTemplate.setDeliveryPreHoure(paramOrder.getDeliveryPreHoure());
		localGoodsTemplate.setDeliveryType(paramOrder.getDeliveryType());
		localGoodsTemplate.setIsPickOff(paramOrder.getIsPickOff());
		localGoodsTemplate.setIsSuborder(paramOrder.getIsSuborder());
		localGoodsTemplate.setMinTradeQty(paramOrder.getMinTradeQty());
		localGoodsTemplate.setOrderTitle(paramOrder.getOrderTitle());
		localGoodsTemplate.setPrice(paramOrder.getPrice());
		localGoodsTemplate.setQuantity(paramOrder.getQuantity());
		localGoodsTemplate.setRemark(paramOrder.getRemark());
		localGoodsTemplate.setTradeMargin_b(paramOrder.getTradeMargin_B());
		localGoodsTemplate.setTradeMargin_s(paramOrder.getTradeMargin_S());
		localGoodsTemplate.setTradePreTime(paramOrder.getTradePreTime());
		localGoodsTemplate.setUnit(paramOrder.getUnit());
		localGoodsTemplate.setValidTime(paramOrder.getValidTime());
		localGoodsTemplate.setWarehouseID(paramOrder.getWarehouseID());
		localGoodsTemplate.setTradeType(paramOrder.getTradeType());
		localGoodsTemplate.setPayType(paramOrder.getPayType());
		if (paramOrder.getContainGoodsProperty() != null) {
			HashSet localHashSet = new HashSet();
			Iterator localIterator = paramOrder.getContainGoodsProperty().iterator();
			while (localIterator.hasNext()) {
				GoodsProperty localGoodsProperty = (GoodsProperty) localIterator.next();
				GoodsTemplateProperty localGoodsTemplateProperty = new GoodsTemplateProperty();
				localGoodsTemplateProperty.setTemplate(localGoodsTemplate);
				localGoodsTemplateProperty.setPropertyName(localGoodsProperty.getPropertyName());
				localGoodsTemplateProperty.setPropertyValue(localGoodsProperty.getPropertyValue());
				localGoodsTemplateProperty.setPropertyTypeID(localGoodsProperty.getPropertyTypeID());
				localHashSet.add(localGoodsTemplateProperty);
			}
			localGoodsTemplate.setContainGoodsTemplateProperty(localHashSet);
		}
		getService().add(localGoodsTemplate);
		this.logger.debug("=================添加模版！！结束");
		return "success";
	}

	public String performOrderStock() {
		String str1 = "通过仓单%s发布委托";
		this.logger.debug("通过仓单委托");
		Order localOrder = getOrderByRequest();
		String str2 = this.request.getParameter("stockID");
		String str3 = (String) ServletActionContext.getRequest().getAttribute("ExceededError");
		if (str3 != null) {
			this.logger.debug(str3);
			addReturnValue(-1, 2310103L, new Object[] { str3 });
			return "success";
		}
		String[] arrayOfString = this.request.getParameterValues("filePath1");
		int i;
		if (arrayOfString != null) {
			this.fileNameFileName = new String[arrayOfString.length];
			this.fileName = new File[arrayOfString.length];
			if (arrayOfString.length > 0) {
				for (i = 0; i < arrayOfString.length; i++) {
					this.fileNameFileName[i] = arrayOfString[i];
					System.out.println("--------------------?????????????" + this.fileNameFileName[i]);
					this.fileName[i] = new File(arrayOfString[i]);
				}
			}
		}
		String[] localObject1;
		if (this.fileNameFileName != null) {
			for (i = 0; i < this.fileNameFileName.length; i++) {
				if (this.fileNameFileName[i] != null) {
					localObject1 = this.fileNameFileName[i].split("\\.");
					Object localObject2 = localObject1[(localObject1.length - 1)];
					if (!this.imageTypeList.contains(((String) localObject2).toLowerCase())) {
						addReturnValue(-1, 2310104L);
						return "success";
					}
				}
			}
		}
		this.logger.debug("买方诚信保障金：" + localOrder.getTradeMargin_B());
		this.logger.debug("卖方诚信保障金：" + localOrder.getTradeMargin_S());
		this.logger.debug("买方交割保证金：" + localOrder.getDeliveryMargin_B());
		this.logger.debug("卖方交割保证金：" + localOrder.getDeliveryMargin_S());
		try {
			if (ifhasRight(1, localOrder.getBsFlag()) < 0) {
				if (this.request.getAttribute("ReturnValue") != null) {
					writeOperateLog(2309, str1 + "失败，", 0, String.valueOf(this.request.getAttribute("ReturnValue")));
				}
				return "success";
			}
			str1 = String.format(str1, new Object[] { str2 });
			String str4 = this.request.getParameter("addToTemplate");
			if ("true".equalsIgnoreCase(str4)) {
				templateAdd(localOrder);
			}
			OrderResultVO localObject11 = getOrderAndPickoffOrderService().performOrderStock(localOrder.getOrderBO().orderPO, str2);
			if (((OrderResultVO) localObject11).getResult() < 0L) {
				addReturnValue(-1, 2300002L, new Object[] { ((OrderResultVO) localObject11).getErrorInfo().replace("\n", "").replaceAll("\n", "") });
				writeOperateLog(2309, str1 + "失败，", 0, ((OrderResultVO) localObject11).getErrorInfo().replace("\n", ""));
			} else if (((OrderResultVO) localObject11).getResult() == 0L) {
				addReturnValue(-1, 2300003L, new Object[] { ((OrderResultVO) localObject11).getErrorInfo().replace("\n", "") });
				writeOperateLog(2309, str1 + "失败，", 0, ((OrderResultVO) localObject11).getErrorInfo().replace("\n", ""));
			} else {
				if (this.fileName != null) {
					for (int j = 0; j < this.fileName.length; j++) {
						if (this.fileName[j] != null) {
							FileInputStream localFileInputStream = new FileInputStream(this.fileName[j]);
							byte[] arrayOfByte = new byte[localFileInputStream.available()];
							localFileInputStream.read(arrayOfByte);
							OrderPic localOrderPic = new OrderPic();
							localOrderPic.setOrderID(Long.valueOf(((OrderResultVO) localObject11).getOrderID()));
							localOrderPic.setPicture(arrayOfByte);
							getService().add(localOrderPic);
						}
					}
				}
				addReturnValue(1, 2310105L);
				writeOperateLog(2309, str1 + "成功，委托号：" + ((OrderResultVO) localObject11).getOrderID(), 1, "");
			}
		} catch (Exception localException) {
			addReturnValue(-1, 2300004L, new Object[] { "仓单委托" });
			writeOperateLog(2309, str1 + "失败，", 0, localException.getMessage());
			this.logger.error(Tools.getExceptionTrace(localException));
		}
		return "success";
	}

	public String withdrawOrder() {
		String str = "撤销委托%s";
		this.logger.debug("撤销委托操作");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		long l = -1000L;
		try {
			l = Tools.strToLong(this.request.getParameter("orderID"), -1000L);
		} catch (Exception localException1) {
		}
		str = String.format(str, new Object[] { Long.valueOf(l) });
		this.logger.debug("撤销委托单号：" + l + " 撤销人：" + localUser.getTraderID());
		try {
			ResultVO localResultVO = getOrderAndPickoffOrderService().withdrawOrder(l, localUser.getTraderID());
			if (localResultVO.getResult() < 0L) {
				addReturnValue(-1, 2300002L, new Object[] { localResultVO.getErrorInfo().replace("\n", "").replaceAll("\n", "") });
				writeOperateLog(2309, str, 0, localResultVO.getErrorInfo().replace("\n", ""));
			} else if (localResultVO.getResult() == 0L) {
				addReturnValue(-1, 2300003L, new Object[] { localResultVO.getErrorInfo().replace("\n", "").replaceAll("\n", "") });
				writeOperateLog(2309, str, 0, localResultVO.getErrorInfo().replace("\n", ""));
			} else {
				addReturnValue(1, 2310106L);
				writeOperateLog(2309, str, 1, "");
			}
		} catch (Exception localException2) {
			addReturnValue(-1, 2300004L, new Object[] { "撤销委托操作" });
			writeOperateLog(2309, str, 0, localException2.getMessage());
			this.logger.error(Tools.getExceptionTrace(localException2));
		}
		return "success";
	}

	public String performPickoff() {
		String str1 = "%s商品委托%s";
		this.logger.debug("摘牌处理操作");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		String str2 = localUser.getBelongtoFirm().getFirmID();
		long l1 = Tools.strToLong(this.request.getParameter("orderID"), -1000L);
		long l2 = Tools.strToLong(this.request.getParameter("subOrderID"), -1000L);
		boolean bool1 = false;
		if (null != this.request.getParameter("isPayMargin")) {
			bool1 = Boolean.valueOf(this.request.getParameter("isPayMargin")).booleanValue();
		}
		this.logger.debug("isPayMargin:" + bool1);
		boolean bool2 = Tools.strToBoolean(this.request.getParameter("notjudge"));
		String str3 = this.request.getParameter("pickNum");
		Double localDouble = Double.valueOf(0.0D);
		if (null != str3) {
			localDouble = Double.valueOf(str3);
		}
		this.logger.debug("摘牌委托单号：" + l1 + " 摘牌数量：" + localDouble + " 子委托号：" + l2 + " 摘牌人：" + localUser.getTraderID() + "  是否需要判断：" + bool2);
		if (l2 > 0L) {
			str1 = str1 + "子委托" + l2;
		}
		if (l1 > 0L) {
			Object localObject = new Order();
			((OrderBase) localObject).setOrderID(Long.valueOf(l1));
			localObject = (OrderBase) getService().get((StandardModel) localObject);
			String str4 = ((OrderBase) localObject).getBelongtoMFirm().getFirmID();
			String str5 = "";
			if (localUser.getBelongtoFirm().getFirmID().equals(((OrderBase) localObject).getBelongtoMFirm().getFirmID())) {
				str5 = ((OrderBase) localObject).getBsFlag().equals("S") ? "销售" : "采购";
			} else {
				str5 = ((OrderBase) localObject).getBsFlag().equals("S") ? "采购" : "销售";
			}
			str1 = String.format(str1, new Object[] { str5, Long.valueOf(l1) });
			if ((!str2.equals(str4)) && ("N".equals(((OrderBase) localObject).getIsPickOff()))) {
				addReturnValue(-1, 2300002L, new Object[] { "  该委托不允许直接" + str5 });
				writeOperateLog(2309, str1, 0, String.format(ApplicationContextInit.getErrorInfo("-10004"), new Object[] { "  该委托不允许直接" + str5 }));
				return "success";
			}
			String str6 = "B";
			if ("B".equalsIgnoreCase(((OrderBase) localObject).getBsFlag())) {
				str6 = "S";
			}
			if (ifhasRight(2, str6) < 0) {
				if (this.request.getAttribute("ReturnValue") != null) {
					writeOperateLog(2309, str1, 0, String.valueOf(this.request.getAttribute("ReturnValue")));
				}
				return "success";
			}
			if (!bool2) {
				try {
					PickoffResultVO localPickoffResultVO1 = getOrderAndPickoffOrderService().isPickoff(str2, l1, l2, localDouble.doubleValue(),
							bool1);
					this.logger.debug("判断是否可以摘牌返回值：" + localPickoffResultVO1.getResult());
					this.logger.debug("判断摘牌返回信息：：" + localPickoffResultVO1.getErrorInfo());
					if (localPickoffResultVO1.getResult() < 0L) {
						addReturnValue(-1, 2300002L, new Object[] { localPickoffResultVO1.getErrorInfo().replace("\n", "") });
						writeOperateLog(2309, str1, 0, localPickoffResultVO1.getErrorInfo().replace("\n", ""));
						return "success";
					}
					if (localPickoffResultVO1.getResult() == 0L) {
						addReturnValue(2, 2300003L,
								new Object[] { (localPickoffResultVO1.getErrorInfo() + " 您确认要继续" + str5 + "吗?").replace("\n", "") }, 8);
						return "success";
					}
				} catch (Exception localException1) {
					addReturnValue(-1, 2300004L, new Object[] { str5 });
					writeOperateLog(2309, str1, 0, localException1.getMessage());
					this.logger.error(Tools.getExceptionTrace(localException1));
					return "success";
				}
			}
			try {
				PickoffResultVO localPickoffResultVO2 = getOrderAndPickoffOrderService().performPickoff(str2, l1, l2, localDouble.doubleValue(),
						bool1);
				this.logger.debug("摘牌返回值：" + localPickoffResultVO2.getResult());
				if (localPickoffResultVO2.getResult() < 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localPickoffResultVO2.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, str1, 0, localPickoffResultVO2.getErrorInfo().replace("\n", ""));
				} else if (localPickoffResultVO2.getResult() == 0L) {
					addReturnValue(-1, 2300002L, new Object[] { localPickoffResultVO2.getErrorInfo().replace("\n", "") });
					writeOperateLog(2309, str1, 0, localPickoffResultVO2.getErrorInfo().replace("\n", ""));
				} else {
					Trade localTrade = new Trade();
					localTrade.setTradeNo(Long.valueOf(localPickoffResultVO2.getTradeNO()));
					localTrade = (Trade) super.getService().get(localTrade);
					this.logger.debug("Time ====" + localTrade.getTime());
					this.request.setAttribute("tradePreTime", Tools.dateAddSeconds(localTrade.getTime(), localTrade.getTradePreTime()));
					this.logger.debug(((OrderBase) localObject).getBsFlag() + ":" + str5);
					String str7 = "";
					int i = 1;
					Iterator localIterator = localTrade.getContainReserve().iterator();
					while (localIterator.hasNext()) {
						Reserve localReserve = (Reserve) localIterator.next();
						if ((localReserve.getFirmID().equals(str2)) && (localReserve.getPayableReserve().equals(localReserve.getPayReserve()))) {
							i = 0;
							break;
						}
					}
					if ((((OrderBase) localObject).getBelongtoBreed().getTradeMode().intValue() == 1) && (i != 0)
							&& ((!str4.equals(str2)) || (((OrderBase) localObject).getPledgeFlag().intValue() != 1))) {
						str7 = "  注意： 请在" + Tools.fmtTime(Tools.dateAddSeconds(localTrade.getTime(), localTrade.getTradePreTime())) + "前转入履约保证金！";
					}
					addReturnValue(1, 2310100L, new Object[] { str5, str7 });
					writeOperateLog(2309, str1, 1, "");
				}
			} catch (Exception localException2) {
				addReturnValue(-1, 2300004L, new Object[] { str5 });
				writeOperateLog(2309, str1, 0, localException2.getMessage());
				this.logger.error(Tools.getExceptionTrace(localException2));
			}
		} else {
			addReturnValue(-1, 2300002L, new Object[] { "传入委托号为空摘牌" });
			str1 = String.format(str1, new Object[] { "买/卖", "" });
			writeOperateLog(2309, str1, 0, String.format(ApplicationContextInit.getErrorInfo("-10003"), new Object[] { "传入委托号为空" }));
			this.logger.debug("摘牌 委托单号为空");
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

	public String orderList() {
		this.logger.debug("委托列表查询");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		PageRequest localPageRequest = null;
		try {
			localPageRequest = ActionUtil.getPageRequest(this.request);
		} catch (Exception localException) {
			this.logger.error(Tools.getExceptionTrace(localException));
		}
		QueryConditions localQueryConditions = (QueryConditions) localPageRequest.getFilters();
		localQueryConditions.addCondition("firmID", "=", localUser.getBelongtoFirm().getFirmID());
		if ("".equals(localPageRequest.getSortColumns())) {
			localPageRequest.setSortColumns(" order by orderID  desc");
		}
		Object localObject = null;
		if ("H".equalsIgnoreCase(this.request.getParameter("isHistory"))) {
			localObject = new OrderHis();
		} else {
			localObject = new Order();
		}
		Page localPage = getService().getPage(localPageRequest, (StandardModel) localObject);
		this.request.setAttribute("isHistory", this.request.getParameter("isHistory"));
		this.request.setAttribute("pageInfo", localPage);
		this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
		return "success";
	}

	public String pickOffOrderDetails() {
		Order localOrder = (Order) this.entity;
		localOrder = (Order) getService().get(localOrder);
		this.entity = localOrder;
		if (localOrder.getStatus().intValue() == 2) {
			addReturnValue(-1, 2310107L);
		} else if (localOrder.getStatus().intValue() == 3) {
			addReturnValue(-1, 2310108L);
		}
		PageRequest localPageRequest = new PageRequest(" and primary.categoryID=" + localOrder.getCategoryID());
		getService().getPage(localPageRequest, new Category());
		return "success";
	}

	public String orderDetails() {
		this.logger.debug("委托详情查询:" + this.deliveryDayType);
		long l = Tools.strToLong(this.request.getParameter("orderID"), -1000L);
		if (l > 0L) {
			Object localObject1 = null;
			Object localObject2 = null;
			if ("H".equalsIgnoreCase(this.request.getParameter("isHistory"))) {
				localObject1 = new OrderHis();
				localObject2 = new OrderPicHis();
			} else {
				localObject1 = new Order();
				localObject2 = new OrderPic();
			}
			((OrderBase) localObject1).setOrderID(Long.valueOf(l));
			localObject1 = (OrderBase) getService().get((StandardModel) localObject1);
			this.request.setAttribute("isHistory", this.request.getParameter("isHistory"));
			this.request.setAttribute("order", localObject1);
			PageRequest localPageRequest1 = new PageRequest(
					" and primary.status=1 and primary.categoryID=" + ((OrderBase) localObject1).getCategoryID());
			PageRequest localPageRequest2 = new PageRequest(" and primary.orderID=" + ((OrderBase) localObject1).getOrderID());
			localPageRequest2.setPageSize(10000);
			Page localPage = getService().getPage(localPageRequest2, (StandardModel) localObject2);
			this.request.setAttribute("imagePicPage", localPage);
			getService().getPage(localPageRequest1, new Category());
			localPageRequest1 = new PageRequest(" and primary.breedID=" + ((OrderBase) localObject1).getBelongtoBreed().getBreedID());
			getService().getPage(localPageRequest1, new Breed());
			LinkedHashSet localLinkedHashSet = new LinkedHashSet();
			Object localObject3;
			Iterator localIterator;
			Object localObject4;
			if ((localObject1 instanceof Order)) {
				localObject3 = (Order) localObject1;
				if (((Order) localObject3).getContainGoodsProperty() != null) {
					localIterator = ((Order) localObject3).getContainGoodsProperty().iterator();
					while (localIterator.hasNext()) {
						localObject4 = (GoodsProperty) localIterator.next();
						localLinkedHashSet.add(localObject4);
					}
				}
			} else {
				localObject3 = (OrderHis) localObject1;
				if (((OrderHis) localObject3).getContainGoodsProperty() != null) {
					localIterator = ((OrderHis) localObject3).getContainGoodsProperty().iterator();
					while (localIterator.hasNext()) {
						localObject4 = (GoodsPropertyHis) localIterator.next();
						localLinkedHashSet.add(localObject4);
					}
				}
			}
			putResourcePropertys(localLinkedHashSet);
		}
		return "success";
	}

	public String orderDetailsForSuberOrder() {
		this.logger.debug("委托详情查询----------议价:");
		long l = Tools.strToLong(this.request.getParameter("orderID"), -1000L);
		if (l > 0L) {
			Object localObject1 = new Order();
			((OrderBase) localObject1).setOrderID(Long.valueOf(l));
			localObject1 = (OrderBase) getService().get((StandardModel) localObject1);
			this.request.setAttribute("order", localObject1);
			PageRequest localPageRequest1 = new PageRequest(
					" and primary.status=1 and primary.categoryID=" + ((OrderBase) localObject1).getCategoryID());
			getService().getPage(localPageRequest1, new Category());
			String str1 = "select * from BI_WareHouse where status=0 order by id ";
			List localList1 = super.getService().getListBySql(str1, new WareHouse());
			this.logger.debug("wareHouses: " + localList1.size());
			this.request.setAttribute("wareHouses", localList1);
			String str2 = "select t.runtimevalue from E_SYSTEMPROPS t where t.key ='TradePreTime'";
			List localList2 = getService().getDao().queryBySql(str2);
			Integer localInteger = Integer.valueOf((String) ((Map) localList2.get(0)).get("RUNTIMEVALUE"));
			this.request.setAttribute("tradePreHour", localInteger);
			FeeComputeArithmeticVO localFeeComputeArithmeticVO1 = null;
			FeeComputeArithmeticVO localFeeComputeArithmeticVO2 = null;
			User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
			try {
				localFeeComputeArithmeticVO1 = this.kernelService.getDeliveryMarginArithmetic(
						((OrderBase) localObject1).getBelongtoMFirm().getFirmID(), ((OrderBase) localObject1).getCategoryID().longValue());
				localFeeComputeArithmeticVO2 = this.kernelService.getDeliveryMarginArithmetic(localUser.getBelongtoFirm().getFirmID(),
						((OrderBase) localObject1).getCategoryID().longValue());
			} catch (RemoteException localRemoteException) {
				this.logger.error(Tools.getExceptionTrace(localRemoteException));
			}
			PageRequest localPageRequest2 = new PageRequest(" and primary.orderID=" + ((OrderBase) localObject1).getOrderID());
			localPageRequest2.setPageSize(100);
			Page localPage = getService().getPage(localPageRequest2, new OrderPic());
			this.request.setAttribute("imagePicList", localPage);
			this.request.setAttribute("deliveryMargin", localFeeComputeArithmeticVO1);
			this.request.setAttribute("delistDeliveryMargin", localFeeComputeArithmeticVO2);
			LinkedHashSet localLinkedHashSet = new LinkedHashSet();
			Object localObject2;
			Iterator localIterator;
			Object localObject3;
			if ((localObject1 instanceof Order)) {
				localObject2 = (Order) localObject1;
				if (((Order) localObject2).getContainGoodsProperty() != null) {
					localIterator = ((Order) localObject2).getContainGoodsProperty().iterator();
					while (localIterator.hasNext()) {
						localObject3 = (GoodsProperty) localIterator.next();
						localLinkedHashSet.add(localObject3);
					}
				}
			} else {
				localObject2 = (OrderHis) localObject1;
				if (((OrderHis) localObject2).getContainGoodsProperty() != null) {
					localIterator = ((OrderHis) localObject2).getContainGoodsProperty().iterator();
					while (localIterator.hasNext()) {
						localObject3 = (GoodsPropertyHis) localIterator.next();
						localLinkedHashSet.add(localObject3);
					}
				}
			}
			putResourcePropertys(localLinkedHashSet);
		}
		return "success";
	}

	public String getFirstCategory() {
		this.logger.debug("查询分类信息");
		ArrayList localArrayList = new ArrayList();
		Page localPage1 = XTradeFrontGlobal.getCategoryPage();
		Object localObject1 = localPage1.getResult().iterator();
		while (((Iterator) localObject1).hasNext()) {
			Category localObject2 = (Category) ((Iterator) localObject1).next();
			if ((((Category) localObject2).getCategoryID().longValue() > 0L) && ("leaf".equalsIgnoreCase(((Category) localObject2).getType()))
					&& (((Category) localObject2).getStatus().intValue() == 1)) {
				localArrayList.add(localObject2);
			}
		}
		localObject1 = (User) this.request.getSession().getAttribute("CurrentUser");
		Object localObject2 = "select * from E_TRADERIGHT t where t.firmid='" + ((User) localObject1).getBelongtoFirm().getFirmID() + "'";
		List localList1 = getService().getListBySql((String) localObject2, new TradeRight());
		if ((null != localList1) && (localList1.size() == 1)) {
			this.request.setAttribute("tradeRight", localList1.get(0));
			this.logger.debug("=====TRADERIGHT:" + localList1.get(0));
		}
		QueryConditions localQueryConditions = new QueryConditions();
		localQueryConditions.addCondition("status", "=", Integer.valueOf(0));
		PageRequest localPageRequest = new PageRequest(1, 1000, localQueryConditions, " order by id");
		Page localPage2 = getService().getPage(localPageRequest, new WareHouse());
		this.request.setAttribute("warehouseList", localPage2.getResult());
		String str1 = "select t.runtimevalue from E_SYSTEMPROPS t where t.key = 'TradePreTime'";
		List localList2 = getService().getDao().queryBySql(str1);
		Integer localInteger1 = Integer.valueOf(((Map) localList2.get(0)).get("RUNTIMEVALUE").toString());
		this.request.setAttribute("tradePreHoure", localInteger1);
		String str2 = "select t.runtimevalue from E_SYSTEMPROPS t where t.key = 'DeliveryPreTime'";
		List localList3 = getService().getDao().queryBySql(str2);
		Integer localInteger2 = Integer.valueOf(((Map) localList3.get(0)).get("RUNTIMEVALUE").toString());
		this.request.setAttribute("deliveryPreHoure",
				Integer.valueOf(localInteger2.intValue() > localInteger1.intValue() ? localInteger2.intValue() : localInteger1.intValue() + 1));
		String str3 = "select t.runtimevalue from E_SYSTEMPROPS t where t.key = 'OrderValidTime'";
		List localList4 = getService().getDao().queryBySql(str3);
		this.request.setAttribute("validHoure", ((Map) localList4.get(0)).get("RUNTIMEVALUE"));
		this.logger.debug(((Map) localList2.get(0)).get("RUNTIMEVALUE") + "=====trades=========================");
		this.logger.debug(((Map) localList3.get(0)).get("RUNTIMEVALUE") + "=====deliveryPreHoure=========================");
		this.logger.debug(((Map) localList4.get(0)).get("RUNTIMEVALUE") + "=====orderValidTime=========================");
		this.request.setAttribute("categoryList", localArrayList);
		return "success";
	}

	public String getBreedByCategoryID() {
		this.logger.debug("通过分类信息查询品名==================================================");
		this.jsonReturn = new JSONArray();
		long l = Tools.strToLong(this.request.getParameter("categoryID"), -1000L);
		if (l < 0L) {
			return "success";
		}
		this.logger.debug("FREE:========== " + this.kernelService);
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Object localObject2;
		try {
			Double localDouble = Double.valueOf(this.kernelService.getOneTradeMargin());
			this.logger.debug("oneTradeMargin:" + localDouble);
			FeeComputeArithmeticVO localObject1 = this.kernelService.getDeliveryMarginArithmetic(localUser.getBelongtoFirm().getFirmID(), l);
			localObject2 = this.kernelService.getDeliveryMarginArithmetic("", l);
			this.jsonReturn.add(((FeeComputeArithmeticVO) localObject1).getMode() + ":" + ((FeeComputeArithmeticVO) localObject1).getRate() + "="
					+ ((FeeComputeArithmeticVO) localObject2).getMode() + ":" + ((FeeComputeArithmeticVO) localObject2).getRate() + "="
					+ localDouble);
			this.logger.debug("deliveryMargin:========== MODE:" + ((FeeComputeArithmeticVO) localObject1).getMode() + ",RATE:"
					+ ((FeeComputeArithmeticVO) localObject1).getRate() + ",oneTradeMargin: " + localDouble);
		} catch (RemoteException localRemoteException) {
			this.jsonReturn.add("1:1=1:1=1:1=1:1");
			this.logger.error(Tools.getExceptionTrace(localRemoteException));
		}
		Page localPage = XTradeFrontGlobal.getCategoryPage();
		Object localObject1 = localPage.getResult().iterator();
		while (((Iterator) localObject1).hasNext()) {
			localObject2 = (Category) ((Iterator) localObject1).next();
			if (l == ((Category) localObject2).getCategoryID().longValue()) {
				Iterator localIterator = ((Category) localObject2).getContainBreed().iterator();
				while (localIterator.hasNext()) {
					Breed localBreed = (Breed) localIterator.next();
					if (localBreed.getStatus().intValue() == 1) {
						JSONArray localJSONArray = new JSONArray();
						localJSONArray.add(localBreed.getBreedID());
						localJSONArray.add(localBreed.getBreedName());
						localJSONArray.add(localBreed.getUnit());
						localJSONArray.add(localBreed.getTradeMode());
						this.logger.debug(localBreed.getTradeMode());
						this.jsonReturn.add(localJSONArray);
					}
				}
				this.logger.debug("商品名称:" + this.jsonReturn);
				break;
			}
		}
		return "success";
	}

	public String getPropertyValueByBreedID() {
		this.logger.debug("通过品名编号获取品名属性信息");
		this.jsonReturn = new JSONArray();
		long l = Tools.strToLong(this.request.getParameter("breedID"), -1000L);
		if (l < 0L) {
			return "success";
		}
		Page localPage = XTradeFrontGlobal.getCategoryPage();
		Iterator localIterator1 = localPage.getResult().iterator();
		while (localIterator1.hasNext()) {
			Category localCategory = (Category) localIterator1.next();
			Iterator localIterator2 = localCategory.getContainBreed().iterator();
			while (localIterator2.hasNext()) {
				Breed localBreed = (Breed) localIterator2.next();
				if (l == localBreed.getBreedID().longValue()) {
					Iterator localIterator3 = localCategory.getContainProperty().iterator();
					while (localIterator3.hasNext()) {
						Property localProperty = (Property) localIterator3.next();
						JSONArray localJSONArray1 = new JSONArray();
						localJSONArray1.add(localProperty.getPropertyName());
						localJSONArray1.add(localProperty.getHasValueDict());
						if ("Y".equalsIgnoreCase(localProperty.getHasValueDict())) {
							JSONArray localJSONArray2 = new JSONArray();
							Iterator localIterator4 = localBreed.getContainBreedProps().iterator();
							while (localIterator4.hasNext()) {
								BreedProps localBreedProps = (BreedProps) localIterator4.next();
								if (localBreedProps.getBelongtoProperty().getPropertyID() == localProperty.getPropertyID()) {
									localJSONArray2.add(localBreedProps.getPropertyValue());
								}
							}
							localJSONArray1.add(localJSONArray2);
						}
						localJSONArray1.add(localProperty.getIsNecessary());
						localJSONArray1.add(localProperty.getFieldType());
						this.jsonReturn.add(localJSONArray1);
					}
					this.logger.debug("商品属性信息:" + this.jsonReturn);
					return "success";
				}
			}
		}
		return "success";
	}

	public String getPropertyPagValueByBreedID() {
		long l = Tools.strToLong(this.request.getParameter("breedID"), -1000L);
		if (l > 0L) {
			Object localObject1 = new Breed();
			Page localPage = XTradeFrontGlobal.getCategoryPage();
			Object localObject2 = localPage.getResult().iterator();
			Object localObject3;
			Object localObject4;
			Object localObject5;
			while (((Iterator) localObject2).hasNext()) {
				localObject3 = (Category) ((Iterator) localObject2).next();
				localObject4 = ((Category) localObject3).getContainBreed().iterator();
				while (((Iterator) localObject4).hasNext()) {
					localObject5 = (Breed) ((Iterator) localObject4).next();
					if (l == ((Breed) localObject5).getBreedID().longValue()) {
						localObject1 = localObject5;
					}
				}
			}
			if (localObject1 != null) {
				localObject2 = new QueryConditions();
				((QueryConditions) localObject2).addCondition("status", "=", Integer.valueOf(0));
				localObject3 = new PageRequest(1, 100, localObject2, " order by sortNo ");
				localObject4 = getService().getPage((PageRequest) localObject3, new PropertyType());
				localObject5 = new HashMap();
				LinkedHashMap localLinkedHashMap = new LinkedHashMap();
				if ((localObject4 != null) && (((Page) localObject4).getResult() != null)) {
					for (int i = 0; i < ((Page) localObject4).getResult().size(); i++) {
						PropertyType localObject6 = (PropertyType) ((Page) localObject4).getResult().get(i);
						localLinkedHashMap.put(((PropertyType) localObject6).getPropertyTypeID(), new LinkedHashMap());
						((Map) localObject5).put(((PropertyType) localObject6).getPropertyTypeID(), ((PropertyType) localObject6).getName());
					}
				}
				Long localLong = Long.valueOf(-1L);
				localLinkedHashMap.put(localLong, new LinkedHashMap());
				((Map) localObject5).put(localLong, "其它属性");
				Object localObject6 = ((Breed) localObject1).getBelongtoCategory().getContainProperty();
				HashMap localHashMap = new HashMap();
				Object localObject7 = ((Set) localObject6).iterator();
				Object localObject9;
				while (((Iterator) localObject7).hasNext()) {
					Property localObject8 = (Property) ((Iterator) localObject7).next();
					localObject9 = (Map) localLinkedHashMap.get(((Property) localObject8).getPropertyTypeID());
					if (localObject9 == null) {
						localObject9 = (Map) localLinkedHashMap.get(localLong);
					}
					((Map) localObject9).put(((Property) localObject8).getPropertyID(), new ArrayList());
					localHashMap.put(((Property) localObject8).getPropertyID(), localObject8);
				}
				if (((Breed) localObject1).getContainBreedProps() != null) {
					localObject7 = ((Breed) localObject1).getContainBreedProps().iterator();
					while (((Iterator) localObject7).hasNext()) {
						BreedProps localObject8 = (BreedProps) ((Iterator) localObject7).next();
						localObject9 = (Map) localLinkedHashMap.get(((BreedProps) localObject8).getBelongtoProperty().getPropertyTypeID());
						if (localObject9 == null) {
							localObject9 = (Map) localLinkedHashMap.get(localLong);
						}
						Object localObject10 = (List) ((Map) localObject9).get(((BreedProps) localObject8).getBelongtoProperty().getPropertyID());
						if (localObject10 == null) {
							localObject10 = new ArrayList();
							((Map) localObject9).put(((BreedProps) localObject8).getBelongtoProperty().getPropertyID(), localObject10);
						}
						((List) localObject10).add(localObject8);
					}
				}
				localObject7 = new LinkedHashMap();
				Object localObject8 = localLinkedHashMap.keySet().iterator();
				while (((Iterator) localObject8).hasNext()) {
					localObject9 = (Long) ((Iterator) localObject8).next();
					if (((Map) localLinkedHashMap.get(localObject9)).size() > 0) {
						((Map) localObject7).put(localObject9, localLinkedHashMap.get(localObject9));
					}
				}
				this.request.setAttribute("ptnameMap", localObject5);
				this.request.setAttribute("propertyMap", localObject7);
				this.request.setAttribute("categoryPropertyMap", localHashMap);
			}
		}
		return "success";
	}

	public String performorderpreview() throws Exception {
		this.logger.debug("预览委托信息");
		String str1 = this.request.getParameter("stockID");
		String str2 = this.request.getParameter("flag");
		String str3 = new String(this.request.getParameter("remark").getBytes("ISO-8859-1"), "gb2312");
		Order localOrder = getOrderByRequest();
		String str4 = (String) ServletActionContext.getRequest().getAttribute("ExceededError");
		if (str4 != null) {
			this.logger.debug(str4);
			addReturnValue(-1, 2310103L, new Object[] { str4 }, -8);
			return "error";
		}
		if (null != this.request.getParameter("chckImage")) {
			addReturnValue(-2, 9930091L, new Object[] { "" }, 8);
			return "error";
		}
		int i = 0;
		this.logger.debug("预览委托信息" + localOrder.getCategoryID());
		LinkedHashSet localLinkedHashSet = new LinkedHashSet();
		Object localObject2;
		if (localOrder.getContainGoodsProperty() != null) {
			Iterator localObject1 = localOrder.getContainGoodsProperty().iterator();
			while (((Iterator) localObject1).hasNext()) {
				localObject2 = (GoodsProperty) ((Iterator) localObject1).next();
				localLinkedHashSet.add(localObject2);
			}
		}
		putResourcePropertys(localLinkedHashSet);
		Object localObject3;
		Object localObject4;
		if ((localOrder.getCategoryID() != null) && (localOrder.getBelongtoBreed() != null) && (localOrder.getBelongtoBreed().getBreedID() != null)) {
			Iterator localObject1 = XTradeFrontGlobal.getCategoryPage().getResult().iterator();
			while (((Iterator) localObject1).hasNext()) {
				localObject2 = (Category) ((Iterator) localObject1).next();
				localObject3 = ((Category) localObject2).getContainBreed().iterator();
				while (((Iterator) localObject3).hasNext()) {
					localObject4 = (Breed) ((Iterator) localObject3).next();
					if (((Breed) localObject4).getBreedID().longValue() == localOrder.getBelongtoBreed().getBreedID().longValue()) {
						localOrder.setBelongtoBreed((Breed) localObject4);
						i = 1;
						break;
					}
				}
				if (i != 0) {
					break;
				}
			}
		}
		String[] localObject1 = new String[0];
		if (this.fileName != null) {
			localObject1 = new String[this.fileName.length];
			for (int j = 0; j < this.fileName.length; j++) {
				if (this.fileName[j] != null) {
					localObject1[j] = (this.fileName[j].getPath().substring(0, this.fileName[j].getPath().lastIndexOf(File.separator) + 1)
							+ this.fileNameFileName[j]);
					try {
						localObject4 = new FileOutputStream(localObject1[j]);
						localObject3 = new FileInputStream(this.fileName[j]);
						byte[] arrayOfByte = new byte[((FileInputStream) localObject3).available()];
						((FileInputStream) localObject3).read(arrayOfByte);
						((FileOutputStream) localObject4).write(arrayOfByte);
						((FileOutputStream) localObject4).flush();
						((FileOutputStream) localObject4).close();
						((FileInputStream) localObject3).close();
					} catch (FileNotFoundException localFileNotFoundException) {
						localFileNotFoundException.printStackTrace();
					} catch (IOException localIOException) {
						localIOException.printStackTrace();
					}
				}
			}
		}
		if ((str1 == null) || ("".equals(str1))) {
			str1 = "-1";
		}
		this.request.setAttribute("order", localOrder);
		this.request.setAttribute("flag", str2);
		this.request.setAttribute("remark", str3);
		this.request.setAttribute("stockID", str1);
		this.request.setAttribute("filePath", localObject1);
		return "success";
	}

	private Order getOrderByRequest() {
		this.logger.debug("封装页面输入的委托信息");
		User localUser = (User) this.request.getSession().getAttribute("CurrentUser");
		Order localOrder = (Order) this.entity;
		localOrder.setBelongtoMFirm(localUser.getBelongtoFirm());
		localOrder.setTraderID(localUser.getTraderID());
		String str = this.request.getParameter("warehouseID");
		if ((str == null) && (localOrder.getPledgeFlag().intValue() == 1)) {
			str = this.request.getParameter("warehouseIDD");
		}
		if ((!"".equals(str)) && (str != null)) {
			String[] localObject = str.split("-");
			if ((localObject != null) && (localObject.length > 0)) {
				localOrder.setWarehouseID(localObject[0]);
			}
		}
		Object localObject = this.request.getParameter("tradeWay");
		if ("1".equals(localObject)) {
			localOrder.setIsSuborder("N");
			localOrder.setIsPickOff("Y");
		} else if ("2".equals(localObject)) {
			localOrder.setIsSuborder("Y");
			localOrder.setIsPickOff("Y");
		} else if ("3".equals(localObject)) {
			localOrder.setIsSuborder("Y");
			localOrder.setIsPickOff("N");
		}
		this.logger.debug("================ISPAYMARGIN:" + localOrder.getIsPayMargin());
		if (this.goodsPropertys != null) {
			Iterator localIterator = this.goodsPropertys.iterator();
			while (localIterator.hasNext()) {
				GoodsProperty localGoodsProperty = (GoodsProperty) localIterator.next();
				this.logger.debug("property[" + localGoodsProperty.getPropertyName() + "][" + localGoodsProperty.getPropertyValue() + "]");
				localOrder.addGoodsProperty(localGoodsProperty);
			}
		}
		return localOrder;
	}

	public String showImages() throws IOException {
		this.logger.debug("enter showImages");
		HttpServletResponse localHttpServletResponse = ServletActionContext.getResponse();
		ServletOutputStream localServletOutputStream = null;
		byte[] arrayOfByte = null;
		OrderPic localOrderPic = new OrderPic();
		localOrderPic.setId(Long.valueOf(Tools.strToLong(this.request.getParameter("id"), -1000L)));
		localOrderPic = (OrderPic) getService().get(localOrderPic);
		if (localOrderPic == null) {
			OrderPicHis localOrderPicHis = new OrderPicHis();
			localOrderPicHis.setId(Long.valueOf(Tools.strToLong(this.request.getParameter("id"), -1000L)));
			localOrderPicHis = (OrderPicHis) getService().get(localOrderPicHis);
			arrayOfByte = localOrderPicHis.getPicture();
		} else {
			arrayOfByte = localOrderPic.getPicture();
		}
		try {
			localHttpServletResponse.setContentType("text/html");
			localServletOutputStream = localHttpServletResponse.getOutputStream();
			localServletOutputStream.write(arrayOfByte);
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

	private void putResourcePropertys(Set<GoodsPropertyBase> paramSet) {
		if ((paramSet != null) && (paramSet.size() > 0)) {
			LinkedHashMap localLinkedHashMap = new LinkedHashMap();
			QueryConditions localQueryConditions = new QueryConditions();
			localQueryConditions.addCondition("status", "=", Integer.valueOf(0));
			PageRequest localPageRequest = new PageRequest(1, 100, localQueryConditions, " order by sortNo ");
			Page localPage = getService().getPage(localPageRequest, new PropertyType());
			if ((localPage != null) && (localPage.getResult() != null)) {
				for (int i = 0; i < localPage.getResult().size(); i++) {
					PropertyType localObject1 = (PropertyType) localPage.getResult().get(i);
					localLinkedHashMap.put(localObject1, new ArrayList());
				}
			}
			ArrayList localArrayList = new ArrayList();
			Object localObject1 = paramSet.iterator();
			Object localObject3;
			while (((Iterator) localObject1).hasNext()) {
				GoodsPropertyBase localObject2 = (GoodsPropertyBase) ((Iterator) localObject1).next();
				localObject3 = null;
				Iterator localIterator = localLinkedHashMap.keySet().iterator();
				while (localIterator.hasNext()) {
					PropertyType localPropertyType = (PropertyType) localIterator.next();
					if ((((GoodsPropertyBase) localObject2).getPropertyTypeID() != null)
							&& (((GoodsPropertyBase) localObject2).getPropertyTypeID().equals(localPropertyType.getPropertyTypeID()))) {
						localObject3 = (List) localLinkedHashMap.get(localPropertyType);
					}
				}
				if (localObject3 == null) {
					localObject3 = localArrayList;
				}
				((List) localObject3).add(localObject2);
			}
			localObject1 = new LinkedHashMap();
			Object localObject2 = localLinkedHashMap.keySet().iterator();
			while (((Iterator) localObject2).hasNext()) {
				localObject3 = (PropertyType) ((Iterator) localObject2).next();
				if (((List) localLinkedHashMap.get(localObject3)).size() > 0) {
					((Map) localObject1).put(localObject3, localLinkedHashMap.get(localObject3));
				}
			}
			if (localArrayList.size() > 0) {
				localObject2 = new PropertyType();
				((PropertyType) localObject2).setName("其它属性");
				((PropertyType) localObject2).setPropertyTypeID(Long.valueOf(-1L));
				((Map) localObject1).put(localObject2, localArrayList);
			}
			this.request.setAttribute("tpmap", localObject1);
		}
	}
}

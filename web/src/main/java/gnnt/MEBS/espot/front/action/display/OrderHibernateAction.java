package gnnt.MEBS.espot.front.action.display;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.front.action.StandardAction;
import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.front.model.commodity.Breed;
import gnnt.MEBS.espot.front.model.commodity.Category;
import gnnt.MEBS.espot.front.model.commodity.PropertyType;
import gnnt.MEBS.espot.front.model.trade.GoodsProperty;
import gnnt.MEBS.espot.front.model.trade.GoodsPropertyBase;
import gnnt.MEBS.espot.front.model.trade.Order;
import gnnt.MEBS.espot.front.model.trade.OrderPic;

@Controller("orderHibernateAction")
@Scope("request")
public class OrderHibernateAction extends StandardAction {
	private static final long serialVersionUID = -4711056789848892296L;
	@Resource(name = "bsFlagMap")
	Map<String, String> bsFlagMap;
	@Resource(name = "deliveryType")
	Map<String, String> deliveryType;
	@Resource(name = "deliveryDayTypeMap")
	Map<Integer, String> deliveryDayType;
	private static byte[] defaultorderpic;

	public Map<String, String> getBsFlagMap() {
		return this.bsFlagMap;
	}

	public Map<String, String> getDeliveryType() {
		return this.deliveryType;
	}

	public Map<Integer, String> getDeliveryDayType() {
		return this.deliveryDayType;
	}

	public String getOrderByOrderID() {
		this.logger.debug("Query individual order's detailed information");
		long l = -1000L;
		if (this.request.getParameter("orderID") != null) {
			l = Tools.strToLong(this.request.getParameter("orderID"), -1000L);
		}
		if (l > 0L) {
			((Order) this.entity).setOrderID(Long.valueOf(l));
			this.entity = getService().get(this.entity);
			this.request.setAttribute("order", this.entity);
			PageRequest localPageRequest1 = new PageRequest(" and primary.status=1 and primary.categoryID=" + ((Order) this.entity).getCategoryID());
			Page localPage1 = getService().getPage(localPageRequest1, new Category());
			PageRequest localPageRequest2 = new PageRequest(" and primary.orderID=" + ((Order) this.entity).getOrderID());
			localPageRequest2.setPageSize(100);
			Page localPage2 = getService().getPage(localPageRequest2, new OrderPic());
			this.request.setAttribute("imagePicList", localPage2);
			this.request.setAttribute("page", localPage1);
			LinkedHashSet localLinkedHashSet = new LinkedHashSet();
			Iterator localIterator = ((Order) this.entity).getContainGoodsProperty().iterator();
			while (localIterator.hasNext()) {
				GoodsProperty localGoodsProperty = (GoodsProperty) localIterator.next();
				localLinkedHashSet.add(localGoodsProperty);
			}
			putResourcePropertys(localLinkedHashSet);
		}
		this.logger.debug("order  queryed----------------" + l);
		return "success";
	}

	public String getOrderPic() {
		this.logger.debug("获取  图片！");
		long l1 = -1000L;
		if (this.request.getParameter("orderID") != null) {
			l1 = Tools.strToLong(this.request.getParameter("orderID"), -1000L);
		}
		this.logger.debug("获取  图片！" + l1);
		byte[] arrayOfByte = null;
		Object localObject1;
		Object localObject2;
		if (l1 > 0L) {
			PageRequest localPageRequest = new PageRequest(" and primary.orderID=" + l1);
			localPageRequest.setPageSize(100);
			localObject1 = getService().getPage(localPageRequest, new OrderPic());
			if ((((Page) localObject1).getResult() != null) && (((Page) localObject1).getResult().size() > 0)) {
				localObject2 = (OrderPic) ((Page) localObject1).getResult().get(0);
				arrayOfByte = ((OrderPic) localObject2).getPicture();
			}
		}
		if (arrayOfByte == null) {
			long l2 = Tools.strToLong(this.request.getParameter("breedID"), -1000L);
			if (l2 > 0L) {
				localObject2 = new Breed();
				((Breed) localObject2).setBreedID(Long.valueOf(l2));
				localObject2 = (Breed) getService().get((StandardModel) localObject2);
				if ((localObject2 != null) && (((Breed) localObject2).getPicture() != null)) {
					arrayOfByte = (byte[]) ((Breed) localObject2).getPicture().clone();
				}
			}
		}
		if (arrayOfByte == null) {
			if (defaultorderpic == null) {
				synchronized (this) {
					if (defaultorderpic == null) {
						localObject1 = System.getProperty("catalina.home") + "/webapps" + this.request.getContextPath()
								+ "/front/app/espot/image/photo01.gif";
						localObject2 = new File((String) localObject1);
						if ((((File) localObject2).exists()) && (((File) localObject2).isFile())) {
							defaultorderpic = new byte[(int) ((File) localObject2).length()];
							BufferedInputStream localBufferedInputStream = null;
							try {
								localBufferedInputStream = new BufferedInputStream(new FileInputStream((File) localObject2));
								localBufferedInputStream.read(defaultorderpic);
								if (localBufferedInputStream != null) {
									try {
										localBufferedInputStream.close();
									} catch (IOException localIOException4) {
										this.logger.error(Tools.getExceptionTrace(localIOException4));
									}
								}
							} catch (FileNotFoundException localFileNotFoundException) {
								this.logger.error(Tools.getExceptionTrace(localFileNotFoundException));
							} catch (IOException localIOException6) {
								this.logger.error(Tools.getExceptionTrace(localIOException6));
							} finally {
								if (localBufferedInputStream != null) {
									try {
										localBufferedInputStream.close();
									} catch (IOException localIOException8) {
										this.logger.error(Tools.getExceptionTrace(localIOException8));
									}
								}
							}
						}
					}
				}
			}
			arrayOfByte = defaultorderpic;
		}
		if (arrayOfByte != null) {
			ServletOutputStream outputStream = null;
			try {
				outputStream = this.response.getOutputStream();
				((ServletOutputStream) outputStream).write(arrayOfByte);
			} catch (IOException localIOException2) {
				this.logger.error(Tools.getExceptionTrace(localIOException2));
			} finally {
				if (outputStream != null) {
					try {
						((ServletOutputStream) outputStream).close();
					} catch (IOException localIOException9) {
						this.logger.error(Tools.getExceptionTrace(localIOException9));
					}
				}
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

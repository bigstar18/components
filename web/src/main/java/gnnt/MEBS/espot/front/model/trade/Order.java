package gnnt.MEBS.espot.front.model.trade;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.core.bo.OrderBO;
import gnnt.MEBS.espot.core.po.GoodsPropertyPO;
import gnnt.MEBS.espot.core.po.OrderPO;

public class Order extends OrderBase {
	private static final long serialVersionUID = 1724143595733711429L;
	@ClassDiscription(name = "商品属性", description = "")
	private Set<GoodsProperty> containGoodsProperty;
	@ClassDiscription(name = "委托议价", description = "")
	private Set<SubOrder> containSubOrder;

	public Set<GoodsProperty> getContainGoodsProperty() {
		return this.containGoodsProperty;
	}

	public void setContainGoodsProperty(Set<GoodsProperty> paramSet) {
		this.containGoodsProperty = paramSet;
	}

	public Set<SubOrder> getContainSubOrder() {
		return this.containSubOrder;
	}

	public void setContainSubOrder(Set<SubOrder> paramSet) {
		this.containSubOrder = paramSet;
	}

	public void addGoodsProperty(GoodsProperty paramGoodsProperty) {
		if (this.containGoodsProperty == null) {
			synchronized (this) {
				if (this.containGoodsProperty == null) {
					this.containGoodsProperty = new HashSet();
				}
			}
		}
		this.containGoodsProperty.add(paramGoodsProperty);
	}

	public OrderBO getOrderBO() {
		OrderBO localOrderBO = new OrderBO();
		localOrderBO.orderPO = new OrderPO();
		localOrderBO.goodsPropertyPOList = new ArrayList();
		localOrderBO.orderPO.setBSFlag(getBsFlag());
		localOrderBO.isPayMargin = "Y".equals(getIsPayMargin());
		localOrderBO.orderPO.setIsPayMargin(getIsPayMargin());
		localOrderBO.orderPO.setIsSuborder(getIsSuborder());
		if (null == getIsPickOff()) {
			localOrderBO.orderPO.setIsPickoff("Y");
		} else {
			localOrderBO.orderPO.setIsPickoff(getIsPickOff());
		}
		localOrderBO.orderPO.setMinTradeQty(getMinTradeQty().doubleValue());
		localOrderBO.orderPO.setTradeUnit(getTradeUnit().doubleValue());
		if (getValidTime().intValue() != 0) {
			localOrderBO.orderPO.setValidTime(getValidTime().intValue());
		}
		if (getCategoryID() != null) {
			localOrderBO.orderPO.setCategoryID(getCategoryID().longValue());
		}
		Object localObject;
		if (getDeliveryDay() != null) {
			localObject = Tools.fmtDate(getDeliveryDay()) + " 23:59:59";
			localOrderBO.orderPO.setDeliveryDay(Tools.strToTimestamp((String) localObject));
		}
		localOrderBO.orderPO.setBreedID(getBelongtoBreed().getBreedID().longValue());
		if (getDeliveryMargin_B() != null) {
			localOrderBO.orderPO.setDeliveryMargin_b(getDeliveryMargin_B().doubleValue());
		}
		if (getDeliveryMargin_S() != null) {
			localOrderBO.orderPO.setDeliveryMargin_s(getDeliveryMargin_S().doubleValue());
		}
		if (getWarehouseID() != null) {
			localOrderBO.orderPO.setWarehouseID(getWarehouseID());
		}
		if (getDeliveryType() != null) {
			localOrderBO.orderPO.setDeliveryType(Integer.parseInt(getDeliveryType()));
			if ("1".equals(getDeliveryType())) {
				localOrderBO.orderPO.setDeliveryAddress(null);
			} else {
				localOrderBO.orderPO.setWarehouseID(null);
			}
		}
		if (getDeliveryAddress() != null) {
			localOrderBO.orderPO.setDeliveryAddress(getDeliveryAddress());
		}
		if (getDeliveryPreTime() != null) {
			localOrderBO.orderPO.setDeliveryPreTime(getDeliveryPreTime().intValue());
		}
		localOrderBO.orderPO.setFirmID(getBelongtoMFirm().getFirmID());
		localOrderBO.orderPO.setOrderTitle(getOrderTitle());
		if (getPrice() != null) {
			localOrderBO.orderPO.setPrice(getPrice().doubleValue());
		}
		if (getQuantity() != null) {
			localOrderBO.orderPO.setQuantity(getQuantity().doubleValue());
		}
		localOrderBO.orderPO.setRemark(getRemark());
		if (getTradeMargin_B() != null) {
			localOrderBO.orderPO.setTradeMargin_b(getTradeMargin_B().doubleValue());
		}
		if (getTradeMargin_S() != null) {
			localOrderBO.orderPO.setTradeMargin_s(getTradeMargin_S().doubleValue());
		}
		if (getTradePreTime() != null) {
			localOrderBO.orderPO.setTradePreTime(getTradePreTime().intValue());
		}
		localOrderBO.orderPO.setTraderID(getTraderID());
		localOrderBO.orderPO.setUnit(getUnit());
		if (getDeliveryDayType() != null) {
			localOrderBO.orderPO.setDeliveryDayType(getDeliveryDayType().intValue());
		}
		if (getTradeType() != null) {
			localOrderBO.orderPO.setTradeType(getTradeType().intValue());
		}
		if (getPayType() != null) {
			localOrderBO.orderPO.setPayType(getPayType().intValue());
		}
		if ((getContainGoodsProperty() != null) && (getContainGoodsProperty().size() > 0)) {
			localObject = null;
			Iterator localIterator = getContainGoodsProperty().iterator();
			while (localIterator.hasNext()) {
				GoodsProperty localGoodsProperty = (GoodsProperty) localIterator.next();
				localObject = new GoodsPropertyPO();
				if (getOrderID() != null) {
					((GoodsPropertyPO) localObject).setOrderID(getOrderID().longValue());
				}
				((GoodsPropertyPO) localObject).setPropertyName(localGoodsProperty.getPropertyName());
				((GoodsPropertyPO) localObject).setPropertyValue(localGoodsProperty.getPropertyValue());
				if (localGoodsProperty.getPropertyTypeID() != null) {
					((GoodsPropertyPO) localObject).setPropertyTypeID(localGoodsProperty.getPropertyTypeID().longValue());
				}
				localOrderBO.goodsPropertyPOList.add((GoodsPropertyPO) localObject);
			}
		}
		return localOrderBO;
	}
}

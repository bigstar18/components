package gnnt.MEBS.espot.front.dao.jdbc.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Comparator;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import org.springframework.jdbc.core.RowMapper;

import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.espot.front.common.XTradeFrontGlobal;
import gnnt.MEBS.espot.front.dao.jdbc.OrderDAO;
import gnnt.MEBS.espot.front.model.commodity.Breed;
import gnnt.MEBS.espot.front.model.commodity.Category;
import gnnt.MEBS.espot.front.model.commodity.Property;
import gnnt.MEBS.espot.front.model.trade.GoodsProperty;
import gnnt.MEBS.espot.front.model.trade.Order;
import gnnt.MEBS.espot.front.model.trade.Trade;
import gnnt.MEBS.espot.front.model.trade.TradeGoodsProperty;
import gnnt.MEBS.espot.front.vo.ShopVO;

public class OrderDAOImpl extends BaseDAOJdbc implements OrderDAO {
	public Page<ShopVO> getFirmByParamter(String paramString, PageRequest<QueryConditions> paramPageRequest) {
		String str = "select m.firmID,m.name,m.contactMan,m.phone,s.description,s.shopLevel,s.shopName  from M_Firm m ,M_FIRMMODULE fm ,E_Shop s left join E_RECOMMENDSHOP rs on rs.firmid =s.firmid where s.firmid=m.firmid and fm.firmid=m.firmid and fm.moduleid=23 and fm.enabled='Y'";
		if ((paramString != null) && (!paramString.equals(""))) {
			str = str + "  and (m.firmID like '%" + paramString + "%' " + "or lower(m.name) like  '%" + paramString + "%' "
					+ "or m.firmID in (select firmID from E_SHOP s where lower(s.shopName) like '%" + paramString + "%'))";
		}
		str = str + " order by rs.num,m.createtime asc";
		Page localPage = getPage(str, paramPageRequest, new MFirmMapper());
		return localPage;
	}

	public Page<Order> getOrderByFirmID(PageRequest<QueryConditions> paramPageRequest, String paramString) {
		String str = "select distinct(t.categoryid) as categoryID from e_order t where t.status in(0,1) and t.firmid='" + paramString + "'";
		Page localPage = getPage(str, paramPageRequest, new orderByFirmID());
		return localPage;
	}

	public Page<Order> getOrdersByCommodity(long paramLong, String paramString, PageRequest<QueryConditions> paramPageRequest) {
		if ((paramString != null) && (paramString.trim().length() > 0)) {
			paramString = "%" + paramString.replaceAll("%", "/%").replaceAll("_", "/_") + "%";
			paramString = paramString.toLowerCase();
		}
		TreeSet localTreeSet = new TreeSet(new Comparator<Property>() {
			public int compare(Property paramAnonymousProperty1, Property paramAnonymousProperty2) {
				if (paramAnonymousProperty1.getSortNo().longValue() > paramAnonymousProperty2.getSortNo().longValue()) {
					return 1;
				}
				return -1;
			}
		});
		List localList = XTradeFrontGlobal.getCategoryPage().getResult();
		Object localObject1 = localList.iterator();
		while (((Iterator) localObject1).hasNext()) {
			Category localObject2 = (Category) ((Iterator) localObject1).next();
			if (((Category) localObject2).getCategoryID().longValue() == paramLong) {
				Iterator localObject3 = ((Category) localObject2).getContainProperty().iterator();
				while (((Iterator) localObject3).hasNext()) {
					Property localObject4 = (Property) ((Iterator) localObject3).next();
					if (((Property) localObject4).getSearchable().equals("Y")) {
						localTreeSet.add(localObject4);
					}
				}
				break;
			}
		}
		localObject1 = null;
		Object localObject2 = "";
		Object localObject3 = "";
		Object localObject4 = "";
		String str1 = "";
		if ((localTreeSet != null) && (localTreeSet.size() > 0)) {
			int i = 0;
			Iterator localIterator = localTreeSet.iterator();
			while (localIterator.hasNext()) {
				Property localProperty = (Property) localIterator.next();
				String str2 = "tableproperty" + i++;
				localObject2 = (String) localObject2 + ",(select orderid, p.propertyvalue from e_goodsproperty p where p.propertyname='"
						+ localProperty.getPropertyName() + "') " + str2;
				localObject3 = (String) localObject3 + ",nvl(" + str2 + ".propertyvalue,'') as " + str2;
				localObject4 = (String) localObject4 + " and o.orderid=" + str2 + ".orderid(+) ";
				if ((localProperty.getSearchable().equals("Y")) && (paramString != null) && (paramString.trim().length() > 0)) {
					if (str1.length() > 0) {
						str1 = str1 + " or ";
					}
					str1 = str1 + "lower(" + str2 + ".propertyvalue) like '" + paramString + "'";
				}
			}
		}
		if ((paramString != null) && (!"".equals(paramString))) {
			if (!"".equals(str1)) {
				str1 = str1 + " or ";
			}
			str1 = str1 + "lower(o.orderTitle) like '" + paramString + "' or lower(g.breedName) like '" + paramString + "' ";
		}
		if (str1.length() > 0) {
			str1 = " and (" + str1 + ")";
		}
		localObject1 = "select o.*,g.breedName,g.trademode" + (String) localObject3 + " from e_order o,M_breed g " + (String) localObject2
				+ " where 1=1 and (o.status=0 or o.status=1) and o.breedID=g.breedID " + (String) localObject4 + " " + str1;
		this.logger.debug("aaaaaaaaaasql:" + (String) localObject1);
		Page localPage = getPage((String) localObject1, paramPageRequest, new OrdersByCommodity(localTreeSet));
		return localPage;
	}

	public Page<Trade> getTradesByCommodity(long paramLong, String paramString, PageRequest<QueryConditions> paramPageRequest) {
		if ((paramString != null) && (paramString.trim().length() > 0)) {
			paramString = paramString.replaceAll("%", "/%").replaceAll("_", "/_") + "%";
			paramString = paramString.toLowerCase();
		}
		TreeSet localTreeSet = new TreeSet(new Comparator<Property>() {
			public int compare(Property paramAnonymousProperty1, Property paramAnonymousProperty2) {
				if (paramAnonymousProperty1.getSortNo().longValue() > paramAnonymousProperty2.getSortNo().longValue()) {
					return 1;
				}
				return -1;
			}
		});
		List localList = XTradeFrontGlobal.getCategoryPage().getResult();
		Object localObject1 = localList.iterator();
		while (((Iterator) localObject1).hasNext()) {
			Category localObject2 = (Category) ((Iterator) localObject1).next();
			if (((Category) localObject2).getCategoryID().longValue() == paramLong) {
				Iterator localObject3 = ((Category) localObject2).getContainProperty().iterator();
				while (((Iterator) localObject3).hasNext()) {
					Property localObject4 = (Property) ((Iterator) localObject3).next();
					if (((Property) localObject4).getSearchable().equals("Y")) {
						localTreeSet.add(localObject4);
					}
				}
				break;
			}
		}
		localObject1 = null;
		Object localObject2 = "";
		Object localObject3 = "";
		Object localObject4 = "";
		String str1 = "";
		if ((localTreeSet != null) && (localTreeSet.size() > 0)) {
			int i = 0;
			Iterator localIterator = localTreeSet.iterator();
			while (localIterator.hasNext()) {
				Property localProperty = (Property) localIterator.next();
				String str2 = "tableproperty" + i++;
				localObject2 = (String) localObject2 + ",(select tradeno, p.propertyvalue from e_trade_goodsproperty p where p.propertyname='"
						+ localProperty.getPropertyName() + "') " + str2;
				localObject3 = (String) localObject3 + "," + str2 + ".propertyvalue as " + str2;
				localObject4 = (String) localObject4 + " and o.tradeno=" + str2 + ".tradeno ";
				if ((localProperty.getSearchable().equals("Y")) && (paramString != null) && (paramString.trim().length() > 0)) {
					if (str1.length() > 0) {
						str1 = str1 + " or ";
					}
					str1 = str1 + "lower(" + str2 + ".propertyvalue) like '" + paramString + "'";
				}
			}
		}
		if ((paramString != null) && (!"".equals(paramString))) {
			if (!"".equals(str1)) {
				str1 = str1 + " or ";
			}
			str1 = str1 + "lower(o.orderTitle) like '" + paramString + "' or lower(g.breedName) like '" + paramString + "' ";
		}
		if (str1.length() > 0) {
			str1 = " and (" + str1 + ")";
		}
		localObject1 = "select o.*,g.breedName,g.trademode" + (String) localObject3 + " from e_trade o,M_breed g " + (String) localObject2
				+ " where 1=1 and o.breedID=g.breedID " + (String) localObject4 + " " + str1;
		this.logger.debug("sql:" + (String) localObject1);
		Page localPage = getPage((String) localObject1, paramPageRequest, new TradesByCommodity(localTreeSet));
		return localPage;
	}

	private class TradesByCommodity implements RowMapper<Trade> {
		private Set<Property> propertySet;

		public TradesByCommodity(Set localSet) {

			this.propertySet = localSet;
		}

		public Trade mapRow(ResultSet paramResultSet, int paramInt) throws SQLException {
			Trade localTrade = new Trade();
			Breed localBreed = new Breed();
			localBreed.setBreedID(Long.valueOf(paramResultSet.getLong("breedID")));
			localBreed.setBreedName(paramResultSet.getString("breedName"));
			localBreed.setTradeMode(Integer.valueOf(paramResultSet.getInt("trademode")));
			localTrade.setBelongtoBreed(localBreed);
			localTrade.setBfirmID(paramResultSet.getString("bfirmID"));
			localTrade.setBuyDeliveryFee(Double.valueOf(paramResultSet.getDouble("buyDeliveryFee")));
			localTrade.setBuyPayDeliveryFee(Double.valueOf(paramResultSet.getDouble("buyPayDeliveryFee")));
			localTrade.setBuyPayTradeFee(Double.valueOf(paramResultSet.getDouble("buyPayTradeFee")));
			localTrade.setBuyTradeFee(Double.valueOf(paramResultSet.getDouble("buyTradeFee")));
			localTrade.setDeliveryAddress(paramResultSet.getString("deliveryAddress"));
			localTrade.setDeliveryDay(paramResultSet.getTimestamp("deliveryDay"));
			localTrade.setDeliveryMargin_B(Double.valueOf(paramResultSet.getDouble("deliveryMargin_B")));
			localTrade.setDeliveryMargin_S(Double.valueOf(paramResultSet.getDouble("deliveryMargin_S")));
			localTrade.setDeliveryType(paramResultSet.getString("deliveryType"));
			localTrade.setOrderID(Long.valueOf(paramResultSet.getLong("orderID")));
			localTrade.setOrderTitle(paramResultSet.getString("orderTitle"));
			localTrade.setPayType(Integer.valueOf(paramResultSet.getInt("payType")));
			localTrade.setPrice(Double.valueOf(paramResultSet.getDouble("price")));
			localTrade.setQuantity(Double.valueOf(paramResultSet.getDouble("quantity")));
			localTrade.setRemark(paramResultSet.getString("remark"));
			localTrade.setSellDeliveryFee(Double.valueOf(paramResultSet.getDouble("sellDeliveryFee")));
			localTrade.setSellPayDeliveryFee(Double.valueOf(paramResultSet.getDouble("sellPayDeliveryFee")));
			localTrade.setSellPayTradeFee(Double.valueOf(paramResultSet.getDouble("sellPayTradeFee")));
			localTrade.setSellTradeFee(Double.valueOf(paramResultSet.getDouble("sellTradeFee")));
			localTrade.setSfirmID(paramResultSet.getString("sfirmID"));
			localTrade.setStatus(Integer.valueOf(paramResultSet.getInt("status")));
			localTrade.setTime(paramResultSet.getTimestamp("time"));
			if (this.propertySet != null) {
				LinkedHashSet localLinkedHashSet = new LinkedHashSet();
				localTrade.setTradeGoodsPropertys(localLinkedHashSet);
				int i = 0;
				Iterator localIterator = this.propertySet.iterator();
				while (localIterator.hasNext()) {
					Property localProperty = (Property) localIterator.next();
					String str = "tableproperty" + i++;
					TradeGoodsProperty localTradeGoodsProperty = new TradeGoodsProperty();
					localTradeGoodsProperty.setPropertyName(localProperty.getPropertyName());
					localTradeGoodsProperty.setPropertyValue(paramResultSet.getString(str));
					localLinkedHashSet.add(localTradeGoodsProperty);
				}
			}
			localTrade.setTradeMargin_B(Double.valueOf(paramResultSet.getDouble("tradeMargin_B")));
			localTrade.setTradeMargin_S(Double.valueOf(paramResultSet.getDouble("tradeMargin_S")));
			localTrade.setTradeNo(Long.valueOf(paramResultSet.getLong("tradeNo")));
			localTrade.setTradePreTime(Integer.valueOf(paramResultSet.getInt("tradePreTime")));
			localTrade.setTradeType(Integer.valueOf(paramResultSet.getInt("tradeType")));
			localTrade.setUnit(paramResultSet.getString("unit"));
			localTrade.setWarehouseID(paramResultSet.getString("warehouseID"));
			return localTrade;
		}
	}

	private class OrdersByCommodity implements RowMapper<Order> {
		private Set<Property> propertySet;

		public OrdersByCommodity(Set localSet) {

			this.propertySet = localSet;
		}

		public Order mapRow(ResultSet paramResultSet, int paramInt) throws SQLException {
			Order localOrder = new Order();
			localOrder.setOrderID(Long.valueOf(paramResultSet.getLong("orderID")));
			localOrder.setOrderTitle(paramResultSet.getString("orderTitle"));
			Breed localBreed = new Breed();
			localBreed.setBreedID(Long.valueOf(paramResultSet.getLong("breedID")));
			localBreed.setBreedName(paramResultSet.getString("breedName"));
			localBreed.setTradeMode(Integer.valueOf(paramResultSet.getInt("trademode")));
			localOrder.setBelongtoBreed(localBreed);
			localOrder.setBsFlag(paramResultSet.getString("bsFlag"));
			MFirm localMFirm = new MFirm();
			localMFirm.setFirmID(paramResultSet.getString("firmID"));
			localOrder.setBelongtoMFirm(localMFirm);
			localOrder.setPrice(Double.valueOf(paramResultSet.getDouble("price")));
			localOrder.setQuantity(Double.valueOf(paramResultSet.getDouble("quantity")));
			localOrder.setUnit(paramResultSet.getString("unit"));
			localOrder.setTradePreTime(Integer.valueOf(paramResultSet.getInt("tradePreTime")));
			localOrder.setTradeMargin_B(Double.valueOf(paramResultSet.getDouble("tradeMargin_B")));
			localOrder.setTradeMargin_S(Double.valueOf(paramResultSet.getDouble("tradeMargin_S")));
			localOrder.setDeliveryDayType(Integer.valueOf(paramResultSet.getInt("deliveryDayType")));
			localOrder.setDeliveryPreTime(Integer.valueOf(paramResultSet.getInt("deliveryPreTime")));
			localOrder.setDeliveryDay(paramResultSet.getDate("deliveryDay"));
			localOrder.setDeliveryMargin_B(Double.valueOf(paramResultSet.getDouble("deliveryMargin_B")));
			localOrder.setDeliveryMargin_S(Double.valueOf(paramResultSet.getDouble("deliveryMargin_S")));
			localOrder.setDeliveryType(paramResultSet.getString("deliveryType"));
			localOrder.setWarehouseID(paramResultSet.getString("warehouseID"));
			localOrder.setDeliveryAddress(paramResultSet.getString("deliveryAddress"));
			localOrder.setStatus(Integer.valueOf(paramResultSet.getInt("status")));
			localOrder.setTradedQty(Double.valueOf(paramResultSet.getDouble("tradedQty")));
			localOrder.setRemark(paramResultSet.getString("remark"));
			localOrder.setOrderTime(paramResultSet.getTimestamp("orderTime"));
			localOrder.setEffectOfTime(paramResultSet.getTimestamp("effectOfTime"));
			localOrder.setTraderID(paramResultSet.getString("traderID"));
			localOrder.setWithdrawTime(paramResultSet.getDate("withdrawTime"));
			localOrder.setWithdrawTraderID(paramResultSet.getString("withdrawTraderID"));
			localOrder.setIsPickOff(paramResultSet.getString("isPickOff"));
			localOrder.setIsSuborder(paramResultSet.getString("isSuborder"));
			localOrder.setTradeType(Integer.valueOf(paramResultSet.getInt("tradeType")));
			localOrder.setPayType(Integer.valueOf(paramResultSet.getInt("payType")));
			if (this.propertySet != null) {
				LinkedHashSet localLinkedHashSet = new LinkedHashSet();
				localOrder.setContainGoodsProperty(localLinkedHashSet);
				int i = 0;
				Iterator localIterator = this.propertySet.iterator();
				while (localIterator.hasNext()) {
					Property localProperty = (Property) localIterator.next();
					String str = "tableproperty" + i++;
					GoodsProperty localGoodsProperty = new GoodsProperty();
					localGoodsProperty.setPropertyName(localProperty.getPropertyName());
					localGoodsProperty.setPropertyValue(paramResultSet.getString(str));
					localLinkedHashSet.add(localGoodsProperty);
				}
			}
			return localOrder;
		}
	}

	private class MFirmMapper implements RowMapper<ShopVO> {
		private MFirmMapper() {
		}

		public ShopVO mapRow(ResultSet paramResultSet, int paramInt) throws SQLException {
			ShopVO localShopVO = new ShopVO();
			localShopVO.setFirmID(paramResultSet.getString("firmID"));
			localShopVO.setName(paramResultSet.getString("name"));
			localShopVO.setContactMan(paramResultSet.getString("contactMan"));
			localShopVO.setPhone(paramResultSet.getString("phone"));
			localShopVO.setLevel(paramResultSet.getString("shoplevel"));
			localShopVO.setDescription(paramResultSet.getString("description"));
			localShopVO.setShopName(paramResultSet.getString("shopName"));
			return localShopVO;
		}
	}

	private class orderByFirmID implements RowMapper<Order> {
		private orderByFirmID() {
		}

		public Order mapRow(ResultSet paramResultSet, int paramInt) throws SQLException {
			Order localOrder = new Order();
			localOrder.setCategoryID(Long.valueOf(paramResultSet.getLong("categoryID")));
			return localOrder;
		}
	}
}

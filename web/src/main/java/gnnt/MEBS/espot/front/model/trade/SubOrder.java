package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.core.po.SubOrderPO;

public class SubOrder
  extends SubOrderBase
{
  private static final long serialVersionUID = 5007601338081657405L;
  @ClassDiscription(name="委托号", description="")
  private Order belongtoOrder;
  
  public Order getBelongtoOrder()
  {
    return this.belongtoOrder;
  }
  
  public void setBelongtoOrder(Order paramOrder)
  {
    this.belongtoOrder = paramOrder;
  }
  
  public SubOrderPO getSubOrderPO()
  {
    SubOrderPO localSubOrderPO = new SubOrderPO();
    if (getDeliveryMargin_B() != null) {
      localSubOrderPO.setDeliveryMargin_b(getDeliveryMargin_B().doubleValue());
    }
    if (getDeliveryMargin_S() != null) {
      localSubOrderPO.setDeliveryMargin_s(getDeliveryMargin_S().doubleValue());
    }
    if ((getBelongtoOrder() != null) && (getBelongtoOrder().getOrderID() != null)) {
      localSubOrderPO.setOrderID(getBelongtoOrder().getOrderID().longValue());
    }
    if (getPrice() != null) {
      localSubOrderPO.setPrice(getPrice().doubleValue());
    }
    if (getQuantity() != null) {
      localSubOrderPO.setQuantity(getQuantity().doubleValue());
    }
    if (getRemark() != null) {
      localSubOrderPO.setRemark(getRemark());
    }
    if (getReply() != null) {
      localSubOrderPO.setReply(getReply());
    }
    if (getStatus() != null) {
      localSubOrderPO.setStatus(getStatus().intValue());
    }
    if (getSubFirmID() != null) {
      localSubOrderPO.setSubFirmID(getSubFirmID());
    } else if (getBelongtoFirm() != null) {
      localSubOrderPO.setSubFirmID(getBelongtoFirm().getFirmID());
    }
    if (getTradePreTime() != null) {
      localSubOrderPO.setTradePreTime(getTradePreTime().intValue());
    }
    if (getWareHouseID() != null) {
      localSubOrderPO.setWarehouseID(getWareHouseID());
    }
    if (getWithdrawer() != null) {
      localSubOrderPO.setWithdrawer(getWithdrawer());
    }
    if (getWithdrawTime() != null) {
      localSubOrderPO.setWithdrawTime(getWithdrawTime());
    }
    if (getDeliveryDayType() != null) {
      localSubOrderPO.setDeliveryDayType(getDeliveryDayType());
    }
    if (getDeliveryDay() != null)
    {
      String str = Tools.fmtDate(getDeliveryDay()) + " 23:59:59";
      localSubOrderPO.setDeliveryDay(Tools.strToTimestamp(str));
    }
    if (getDeliveryPreTime() != null) {
      localSubOrderPO.setDeliveryPreTime(getDeliveryPreTime().intValue());
    }
    return localSubOrderPO;
  }
}

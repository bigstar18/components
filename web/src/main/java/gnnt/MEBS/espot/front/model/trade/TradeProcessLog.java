package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class TradeProcessLog extends TradeProcessLogBase {
	private static final long serialVersionUID = 1L;
	@ClassDiscription(name = "关联合同", description = "对应合同号")
	private Trade trade;

	public Trade getTrade() {
		return this.trade;
	}

	public void setTrade(Trade paramTrade) {
		this.trade = paramTrade;
	}

	public StandardModel.PrimaryInfo fetchPKey() {
		return null;
	}
}

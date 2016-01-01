package gnnt.MEBS.espot.front.model.trade;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class TradeProcessLogHis extends TradeProcessLogBase {
	private static final long serialVersionUID = 1L;
	@ClassDiscription(name = "关联合同", description = "对应合同号")
	private TradeHis trade;

	public TradeHis getTrade() {
		return this.trade;
	}

	public void setTrade(TradeHis paramTradeHis) {
		this.trade = paramTradeHis;
	}

	public StandardModel.PrimaryInfo fetchPKey() {
		return null;
	}
}

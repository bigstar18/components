package gnnt.MEBS.espot.core.bo;

import java.util.Comparator;
import java.util.SortedSet;
import java.util.TreeSet;

/**
 * 资金处理信息<br>
 * 为了避免死锁所以批量处理资金的时候统一放到队列排序后统一处理
 * 
 * @author xuejt
 * 
 */
public class FundsProcessInfo {
	/**
	 * 保证金类型 0解冻保证金 1 收取保证金
	 */
	private int type;
	/**
	 * 交易商代码
	 */
	private String firmID;
	/**
	 * 资金
	 */
	private double money;
	/**
	 * 合同号
	 */
	private long tradeNO;

	/**
	 * 保证金处理信息
	 * 
	 * @param type
	 *            保证金类型 0 解冻保证金 1 收取保证金
	 * @param firmID
	 *            交易商代码
	 * @param money
	 *            资金
	 * @param tradeNO
	 *            合同号
	 */
	public FundsProcessInfo(int type, String firmID, double money, long tradeNO) {
		if (type != 0 && type != 1) {
			throw new IllegalArgumentException(
					"初始化保证金处理信息失败,失败原因:保证金类型不在{0,1}!");
		}
		if (firmID == null || firmID.length() == 0) {
			throw new IllegalArgumentException("初始化保证金处理信息失败,失败原因:交易商代码不能为空!");
		}
		if (money <= 0) {
			throw new IllegalArgumentException("初始化保证金处理信息失败,失败原因:资金必须大于等于0!");
		}

		if (type == 1 && tradeNO <= 0) {
			throw new IllegalArgumentException(
					"初始化保证金处理信息失败,失败原因:收取保证金类型合同号不能为空!");
		}

		this.type = type;
		this.firmID = firmID;
		this.money = money;
		this.tradeNO = tradeNO;
	}

	/**
	 * @return 保证金类型 0 解冻保证金 1 收取保证金
	 */
	public int getType() {
		return type;
	}

	/**
	 * @return 交易商代码
	 */
	public String getFirmID() {
		return firmID;
	}

	/**
	 * @return 资金
	 */
	public double getMoney() {
		return money;
	}

	/**
	 * @return 合同号
	 */
	public long getTradeNO() {
		return tradeNO;
	}

	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("[保证金处理信息:");

		sb.append("[类型 ").append(this.type == 0 ? "解冻保证金" : "收取保证金")
				.append("]");
		sb.append("[交易商代码 ").append(this.firmID).append("]");
		sb.append("[保证金金额 ").append(this.money).append("]");
		sb.append("[合同号 ").append(this.tradeNO).append("]");

		sb.append("]");
		return sb.toString();
	}

	/**
	 * 升序比较器<br>
	 * 首先按照交易商代码降序排列<br>
	 * 如果交易商代码相同则解冻资金排到前面收取保证金放到后面
	 */
	public static Comparator<FundsProcessInfo> ascComparator = new Comparator<FundsProcessInfo>() {
		public int compare(FundsProcessInfo o1, FundsProcessInfo o2) {
			if (o1.getFirmID().compareTo(o2.getFirmID()) == 0) {
				if (o1.getType() == o2.getType()) {
					return 1;
				} else {
					if (o1.getType() == 0) {
						return -1;
					} else {
						return 1;
					}
				}
			} else if (o1.getFirmID().compareTo(o2.getFirmID()) < 0)
				return -1;
			else
				return 1;
		}
	};

	public static void main(String[] args) {
		SortedSet<FundsProcessInfo> fundsProcessQueue = new TreeSet<FundsProcessInfo>(
				ascComparator);
		fundsProcessQueue.add(new FundsProcessInfo(0, "002", 10, 10006));
		fundsProcessQueue.add(new FundsProcessInfo(1, "002", 10, 10007));
		fundsProcessQueue.add(new FundsProcessInfo(1, "001", 1, 10000));
		fundsProcessQueue.add(new FundsProcessInfo(1, "003", 2, 10001));
		fundsProcessQueue.add(new FundsProcessInfo(1, "002", 3, 10002));
		fundsProcessQueue.add(new FundsProcessInfo(0, "002", 4, 10003));
		fundsProcessQueue.add(new FundsProcessInfo(0, "003", 5, 10004));
		fundsProcessQueue.add(new FundsProcessInfo(0, "001", 6, 10005));
		for (FundsProcessInfo FundsProcessInfo : fundsProcessQueue) {
			System.out.println(FundsProcessInfo.toString());
		}
	}
}

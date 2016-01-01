package gnnt.MEBS.espot.core.vo;

import gnnt.MEBS.espot.core.po.Clone;

import java.io.Serializable;

/**
 * 费用计算算法
 * 
 * @author xuejt
 * 
 */
public class FeeComputeArithmeticVO extends Clone implements Serializable {
	private static final long serialVersionUID = -8489906407952994703L;
	
	private int mode;
	private double rate;

	/**
	 * @return 算法 1：固定值 2：百分比
	 */
	public int getMode() {
		return mode;
	}

	/**
	 * @param mode
	 *            算法 1：固定值 2：百分比
	 */
	public void setMode(int mode) {
		this.mode = mode;
	}

	/**
	 * @return 值
	 */
	public double getRate() {
		return rate;
	}

	/**
	 * @param rate
	 *            值
	 */
	public void setRate(double rate) {
		this.rate = rate;
	}

}

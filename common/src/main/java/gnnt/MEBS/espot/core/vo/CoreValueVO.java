package gnnt.MEBS.espot.core.vo;

import java.io.Serializable;
import java.util.Date;

/**
 * 核心值对象
 * 
 * @author xuejt
 * 
 */
public class CoreValueVO implements Serializable {

	private static final long serialVersionUID = -7922955330606943545L;

	/**
	 * 重新加载商品分类标示 当后台修改商品分类都信息后调用交易核心方法，交易核心重新设置标示；
	 * 前台从交易核心获取标示如果与前台记录的不一致则重新加载商品分类信息
	 */
	private int reloadCategoryFlag = 0;

	private int sysStatus;
	
	private Date curDate;

	/**
	 * @return 重新加载商品分类标示 当后台修改商品分类都信息后调用交易核心方法，交易核心重新设置标示；
	 *         前台从交易核心获取标示如果与前台记录的不一致则重新加载商品分类信息
	 */
	public int getReloadCategoryFlag() {
		return reloadCategoryFlag;
	}

	/**
	 * @param 重新加载商品分类标示
	 *            当后台修改商品分类都信息后调用交易核心方法，交易核心重新设置标示；
	 *            前台从交易核心获取标示如果与前台记录的不一致则重新加载商品分类信息
	 */
	public void setReloadCategoryFlag(int reloadCategoryFlag) {
		this.reloadCategoryFlag = reloadCategoryFlag;
	}

	/**
	 * @return 0 无状态,1 交易中,2 暂停交易, 3 交易结束
	 */
	public int getSysStatus() {
		return sysStatus;
	}

	/**
	 * @param 0 无状态,1 交易中,2 暂停交易, 3 交易结束
	 */
	public void setSysStatus(int sysStatus) {
		this.sysStatus = sysStatus;
	}

	/**
	 * @return 返回系统时间
	 */
	public Date getCurDate() {
		return curDate;
	}

	/**
	 * @param 返回系统当前时间
	 */
	public void setCurDate(Date curDate) {
		this.curDate = curDate;
	}

	
}

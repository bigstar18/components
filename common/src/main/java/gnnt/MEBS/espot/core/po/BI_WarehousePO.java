
package gnnt.MEBS.espot.core.po;

import java.io.Serializable;

/**
 * <P>类说明：仓单系统仓库表
 * <br/>
 * <br/>
 * </p>
 * 修改记录:
 * <br/>
 * <ul>
 * 
 * <li> 创建类                    |2013-12-24上午10:36:41|金网安泰 </li>
 * 
 * </ul>
 * @author liuzx
 */
public class BI_WarehousePO extends Clone implements Serializable{
	/** 序列编号 */
	private static final long serialVersionUID = -915004431321499976L;

	/** 仓库编号 */
	private long id;

	/** 仓库原始编号 */
	private String warehouseID;

	/** 仓库名称 */
	private String warehouseName;

	/**
	 * 仓库状态<br/>
	 * 0 可用 1 不可用
	 */
	private int status;

	/**
	 * 
	 * 仓库编号
	 * <br/><br/>
	 * @return
	 */
	public long getId() {
		return id;
	}

	/**
	 * 
	 * 仓库编号
	 * <br/><br/>
	 * @param id
	 */
	public void setId(long id) {
		this.id = id;
	}

	/**
	 * 
	 * 仓库原始编号
	 * <br/><br/>
	 * @return
	 */
	public String getWarehouseID() {
		return warehouseID;
	}

	/**
	 * 
	 * 仓库原始编号
	 * <br/><br/>
	 * @param warehouseID
	 */
	public void setWarehouseID(String warehouseID) {
		this.warehouseID = warehouseID;
	}

	/**
	 * 
	 * 仓库名称
	 * <br/><br/>
	 * @return
	 */
	public String getWarehouseName() {
		return warehouseName;
	}

	/**
	 * 
	 * 仓库名称
	 * <br/><br/>
	 * @param warehouseName
	 */
	public void setWarehouseName(String warehouseName) {
		this.warehouseName = warehouseName;
	}

	/**
	 * 
	 * 仓库状态<br/>
	 * 0 可用 1 不可用
	 * <br/><br/>
	 * @return
	 */
	public int getStatus() {
		return status;
	}

	/**
	 * 
	 * 仓库状态<br/>
	 * 0 可用 1 不可用
	 * <br/><br/>
	 * @param status
	 */
	public void setStatus(int status) {
		this.status = status;
	}

}


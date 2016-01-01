
package gnnt.MEBS.logonService.po;
/**
 * <P>类说明：模块和 AU 对应关系信息
 * <br/>
 * <br/>
 * </p>
 * 修改记录:
 * <br/>
 * <ul>
 * 
 * <li> 创建类                    |2014-6-9下午06:54:14|金网安泰 </li>
 * 
 * </ul>
 * @author liuzx
 */
public class ModuleAndAUPO extends Clone{

	/** 模块编号 */
	private int moduleID;

	/** AU 编号 */
	private int configID;

	/**
	 * 
	 * 模块编号
	 * <br/><br/>
	 * @return
	 */
	public int getModuleID() {
		return moduleID;
	}

	/**
	 * 
	 * 模块编号
	 * <br/><br/>
	 * @param moduleID
	 */
	public void setModuleID(int moduleID) {
		this.moduleID = moduleID;
	}

	/**
	 * 
	 * AU 编号
	 * <br/><br/>
	 * @return
	 */
	public int getConfigID() {
		return configID;
	}

	/**
	 * 
	 * AU 编号
	 * <br/><br/>
	 * @param configID
	 */
	public void setConfigID(int configID) {
		this.configID = configID;
	}

}


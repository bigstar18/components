package gnnt.MEBS.logonService.client.front;

/**
 * 交易员模块 可用性
 * 
 * @author xuejt
 * 
 */
public class TraderModule {
	private String moduleId;
	private String traderId;
	private String enabled;

	/**
	 * @return 模块号
	 */
	public String getModuleId() {
		return moduleId;
	}

	/**
	 * @param moduleId
	 *            模块号
	 */
	public void setModuleId(String moduleId) {
		this.moduleId = moduleId;
	}

	/**
	 * @return 交易员代码
	 */
	public String getTraderId() {
		return traderId;
	}

	/**
	 * @param traderId
	 *            交易员代码
	 */
	public void setTraderId(String traderId) {
		this.traderId = traderId;
	}

	/**
	 * @return 是否可用 Y 可用 N 不可用
	 */
	public String getEnabled() {
		return enabled;
	}

	/**
	 * @param enabled
	 *            是否可用 Y 可用 N 不可用
	 */
	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}
}

package gnnt.MEBS.logonService.client.mgr;

/**
 * 后台用户信息
 * 
 * @author xuejt
 * 
 */
public class User {
	private String userId;

	private String name;

	private transient String password;

	private String description;

	private String keyCode;

	private String type;

	private String isForbid = "N";

	private long sessionId;

	/**
	 * 获取用户代码
	 * 
	 * @return 用户代码
	 */
	public String getUserId() {
		return userId;
	}

	/**
	 * 设置用户代码
	 * 
	 * @param userId
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}

	/**
	 * 获取用户密码
	 * 
	 * @return 密码
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * 设置用户密码
	 * 
	 * @param password
	 *            密码
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * 用户类型 DEFAULT_SUPER_ADMIN 默认超级管理员DEFAULT_ADMIN 高级管理员 ADMIN 普通管理员 <br>
	 * 默认超级管理员不可删除
	 * 
	 * @return
	 */
	public String getType() {
		return type;
	}

	/**
	 * 用户类型 DEFAULT_SUPER_ADMIN 默认超级管理员 ADMIN 普通管理员 <br>
	 * 默认超级管理员不可删除
	 * 
	 * @param type
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * 是否禁用状态 N：可用 Y:禁用
	 * 
	 * @return
	 */
	public String getIsForbid() {
		return isForbid;
	}

	/**
	 * 是否禁用状态 N：可用 Y:禁用
	 * 
	 */
	public void setIsForbid(String isForbid) {
		this.isForbid = isForbid;
	}

	/**
	 * 获取用户名称
	 * 
	 * @return 用户名称
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置用户名称
	 * 
	 * @param name
	 *            用户名称
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 用户描述
	 * 
	 * @return
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * 用户描述
	 * 
	 * @param description
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * key盘中的代码
	 * 
	 * @return key码
	 */
	public String getKeyCode() {
		return keyCode;
	}

	/**
	 * key盘中的代码
	 * 
	 * @param keyCode
	 *            key码
	 */
	public void setKeyCode(String keyCode) {
		this.keyCode = keyCode;
	}

	/**
	 * 用户sessionID 登录成功后由AU返回可以唯一标示用户身份
	 * 
	 * @return
	 */
	public long getSessionId() {
		return sessionId;
	}

	/**
	 * 用户sessionID 登录成功后由AU返回可以唯一标示用户身份
	 * 
	 */
	public void setSessionId(long sessionId) {
		this.sessionId = sessionId;
	}

	@Override
	public boolean equals(Object o) {
		boolean sign = true;
		if (o instanceof User && o != null) {
			User user = (User) o;
			if (!this.getUserId().equals(user.getUserId())) {
				sign = false;
			}
		} else {
			sign = false;
		}
		return sign;
	}
}

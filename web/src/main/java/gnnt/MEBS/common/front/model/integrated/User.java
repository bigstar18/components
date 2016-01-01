package gnnt.MEBS.common.front.model.integrated;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.front.Right;
import gnnt.MEBS.common.front.model.front.Role;
import gnnt.MEBS.common.front.model.translate.ClassDiscription;

public class User extends StandardModel {
	private static final long serialVersionUID = -3775440804644210338L;
	@ClassDiscription(name = "交易员ID", description = "")
	private String traderID;
	@ClassDiscription(name = "交易员用户名 *", description = "")
	private String userID;
	@ClassDiscription(name = "交易员名称", description = "")
	private String name;
	@ClassDiscription(name = "口令", description = "")
	private transient String password;
	@ClassDiscription(name = "状态", description = "状态： N：正常 Normal D：禁用 Disable")
	private String status;
	@ClassDiscription(name = "交易员类型", description = "交易员类型：A：管理员 N：一般交易员")
	private String type;
	@ClassDiscription(name = "创建时间", description = "")
	private Date createTime;
	@ClassDiscription(name = "修改时间 ", description = "")
	private Date modifyTime;
	@ClassDiscription(name = "Key码", description = "")
	private String keyCode;
	@ClassDiscription(name = "是否启用Key", description = "是否启用Key Y：启用 N：不启用")
	private String enableKey;
	@ClassDiscription(name = "信任Key", description = "")
	private String trustKey;
	@ClassDiscription(name = "是否修改口令", description = "是否修改口令：0：否 1：是")
	private Integer forceChangePwd;
	@ClassDiscription(name = "上次登录IP", description = "")
	private String lastIP;
	@ClassDiscription(name = "上次登录时间", description = "")
	private Date lastTime;
	@ClassDiscription(name = "用户sessionID 登录成功后由AU返回可以唯一标示用户身份", description = "")
	private Long sessionId;
	@ClassDiscription(name = "用户登录ip地址 ", description = "")
	private String ipAddress;
	@ClassDiscription(name = "用户使用的皮肤风格", description = "")
	private String skin = "default";
	@ClassDiscription(name = "所属交易商", description = "")
	private MFirm belongtoFirm;
	@ClassDiscription(name = "交易员权限集合", description = "")
	private Set<Right> rightSet;
	@ClassDiscription(name = "交易员角色集合", description = "")
	private Set<Role> roleSet;
	@ClassDiscription(name = "所属交易员模块", description = "")
	private Set<TraderModule> traderModule;
	@ClassDiscription(name = "客户权限map集合", description = "")
	private Map<Long, Right> rightMap;
	@ClassDiscription(name = "登录类型", description = "")
	private String logonType;
	@ClassDiscription(name = "模块编号", description = "")
	private Integer moduleID;

	public String getTraderID() {
		return this.traderID;
	}

	public void setTraderID(String traderID) {
		this.traderID = traderID;
	}

	public String getUserID() {
		return this.userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getForceChangePwd() {
		return this.forceChangePwd;
	}

	public void setForceChangePwd(Integer forceChangePwd) {
		this.forceChangePwd = forceChangePwd;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getModifyTime() {
		return this.modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	public String getKeyCode() {
		return this.keyCode;
	}

	public void setKeyCode(String keyCode) {
		this.keyCode = keyCode;
	}

	public String getEnableKey() {
		return this.enableKey;
	}

	public void setEnableKey(String enableKey) {
		this.enableKey = enableKey;
	}

	public String getTrustKey() {
		return this.trustKey;
	}

	public void setTrustKey(String trustKey) {
		this.trustKey = trustKey;
	}

	public String getLastIP() {
		return this.lastIP;
	}

	public void setLastIP(String lastIP) {
		this.lastIP = lastIP;
	}

	public Date getLastTime() {
		return this.lastTime;
	}

	public void setLastTime(Date lastTime) {
		this.lastTime = lastTime;
	}

	public Long getSessionId() {
		return this.sessionId;
	}

	public void setSessionId(Long sessionId) {
		this.sessionId = sessionId;
	}

	public String getIpAddress() {
		return this.ipAddress;
	}

	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

	public String getSkin() {
		return this.skin;
	}

	public void setSkin(String skin) {
		this.skin = skin;
	}

	public MFirm getBelongtoFirm() {
		return this.belongtoFirm;
	}

	public void setBelongtoFirm(MFirm belongtoFirm) {
		this.belongtoFirm = belongtoFirm;
	}

	public Set<Right> getRightSet() {
		return this.rightSet;
	}

	public void setRightSet(Set<Right> rightSet) {
		this.rightSet = rightSet;
	}

	public Set<Role> getRoleSet() {
		return this.roleSet;
	}

	public void setRoleSet(Set<Role> roleSet) {
		this.roleSet = roleSet;
	}

	public Set<TraderModule> getTraderModule() {
		return this.traderModule;
	}

	public void setTraderModule(Set<TraderModule> traderModule) {
		this.traderModule = traderModule;
	}

	public String getLogonType() {
		return this.logonType;
	}

	public void setLogonType(String logonType) {
		this.logonType = logonType;
	}

	public Integer getModuleID() {
		return this.moduleID;
	}

	public void setModuleID(Integer moduleID) {
		this.moduleID = moduleID;
	}

	public Map getRightMap() {
		if (rightMap == null) {
			rightMap = new HashMap();
			Set rightSet = this.rightSet;
			Set roleSet = this.roleSet;
			if (rightSet != null) {
				for (Iterator iterator = rightSet.iterator(); iterator.hasNext();) {
					Right right = (Right) iterator.next();
					if (!rightMap.containsKey(right.getId()))
						rightMap.put(right.getId(), right);
				}

			}
			if (roleSet != null) {
				for (Iterator iterator1 = roleSet.iterator(); iterator1.hasNext();) {
					Role role = (Role) iterator1.next();
					Set roleRightSet = role.getRightSet();
					for (Iterator iterator2 = roleRightSet.iterator(); iterator2.hasNext();) {
						Right right = (Right) iterator2.next();
						if (!rightMap.containsKey(right.getId()))
							rightMap.put(right.getId(), right);
					}

				}

			}
		}
		return rightMap;
	}

	public StandardModel.PrimaryInfo fetchPKey() {
		return new StandardModel.PrimaryInfo("traderID", this.traderID);
	}
}

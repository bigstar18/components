
package gnnt.MEBS.logonService.vo;
/**
 * <P>类说明：执行登录方法返回对象
 * <br/>
 * <br/>
 * </p>
 * 修改记录:
 * <br/>
 * <ul>
 * 
 * <li> 创建类                    |2014-4-21下午02:16:12|金网安泰 </li>
 * 
 * </ul>
 * @author liuzx
 */
public class LogonResultVO extends ResultVO{
	/** 序列编号 */
	private static final long serialVersionUID = -4008331784951547600L;

	/** 登录用户信息 */
	private UserManageVO userManageVO;

	/**
	 * 
	 * 登录用户信息
	 * <br/><br/>
	 * @return
	 */
	public UserManageVO getUserManageVO() {
		return userManageVO;
	}

	/**
	 * 
	 * 登录用户信息
	 * <br/><br/>
	 * @param userManageVO
	 */
	public void setUserManageVO(UserManageVO userManageVO) {
		this.userManageVO = userManageVO;
	}
}
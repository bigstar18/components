
package gnnt.MEBS.logonService.vo;
/**
 * <P>类说明：通过 SessionID 获取 User 的返回对象
 * <br/>
 * <br/>
 * </p>
 * 修改记录:
 * <br/>
 * <ul>
 * 
 * <li> 创建类                    |2014-4-28下午07:20:49|金网安泰 </li>
 * 
 * </ul>
 * @author liuzx
 */
public class GetUserResultVO extends ResultVO{
	/** 序列编号 */
	private static final long serialVersionUID = -3728502476951594091L;

	/** 用户登录信息 */
	private UserManageVO userManageVO;

	/**
	 * 
	 * 用户登录信息
	 * <br/><br/>
	 * @return
	 */
	public UserManageVO getUserManageVO() {
		return userManageVO;
	}

	/**
	 * 
	 * 用户登录信息
	 * <br/><br/>
	 * @param userManageVO
	 */
	public void setUserManageVO(UserManageVO userManageVO) {
		this.userManageVO = userManageVO;
	}
}


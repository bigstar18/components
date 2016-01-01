package gnnt.MEBS.logonService.activeUser;

import gnnt.MEBS.logonService.model.ActiveUser;

/**
 * <p>
 * 超时回调方法；在ActiveUserManager中检查到用户超时回调此接口
 * 
 * @author xuejt
 * 
 */
public interface TimeoutCallback {
	/**
	 * 用户超时
	 * 
	 * @param activeUser
	 *            超时的用户信息
	 */
	public void userTimeout(ActiveUser activeUser);
}

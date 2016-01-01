
package gnnt.MEBS.logonService.kernel;

import gnnt.MEBS.logonService.vo.CheckUserResultVO;
import gnnt.MEBS.logonService.vo.CheckUserVO;
import gnnt.MEBS.logonService.vo.CompulsoryLogoffResultVO;
import gnnt.MEBS.logonService.vo.CompulsoryLogoffVO;
import gnnt.MEBS.logonService.vo.GetUserResultVO;
import gnnt.MEBS.logonService.vo.GetUserVO;
import gnnt.MEBS.logonService.vo.ISLogonResultVO;
import gnnt.MEBS.logonService.vo.ISLogonVO;
import gnnt.MEBS.logonService.vo.LogoffResultVO;
import gnnt.MEBS.logonService.vo.LogoffVO;
import gnnt.MEBS.logonService.vo.LogonOrLogoffUserVO;
import gnnt.MEBS.logonService.vo.LogonResultVO;
import gnnt.MEBS.logonService.vo.LogonVO;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.List;

/**
 * <P>类说明：开放的 登录相关 RMI 接口
 * <br/>
 * <br/>
 * </p>
 * 修改记录:
 * <br/>
 * <ul>
 * 
 * <li> 创建类                    |2014-4-18下午04:45:19|金网安泰 </li>
 * 
 * </ul>
 * @author liuzx
 */
public interface ILogonService extends Remote{
	/**
	 * 
	 * 用户登录
	 * <br/><br/>
	 * @param logonVO 登录时，传入对象
	 * @return
	 */
	public LogonResultVO logon(LogonVO logonVO) throws RemoteException;

	/**
	 * 
	 * 退出登录
	 * <br/><br/>
	 * @param logoffVO
	 * @return
	 */
	public LogoffResultVO logoff(LogoffVO logoffVO) throws RemoteException;

	/**
	 * 
	 * 用户跳转
	 * <br/><br/>
	 * @param checkUserVO 登录 RMI 信息
	 * @param fromModuleID 来源模块编号
	 * @param fromLogonType 来源登录类型 (web web服务登录、pc 电脑客户端登录、mobile 手机客户端登录)
	 * @return
	 */
	public CheckUserResultVO checkUser(CheckUserVO checkUserVO,int fromModuleID,String fromLogonType) throws RemoteException;

	/**
	 * 
	 * 通过 SessionID 获取登录用户信息
	 * <br/><br/>
	 * @param getUserVO
	 * @return
	 */
	public GetUserResultVO getUserBySessionID(GetUserVO getUserVO) throws RemoteException;

	/**
	 * 
	 * 判断用户是否已经登录
	 * <br/><br/>
	 * @param isLogonVO
	 * @return
	 */
	public ISLogonResultVO isLogon(ISLogonVO isLogonVO) throws RemoteException;

	/**
	 * 
	 * 强制退出用户
	 * <br/><br/>
	 * @param compulsoryLogoffVO
	 * @return
	 */
	public CompulsoryLogoffResultVO compulsoryLogoff(CompulsoryLogoffVO compulsoryLogoffVO) throws RemoteException;

	/**
	 * 
	 * 获取登录退出列表
	 * <br/><br/>
	 * @return
	 */
	public List<LogonOrLogoffUserVO> getLogonOrLogoffUserList() throws RemoteException;

	/**
	 * 
	 * 获取当前系统中的所有登录信息，并删除记录的登录退出流水
	 * <br/><br/>
	 * @return
	 * @throws RemoteException
	 */
	public List<LogonOrLogoffUserVO> getAllLogonUserList() throws RemoteException;

	/**
	 * 
	 * 只获取当前系统中的所有登录信息，不删除记录的登录退出流水
	 * <br/><br/>
	 * @return
	 */
	public List<LogonOrLogoffUserVO> onlyGetAllLogonUserList() throws RemoteException;

	/**
	 * 
	 * 是否重新启动的服务
	 * <br/><br/>
	 * @return int 1 是，2 否
	 */
	public int isRestartStartRMI() throws RemoteException;
}


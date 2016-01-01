package gnnt.MEBS.logonService.kernel.impl;

import gnnt.MEBS.activeUser.operation.ActiveUserManage;
import gnnt.MEBS.activeUser.vo.AUCheckUserResultVO;
import gnnt.MEBS.activeUser.vo.AUCheckUserVO;
import gnnt.MEBS.activeUser.vo.AUCompulsoryLogoffResultVO;
import gnnt.MEBS.activeUser.vo.AUCompulsoryLogoffVO;
import gnnt.MEBS.activeUser.vo.AUGetUserResultVO;
import gnnt.MEBS.activeUser.vo.AUGetUserVO;
import gnnt.MEBS.activeUser.vo.AUISLogonResultVO;
import gnnt.MEBS.activeUser.vo.AUISLogonVO;
import gnnt.MEBS.activeUser.vo.AULogoffResultVO;
import gnnt.MEBS.activeUser.vo.AULogoffVO;
import gnnt.MEBS.activeUser.vo.AULogonOrLogoffUserVO;
import gnnt.MEBS.activeUser.vo.AULogonResultVO;
import gnnt.MEBS.activeUser.vo.AULogonVO;
import gnnt.MEBS.activeUser.vo.AUUserManageVO;
import gnnt.MEBS.logonService.kernel.ILogonService;
import gnnt.MEBS.logonService.po.LogonConfigPO;
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
import gnnt.MEBS.logonService.vo.RemoteLogonServerVO;
import gnnt.MEBS.logonService.vo.UserManageVO;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;
/**
 * 开放的 登录相关 RMI 实现类
 * @author liuzx
 *
 */
public class LogonService_Standard extends LogonServiceBase implements ILogonService{
	/** 序列编号 */
	private static final long serialVersionUID = 7554525770181024510L;

	/**
	 * 
	 * 构造方法
	 * <br/><br/>
	 * @throws RemoteException
	 */
	public LogonService_Standard()throws RemoteException{
		super();
	}

	@Override
	public LogonResultVO logon(LogonVO logonVO){
		AULogonVO auLogonVO = new AULogonVO();
		auLogonVO.setLogonType(logonVO.getLogonType());
		auLogonVO.setModuleID(logonVO.getModuleID());
		auLogonVO.setUserID(logonVO.getUserID());
		auLogonVO.setLogonTime(logonVO.getLogonTime());
		auLogonVO.setLogonIp(logonVO.getLogonIp());

		AULogonResultVO rv = ActiveUserManage.getInstance().logon(auLogonVO);

		LogonResultVO result = new LogonResultVO();
		result.setMessage(rv.getMessage());
		result.setRecode(rv.getRecode());
		result.setResult(rv.getResult());
		result.setUserManageVO(getUserManageVO(rv.getUserManageVO()));

		return result;
	}

	@Override
	public LogoffResultVO logoff(LogoffVO logoffVO){
		AULogoffVO auLogoffVO = new AULogoffVO();
		auLogoffVO.setLogonType(logoffVO.getLogonType());
		auLogoffVO.setSessionID(logoffVO.getSessionID());
		auLogoffVO.setUserID(logoffVO.getUserID());

		AULogoffResultVO rv = ActiveUserManage.getInstance().logoff(auLogoffVO);

		LogoffResultVO result = new LogoffResultVO();
		result.setMessage(rv.getMessage());
		result.setRecode(rv.getRecode());
		result.setResult(rv.getResult());

		return result;
	}

	@Override
	public CheckUserResultVO checkUser(CheckUserVO checkUserVO,int fromModuleID,String fromLogonType){
		CheckUserResultVO result = new CheckUserResultVO();
		result.setResult(-1);

		ISLogonVO isLogonVO = new ISLogonVO();
		isLogonVO.setLogonType(checkUserVO.getLogonType());
		isLogonVO.setModuleID(checkUserVO.getToModuleID());
		isLogonVO.setSessionID(checkUserVO.getSessionID());
		isLogonVO.setUserID(checkUserVO.getUserID());

		//验证本用户当前是否已经是登录状态
		ISLogonResultVO isLogonResult = isLogon(isLogonVO);
		if(isLogonResult.getResult() == 1){
			result.setResult(1);
			result.setUserManageVO(isLogonResult.getUserManageVO());
			return result;
		}

		//通过模块编号获取AU 编号
		int fromauID = this.getConfigID(fromModuleID);

		//验证是否有模块对应的 AU
		if(fromauID < 0){
			result.setRecode("-1202");
			result.setMessage("通过模块编号没有找到对应au编号");
			return result;
		}

		if(fromauID == getSelfLogonConfigPO().getConfigID().intValue()){//如果是从本 AU 跳转
			isLogonVO.setLogonType(fromLogonType);
			isLogonResult = isLogon(isLogonVO);
		}else{
			isLogonVO.setLogonType(fromLogonType);
			RemoteLogonServerVO logonManager = logonManagerMap.get(fromauID);

			//追加新增 AU
			if(logonManager == null){
				LogonConfigPO logonConfigPO = this.getLogonConfigByID(fromauID);
				//如果当个连接与本连接同组而连接中没有本记录，则认为这个是新加的 AU
				if(getSelfLogonConfigPO().getSysname().equals(logonConfigPO.getSysname())){
					logonManager = new RemoteLogonServerVO();
					logonManager.setLogonConfigPO(logonConfigPO);
					logonManagerMap.put(logonConfigPO.getConfigID(), logonManager);
				}
			}

			try{
				isLogonResult = logonManager.getRmiService().isLogon(isLogonVO);
			}catch(RemoteException e){
				//重置 RMI 连接次数
				int times = logonManager.clearRMI();
				try{
					isLogonResult = logonManager.getRmiService().isLogon(isLogonVO);
				}catch(RemoteException e1){
					//如果重连次数超过了指定重连次数，则连接数据库重新获取 RMI 连接
					if(clearRMITimes > 0 && times > clearRMITimes){
						LogonConfigPO logonConfigPO = this.getLogonConfigByID(fromauID);
						if(logonConfigPO != null){//由于可能数据库配置已经被删除了，所以需要验证空
							logonManager.setLogonConfigPO(logonConfigPO);
						}
					}
					result.setRecode("-1");
					result.setMessage("连接来源 RMI 失败");
					logger.error("用户验证调用来源 RMI 异常",e1);
					return result;
				}catch(Exception e1){
					result.setRecode("-1");
					result.setMessage("连接来源 RMI 失败");
					logger.error("用户验证调用来源 RMI 异常",e1);
					return result;
				}
			}catch(Exception e){
				result.setRecode("-1");
				result.setMessage("从来源 RMI 获取用户登录信息异常");
				logger.error("从来源 RMI 获取用户登录信息异常",e);
				return result;
			}
		}

		//如果从来源 RMI 判断用户是否已经登录失败，则返回失败
		if(isLogonResult.getResult() == -1){
			result.setRecode(isLogonResult.getRecode());
			result.setMessage(isLogonResult.getMessage());
			logger.info(isLogonResult.getMessage());
			return result;
		}

		AUCheckUserVO auCheckUserVO = new AUCheckUserVO();
		auCheckUserVO.setLogonType(checkUserVO.getLogonType());
		auCheckUserVO.setSessionID(checkUserVO.getSessionID());
		auCheckUserVO.setToModuleID(checkUserVO.getToModuleID());
		auCheckUserVO.setUserID(checkUserVO.getUserID());
		auCheckUserVO.setLogonTime(isLogonResult.getUserManageVO().getLogonTime());
		auCheckUserVO.setLogonIp(isLogonResult.getUserManageVO().getLogonIp());

		AUCheckUserResultVO rv = ActiveUserManage.getInstance().checkUser(auCheckUserVO);

		result.setMessage(rv.getMessage());
		result.setRecode(rv.getRecode());
		result.setResult(rv.getResult());
		result.setUserManageVO(getUserManageVO(rv.getUserManageVO()));

		return result;
	}

	@Override
	public GetUserResultVO getUserBySessionID(GetUserVO getUserVO){
		AUGetUserVO auGetUserVO = new AUGetUserVO();
		auGetUserVO.setLogonType(getUserVO.getLogonType());
		auGetUserVO.setModuleID(getUserVO.getModuleID());
		auGetUserVO.setSessionID(getUserVO.getSessionID());

		AUGetUserResultVO rv = ActiveUserManage.getInstance().getUserBySessionID(auGetUserVO);

		GetUserResultVO result = new GetUserResultVO();
		result.setMessage(rv.getMessage());
		result.setRecode(rv.getRecode());
		result.setResult(rv.getResult());
		result.setUserManageVO(getUserManageVO(rv.getUserManageVO()));

		return result;
	}

	@Override
	public ISLogonResultVO isLogon(ISLogonVO isLogonVO){
		AUISLogonVO auISLogonVO = new AUISLogonVO();
		auISLogonVO.setLogonType(isLogonVO.getLogonType());
		auISLogonVO.setModuleID(isLogonVO.getModuleID());
		auISLogonVO.setSessionID(isLogonVO.getSessionID());
		auISLogonVO.setUserID(isLogonVO.getUserID());

		AUISLogonResultVO rv = ActiveUserManage.getInstance().isLogon(auISLogonVO);

		ISLogonResultVO result = new ISLogonResultVO();
		result.setMessage(rv.getMessage());
		result.setRecode(rv.getRecode());
		result.setResult(rv.getResult());
		result.setUserManageVO(getUserManageVO(rv.getUserManageVO()));

		return result;
	}

	@Override
	public CompulsoryLogoffResultVO compulsoryLogoff(CompulsoryLogoffVO compulsoryLogoffVO){
		AUCompulsoryLogoffVO auCompulsoryLogoffVO = new AUCompulsoryLogoffVO();
		auCompulsoryLogoffVO.setLogonIP(compulsoryLogoffVO.getLogonIP());
		auCompulsoryLogoffVO.setOperator(compulsoryLogoffVO.getOperator());
		auCompulsoryLogoffVO.setUserIDList(compulsoryLogoffVO.getUserIDList());

		AUCompulsoryLogoffResultVO rv = ActiveUserManage.getInstance().compulsoryLogoff(auCompulsoryLogoffVO);

		CompulsoryLogoffResultVO result = new CompulsoryLogoffResultVO();
		result.setMessage(rv.getMessage());
		result.setRecode(rv.getRecode());
		result.setResult(rv.getResult());

		return result;
	}

	@Override
	public List<LogonOrLogoffUserVO> getLogonOrLogoffUserList(){
		List<AULogonOrLogoffUserVO> list = ActiveUserManage.getInstance().getLogonOrLogoffUserList();

		List<LogonOrLogoffUserVO> result = new ArrayList<LogonOrLogoffUserVO>();
		if(list != null){
			for(AULogonOrLogoffUserVO rv : list){
				LogonOrLogoffUserVO e = new LogonOrLogoffUserVO();
				e.setLogonOrlogOff(rv.getLogonOrlogOff());
				e.setUserManageVO(getUserManageVO(rv.getUserManageVO()));
				result.add(e);
			}
		}

		return result;
	}

	@Override
	public List<LogonOrLogoffUserVO> getAllLogonUserList(){
		List<AULogonOrLogoffUserVO> list = ActiveUserManage.getInstance().getAllLogonUserList();

		List<LogonOrLogoffUserVO> result = new ArrayList<LogonOrLogoffUserVO>();
		if(list != null){
			for(AULogonOrLogoffUserVO rv : list){
				LogonOrLogoffUserVO e = new LogonOrLogoffUserVO();
				e.setLogonOrlogOff(rv.getLogonOrlogOff());
				e.setUserManageVO(getUserManageVO(rv.getUserManageVO()));
				result.add(e);
			}
		}

		return result;
	}

	@Override
	public List<LogonOrLogoffUserVO> onlyGetAllLogonUserList(){
		List<AULogonOrLogoffUserVO> list = ActiveUserManage.getInstance().onlyGetAllLogonUserList();

		List<LogonOrLogoffUserVO> result = new ArrayList<LogonOrLogoffUserVO>();
		if(list != null){
			for(AULogonOrLogoffUserVO rv : list){
				LogonOrLogoffUserVO e = new LogonOrLogoffUserVO();
				e.setLogonOrlogOff(rv.getLogonOrlogOff());
				e.setUserManageVO(getUserManageVO(rv.getUserManageVO()));
				result.add(e);
			}
		}

		return result;
	}

	@Override
	public int isRestartStartRMI(){
		return ActiveUserManage.getInstance().isRestartStartRMI();
	}

	/**
	 * 
	 * 封装用户信息
	 * <br/><br/>
	 * @param auUserManageVO
	 * @return
	 */
	private UserManageVO getUserManageVO(AUUserManageVO auUserManageVO){
		UserManageVO result = null;
		if(auUserManageVO != null){
			result = new UserManageVO();
			result.setLastTime(auUserManageVO.getLastTime());
			result.setLogonType(auUserManageVO.getLogonType());
			result.setModuleIDList(auUserManageVO.getModuleIDList());
			result.setSessionID(auUserManageVO.getSessionID());
			result.setUserID(auUserManageVO.getUserID());
			result.setLogonTime(auUserManageVO.getLogonTime());
			result.setLogonIp(auUserManageVO.getLogonIp());
		}
		return result;
	}
}

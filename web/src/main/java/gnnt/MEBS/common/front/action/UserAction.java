package gnnt.MEBS.common.front.action;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.checkLogon.vo.front.TraderLogonInfo;
import gnnt.MEBS.common.front.common.ActiveUserManager;
import gnnt.MEBS.common.front.common.Global;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.service.StandardService;
import gnnt.MEBS.common.front.service.UserService;
import gnnt.MEBS.common.front.statictools.ApplicationContextInit;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.common.front.statictools.filetools.XMLWork;
import gnnt.MEBS.common.front.vo.CheckUserXML;
import gnnt.MEBS.common.front.vo.LogonXML;
import gnnt.MEBS.logonService.vo.CheckUserResultVO;

@Controller("com_userAction")
@Scope("request")
public class UserAction extends StandardAction {
	private static final long serialVersionUID = 8849362928513184976L;
	@Autowired
	@Qualifier("com_userService")
	private UserService com_userService;
	@Autowired
	@Resource(name = "com_firmStatusMap")
	protected Map<String, String> com_firmStatusMap;
	@Autowired
	@Resource(name = "com_firmTypeMap")
	protected Map<String, String> com_firmTypeMap;

	public StandardService getService() {
		return this.com_userService;
	}

	public Map<String, String> getCom_firmStatusMap() {
		return this.com_firmStatusMap;
	}

	public Map<String, String> getCom_firmTypeMap() {
		return this.com_firmTypeMap;
	}

	public String checkLogon() {
		String result = "";
		try {
			BufferedReader br = new BufferedReader(new InputStreamReader(this.request.getInputStream()));
			String re = br.readLine();
			StringBuffer strXML = new StringBuffer();
			while (re != null) {
				strXML.append(re);
				re = br.readLine();
			}
			String loginxml = strXML.toString();

			this.logger.info("客户端传入：" + loginxml);
			if (loginxml.indexOf("check_user") > 0) {
				result = checkUser(loginxml);
			} else if (loginxml.indexOf("logon") > 0) {
				result = checkLogon(loginxml);
			} else if (loginxml.indexOf("logoff") > 0) {
				result = checkLogoff(loginxml);
			}
			this.logger.info("回复客户端：" + result);
		} catch (Exception e) {
			this.logger.error("调用 checkLogon 方法异常", e);
		}
		try {
			this.response.setContentType("text/html;charset=GBK");
			this.response.getWriter().print(result);
			this.response.getWriter().close();
		} catch (IOException e) {
			this.logger.error("返回登录信息时异常", e);
		}
		return null;
	}

	private String checkLogon(String xml) {
		String userID = null;

		String password = null;

		String key = null;

		String logonType = null;

		int selfModuleID = -1;

		LogonXML x = (LogonXML) XMLWork.reader(LogonXML.class, xml);
		if ((x != null) && (x.req != null) && ("logon".equals(x.req.name))) {
			userID = x.req.userID;
			password = x.req.password;
			key = x.req.key;
			logonType = x.req.logonType;
			selfModuleID = Tools.strToInt(x.req.selfModuleID, Global.getSelfModuleID());
		}
		String code = "0";

		String msg = "";

		TraderLogonInfo traderLogonInfo = null;
		try {
			traderLogonInfo = ActiveUserManager.logon(userID, password, selfModuleID, key, "", this.request.getRemoteAddr(), 0, logonType);
		} catch (Exception e) {
			this.logger.error("执行 checkLogon 登录异常", e);
		}
		if (traderLogonInfo == null) {
			code = "-1";
			msg = "登录失败，请联系管理员";
			return "<?xml version=\"1.0\" encoding=\"GB2312\"?><GNNT><REP name=\"logon\"><RESULT><RETCODE>" + code + "</RETCODE>" + "<MESSAGE>" + msg
					+ "</MESSAGE><MODULE_ID>" + selfModuleID + "</MODULE_ID>"
					+ "<LAST_TIME></LAST_TIME><LAST_IP></LAST_IP><CHG_PWD></CHG_PWD><NAME></NAME><RANDOM_KEY></RANDOM_KEY></RESULT></REP></GNNT>";
		}
		int recode = Tools.strToInt(traderLogonInfo.getRecode(), 1);
		if ((recode == -1) || (recode == -2)) {
			this.logger.debug("用户不存在或密码错误");
			code = "-1";
			msg = "用户不存在或密码错误";
		} else if ((recode == -3) || (recode == -6) || (recode == -7)) {
			this.logger.debug("禁止登录");
			code = "-1";
			msg = "禁止登录";
		} else if (recode == -4) {
			this.logger.debug("Key盘验证错误");
			code = "-1";
			msg = "Key盘验证错误";
		} else if (recode == -5) {
			this.logger.debug("交易板块被禁止");
			code = "-1";
			msg = "交易板块被禁止";
		} else if (recode < 0) {
			this.logger.debug("核心系统返回异常编号[" + recode + "]，错误信息[" + traderLogonInfo.getMessage() + "]");
			code = "-1";
			msg = "登录失败，" + traderLogonInfo.getMessage();
		}
		if (recode > 0) {
			boolean logonSuccess = ActiveUserManager.logon(traderLogonInfo.getTraderId(), this.request, traderLogonInfo.getSessionID(), logonType,
					selfModuleID);
			if (!logonSuccess) {
				this.logger.error("登录时，向 Session 中写入信息失败");
				code = "-1";
				msg = "加载内存失败";
			} else {
				code = traderLogonInfo.getSessionID() + "";
			}
		}
		String result = "<?xml version=\"1.0\" encoding=\"GB2312\"?><GNNT><REP name=\"logon\"><RESULT><RETCODE>" + code + "</RETCODE>" + "<MESSAGE>"
				+ msg + "</MESSAGE><MODULE_ID>" + selfModuleID + "</MODULE_ID>" + "<LAST_TIME>" + traderLogonInfo.getLastTime() + "</LAST_TIME>"
				+ "<LAST_IP>" + traderLogonInfo.getLastIP() + "</LAST_IP>" + "<CHG_PWD>" + (traderLogonInfo.getForceChangePwd() == 1 ? 1 : 2)
				+ "</CHG_PWD>" + "<NAME>" + traderLogonInfo.getTraderName() + "</NAME>" + "<RANDOM_KEY>" + traderLogonInfo.getTrustKey()
				+ "</RANDOM_KEY></RESULT></REP></GNNT>";

		return result;
	}

	private String checkUser(String xml) {
		long sessionID = 0L;

		String userID = null;

		int fromModuleID = 1;

		String fromLogonType = null;

		String selfLogonType = Global.getSelfLogonType();

		int selfModuleID = 1;

		CheckUserXML x = (CheckUserXML) XMLWork.reader(CheckUserXML.class, xml);
		if ((x != null) && (x.req != null) && ("check_user".equals(x.req.name))) {
			sessionID = Tools.strToLong(x.req.sessionID, sessionID);
			userID = x.req.userID;
			fromModuleID = Tools.strToInt(x.req.moduleID);
			fromLogonType = x.req.fromLogonType;
			selfLogonType = x.req.selfLogonType;
			if ((selfLogonType == null) || (selfLogonType.trim().length() <= 0)) {
				selfLogonType = Global.getSelfLogonType();
			}
			selfModuleID = Tools.strToInt(x.req.selfModuleID, Global.getSelfModuleID());
		}
		int code = 0;
		String msg = "";

		CheckUserResultVO au = ActiveUserManager.checkUser(userID, sessionID, fromModuleID, selfLogonType, fromLogonType, selfModuleID);
		if ((au == null) || (au.getResult() == -1)) {
			this.logger.debug("通过 sessionID 到 AU 中未获取到信息");

			addReturnValue(-1, 9930101L);
			code = -1;
			msg = "传入的 SessionID不存在";
		} else if (!au.getUserManageVO().getUserID().equals(userID)) {
			this.request.getSession().invalidate();
			this.logger.debug("通过 sessionID 到 AU 中未获取到信息");

			addReturnValue(-1, 9930103L);
			code = -1;
			msg = "用户信息与 SessionID信息不一致";
		}
		return "<?xml version=\"1.0\" encoding=\"GBK\"?><GNNT><REP name=\"check_user\"><RESULT><RETCODE>" + code + "</RETCODE><MESSAGE>" + msg
				+ "</MESSAGE><MODULE_ID>" + selfModuleID + "</MODULE_ID></RESULT></REP></GNNT>";
	}

	private String checkLogoff(String xml) {
		String code = "0";
		String msg = "";
		try {
			ActiveUserManager.logoff(this.request);
		} catch (Exception e) {
			code = "-1";
			msg = "系统处理失败";
			this.logger.error("退出用户登录 checkLogoff 异常", e);
		}
		return "<?xml version=\"1.0\" encoding = \"GB2312\"?><GNNT><REQ name=\"logoff\"><RESULT><RETCODE>" + code + "</RETCODE><MESSAGE>" + msg
				+ "</MESSAGE></RESULT></REQ></GNNT>";
	}

	public String logon() throws Exception {
		User user = (User) this.entity;

		int userIdType = Tools.strToInt(this.request.getParameter("userIdType"), 0);
		this.request.setAttribute("userIdType", Integer.valueOf(userIdType));

		String randomicitynum = (String) this.request.getSession().getAttribute("RANDOMICITYNUM");

		String imgcode = null;
		String password = null;
		if (userIdType == 1) {
			imgcode = this.request.getParameter("uimgcode");
			password = this.request.getParameter("upassword");
		} else {
			imgcode = this.request.getParameter("timgcode");
			password = this.request.getParameter("tpassword");
		}
		if ((randomicitynum == null) || (randomicitynum.trim().length() < 0)) {
			this.logger.debug("系统生成的验证码为空值");

			addReturnValue(-1, 9930103L);
			return "error";
		}
		if ((imgcode == null) || (imgcode.trim().length() < 0)) {
			this.logger.debug("用户传入验证码为空值");
			if (userIdType == 1) {
				this.request.setAttribute("userID", user.getUserID());
				this.request.setAttribute("upassword", password);
			} else {
				this.request.setAttribute("traderID", user.getTraderID());
				this.request.setAttribute("tpassword", password);
			}
			addReturnValue(-1, 9930102L);
			return "error";
		}
		if (!imgcode.equalsIgnoreCase(randomicitynum)) {
			this.logger.debug("用户输入验证码[" + imgcode + "]与系统验生成的证码[" + randomicitynum + "]不一致");
			if (userIdType == 1) {
				this.request.setAttribute("userID", user.getUserID());
				this.request.setAttribute("upassword", password);
			} else {
				this.request.setAttribute("traderID", user.getTraderID());
				this.request.setAttribute("tpassword", password);
			}
			addReturnValue(-1, 9930103L);
			return "error";
		}
		TraderLogonInfo traderLogonInfo = null;

		String logonType = this.request.getParameter("LogonType");
		if ((logonType == null) || (logonType.trim().length() <= 0)) {
			logonType = Global.getSelfLogonType();
		}
		int selfModuleID = Tools.strToInt(this.request.getParameter("ModuleID"), Global.getSelfModuleID());
		if (userIdType == 1) {
			traderLogonInfo = ActiveUserManager.logon(user.getUserID(), password, selfModuleID, user.getKeyCode(), user.getTrustKey(),
					this.request.getRemoteAddr(), 1, logonType);
		} else {
			traderLogonInfo = ActiveUserManager.logon(user.getTraderID(), password, selfModuleID, user.getKeyCode(), user.getTrustKey(),
					this.request.getRemoteAddr(), 0, logonType);
		}
		if (traderLogonInfo == null) {
			this.logger.debug("调用核心系统用户登录，核心返回信息异常");

			addReturnValue(-1, 9930111L);
			return "error";
		}
		int recode = Tools.strToInt(traderLogonInfo.getRecode(), 1);
		if ((recode == -1) || (recode == -2)) {
			this.logger.debug("用户不存在或密码错误");
			addReturnValue(-1, 9930118L);
		} else if ((recode == -3) || (recode == -6) || (recode == -7)) {
			this.logger.debug("禁止登录");

			addReturnValue(-1, 9930114L);
		} else if (recode == -4) {
			this.logger.debug("Key盘验证错误");

			addReturnValue(-1, 9930115L);
		} else if (recode == -5) {
			this.logger.debug("交易板块被禁止");

			addReturnValue(-1, 9930116L);
		} else if (recode < 0) {
			this.logger.debug("核心系统返回异常编号[" + recode + "]返回信息[" + traderLogonInfo.getMessage() + "]");

			addReturnValue(-1, 9930117L, new Object[] { traderLogonInfo.getMessage() });
		}
		if (recode < 0) {
			return "error";
		}
		boolean logonSuccess = ActiveUserManager.logon(traderLogonInfo.getTraderId(), this.request, traderLogonInfo.getSessionID(), logonType,
				selfModuleID);
		if (!logonSuccess) {
			this.logger.error("登录时，向 Session 中写入信息失败");

			addReturnValue(-1, 9930111L);
			return "error";
		}
		user = (User) this.request.getSession().getAttribute("CurrentUser");

		String preUrl = this.request.getParameter("preUrl");
		this.logger.debug("preUrl:    " + preUrl);
		if ((preUrl != null) && (preUrl.trim().length() > 0) && (!preUrl.trim().equalsIgnoreCase("null"))) {
			if (preUrl.indexOf("?") > 0) {
				if (preUrl.indexOf("sessionID") < 0) {
					preUrl = preUrl + "&sessionID=" + user.getSessionId();
				} else {
					String[] pred = preUrl.split("[?]|&");
					String newPreUrl = pred[0];
					for (int i = 1; i < pred.length; i++) {
						if (newPreUrl.indexOf("?") > 0) {
							newPreUrl = newPreUrl + "&";
						} else {
							newPreUrl = newPreUrl + "?";
						}
						if (pred[i].startsWith("sessionID=")) {
							newPreUrl = newPreUrl + "sessionID=" + user.getSessionId();
						} else {
							newPreUrl = newPreUrl + pred[i];
						}
					}
					preUrl = newPreUrl;
				}
			} else {
				preUrl = preUrl + "?sessionID=" + user.getSessionId();
			}
			this.request.setAttribute("preUrl", preUrl);
		}
		addReturnValue(1, 9910101L);
		return "success";
	}

	public String updatePasswordSelfSave() {
		this.logger.debug("enter passwordSelfSave");
		String oldPassword = this.request.getParameter("oldPassword");
		User user = (User) this.entity;
		if (user != null) {
			int result = ActiveUserManager.changePassowrd(user.getTraderID(), oldPassword, user.getPassword(), this.request.getRemoteAddr());
			if (result != 1) {
				addReturnValue(-1, 9930201L);
				writeOperateLog(9901, "交易商" + user.getTraderID() + "修改登录密码", 0, ApplicationContextInit.getErrorInfo("-1005"));

				this.request.setAttribute("user", user);
				this.request.setAttribute("oldPassword", oldPassword);
				return "success";
			}
			addReturnValue(1, 9910201L);
			writeOperateLog(9901, "交易商" + user.getTraderID() + "修改登录密码", 1, "");
		}
		this.request.setAttribute("user", user);
		this.request.setAttribute("oldPassword", oldPassword);
		return "success";
	}

	public String logout() throws Exception {
		ActiveUserManager.logoff(this.request);
		return "success";
	}

	public String saveShinStyle() {
		this.logger.debug("enter modShinStyle");

		User currentUser = (User) this.request.getSession().getAttribute("CurrentUser");
		User user = (User) this.entity;
		currentUser.setSkin(user.getSkin());
		getService().update(user);

		addReturnValue(1, 9910301L);
		writeOperateLog(9901, "交易商" + user.getTraderID() + "修改风格", 1, "");
		return "success";
	}
}

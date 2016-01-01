package gnnt.MEBS.bank.front.action;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.rmi.RemoteException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.bank.front.core.BankCoreCode;
import gnnt.MEBS.bank.front.model.Bank;
import gnnt.MEBS.bank.front.model.CapitalInfo;
import gnnt.MEBS.bank.front.model.FirmIDAndAccount;
import gnnt.MEBS.bank.front.model.FirmUser;
import gnnt.MEBS.bank.front.statictools.Util;
import gnnt.MEBS.common.front.action.StandardAction;
import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.model.StandardModel;
import gnnt.MEBS.common.front.model.integrated.MFirm;
import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.common.front.statictools.ActionUtil;
import gnnt.MEBS.common.front.statictools.ApplicationContextInit;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.trade.bank.processorrmi.CapitalProcessorRMI;
import gnnt.trade.bank.util.ErrorCode;
import gnnt.trade.bank.util.MD5orSHA;
import gnnt.trade.bank.util.Tool;
import gnnt.trade.bank.vo.CitysValue;
import gnnt.trade.bank.vo.CorrespondValue;
import gnnt.trade.bank.vo.FirmBalanceValue;
import gnnt.trade.bank.vo.ReturnValue;

@Controller("moneyAction")
@Scope("request")
public class MoneyAction extends StandardAction {
	private static final long serialVersionUID = -8408589201557981299L;
	@Resource(name = "capitalInfoType")
	private Map<Integer, String> capitalInfoType;
	@Resource(name = "capitalInfoStatus")
	private Map<Integer, String> capitalInfoStatus;
	@Autowired
	@Qualifier("capitalProcessorRMI")
	private CapitalProcessorRMI capitalProcessorRMI;

	public Map<Integer, String> getCapitalInfoType() {
		return this.capitalInfoType;
	}

	public Map<Integer, String> getCapitalInfoStatus() {
		return this.capitalInfoStatus;
	}

	public String gotoChangePasswordPage() {
		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		long isFirstChangePassword = 0L;
		try {
			isFirstChangePassword = this.capitalProcessorRMI.isPassword(user.getBelongtoFirm().getFirmID(), "");
		} catch (Exception e) {
			this.logger.error("跳转到修改页码页面时，连接处理器异常", e);

			addReturnValue(-1, 2830201L);
		}
		if (isFirstChangePassword == 1L) {
			this.request.setAttribute("isFirstChangePassword", Boolean.valueOf(true));
		} else {
			this.request.setAttribute("isFirstChangePassword", Boolean.valueOf(false));
		}
		return "success";
	}

	public String changePassword() {
		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		String oldpwd = this.request.getParameter("oldpwd");
		String newpwd = this.request.getParameter("newpwd");
		long isFirstChangePassword = -1L;
		try {
			isFirstChangePassword = this.capitalProcessorRMI.isPassword(user.getBelongtoFirm().getFirmID(), oldpwd);
		} catch (Exception e) {
			this.logger.error("验证旧密码异常", e);

			addReturnValue(-1, 2830204L);
			return "success";
		}
		if (isFirstChangePassword < 0L) {
			if (isFirstChangePassword == -1L) {
				addReturnValue(-1, 9930092L, new Object[] { "原密码错误" });
			} else if (isFirstChangePassword == -2L) {
				addReturnValue(-1, 9930092L, new Object[] { "为查询到您的信息" });
			} else {
				addReturnValue(-1, 9930092L, new Object[] { BankCoreCode.getCode(isFirstChangePassword) });
			}
			return "success";
		}
		try {
			long flag2 = this.capitalProcessorRMI.modPwd(user.getBelongtoFirm().getFirmID(), oldpwd, newpwd);
			if (flag2 < 0L) {
				addReturnValue(-1, 9930092L, new Object[] { BankCoreCode.getCode(flag2) });
			} else {
				addReturnValue(1, 2810201L);
			}
		} catch (Exception e) {
			this.logger.error("修改密码异常", e);

			addReturnValue(-1, 2830203L);
		}
		return "success";
	}

	public String gotoMoneyPage() {
		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		QueryConditions qc = new QueryConditions();
		qc.addCondition("firm.firmID", "=", user.getBelongtoFirm().getFirmID());
		qc.addCondition("bank.validflag", "=", Integer.valueOf(0));
		qc.addCondition("status", "=", Integer.valueOf(0));
		qc.addCondition("isOpen", "=", Integer.valueOf(1));
		PageRequest<QueryConditions> pageRequest = new PageRequest(1, 100, qc, " order by bank.bankID ");
		Page<StandardModel> page = getService().getPage(pageRequest, new FirmIDAndAccount());
		this.request.setAttribute("pageInfo", page);

		boolean isCheckMarketPassword = Tools.strToBoolean(ApplicationContextInit.getConfig("isCheckMarketPassword"));
		this.request.setAttribute("isCheckMarketPassword", Boolean.valueOf(isCheckMarketPassword));

		String inMoneyNeedPasswordBankID = ApplicationContextInit.getConfig("inMoneyNeedPasswordBankID");
		this.request.setAttribute("inMoneyNeedPasswordBankID", inMoneyNeedPasswordBankID);

		String outMoneyNeedPasswordBankID = ApplicationContextInit.getConfig("outMoneyNeedPasswordBankID");
		this.request.setAttribute("outMoneyNeedPasswordBankID", outMoneyNeedPasswordBankID);

		return "success";
	}

	public String moneyTransfer() {
		String bankID = this.request.getParameter("bankID");
		String InOutStart = this.request.getParameter("InOutStart");
		String PersonName = this.request.getParameter("PersonName");
		String bankName = this.request.getParameter("BankName");
		String AmoutDate = this.request.getParameter("AmoutDate");
		String OutAccount = this.request.getParameter("OutAccount");
		if ((bankID == null) || (bankID.trim().length() <= 0)) {
			addReturnValue(-1, 2830101L);
			return "success";
		}
		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		FirmIDAndAccount ffirmIDAndAccount = new FirmIDAndAccount();
		Bank bank = new Bank();
		bank.setBankID(bankID);
		bank = (Bank) getService().get(bank);
		ffirmIDAndAccount.setBank(bank);
		ffirmIDAndAccount.setFirm(user.getBelongtoFirm());
		FirmIDAndAccount firmIDAndAccount = (FirmIDAndAccount) getService().get(ffirmIDAndAccount);
		firmIDAndAccount.setBank(bank);
		if (firmIDAndAccount == null) {
			addReturnValue(-1, 2830104L, new Object[] { bankID });
			return "success";
		}
		if (firmIDAndAccount.getIsOpen().intValue() != 1) {
			addReturnValue(-1, 2830105L, new Object[] { bankID });
			return "success";
		}
		if (firmIDAndAccount.getStatus().intValue() != 0) {
			addReturnValue(-1, 2830106L, new Object[] { bankID });
			return "success";
		}
		if (firmIDAndAccount.getBank().getValidflag().intValue() != 0) {
			addReturnValue(-1, 2830107L, new Object[] { bankID });
			return "success";
		}
		double money = Tools.strToDouble(this.request.getParameter("money"), -1000.0D);
		if (money <= 0.0D) {
			addReturnValue(-1, 2830102L);
			return "success";
		}
		int express = Tools.strToInt(this.request.getParameter("express"), 0);
		String password = this.request.getParameter("password");

		String inoutMoney = this.request.getParameter("inoutMoney");
		if ("0".equals(inoutMoney)) {
			return inMoney(firmIDAndAccount, money, express, password, InOutStart, PersonName, AmoutDate, bankName, OutAccount);
		}
		if ("1".equals(inoutMoney)) {
			return outMoney(firmIDAndAccount, money, express, password);
		}
		addReturnValue(-1, 2830103L);
		return "success";
	}

	private String inMoney(FirmIDAndAccount firmIDAndAccount, double money, int express, String password, String InOutStart, String PersonName,
			String AmoutDate, String bankName, String OutAccount) {
		boolean isCheckMarketPassword = Tools.strToBoolean(ApplicationContextInit.getConfig("isCheckMarketPassword"));
		String pb = ApplicationContextInit.getConfig("inMoneyNeedPasswordBankID");
		long result = 0L;
		if ((!getNeedPasswordBankID(pb, firmIDAndAccount.getBank().getBankID())) && (isCheckMarketPassword)) {
			try {
				result = this.capitalProcessorRMI.isPassword(firmIDAndAccount.getFirm().getFirmID(), password);
			} catch (Exception e) {
				this.logger.error("入金验证密码时异常", e);

				addReturnValue(-1, 2830108L);
				return "success";
			}
		}
		if (result == 1L) {
			addReturnValue(-1, 2830109L);
			return "success";
		}
		if (result != 0L) {
			if (result == -1L) {
				addReturnValue(-1, 9930092L, new Object[] { "密码错误" });
			} else if (result == -2L) {
				addReturnValue(-1, 9930092L, new Object[] { "为查询到您的信息" });
			} else {
				addReturnValue(-1, 9930092L, new Object[] { BankCoreCode.getCode(result) });
			}
			return "success";
		}
		try {
			this.logger.info("入金--银行：" + firmIDAndAccount.getBank().getBankID());
			this.logger.info("入金--：" + InOutStart + "付款人：" + PersonName + "日期：" + AmoutDate + "付款银行：" + bankName + "帐号：" + OutAccount);
			if (firmIDAndAccount.getBank().getBankID().equals("66")) {
				result = this.capitalProcessorRMI.inMoneyMarketGS(firmIDAndAccount.getBank().getBankID(), firmIDAndAccount.getFirm().getFirmID(),
						firmIDAndAccount.getAccount(), password, money, "market_in");
			}
			if (firmIDAndAccount.getBank().getBankID().equals("17")) {
				result = this.capitalProcessorRMI.inMoneyMarket(firmIDAndAccount.getBank().getBankID(), firmIDAndAccount.getFirm().getFirmID(),
						firmIDAndAccount.getAccount(), password, money, "market_in", InOutStart, PersonName, AmoutDate, bankName, OutAccount);
			} else {
				result = this.capitalProcessorRMI.inMoneyMarket(firmIDAndAccount.getBank().getBankID(), firmIDAndAccount.getFirm().getFirmID(),
						firmIDAndAccount.getAccount(), password, money, "market_in");
			}
		} catch (Exception e) {
			this.logger.error("执行入金时异常", e);

			addReturnValue(-1, 2830111L);
			return "success";
		}
		if (result >= 0L) {
			addReturnValue(1, 2810101L);
			return "success";
		}
		addReturnValue(-1, 9930092L, new Object[] { BankCoreCode.getCode(result) });
		return "success";
	}

	private String outMoney(FirmIDAndAccount firmIDAndAccount, double money, int express, String password) {
		boolean isCheckMarketPassword = Tools.strToBoolean(ApplicationContextInit.getConfig("isCheckMarketPassword"));
		String pb = ApplicationContextInit.getConfig("outMoneyNeedPasswordBankID");
		long result = 0L;
		if ((!getNeedPasswordBankID(pb, firmIDAndAccount.getBank().getBankID())) && (isCheckMarketPassword)) {
			try {
				result = this.capitalProcessorRMI.isPassword(firmIDAndAccount.getFirm().getFirmID(), password);
			} catch (Exception e) {
				this.logger.error("出金验证密码时异常", e);

				addReturnValue(-1, 2830108L);
				return "success";
			}
		}
		if (result == 1L) {
			addReturnValue(-1, 2830109L);
			return "success";
		}
		if (result != 0L) {
			if (result == -1L) {
				addReturnValue(-1, 9930092L, new Object[] { "密码错误" });
			} else if (result == -2L) {
				addReturnValue(-1, 9930092L, new Object[] { "为查询到您的信息" });
			} else {
				addReturnValue(-1, 9930092L, new Object[] { BankCoreCode.getCode(result) });
			}
			return "success";
		}
		boolean isAudit = true;
		Double maxAuditMoney = firmIDAndAccount.getBank().getMaxAuditMoney();
		FirmUser firmUser = new FirmUser();
		firmUser.setFirm(firmIDAndAccount.getFirm());
		firmUser.setFirmID(firmIDAndAccount.getFirm().getFirmID());
		firmUser = (FirmUser) getService().get(firmUser);
		if ((firmUser.getMaxAuditMoney() != null) && (firmUser.getMaxAuditMoney().doubleValue() > 0.0D)) {
			maxAuditMoney = firmUser.getMaxAuditMoney();
		}
		if ((maxAuditMoney != null) && (money <= maxAuditMoney.doubleValue())) {
			isAudit = false;
		}
		try {
			ReturnValue rv = this.capitalProcessorRMI.outMoney(firmIDAndAccount.getBank().getBankID(), money, firmIDAndAccount.getFirm().getFirmID(),
					firmIDAndAccount.getAccount(), null, "market_out", express, 0);
			if (rv.result < 0L) {
				if (rv.result == -30006L) {
					addReturnValue(1, 2810103L);
				} else if ((rv.remark != null) && (rv.remark.trim().length() > 0)) {
					addReturnValue(-1, 9930092L, new Object[] { rv.remark });
				} else {
					addReturnValue(-1, 9930092L, new Object[] { BankCoreCode.getCode(rv.result) });
				}
			} else if (!isAudit) {
				addReturnValue(1, 2810102L);
			} else {
				addReturnValue(1, 2810103L);
			}
		} catch (Exception e) {
			this.logger.error("执行入金时异常", e);

			addReturnValue(-1, 2830113L);
		}
		return "success";
	}

	public String gotoQueryMoneyPage() {
		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		QueryConditions qc = new QueryConditions();
		qc.addCondition("firm.firmID", "=", user.getBelongtoFirm().getFirmID());
		qc.addCondition("bank.validflag", "=", Integer.valueOf(0));
		qc.addCondition("status", "=", Integer.valueOf(0));
		qc.addCondition("isOpen", "=", Integer.valueOf(1));
		PageRequest<QueryConditions> pageRequest = new PageRequest(1, 100, qc, " order by bank.bankID ");
		Page<StandardModel> page = getService().getPage(pageRequest, new FirmIDAndAccount());
		this.request.setAttribute("pageInfo", page);

		boolean isCheckMarketPassword = Tools.strToBoolean(ApplicationContextInit.getConfig("isCheckMarketPassword"));
		this.request.setAttribute("isCheckMarketPassword", Boolean.valueOf(isCheckMarketPassword));

		String queryMoneyNeedPasswordBankID = ApplicationContextInit.getConfig("queryMoneyNeedPasswordBankID");
		this.request.setAttribute("queryMoneyNeedPasswordBankID", queryMoneyNeedPasswordBankID);

		return "success";
	}

	public String queryMoney() {
		String bankID = this.request.getParameter("bankID");
		if ((bankID == null) || (bankID.trim().length() <= 0)) {
			addReturnValue(-1, 2830101L);
			return "success";
		}
		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		FirmIDAndAccount firmIDAndAccount = new FirmIDAndAccount();
		Bank bank = new Bank();
		bank.setBankID(bankID);
		bank = (Bank) getService().get(bank);
		firmIDAndAccount.setBank(bank);
		firmIDAndAccount.setFirm(user.getBelongtoFirm());
		firmIDAndAccount = (FirmIDAndAccount) getService().get(firmIDAndAccount);
		if (firmIDAndAccount == null) {
			addReturnValue(-1, 2830104L, new Object[] { bankID });
			return "success";
		}
		if (firmIDAndAccount.getIsOpen().intValue() != 1) {
			addReturnValue(-1, 2830105L, new Object[] { bankID });
			return "success";
		}
		if (firmIDAndAccount.getStatus().intValue() != 0) {
			addReturnValue(-1, 2830106L, new Object[] { bankID });
			return "success";
		}
		if (firmIDAndAccount.getBank().getValidflag().intValue() != 0) {
			addReturnValue(-1, 2830107L, new Object[] { bankID });
			return "success";
		}
		boolean isCheckMarketPassword = Tools.strToBoolean(ApplicationContextInit.getConfig("isCheckMarketPassword"));
		String pb = ApplicationContextInit.getConfig("queryMoneyNeedPasswordBankID");
		String password = this.request.getParameter("password");
		long result = 0L;
		if ((!getNeedPasswordBankID(pb, firmIDAndAccount.getBank().getBankID())) && (isCheckMarketPassword)) {
			try {
				result = this.capitalProcessorRMI.isPassword(firmIDAndAccount.getFirm().getFirmID(), password);
			} catch (Exception e) {
				this.logger.error("查询 余额验证密码时异常", e);

				addReturnValue(-1, 2830108L);
				return "success";
			}
		}
		if (result == 1L) {
			addReturnValue(-1, 2830109L);
			return "success";
		}
		if (result != 0L) {
			if (result == -1L) {
				addReturnValue(-1, 9930092L, new Object[] { "密码错误" });
			} else if (result == -2L) {
				addReturnValue(-1, 9930092L, new Object[] { "为查询到您的信息" });
			} else {
				addReturnValue(-1, 9930092L, new Object[] { BankCoreCode.getCode(result) });
			}
			return "success";
		}
		try {
			FirmBalanceValue fv = this.capitalProcessorRMI.getFirmBalance(bankID, firmIDAndAccount.getFirm().getFirmID(), password);
			this.request.setAttribute("bank", bank);
			this.request.setAttribute("marketBalance", Double.valueOf(fv.marketBalance));
			this.request.setAttribute("frozenBalance", Double.valueOf(fv.frozenBalance));
			this.request.setAttribute("avilableBalance", Double.valueOf(fv.avilableBalance));
			this.request.setAttribute("bankAccount", fv.bankAccount);
			this.request.setAttribute("bankBalance", Double.valueOf(fv.bankBalance));
		} catch (Exception e) {
			this.logger.error("查询余额时异常", e);
			addReturnValue(-1, 2830301L);
		}
		return "success";
	}

	private boolean getNeedPasswordBankID(String pb, String bankID) {
		if ((pb == null) || (pb.trim().length() <= 0)) {
			return false;
		}
		if (pb.trim().equalsIgnoreCase(bankID)) {
			return true;
		}
		if (pb.contains("," + bankID + ",")) {
			return true;
		}
		if (pb.startsWith(bankID + ",")) {
			return true;
		}
		if (pb.endsWith("," + bankID)) {
			return true;
		}
		return false;
	}

	public String getCapitalInfoList() throws Exception {
		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		QueryConditions qc = new QueryConditions();
		qc.addCondition("firm.firmID", "=", user.getBelongtoFirm().getFirmID());

		qc.addCondition("isOpen", "=", Integer.valueOf(1));
		PageRequest<QueryConditions> pageRequest = new PageRequest(1, 100, qc, " order by bank.bankID ");
		Page<StandardModel> page = getService().getPage(pageRequest, new FirmIDAndAccount());
		this.request.setAttribute("firmIDAndAccountList", page);

		PageRequest<QueryConditions> pageRequestc = ActionUtil.getPageRequest(this.request);
		QueryConditions qcc = (QueryConditions) pageRequestc.getFilters();
		qcc.addCondition("firm.firmID", "=", user.getBelongtoFirm().getFirmID());
		Page<StandardModel> pagec = getService().getPage(pageRequestc, new CapitalInfo());
		this.request.setAttribute("pageInfo", pagec);

		this.request.setAttribute("oldParams", ActionUtil.getParametersStartingWith(this.request, "gnnt_"));
		return "success";
	}

	public String gotoRgstDelFirmInfoPage() {
		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		QueryConditions qc = new QueryConditions();
		qc.addCondition("firm.firmID", "=", user.getBelongtoFirm().getFirmID());
		qc.addCondition("bank.validflag", "=", Integer.valueOf(0));

		PageRequest<QueryConditions> pageRequest = new PageRequest(1, 100, qc, " order by bank.bankID ");
		Page<StandardModel> page = getService().getPage(pageRequest, new FirmIDAndAccount());
		this.request.setAttribute("pageInfo", page);

		boolean isCheckMarketPassword = Tools.strToBoolean(ApplicationContextInit.getConfig("isCheckMarketPassword"));
		this.request.setAttribute("isCheckMarketPassword", Boolean.valueOf(isCheckMarketPassword));

		String rgstAccountNeedPasswordBankID = ApplicationContextInit.getConfig("rgstAccountNeedPasswordBankID");
		this.request.setAttribute("rgstAccountNeedPasswordBankID", rgstAccountNeedPasswordBankID);

		String delAccountNeedPasswordBankID = ApplicationContextInit.getConfig("delAccountNeedPasswordBankID");
		this.request.setAttribute("delAccountNeedPasswordBankID", delAccountNeedPasswordBankID);

		return "success";
	}

	public String gotoHXCrossFirmInfoPage() {
		this.logger.info("华夏他行签约");
		User user = (User) this.request.getSession().getAttribute("CurrentUser");

		String bankID = this.request.getParameter("bankID");
		QueryConditions qc = new QueryConditions();
		qc.addCondition("firm.firmID", "=", user.getBelongtoFirm().getFirmID());
		qc.addCondition("bank.validflag", "=", Integer.valueOf(0));

		PageRequest<QueryConditions> pageRequest = new PageRequest(1, 100, qc, " order by bank.bankID ");
		Page<StandardModel> page = getService().getPage(pageRequest, new FirmIDAndAccount());
		this.request.setAttribute("pageInfo", page);

		List<StandardModel> firm = getService().getListBySql(
				"select * from F_b_firmIDAndAccount where firmID ='" + user.getBelongtoFirm().getFirmID() + "'", new FirmIDAndAccount());
		this.request.setAttribute("firmIDAndAccount", firm.get(0));

		String filterForGetCitys = "where parentID='0'";
		Vector<CitysValue> citysValue = null;
		try {
			citysValue = this.capitalProcessorRMI.getCitysValue(filterForGetCitys);
		} catch (RemoteException e) {
			e.printStackTrace();
		}
		this.request.setAttribute("cityValues", citysValue);

		return "success";
	}

	public String synchroRegist() {
		String firmID = this.request.getParameter("firmID");
		if ((firmID == null) || (firmID.trim().length() <= 0)) {
			addReturnValue(-1, 133301L);
			return "success";
		}
		String bankID = this.request.getParameter("bankID");
		if ((bankID == null) || (bankID.trim().length() <= 0)) {
			addReturnValue(-1, 133302L);
			return "success";
		}
		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		gnnt.MEBS.bank.front.model.Log log = new gnnt.MEBS.bank.front.model.Log();
		log.setLogDate(new Date());
		log.setLogIP(user.getIpAddress());
		log.setLogopr(user.getUserID());

		String success = "";
		String error = "";

		FirmIDAndAccount firmIDAndAccount = (FirmIDAndAccount) getFirmIDAndAccount(firmID, bankID).clone();
		CorrespondValue cv = firmIDAndAccount.getCorrespondValue();
		cv.status = 0;
		cv.isOpen = 0;
		try {
			if (!Util.isContentsBank(ApplicationContextInit.getConfig("marketPerformSynchroAccount"), bankID)) {
				log.setLogcontent("同步交易商 " + firmID + " 在银行 " + bankID + " 帐号，失败。本银行不允许交易所发起同步");
				getService().add(log);
				this.logger.debug("同步交易商 " + firmID + " 在银行 " + bankID + " 帐号，失败。本银行不允许交易所发起同步");
				if (error.trim().length() > 0) {
					error = error + ",";
				}
				error = error + bankID;
			}
			ReturnValue result = this.capitalProcessorRMI.synchroAccountMarket(cv);
			if (result.result == 0L) {
				log.setLogcontent("同步交易商 " + firmID + " 在银行 " + bankID + " 帐号，成功。");
				getService().add(log);
				if (success.trim().length() > 0) {
					success = success + ",";
				}
				success = success + bankID;
			} else {
				log.setLogcontent("同步交易商 " + firmID + " 在银行 " + bankID + " 帐号，失败。" + BankCoreCode.getCode(result.result));
				getService().add(log);
				this.logger.debug("同步交易商 " + firmID + " 在银行 " + bankID + " 帐号，" + BankCoreCode.getCode(result.result));
				if (error.trim().length() > 0) {
					error = error + ",";
				}
				error = error + "银行" + bankID + "：" + BankCoreCode.getCode(result.result);
			}
		} catch (Exception e) {
			log.setLogcontent("同步交易商 " + firmID + " 在银行 " + bankID + " 帐号，发生异常");
			getService().add(log);
			if (error.trim().length() > 0) {
				error = error + ",";
			}
			error = error + "银行" + bankID + "：异常";
			this.logger.error("同步交易商 " + firmID + " 在银行 " + bankID + " 帐号异常", e);
		}
		String msg = "同步交易商 " + firmID + " 银行帐号";
		if (success.length() > 0) {
			msg = msg + "," + success + " 成功";
		}
		if (error.length() > 0) {
			msg = msg + "," + error;
		}
		addReturnValue(1, 130000L, new Object[] { msg });

		return "success";
	}

	public String gotoRgstHX() {
		String firmID = this.request.getParameter("firmID");
		if ((firmID == null) || (firmID.trim().length() <= 0)) {
			addReturnValue(-1, 133301L);
			return "success";
		}
		String bankID = this.request.getParameter("bankID");
		if ((bankID == null) || (bankID.trim().length() <= 0)) {
			addReturnValue(-1, 133302L);
			return "success";
		}
		String accountName1 = this.request.getParameter("accountName1").trim();
		String RelatingAcct = this.request.getParameter("RelatingAcct").trim();
		String RelatingAcctName = this.request.getParameter("RelatingAcctName").trim();
		String RelatingAcctBank = this.request.getParameter("RelatingAcctBank").trim();
		String RelatingAcctBankAddr = this.request.getParameter("RelatingAcctBankAddr").trim();
		String RelatingAcctBankCode = this.request.getParameter("RelatingAcctBankCode").trim();
		String PersonName = this.request.getParameter("PersonName").trim();
		String OfficeTel = this.request.getParameter("OfficeTel").trim();
		String MobileTel = this.request.getParameter("MobileTel").trim();
		String Addr = this.request.getParameter("Addr").trim();
		String LawName = this.request.getParameter("LawName").trim();

		String NoteFlag = this.request.getParameter("NoteFlag").trim();
		String NotePhone = this.request.getParameter("NotePhone").trim();
		String eMail = this.request.getParameter("eMail").trim();
		String zipCode = this.request.getParameter("ZipCode").trim();
		String checkFlag = this.request.getParameter("CheckFlag").trim();

		Vector<CorrespondValue> corrList = null;
		try {
			corrList = this.capitalProcessorRMI.getCorrespondValue(" where firmID ='" + firmID + "'");
		} catch (RemoteException e) {
			e.printStackTrace();
		}
		CorrespondValue corr = new CorrespondValue();
		corr.bankID = bankID;
		corr.firmID = firmID;
		corr.account = RelatingAcct;
		corr.accountName = RelatingAcctName;
		corr.accountName1 = accountName1;
		corr.bankName = RelatingAcctBank;
		corr.bankCity = RelatingAcctBankAddr;
		corr.mobile = OfficeTel;
		corr.status = 0;
		corr.isOpen = 1;
		corr.cardType = ((CorrespondValue) corrList.get(0)).cardType;
		corr.card = ((CorrespondValue) corrList.get(0)).card;
		corr.OpenBankCode = RelatingAcctBankCode;
		corr.Phone = MobileTel;
		corr.Linkman = PersonName;
		corr.addr = Addr;
		corr.LawName = LawName;
		corr.NoteFlag = NoteFlag;
		corr.NotePhone = NotePhone;
		corr.email = eMail;
		corr.zipCode = zipCode;
		corr.checkFlag = checkFlag;

		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		gnnt.MEBS.bank.front.model.Log log = new gnnt.MEBS.bank.front.model.Log();
		log.setLogDate(new Date());
		log.setLogIP(user.getIpAddress());
		log.setLogopr(user.getUserID());

		String success = "";
		String error = "";
		try {
			ReturnValue result = this.capitalProcessorRMI.openAccountMarket(corr);
			if (result.result == 0L) {
				log.setLogcontent("交易商 " + firmID + " 在银行 " + bankID + " 帐号，他行签约成功。");
				getService().add(log);
				if (success.trim().length() > 0) {
					success = success + ",";
				}
				success = success + bankID;
			} else {
				log.setLogcontent("交易商 " + firmID + " 在银行 " + bankID + " 帐号，他行签约失败。" + BankCoreCode.getCode(result.result));
				getService().add(log);
				this.logger.debug("交易商 " + firmID + " 在银行 " + bankID + " 帐号，" + BankCoreCode.getCode(result.result));
				if (error.trim().length() > 0) {
					error = error + ",";
				}
				error = error + "银行" + bankID + "：" + BankCoreCode.getCode(result.result);
			}
		} catch (Exception e) {
			log.setLogcontent("交易商 " + firmID + " 在银行 " + bankID + " 帐号，发生异常");
			getService().add(log);
			if (error.trim().length() > 0) {
				error = error + ",";
			}
			error = error + "银行" + bankID + "：异常";
			this.logger.error("交易商 " + firmID + " 在银行 " + bankID + " 帐号异常", e);
		}
		String msg = "交易商 " + firmID + " 银行帐号";
		if (success.length() > 0) {
			msg = msg + "," + success + " 成功";
		}
		if (error.length() > 0) {
			msg = msg + "," + error;
		}
		addReturnValue(1, 130000L, new Object[] { msg });

		return "success";
	}

	public String openRegist() {
		String firmID = this.request.getParameter("firmID");
		if ((firmID == null) || (firmID.trim().length() <= 0)) {
			addReturnValue(-1, 133301L);
			return "success";
		}
		String bankID = this.request.getParameter("bankID");
		if ((bankID == null) || (bankID.trim().length() <= 0)) {
			addReturnValue(-1, 133302L);
			return "success";
		}
		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		gnnt.MEBS.bank.front.model.Log log = new gnnt.MEBS.bank.front.model.Log();
		log.setLogDate(new Date());
		log.setLogIP(user.getIpAddress());
		log.setLogopr(user.getUserID());

		String pwd = this.request.getParameter("password");
		String success = "";
		String error = "";

		FirmIDAndAccount firmIDAndAccount = (FirmIDAndAccount) getFirmIDAndAccount(firmID, bankID).clone();
		CorrespondValue cv = firmIDAndAccount.getCorrespondValue();
		cv.status = 0;
		cv.isOpen = 0;
		cv.bankCardPassword = pwd;
		try {
			if (!Util.isContentsBank(ApplicationContextInit.getConfig("marketPerformOpenAccount"), bankID)) {
				log.setLogcontent("签约交易商 " + firmID + " 在银行 " + bankID + " 代码，失败。本银行不允许交易所发起签约");
				getService().add(log);
				this.logger.debug("签约交易商 " + firmID + " 在银行 " + bankID + " 代码，失败。本银行不允许交易所发起签约");
				if (error.trim().length() > 0) {
					error = error + ",";
				}
				error = error + bankID;
			}
			ReturnValue result = this.capitalProcessorRMI.openAccountMarket(cv);
			if (result.result == 0L) {
				log.setLogcontent("签约交易商 " + firmID + " 在银行 " + bankID + " 代码，成功");
				getService().add(log);
				if (success.trim().length() > 0) {
					success = success + ",";
				}
				success = success + bankID;
			} else {
				log.setLogcontent("签约交易商 " + firmID + " 在银行 " + bankID + " 代码，失败。" + BankCoreCode.getCode(result.result));
				getService().add(log);
				this.logger.debug("签约交易商 " + firmID + " 在银行 " + bankID + " 代码，" + BankCoreCode.getCode(result.result));
				if (error.trim().length() > 0) {
					error = error + ",";
				}
				error = error + "银行" + bankID + "：" + BankCoreCode.getCode(result.result);
			}
		} catch (Exception e) {
			log.setLogcontent("签约交易商 " + firmID + " 在银行 " + bankID + " 代码，发生异常");
			getService().add(log);
			if (error.trim().length() > 0) {
				error = error + ",";
			}
			error = error + "银行" + bankID + "：异常";
			this.logger.error("签约交易商 " + firmID + " 在银行 " + bankID + " 代码异常", e);
		}
		String msg = "签约交易商 " + firmID + " 银行代码";
		if (success.length() > 0) {
			msg = msg + "," + success + " 成功";
		}
		if (error.length() > 0) {
			msg = msg + "," + error;
		}
		addReturnValue(1, 130000L, new Object[] { msg });

		return "success";
	}

	public String delRegist() {
		String firmID = this.request.getParameter("firmID");
		if ((firmID == null) || (firmID.trim().length() <= 0)) {
			addReturnValue(-1, 133301L);
			return "success";
		}
		String bankID = this.request.getParameter("bankID");
		if ((bankID == null) || (bankID.trim().length() <= 0)) {
			addReturnValue(-1, 133302L);
			return "success";
		}
		User user = (User) this.request.getSession().getAttribute("CurrentUser");
		gnnt.MEBS.bank.front.model.Log log = new gnnt.MEBS.bank.front.model.Log();
		log.setLogDate(new Date());
		log.setLogIP(user.getIpAddress());
		log.setLogopr(user.getUserID());

		String success = "";
		String error = "";
		String pwd = this.request.getParameter("password");
		FirmIDAndAccount firmIDAndAccount = (FirmIDAndAccount) getFirmIDAndAccount(firmID, bankID).clone();
		CorrespondValue cv = firmIDAndAccount.getCorrespondValue();
		cv.bankCardPassword = pwd;
		try {
			if (!Util.isContentsBank(ApplicationContextInit.getConfig("marketPerformDelAccount"), bankID)) {
				log.setLogcontent("注销交易商 " + firmID + " 在银行 " + bankID + " 帐号，银行不允许交易所端发起解约");
				getService().add(log);
				if (error.trim().length() > 0) {
					error = error + ",";
				}
				error = error + bankID;
			}
			long result = 0L;
			if (Util.isContentsBank(ApplicationContextInit.getConfig("noAdapterBank"), bankID)) {
				result = this.capitalProcessorRMI.delAccountNoAdapter(cv);
			} else {
				result = this.capitalProcessorRMI.delAccountMaket(cv);
			}
			if (result == 0L) {
				log.setLogcontent("注销交易商 " + firmID + " 在银行 " + bankID + " 帐号，成功");
				getService().add(log);
				if (success.trim().length() > 0) {
					success = success + ",";
				}
				success = success + bankID;
			} else {
				log.setLogcontent("注销交易商 " + firmID + " 在银行 " + bankID + " 帐号，失败，" + BankCoreCode.getCode(result));
				getService().add(log);
				this.logger.debug("注销交易商 " + firmID + " 在银行 " + bankID + " 帐号，" + BankCoreCode.getCode(result));
				if (error.trim().length() > 0) {
					error = error + ",";
				}
				error = error + "银行" + bankID + "：" + BankCoreCode.getCode(result);
			}
		} catch (Exception e) {
			log.setLogcontent("注销交易商 " + firmID + " 在银行 " + bankID + " 帐号，发生异常");
			getService().add(log);
			if (error.trim().length() > 0) {
				error = error + ",";
			}
			error = error + "银行" + bankID + "：异常";
			this.logger.error("注销交易商 " + firmID + " 在银行 " + bankID + " 帐号异常", e);
		}
		String msg = "注销交易商 " + firmID + " 银行帐号";
		if (success.length() > 0) {
			msg = msg + "," + success + " 成功";
		}
		if (error.length() > 0) {
			msg = msg + "," + error;
		}
		addReturnValue(1, 130000L, new Object[] { msg });

		return "success";
	}

	private FirmIDAndAccount getFirmIDAndAccount(String firmID, String bankID) {
		FirmIDAndAccount result = new FirmIDAndAccount();
		MFirm firm = new MFirm();
		firm.setFirmID(firmID);
		result.setFirm(firm);
		Bank bank = new Bank();
		bank.setBankID(bankID);
		result.setBank(bank);
		return (FirmIDAndAccount) getService().get(result);
	}

	public String gotoRgstDelFirmInfoPageGFB() {
		this.logger.info("国付宝签解约");
		String msg = "";
		try {
			String bankID = this.request.getParameter("bankID");
			String firmID = this.request.getParameter("firmID");
			String account = this.request.getParameter("account");
			String accountName = this.request.getParameter("accountName");
			int rgstdelType = Integer.parseInt(this.request.getParameter("rgstdelType"));
			this.logger.info("签解约交易商代码[" + firmID + "] 账号[" + account + "] 户名[" + accountName + "] 签解约类型[" + rgstdelType + "] ");
			FirmIDAndAccount firmIDAndAccount = (FirmIDAndAccount) getFirmIDAndAccount(firmID, bankID).clone();
			CorrespondValue cv = firmIDAndAccount.getCorrespondValue();

			ReturnValue returnValue = this.capitalProcessorRMI.addRgstCapitalValue(cv, rgstdelType);
			if (returnValue.result < 0L) {
				msg = "调用处理器验证签解约失败：" + returnValue.remark;
				addReturnValue(-1, 130000L, new Object[] { msg });
				return "error";
			}
			String GFBTime = Tool.getGSYTTime();
			long actionID = this.capitalProcessorRMI.getMktActionID();
			String backgroundMerUrl = ApplicationContextInit.getConfig("BackgroundMerUrl_GFB");
			String VerficationCode = ApplicationContextInit.getConfig("VerficationCode_GFB");
			String frontMerUrl = ApplicationContextInit.getConfig("FrontMerUrl_GFB");
			String MarkCode = ApplicationContextInit.getConfig("MarkCode_GFB");

			String tranIP = this.request.getRemoteAddr();
			String version = "2.0";
			String signType = "1";
			String merOrderNum = MarkCode + "-" + actionID;
			String signMsg = null;
			String tranCode = "10000";
			if (rgstdelType == 0) {
				signMsg =

				"version=[" + version + "]signType=[" + signType + "]" + "tranCode=[" + tranCode + "]merchantID=[" + MarkCode + "]" + "merOrderNum=["
						+ merOrderNum + "]tranDateTime=[" + GFBTime + "]" + "merURL=[" + backgroundMerUrl + "]VerficationCode=[" + VerficationCode
						+ "]";
			} else {
				tranCode = "10001";
				signMsg = "version=[" + version + "]signType=[" + signType + "]" + "tranCode=[" + tranCode + "]merchantID=[" + MarkCode + "]"
						+ "merOrderNum=[" + merOrderNum + "]tranDateTime=[" + GFBTime + "]" + "merURL=[" + backgroundMerUrl + "]contractNo=["
						+ account + "]" + "VerficationCode=[" + VerficationCode + "]";
			}
			this.logger.info("签解约加密明文signMsg:" + signMsg);
			String signValue = MD5orSHA.md5(signMsg);
			this.logger.info("签约加密密文signMsg:" + signValue);

			this.request.setAttribute("tranCode", tranCode);
			this.request.setAttribute("firmID", firmID);
			this.request.setAttribute("account", account);
			this.request.setAttribute("accountName", accountName);
			this.request.setAttribute("GFBTime", GFBTime);
			this.request.setAttribute("signValue", signValue);
			this.request.setAttribute("tranIP", tranIP);
			this.request.setAttribute("backgroundMerUrl", backgroundMerUrl);
			this.request.setAttribute("frontMerUrl", frontMerUrl);
			this.request.setAttribute("MarkCode", MarkCode);
			this.request.setAttribute("merOrderNum", merOrderNum);
			msg = "签解约信息准备成功";
		} catch (RemoteException e) {
			this.logger.error("执行取市场流水号时异常", e);
			msg = "获取流水号失败";
			addReturnValue(-1, 130000L, new Object[] { msg });
			return "error";
		} catch (UnsupportedEncodingException e) {
			this.logger.error("获取签解约信息签名异常", e);
			msg = "获取签解约信息签名失败";
			addReturnValue(-1, 130000L, new Object[] { msg });
			return "error";
		} catch (IOException e) {
			this.logger.error("取得国付宝时间戳异常", e);
			msg = "取得国付宝时间戳失败";
			addReturnValue(-1, 130000L, new Object[] { msg });
			return "error";
		} catch (Exception e) {
			this.logger.error("国付宝签解约其他异常", e);
			msg = "国付宝签解约其他异常";
			addReturnValue(-1, 130000L, new Object[] { msg });
			return "error";
		}
		return "success";
	}

	public String moneyTransferGFB() {
		this.logger.info("国付宝入金");
		String msg = "";
		try {
			String bankID = this.request.getParameter("bankID");
			if ((bankID == null) || (bankID.trim().length() <= 0)) {
				addReturnValue(-1, 2830101L);
				return "error";
			}
			User user = (User) this.request.getSession().getAttribute("CurrentUser");
			FirmIDAndAccount ffirmIDAndAccount = new FirmIDAndAccount();
			Bank bank = new Bank();
			bank.setBankID(bankID);
			bank = (Bank) getService().get(bank);
			ffirmIDAndAccount.setBank(bank);
			ffirmIDAndAccount.setFirm(user.getBelongtoFirm());
			FirmIDAndAccount firmIDAndAccount = (FirmIDAndAccount) getService().get(ffirmIDAndAccount);
			firmIDAndAccount.setBank(bank);
			if (firmIDAndAccount == null) {
				addReturnValue(-1, 2830104L, new Object[] { bankID });
				return "error";
			}
			if (firmIDAndAccount.getIsOpen().intValue() != 1) {
				addReturnValue(-1, 2830105L, new Object[] { bankID });
				return "error";
			}
			if (firmIDAndAccount.getStatus().intValue() != 0) {
				addReturnValue(-1, 2830106L, new Object[] { bankID });
				return "error";
			}
			if (firmIDAndAccount.getBank().getValidflag().intValue() != 0) {
				addReturnValue(-1, 2830107L, new Object[] { bankID });
				return "error";
			}
			double money = Tools.strToDouble(this.request.getParameter("money"), -1000.0D);
			if (money <= 0.0D) {
				addReturnValue(-1, 2830102L);
				return "error";
			}
			String firmID = firmIDAndAccount.getFirm().getFirmID();
			String account = firmIDAndAccount.getAccount();
			String accountName = firmIDAndAccount.getAccountName();

			this.logger
					.info("国付宝交易商代码[" + firmIDAndAccount.getFirm().getFirmID() + "] 账号[" + account + "] 户名[" + accountName + "] 金额[" + money + "]");

			long result = this.capitalProcessorRMI.inMoneyMarketGS(bankID, firmID, account, "", money, "market_in");
			if (result < 0L) {
				msg = "调用处理器验证入金失败：" + (String) ErrorCode.error.get(Long.valueOf(result));
				addReturnValue(-1, 130000L, new Object[] { msg });
				return "error";
			}
			String GFBTime = Tool.getGSYTTime();
			long actionID = result;
			String backgroundMerUrl = ApplicationContextInit.getConfig("BackgroundMerUrl_GFB");
			String VerficationCode = ApplicationContextInit.getConfig("VerficationCode_GFB");
			String frontMerUrl = ApplicationContextInit.getConfig("FrontMerUrl_GFB");
			String MarkCode = ApplicationContextInit.getConfig("MarkCode_GFB");
			String MarketGSAcount = ApplicationContextInit.getConfig("MarketGSAcount_GFB");

			String tranIP = this.request.getRemoteAddr();
			String version = "2.0";
			String signType = "1";
			String merOrderNum = MarkCode + "-" + actionID;
			String msgExt = firmID + "|" + account;

			String signMsg = "version=[" + version + "]tranCode=[8801]" + "merchantID=[" + MarkCode + "]contractNo=[" + account + "]"
					+ "merOrderNum=[" + merOrderNum + "]virCardNoIn=[" + MarketGSAcount + "]" + "tranAmt=[" + Tool.fmtDouble2(money)
					+ "]currencyType=[156]" + "tranDateTime=[" + GFBTime + "]frontMerUrl=[" + frontMerUrl + "]" + "backgroundMerUrl=["
					+ backgroundMerUrl + "]signType=[" + signType + "]" + "isRepeatSubmit=[1]tranIP=[" + tranIP + "]" + "VerficationCode=["
					+ VerficationCode + "]";
			this.logger.info("入金加密明文signMsg:" + signMsg);
			String signValue = MD5orSHA.md5(signMsg);
			this.logger.info("入金加密密文signMsg:" + signValue);

			this.request.setAttribute("firmID", firmID);
			this.request.setAttribute("account", account);
			this.request.setAttribute("accountName", accountName);
			this.request.setAttribute("GFBTime", GFBTime);
			this.request.setAttribute("signValue", signValue);
			this.request.setAttribute("tranIP", tranIP);
			this.request.setAttribute("backgroundMerUrl", backgroundMerUrl);
			this.request.setAttribute("frontMerUrl", frontMerUrl);
			this.request.setAttribute("MarkCode", MarkCode);
			this.request.setAttribute("merOrderNum", merOrderNum);
			this.request.setAttribute("money", Tool.fmtDouble2(money));
			this.request.setAttribute("MarketGSAcount", MarketGSAcount);
			this.request.setAttribute("msgExt", msgExt);

			msg = "入金信息准备成功";
		} catch (RemoteException e) {
			this.logger.error("执行取市场流水号时异常", e);
			msg = "获取流水号失败";
			addReturnValue(-1, 130000L, new Object[] { msg });
			return "error";
		} catch (UnsupportedEncodingException e) {
			this.logger.error("获取入金信息签名异常", e);
			msg = "获取入金信息签名失败";
			addReturnValue(-1, 130000L, new Object[] { msg });
			return "error";
		} catch (IOException e) {
			this.logger.error("取得国付宝时间戳异常", e);
			msg = "取得国付宝时间戳失败";
			addReturnValue(-1, 130000L, new Object[] { msg });
			return "error";
		} catch (Exception e) {
			this.logger.error("国付宝入金其他异常", e);
			msg = "国付宝入金其他异常";
			addReturnValue(-1, 130000L, new Object[] { msg });
			return "error";
		}
		return "success";
	}
}

package gnnt.MEBS.vendue.front.dao.jdbc;

import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;

import gnnt.MEBS.base.dao.DaoHelper;
import gnnt.MEBS.priceranking.server.model.Commodity;
import gnnt.MEBS.priceranking.server.model.CommodityOrder;
import gnnt.MEBS.priceranking.server.model.SystemStatus;
import gnnt.MEBS.priceranking.server.rmi.ServerRMI;
import gnnt.MEBS.priceranking.server.rmi.TradeRMI;
import gnnt.MEBS.vendue.front.dao.TradeDAO;
import gnnt.MEBS.vendue.front.model.BreedProperty;
import gnnt.MEBS.vendue.front.model.BroadcastVO;
import gnnt.MEBS.vendue.front.model.Commodityparams;
import gnnt.MEBS.vendue.front.model.CurSubmitVO;
import gnnt.MEBS.vendue.front.model.QuantionMap;
import gnnt.MEBS.vendue.front.model.QuantionPage;
import gnnt.MEBS.vendue.front.model.SectionAttribute;
import gnnt.MEBS.vendue.front.model.SettleParams;
import gnnt.MEBS.vendue.front.model.SysPartition;
import gnnt.MEBS.vendue.front.model.TradeUser;

public class TradeDAOImpl extends DaoHelper implements TradeDAO {
	public TradeDAOImpl() throws NamingException {
	}

	public CurSubmitVO[] getCurSubmitList(String paramString) {
		CurSubmitVO[] arrayOfCurSubmitVO = null;
		CurSubmitVO localCurSubmitVO = null;
		Map localMap = null;
		String str = null;
		str = "select tradepartition, cs.code, price, cs.amount, cs.userid, submittime, ordertype, validamount, modifytime,cs.id,traderID,frozenMargin,frozenFee,unFrozenMargin,unFrozenFee,withdrawType from v_cursubmit cs where 1=1 "
				+ paramString;
		List localList = queryBySQL(str);
		arrayOfCurSubmitVO = new CurSubmitVO[localList.size()];
		for (int i = 0; i < localList.size(); i++) {
			localMap = (Map) localList.get(i);
			localCurSubmitVO = new CurSubmitVO();
			localCurSubmitVO.tradePartition = Integer.parseInt(localMap.get("tradepartition").toString());
			localCurSubmitVO.code = localMap.get("code").toString();
			localCurSubmitVO.price = Double.parseDouble(localMap.get("price").toString());
			localCurSubmitVO.amount = Double.parseDouble(localMap.get("amount").toString());
			localCurSubmitVO.userID = localMap.get("userid").toString();
			localCurSubmitVO.submitTime = Timestamp.valueOf(localMap.get("submittime").toString());
			localCurSubmitVO.orderType = Integer.parseInt(localMap.get("ordertype").toString());
			localCurSubmitVO.validAmount = Double.parseDouble(localMap.get("validamount").toString());
			localCurSubmitVO.modifytime = Timestamp.valueOf(localMap.get("modifytime").toString());
			localCurSubmitVO.iD = Long.parseLong(localMap.get("id").toString());
			localCurSubmitVO.traderID = localMap.get("traderID").toString();
			localCurSubmitVO.frozenMargin = Double.parseDouble(localMap.get("frozenMargin").toString());
			localCurSubmitVO.frozenFee = Double.parseDouble(localMap.get("frozenFee").toString());
			localCurSubmitVO.unFrozenMargin = Double.parseDouble(localMap.get("unFrozenMargin").toString());
			localCurSubmitVO.unFrozenFee = Double.parseDouble(localMap.get("unFrozenFee").toString());
			arrayOfCurSubmitVO[i] = localCurSubmitVO;
		}
		return arrayOfCurSubmitVO;
	}

	public BroadcastVO getBroadcast(long paramLong) {
		BroadcastVO localBroadcastVO = null;
		String str = null;
		str = "select title, userid, content, createtime,noticeID from M_Notice where noticeID=?";
		Object[] arrayOfObject = { Long.valueOf(paramLong) };
		List localList = queryBySQL(str, arrayOfObject, null);
		if ((localList != null) && (localList.size() > 0)) {
			Map localMap = (Map) localList.get(0);
			localBroadcastVO = new BroadcastVO();
			localBroadcastVO.iD = paramLong;
			localBroadcastVO.title = localMap.get("title").toString();
			localBroadcastVO.author = localMap.get("userid").toString();
			localBroadcastVO.content = localMap.get("content").toString();
			localBroadcastVO.createtime = Timestamp.valueOf(localMap.get("createtime").toString());
		}
		return localBroadcastVO;
	}

	public BroadcastVO[] getBroadcastList(String paramString) {
		BroadcastVO[] arrayOfBroadcastVO = null;
		BroadcastVO localBroadcastVO = null;
		Map localMap = null;
		String str = null;
		str = "select title, userid, content, createtime,noticeID from M_Notice " + paramString;
		List localList = queryBySQL(str);
		if ((localList != null) && (localList.size() > 0)) {
			arrayOfBroadcastVO = new BroadcastVO[localList.size()];
			for (int i = 0; i < localList.size(); i++) {
				localMap = (Map) localList.get(i);
				localBroadcastVO = new BroadcastVO();
				localBroadcastVO.title = localMap.get("title").toString();
				localBroadcastVO.author = localMap.get("userid").toString();
				localBroadcastVO.content = localMap.get("content").toString();
				localBroadcastVO.createtime = Timestamp.valueOf(localMap.get("createtime").toString());
				localBroadcastVO.iD = Long.parseLong(localMap.get("noticeID").toString());
				arrayOfBroadcastVO[i] = localBroadcastVO;
			}
		}
		return arrayOfBroadcastVO;
	}

	public Map getRMIUrl() {
		HashMap localHashMap = null;
		String str = "";
		str = "select hostip,port from C_TradeModule where moduleId=21";
		List localList = queryBySQL(str);
		if ((localList != null) && (localList.size() > 0)) {
			Map localMap = (Map) localList.get(0);
			localHashMap = new HashMap();
			localHashMap.put("host", localMap.get("hostip").toString());
			localHashMap.put("port", Integer.valueOf(Integer.parseInt(localMap.get("port").toString())));
		}
		return localHashMap;
	}

	public double getFrozenFundsByMID(String paramString) {
		double d = 0.0D;
		String str = "";
		str = "select FROZENFUNDS from F_FROZENFUNDS where MODULEID='21' and firmid='" + paramString + "'";
		List localList = queryBySQL(str);
		if ((localList != null) && (localList.size() > 0)) {
			Map localMap = (Map) localList.get(0);
			d = Double.parseDouble(localMap.get("FROZENFUNDS").toString());
		}
		return d;
	}

	public double getBalance(String paramString) {
		double d = 0.0D;
		String str = "";
		str = "select balance from f_firmfunds where firmid='" + paramString + "'";
		List localList = queryBySQL(str);
		if ((localList != null) && (localList.size() > 0)) {
			Map localMap = (Map) localList.get(0);
			d = Double.parseDouble(localMap.get("balance").toString());
		}
		return d;
	}

	public int cancelCode(String paramString1, int paramInt, String paramString2) {
		int i = -1;
		String str = null;
		str = "delete from V_CommoditySelf where partitionID=" + paramInt + " and userCode='" + paramString2 + "' and code='" + paramString1 + "'";
		updateBySQL(str);
		i = 1;
		return i;
	}

	public boolean checkSelfCodeNums(String paramString1, int paramInt, String paramString2) {
		boolean bool = false;
		int i = 1;
		int j = i;
		String str = "";
		str = "select selfrate,count from (select selfrate from v_sysPartition where partitionID=" + paramInt
				+ ")a,(select count(*) count from V_CommoditySelf where partitionID=" + paramInt + " and userCode='" + paramString2 + "')b";
		List localList = queryBySQL(str);
		Map localMap = null;
		if ((localList != null) && (localList.size() > 0)) {
			for (int k = 0; k < localList.size(); k++) {
				localMap = (Map) localList.get(k);
				j = Integer.parseInt(localMap.get("selfrate").toString());
				i = Integer.parseInt(localMap.get("count").toString());
			}
		}
		if (j > i) {
			bool = true;
		}
		return bool;
	}

	public int countCode(String paramString1, int paramInt, String paramString2) {
		int i = 1;
		String str = "";
		str = "select count(*) from V_CommoditySelf where partitionID=" + paramInt + " and userCode='" + paramString2 + "' and code='" + paramString1
				+ "' ";
		System.out.println(str);
		i = queryForInt(str);
		return i;
	}

	public int insertCode(String paramString1, int paramInt, String paramString2) {
		int i = 1;
		String str = "";
		str = "insert into V_CommoditySelf (partitionid,usercode,code,time) values(?,?,?,sysdate)";
		Object[] arrayOfObject = { Integer.valueOf(paramInt), paramString2, paramString1 };
		updateBySQL(str, arrayOfObject);
		return i;
	}

	public int addCode(String paramString1, int paramInt, String paramString2) {
		int i = 1;
		boolean bool = false;
		i = countCode(paramString1, paramInt, paramString2);
		if (i == 0) {
			bool = checkSelfCodeNums(paramString1, paramInt, paramString2);
			if (bool) {
				insertCode(paramString1, paramInt, paramString2);
			} else {
				i = 2;
			}
		}
		return i;
	}

	public String getChoiceCode(int paramInt, String paramString) {
		String str1 = "";
		String str2 = "";
		str2 = "select code from V_CommoditySelf where partitionID=" + paramInt + " and userCode='" + paramString + "'";
		List localList = queryBySQL(str2);
		Map localMap = null;
		if ((localList != null) && (localList.size() > 0)) {
			for (int i = 0; i < localList.size(); i++) {
				localMap = (Map) localList.get(i);
				str1 = localMap.get("code").toString() + "," + str1;
			}
		}
		return str1;
	}

	public List getCodeNums(String paramString) {
		String str = "";
		ArrayList localArrayList = new ArrayList();
		str = "select amount from V_CommodityQty where code='" + paramString + "' order by amount";
		List localList = queryBySQL(str);
		Map localMap = null;
		if ((localList != null) && (localList.size() > 0)) {
			for (int i = 0; i < localList.size(); i++) {
				localMap = (Map) localList.get(i);
				localArrayList.add(Double.valueOf(Double.parseDouble(localMap.get("amount").toString())));
			}
		}
		return localArrayList;
	}

	public List<SysPartition> getSysPartitions(String paramString, Object[] paramArrayOfObject) {
		String str = "";
		ArrayList localArrayList = new ArrayList();
		SysPartition localSysPartition = null;
		str = "select partitionID,firmLimitClass,description,tradeMode,selfRate,isShowQuotation,countMode,isSplitTarget from v_sysPartition where validFlag=1 "
				+ paramString;
		List localList = queryBySQL(str, paramArrayOfObject, null);
		Map localMap = null;
		if ((localList != null) && (localList.size() > 0)) {
			for (int i = 0; i < localList.size(); i++) {
				localMap = (Map) localList.get(i);
				localSysPartition = new SysPartition();
				localSysPartition.partitionID = Integer.parseInt(localMap.get("partitionID").toString());
				localSysPartition.firmLimitClass = localMap.get("firmLimitClass").toString();
				localSysPartition.description = localMap.get("description").toString();
				localSysPartition.tradeMode = Integer.parseInt(localMap.get("tradeMode").toString());
				localSysPartition.selfRate = Integer.parseInt(localMap.get("selfRate").toString());
				localSysPartition.isShowQuotation = Integer.parseInt(localMap.get("isShowQuotation").toString());
				localSysPartition.countMode = Integer.parseInt(localMap.get("countMode").toString());
				localSysPartition.isSplitTarget = Integer.parseInt(localMap.get("isSplitTarget").toString());
				localArrayList.add(localSysPartition);
			}
		}
		return localArrayList;
	}

	public SystemStatus getSystemStatus(int paramInt) {
		SystemStatus localSystemStatus = null;
		try {
			localSystemStatus = getServerRMI().getSystemStatus((short) paramInt);
		} catch (Exception localException) {
			localException.printStackTrace();
		}
		return localSystemStatus;
	}

	public List<BreedProperty> getBreedProperty(String paramString) {
		String str1 = "select p.* from m_property p where p.CATEGORYID in (select b.categoryid from m_breed b where b.breedid = '" + paramString
				+ "')";
		String str2 = "select propertyValue from m_breedprops  where breedid = ? and propertyid = ?";
		List localList1 = queryBySQL(str1, null, null);
		ArrayList localArrayList1 = new ArrayList();
		BreedProperty localBreedProperty = null;
		Map localMap = null;
		Object localObject = null;
		if ((localList1 != null) && (localList1.size() > 0)) {
			for (int i = 0; i < localList1.size(); i++) {
				localMap = (Map) localList1.get(i);
				localBreedProperty = new BreedProperty();
				localBreedProperty.setPropertyid(Long.valueOf(Long.parseLong(localMap.get("propertyid").toString())));
				localBreedProperty.setPropertyname(localMap.get("propertyname").toString());
				localBreedProperty.setHasvaluedict(localMap.get("hasvaluedict").toString());
				localBreedProperty.setIsnecessary(localMap.get("isnecessary").toString());
				localBreedProperty.setFieldtype(Byte.valueOf(Byte.parseByte(localMap.get("fieldtype").toString())));
				List localList2 = queryBySQL(str2, new Object[] { paramString, localBreedProperty.getPropertyid() }, null);
				ArrayList localArrayList2 = new ArrayList();
				for (int j = 0; j < localList2.size(); j++) {
					localMap = (Map) localList2.get(j);
					localArrayList2.add(localMap.get("propertyValue").toString());
				}
				localBreedProperty.setValues(localArrayList2);
				localArrayList1.add(localBreedProperty);
			}
		}
		return localArrayList1;
	}

	public List<SectionAttribute> getSectionAttribute(int paramInt) {
		String str = "";
		Map localMap = null;
		SectionAttribute localSectionAttribute = null;
		ArrayList localArrayList = new ArrayList();
		try {
			SystemStatus localSystemStatus = getSystemStatus((short) paramInt);
			int j = localSystemStatus.getStatus();
			int i;
			if ((j == 3) || (j == 9)) {
				i = getTradeRMI().getNextSection((short) paramInt);
			} else {
				i = localSystemStatus.getUnitId();
			}
			str = "select decode(max(unitID),null,-1,max(unitID)) section from v_flowControl where tradePartition=" + paramInt + " and unitID<=" + i;
			i = queryForInt(str);
			if (i == -1) {
				str = "select attributeId,attributeName from V_SectionAttribute where breedId =(select breedId from v_sysProperty where tradePartition = "
						+ paramInt + " ) and partitionID=" + paramInt + " and unitId= " + i + " order by num";
			} else {
				str = "select attributeId,attributeName from V_SectionAttribute where breedId =(select breedId from v_flowControl where tradePartition = "
						+ paramInt + " and unitId = " + i + " and unitType=1 ) " + "and partitionID=" + paramInt + " and unitId= " + i
						+ " order by num";
			}
			List localList = queryBySQL(str);
			if ((localList != null) && (localList.size() > 0)) {
				for (int k = 0; k < localList.size(); k++) {
					localMap = (Map) localList.get(k);
					localSectionAttribute = new SectionAttribute();
					localSectionAttribute.attributeId = Integer.parseInt(localMap.get("attributeId").toString());
					localSectionAttribute.attributeName = localMap.get("attributeName").toString();
					localArrayList.add(localSectionAttribute);
				}
			}
		} catch (Exception localException) {
			localException.printStackTrace();
		}
		return localArrayList;
	}

	public Commodityparams getCommodityParams(int paramInt, Long paramLong) {
		String str = "";
		Commodityparams localCommodityparams = null;
		str = "select *  from V_CommodityParams where tradepartition=" + paramInt + " and breedid=" + paramLong + "";
		List localList = queryBySQL(str);
		Map localMap = null;
		if ((localList != null) && (localList.size() > 0)) {
			for (int i = 0; i < localList.size(); i++) {
				localMap = (Map) localList.get(i);
				localCommodityparams = new Commodityparams();
				localCommodityparams.setbFee(Double.valueOf(Double.parseDouble(localMap.get("B_Fee").toString())));
				localCommodityparams.setBreedid(Long.valueOf(Long.parseLong(localMap.get("breedid").toString())));
				localCommodityparams.setbSecurity(Double.valueOf(Double.parseDouble(localMap.get("B_Security").toString())));
				localCommodityparams.setFeealgr(Byte.valueOf(Byte.parseByte(localMap.get("feealgr").toString())));
				localCommodityparams.setFlowamount(Double.valueOf(Double.parseDouble(localMap.get("flowamount").toString())));
				localCommodityparams.setFlowamountalgr(Byte.valueOf(Byte.parseByte(localMap.get("flowamountalgr").toString())));
				localCommodityparams.setMarginalgr(Byte.valueOf(Byte.parseByte(localMap.get("marginalgr").toString())));
				localCommodityparams.setMaxamount(Double.valueOf(Double.parseDouble(localMap.get("maxamount").toString())));
				localCommodityparams.setMaxstepprice(Double.valueOf(Double.parseDouble(localMap.get("maxstepprice").toString())));
				localCommodityparams.setMinamount(Double.valueOf(Double.parseDouble(localMap.get("minamount").toString())));
				localCommodityparams.setsFee(Double.valueOf(Double.parseDouble(localMap.get("S_Fee").toString())));
				localCommodityparams.setsSecurity(Double.valueOf(Double.parseDouble(localMap.get("S_Security").toString())));
				localCommodityparams.setStepprice(Double.valueOf(Double.parseDouble(localMap.get("stepprice").toString())));
				localCommodityparams.setTradepartition(Short.valueOf(Short.parseShort(localMap.get("tradepartition").toString())));
				localCommodityparams.setTradeunit(Double.valueOf(Double.parseDouble(localMap.get("tradeunit").toString())));
			}
		}
		return localCommodityparams;
	}

	public int addCodeApply(Commodity paramCommodity) {
		int i = -1;
		String str = "";
		str = "select SP_V_COMMODITY.NEXTVAL from dual ";
		int j = queryForInt(str);
		str = "insert into V_Commodity (code,firsttime,commodityid,createtime,tradepartition,status,breedid,splitid,userid,amount,tradeunit,minamount,maxamount,flowamountalgr,flowamount,beginprice,stepprice,maxstepprice,marginalgr,B_Security,S_Security,feealgr,B_Fee,S_Fee,authorization,isorder,auditstatus,alertprice,bs_flag,tenderTradeConfirm)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		Object[] arrayOfObject = { Integer.valueOf(j), paramCommodity.getFirstTime(), paramCommodity.getCommodityId(), paramCommodity.getCreateTime(),
				Short.valueOf(paramCommodity.getTradePartition()), Short.valueOf(paramCommodity.getStatus()),
				Short.valueOf(paramCommodity.getBreedId()), Integer.valueOf(paramCommodity.getSplitId()), paramCommodity.getUserId(),
				Double.valueOf(paramCommodity.getAmount()), Double.valueOf(paramCommodity.getTradeUnit()),
				Double.valueOf(paramCommodity.getMinAmount()), Double.valueOf(paramCommodity.getMaxAmount()),
				Short.valueOf(paramCommodity.getFlowAmountAlgr()), Double.valueOf(paramCommodity.getFlowAmount()), paramCommodity.getBeginPrice(),
				paramCommodity.getStepPrice(), paramCommodity.getMaxStepPrice(), Short.valueOf(paramCommodity.getMarginAlgr()),
				paramCommodity.getB_security(), paramCommodity.getS_security(), Short.valueOf(paramCommodity.getFeeAlgr()), paramCommodity.getB_fee(),
				paramCommodity.getS_fee(), Short.valueOf(paramCommodity.getAuthorization()), Short.valueOf(paramCommodity.getIsOrder()),
				Integer.valueOf(0), paramCommodity.getAlertPrice(), Short.valueOf(paramCommodity.getBs_flag()), Integer.valueOf(0) };
		updateBySQL(str, arrayOfObject);
		i = j;
		return i;
	}

	public int addSettleParams(SettleParams paramSettleParams) {
		int i = -1;
		String str = "";
		str = "insert into V_COMMEXT values(SEQ_V_COMMEXT.nextval,?,?,?,?)";
		Object[] arrayOfObject = { paramSettleParams.getCode(), paramSettleParams.getAttributeid(), paramSettleParams.getAttribute(),
				paramSettleParams.getValue() };
		updateBySQL(str, arrayOfObject);
		i = 1;
		return i;
	}

	public TradeRMI getTradeRMI() {
		TradeRMI localTradeRMI = null;
		Map localMap = getRMIUrl();
		StringBuffer localStringBuffer = new StringBuffer();
		localStringBuffer.append("rmi://").append(localMap.get("host")).append(":").append(localMap.get("port")).append("/TradeRMI");
		String str = localStringBuffer.toString();
		try {
			localTradeRMI = (TradeRMI) Naming.lookup(str);
		} catch (MalformedURLException localMalformedURLException) {
			localMalformedURLException.printStackTrace();
		} catch (RemoteException localRemoteException) {
			localRemoteException.printStackTrace();
		} catch (NotBoundException localNotBoundException) {
			localNotBoundException.printStackTrace();
		}
		return localTradeRMI;
	}

	public ServerRMI getServerRMI() {
		ServerRMI localServerRMI = null;
		Map localMap = getRMIUrl();
		StringBuffer localStringBuffer = new StringBuffer();
		localStringBuffer.append("rmi://").append(localMap.get("host")).append(":").append(localMap.get("port")).append("/ServerRMI");
		String str = localStringBuffer.toString();
		try {
			localServerRMI = (ServerRMI) Naming.lookup(str);
		} catch (MalformedURLException localMalformedURLException) {
			localMalformedURLException.printStackTrace();
		} catch (RemoteException localRemoteException) {
			localRemoteException.printStackTrace();
		} catch (NotBoundException localNotBoundException) {
			localNotBoundException.printStackTrace();
		}
		return localServerRMI;
	}

	public TradeUser getTradeUserInfo(String paramString) {
		String str = "";
		TradeUser localTradeUser = new TradeUser();
		str = "select * from v_tradeUser where userCode='" + paramString + "'";
		List localList = queryBySQL(str);
		Map localMap = null;
		if ((localList != null) && (localList.size() > 0)) {
			localMap = (Map) localList.get(0);
			localTradeUser.setUserCode(localMap.get("userCode").toString());
			localTradeUser.setTradeCount(Integer.parseInt(localMap.get("tradeCount").toString()));
			localTradeUser.setOverdraft(Double.valueOf(Double.parseDouble(localMap.get("overdraft").toString())));
			localTradeUser.setLimits(Integer.parseInt(localMap.get("limits").toString()));
			localTradeUser.setIsEntry(Integer.parseInt(localMap.get("isEntry").toString()));
			localTradeUser.setIsContinueOrder(Integer.parseInt(localMap.get("isContinueOrder").toString()));
		}
		return localTradeUser;
	}

	public List<String> getCodeAuth(String paramString) {
		String str = "";
		ArrayList localArrayList = new ArrayList();
		str = "select code from v_TradeAuthority where userCode='" + paramString + "'";
		List localList = queryBySQL(str);
		Map localMap = null;
		if ((localList != null) && (localList.size() > 0)) {
			for (int i = 0; i < localList.size(); i++) {
				localMap = (Map) localList.get(i);
				localArrayList.add(localMap.get("code").toString());
			}
		}
		return localArrayList;
	}

	public Commodity getCode(String paramString) {
		Commodity localCommodity = new Commodity();
		String str = null;
		str = "select d.* from v_commodity d where d.code='" + paramString + "' ";
		List localList = queryBySQL(str);
		if ((localList != null) && (localList.size() > 0)) {
			Map localMap = (Map) localList.get(0);
			localCommodity.setCode(paramString);
			localCommodity.setTradePartition(Short.parseShort(localMap.get("tradePartition").toString()));
			localCommodity.setCommodityId(localMap.get("commodityId").toString());
			localCommodity.setStatus(Short.parseShort(localMap.get("status").toString()));
			localCommodity.setBreedId(Short.parseShort(localMap.get("breedId").toString()));
			localCommodity.setSplitId(Integer.parseInt(localMap.get("splitId").toString()));
			localCommodity.setUserId(localMap.get("userId").toString());
			localCommodity.setAmount(Double.parseDouble(localMap.get("amount").toString()));
			localCommodity.setTradeUnit(Double.parseDouble(localMap.get("tradeUnit").toString()));
			localCommodity.setMinAmount(Double.parseDouble(localMap.get("minAmount").toString()));
			localCommodity.setMaxAmount(Double.parseDouble(localMap.get("maxAmount").toString()));
			localCommodity.setFlowAmountAlgr(Short.parseShort(localMap.get("flowAmountAlgr").toString()));
			localCommodity.setFlowAmount(Double.parseDouble(localMap.get("flowAmount").toString()));
			localCommodity.setBeginPrice(Double.valueOf(Double.parseDouble(localMap.get("beginPrice").toString())));
			localCommodity.setAlertPrice(Double.valueOf(Double.parseDouble(localMap.get("alertPrice").toString())));
			localCommodity.setStepPrice(Double.valueOf(Double.parseDouble(localMap.get("stepPrice").toString())));
			localCommodity.setMaxStepPrice(Double.valueOf(Double.parseDouble(localMap.get("maxStepPrice").toString())));
			localCommodity.setMarginAlgr(Short.parseShort(localMap.get("marginAlgr").toString()));
			localCommodity.setB_security(Double.valueOf(Double.parseDouble(localMap.get("b_Security").toString())));
			localCommodity.setS_security(Double.valueOf(Double.parseDouble(localMap.get("s_Security").toString())));
			localCommodity.setFeeAlgr(Short.parseShort(localMap.get("feeAlgr").toString()));
			localCommodity.setB_fee(Double.valueOf(Double.parseDouble(localMap.get("b_Fee").toString())));
			localCommodity.setS_fee(Double.valueOf(Double.parseDouble(localMap.get("s_Fee").toString())));
			localCommodity.setAuthorization(Short.parseShort(localMap.get("authorization").toString()));
		}
		return localCommodity;
	}

	public String getSysdate() {
		String str1 = null;
		String str2 = null;
		str2 = "select sysdate day from dual";
		List localList = queryBySQL(str2);
		Map localMap = null;
		if ((localList != null) && (localList.size() > 0)) {
			localMap = (Map) localList.get(0);
			str1 = localMap.get("day").toString();
		}
		return str1;
	}

	public Map<Long, String> getBreeds() {
		String str = null;
		str = "select b.breedid id, b.breedname name from m_breed b where b.belongmodule like '%21%' and b.status=1";
		List localList = queryBySQL(str);
		HashMap localHashMap = new HashMap();
		Iterator localIterator = localList.iterator();
		while (localIterator.hasNext()) {
			Map localMap = (Map) localIterator.next();
			localHashMap.put(Long.valueOf(Long.parseLong(localMap.get("ID").toString())), localMap.get("NAME").toString());
		}
		return localHashMap;
	}

	public QuantionPage getQuotations(short paramShort, String paramString) {
		QuantionPage localQuantionPage = new QuantionPage();
		QuantionMap localQuantionMap = QuantionMap.getInit();
		long l = localQuantionMap.getHqCount(paramShort);
		Map localMap1 = localQuantionMap.getHqMap(paramShort);
		ArrayList localArrayList1 = new ArrayList();
		ArrayList localArrayList2 = new ArrayList();
		Object localObject;
		if ((paramString != null) && (!paramString.equals(""))) {
			String str = "select c.Code from V_CommoditySelf c,v_syscurstatus s where c.partitionID = " + paramShort
					+ " and c.partitionID = s.tradepartition and s.status not in (5,6) and c.userCode = '" + paramString
					+ "' order by to_number(c.Code) ";
			localObject = queryBySQL(str);
			Map localMap2 = null;
			if ((localObject != null) && (((List) localObject).size() > 0)) {
				for (int k = 0; k < ((List) localObject).size(); k++) {
					localMap2 = (Map) ((List) localObject).get(k);
					localArrayList1.add(localMap2.get("code").toString());
				}
			}
		}
		if (localArrayList1 != null) {
			for (int i = 0; i < localArrayList1.size(); i++) {
				localObject = (CommodityOrder) localMap1.get(localArrayList1.get(i));
				if (localObject != null) {
					try {
						int j = getTradeRMI().getRightNowCountdown(paramShort, ((CommodityOrder) localObject).getCommodity().getCode());
						((CommodityOrder) localObject).setCountdownTime(j);
					} catch (RemoteException localRemoteException) {
						localRemoteException.printStackTrace();
					}
					localArrayList2.add(localObject);
				}
			}
		}
		localQuantionPage.setCount(l);
		localQuantionPage.setList(localArrayList2);
		return localQuantionPage;
	}

	public QuantionPage getPageQuotations(short paramShort, String paramString1, String paramString2, String paramString3) {
		QuantionPage localQuantionPage = new QuantionPage();
		int i = Integer.parseInt(paramString1);
		int j = Integer.parseInt(paramString2);
		int k = localQuantionPage.getRowNumber();
		int m = localQuantionPage.getTotalPage();
		QuantionMap localQuantionMap = QuantionMap.getInit();
		long l = localQuantionMap.getHqCount(paramShort);
		Map localMap1 = localQuantionMap.getHqMap(paramShort);
		String str1 = "";
		String str2 = "";
		String str3 = "";
		String str4 = "'";
		if ((paramString3 != null) && (!paramString3.equals(""))) {
			paramString3 = paramString3.replaceAll(str4, "");
			str2 = "  and c.code = '" + paramString3 + "' ";
		}
		str1 = "select ComID from (select rownum rid,ComID from (select c.code ComID from v_curCommodity c,(select decode(s.status,3,e.sec, 9, e.sec, s.section) section from v_syscurstatus s, (select nvl(min(cc.section), 0) sec from v_curcommodity cc, v_syscurstatus sc where cc.section > sc.section and cc.tradepartition = sc.tradepartition and sc.tradepartition = "
				+ paramShort + " and sc.status in (2, 3, 4, 9)) e where s.tradepartition = " + paramShort
				+ " and s.status in (2,3,4, 9)) st where c.tradePartition = " + paramShort + " " + str2
				+ " and c.section = st.section order by to_number(c.code))) where rid between ((" + i + "-1)*" + j + " +1) and (" + i + "*" + j + ")";
		ArrayList localArrayList1 = new ArrayList();
		ArrayList localArrayList2 = new ArrayList();
		List localList = queryBySQL(str1);
		Map localMap2 = null;
		int n;
		if ((localList != null) && (localList.size() > 0)) {
			for (n = 0; n < localList.size(); n++) {
				localMap2 = (Map) localList.get(n);
				localArrayList1.add(localMap2.get("ComID").toString());
			}
		}
		str1 = "select count(*) from v_curCommodity c,(select decode(s.status, 3, e.sec, 9, e.sec, s.section) section from v_syscurstatus s, (select nvl(min(cc.section), 0) sec from v_curcommodity cc, v_syscurstatus sc where cc.section > sc.section and cc.tradepartition = sc.tradepartition and sc.tradepartition = "
				+ paramShort + " and sc.status in (2, 3, 4, 9)) e where s.tradepartition = " + paramShort
				+ " and s.status in (2,3,4, 9)) st where c.tradePartition = " + paramShort + " " + str2
				+ " and c.section = st.section and c.bargainType=0 ";
		k = queryForInt(str1);
		if (localArrayList1 != null) {
			for (n = 0; n < localArrayList1.size(); n++) {
				CommodityOrder localCommodityOrder = (CommodityOrder) localMap1.get(localArrayList1.get(n));
				if (localCommodityOrder != null) {
					try {
						int i1 = getTradeRMI().getRightNowCountdown(paramShort, localCommodityOrder.getCommodity().getCode());
						localCommodityOrder.setCountdownTime(i1);
					} catch (RemoteException localRemoteException) {
						localRemoteException.printStackTrace();
					}
					localArrayList2.add(localCommodityOrder);
				}
			}
		}
		if (j > 0) {
			m = Double.valueOf(Math.ceil(k * 1.0D / j)).intValue();
		}
		localQuantionPage.setCount(l);
		localQuantionPage.setList(localArrayList2);
		localQuantionPage.setRowNumber(k);
		localQuantionPage.setCurrentPage(i);
		localQuantionPage.setPageNumber(j);
		localQuantionPage.setTotalPage(m);
		return localQuantionPage;
	}
}

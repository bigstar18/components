package gnnt.MEBS.vendue.mgr.dao.impl.commodity.curCommodity;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import gnnt.MEBS.common.mgr.dao.StandardDao;
import gnnt.MEBS.common.mgr.statictools.ApplicationContextInit;
import gnnt.MEBS.vendue.mgr.dao.commodity.curCommodity.CurCommodityDao;
import gnnt.MEBS.vendue.mgr.model.commodity.curCommodities.CurCommodity;
import gnnt.MEBS.vendue.mgr.util.Arith;

@Repository("curCommodityDao")
public class CurCommodityDaoImpl extends StandardDao implements CurCommodityDao {
	public Integer addSection(String paramString, Byte paramByte, String[] paramArrayOfString) {
		this.logger.debug("enter addSection");
		try {
			if (paramArrayOfString.length != 0) {
				for (int i = 0; i < paramArrayOfString.length; i++) {
					CurCommodity localCurCommodity = new CurCommodity();
					localCurCommodity.setCode(paramArrayOfString[i]);
					localCurCommodity = (CurCommodity) get(localCurCommodity);
					if (!"".equals(paramString)) {
						localCurCommodity.setSection(new Integer(paramString));
					} else {
						localCurCommodity.setSection(null);
					}
					localCurCommodity.setModifyTime(new Date(System.currentTimeMillis()));
					update(localCurCommodity);
				}
			}
		} catch (Exception localException) {
			localException.printStackTrace();
			return Integer.valueOf(-1);
		}
		return Integer.valueOf(1);
	}

	public List<?> listSection(Byte paramByte) {
		String str = "select unitID from v_flowcontrol where 1=1 and unitType = 1 and tradePartition = " + paramByte;
		return queryBySql(str);
	}

	public Integer deleteCurCommodity(String[] paramArrayOfString) {
		this.logger.debug("enter deleteCurCommodity");
		if (paramArrayOfString.length != 0) {
			try {
				String str1 = ApplicationContextInit.getConfig("SelfModuleID");
				for (int i = 0; i < paramArrayOfString.length; i++) {
					String str2 = getUserId(paramArrayOfString[i]);
					Double localDouble = Double.valueOf(Arith.mul(getFrozenFund(paramArrayOfString[i]).doubleValue(), -1.0F));
					executeProcedure("{?=call FN_F_UpdateFrozenFunds(?,?,?) }", new Object[] { str2, localDouble, str1 });
					deleteFrozenFund(paramArrayOfString[i]);
				}
				deleteBYBulk(new CurCommodity(), paramArrayOfString);
			} catch (Exception localException) {
				localException.printStackTrace();
				return Integer.valueOf(-1);
			}
		}
		return Integer.valueOf(1);
	}

	private void deleteFrozenFund(String paramString) {
		String str = "delete from V_FundFrozen where Code = " + paramString;
		executeUpdateBySql(str);
	}

	private String getUserId(String paramString) {
		String str = "select userId from V_FundFrozen where Code = '" + paramString + "'";
		return ((Map) queryBySql(str).get(0)).get("USERID").toString();
	}

	private Double getFrozenFund(String paramString) {
		String str = "select (frozenmargin+frozenfee) FrozenFund from V_FundFrozen where Code = '" + paramString + "'";
		return Double.valueOf(Double.parseDouble(((Map) queryBySql(str).get(0)).get("FROZENFUND").toString()));
	}

	public Integer insertSection(String[] paramArrayOfString, String paramString, Byte paramByte) {
		this.logger.debug("enter insertSection_DaoImpl");
		try {
			String str = "SELECT COUNT(*) COUNT FROM V_CURCOMMODITY WHERE TRADEPARTITION = " + paramByte + " AND BARGAINTYPE = 0 AND SECTION = "
					+ paramString;
			if (Integer.parseInt(((Map) queryBySql(str).get(0)).get("COUNT").toString()) != 0) {
				updateOtherCurCommodity(paramString, paramArrayOfString, paramByte);
			}
			updateBYBulk(new CurCommodity(), "section = " + paramString, paramArrayOfString);
		} catch (Exception localException) {
			localException.printStackTrace();
			return Integer.valueOf(-1);
		}
		return Integer.valueOf(1);
	}

	public void updateOtherCurCommodity(String paramString, String[] paramArrayOfString, Byte paramByte) {
		try {
			String str1 = "SELECT CODE FROM V_CURCOMMODITY WHERE TRADEPARTITION = " + paramByte + " AND BARGAINTYPE = 0 AND SECTION >= "
					+ paramString;
			List localList = queryBySql(str1);
			String str2 = "";
			for (int i = localList.size() - 1; i >= 0; i--) {
				str2 = ((Map) localList.get(i)).get("CODE").toString();
				for (int j = 0; j < paramArrayOfString.length; j++) {
					if (paramArrayOfString[j].equals(str2)) {
						localList.remove(i);
					}
				}
			}
			String[] arrayOfString = new String[localList.size()];
			for (int j = 0; j < localList.size(); j++) {
				arrayOfString[j] = ((Map) localList.get(j)).get("CODE").toString();
			}
			if (localList.size() != 0) {
				updateBYBulk(new CurCommodity(), "section = section +1 ", arrayOfString);
			}
		} catch (Exception localException) {
			localException.printStackTrace();
		}
	}
}

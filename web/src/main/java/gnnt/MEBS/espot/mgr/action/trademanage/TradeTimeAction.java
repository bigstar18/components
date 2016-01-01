package gnnt.MEBS.espot.mgr.action.trademanage;

import java.rmi.RemoteException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.espot.core.kernel.IMgrService;
import gnnt.MEBS.espot.mgr.model.trademanage.TradeTime;
import gnnt.MEBS.espot.mgr.model.trademanage.TradeTimeRT;
import gnnt.MEBS.espot.mgr.model.trademanage.vo.BarginCalendarVO;

@Component("tradeTimeAction")
@Scope("request")
public class TradeTimeAction extends EcsideAction {
	private static final long serialVersionUID = -7134548680962006682L;
	@Autowired
	@Qualifier("mgrService")
	private IMgrService mgrService;

	public IMgrService getMgrService() {
		return this.mgrService;
	}

	public void setMgrService(IMgrService paramIMgrService) {
		this.mgrService = paramIMgrService;
	}

	public String fowardTradeDaySet() {
		TradeTime localTradeTime = new TradeTime();
		localTradeTime.setId(Long.valueOf(1L));
		localTradeTime = (TradeTime) super.getService().get(localTradeTime);
		this.request.setAttribute("tradeTime", localTradeTime);
		TradeTimeRT localTradeTimeRT = new TradeTimeRT();
		localTradeTimeRT.setId(Long.valueOf(1L));
		localTradeTimeRT = (TradeTimeRT) super.getService().get(localTradeTimeRT);
		this.request.setAttribute("tradeTimeRT", localTradeTimeRT);
		SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			this.request.setAttribute("dateNow", localSimpleDateFormat.format(this.mgrService.getCurDbDate()));
		} catch (RemoteException localRemoteException) {
			this.logger.debug(Tools.getExceptionTrace(localRemoteException));
		}
		return "success";
	}

	public String updateTradeDay() {
		TradeTime localTradeTime = (TradeTime) this.entity;
		String[] arrayOfString1 = this.request.getParameterValues("weeks");
		String str1 = this.request.getParameter("mark");
		if (str1 == "1") {
		}
		str1 = "2";
		StringBuilder localStringBuilder = new StringBuilder();
		String str2 = "";
		if (arrayOfString1 != null) {
			for (String str3 : arrayOfString1) {
				localStringBuilder.append(str3).append(",");
				String str4 = "";
				if ("2".equals(str3)) {
					str4 = "一";
				} else if ("3".equals(str3)) {
					str4 = "二";
				} else if ("4".equals(str3)) {
					str4 = "三";
				} else if ("5".equals(str3)) {
					str4 = "四";
				} else if ("6".equals(str3)) {
					str4 = "五";
				} else if ("7".equals(str3)) {
					str4 = "六";
				} else if ("1".equals(str3)) {
					str4 = "日";
				}
				str2 = str2 + str4;
			}
		}
		if (localStringBuilder.length() > 0) {
			localStringBuilder.deleteCharAt(localStringBuilder.lastIndexOf(","));
		}
		this.request.setAttribute("mark", str1);
		localTradeTime.setRestWeekday(localStringBuilder.toString());
		super.getService().update(this.entity);
		addReturnValue(1, 230000L);
		writeOperateLog(2306, "交易日设置，非交易星期为：" + str2 + ",非交易日日期为：" + localTradeTime.getHoliday(), 1, "");
		return "success";
	}

	public String updateTradeDayRT() {
		try {
			String str1 = this.request.getParameter("mark");
			System.out.println(str1.equals("0"));
			if (str1.equals("0")) {
				updateTradeDay();
			}
			TradeTime localTradeTime = (TradeTime) this.entity;
			String[] arrayOfString = this.request.getParameterValues("weeks");
			StringBuilder localStringBuilder = new StringBuilder();
			String str2 = "";
			if ((arrayOfString != null) && (arrayOfString.length > 0)) {
				for (String str3 : arrayOfString) {
					localStringBuilder.append(str3).append(",");
					String str4 = "";
					if ("2".equals(str3)) {
						str4 = "一";
					} else if ("3".equals(str3)) {
						str4 = "二";
					} else if ("4".equals(str3)) {
						str4 = "三";
					} else if ("5".equals(str3)) {
						str4 = "四";
					} else if ("6".equals(str3)) {
						str4 = "五";
					} else if ("7".equals(str3)) {
						str4 = "六";
					} else if ("1".equals(str3)) {
						str4 = "日";
					}
					str2 = str2 + str4;
				}
			}
			if (localStringBuilder.length() > 0) {
				localStringBuilder.deleteCharAt(localStringBuilder.lastIndexOf(","));
			}
			this.logger.debug("星期：" + localStringBuilder.toString() + " 日期：" + localTradeTime.getHoliday());
			String sql = "update E_TRADETIME_RT set restWeekday='" + localStringBuilder.toString() + "',holiday='" + localTradeTime.getHoliday()
					+ "'";
			super.getService().getDao().executeUpdateBySql(sql);
			this.mgrService.refreshTradeTime();
			writeOperateLog(2306, "交易日实时生效设置,非交易星期为：" + str2 + ",非交易日期为：" + localTradeTime.getHoliday(), 1, "");
		} catch (RemoteException localRemoteException) {
			this.logger.error("实时生效RMI调用异常！");
			writeOperateLog(2306, "交易日实时生效", 0, localRemoteException.getMessage());
		}
		addReturnValue(1, 230000L);
		return "success";
	}

	public String fowardTradeTime() {
		TradeTime localTradeTime = new TradeTime();
		localTradeTime.setId(Long.valueOf(1L));
		localTradeTime = (TradeTime) super.getService().get(localTradeTime);
		this.request.setAttribute("tradeTime", localTradeTime);
		TradeTimeRT localTradeTimeRT = new TradeTimeRT();
		localTradeTimeRT.setId(Long.valueOf(1L));
		localTradeTimeRT = (TradeTimeRT) super.getService().get(localTradeTimeRT);
		this.request.setAttribute("tradeTimeRT", localTradeTimeRT);
		return "success";
	}

	public String updateTradeTime() {
		super.getService().update(this.entity);
		addReturnValue(1, 230000L);
		TradeTime localTradeTime = (TradeTime) this.entity;
		writeOperateLog(2306, "交易节设置,开始时间为：" + localTradeTime.getTradeStartTime() + ",结束时间为：" + localTradeTime.getTradeEndTime(), 1, "");
		return "success";
	}

	public String updateTradeTimeRT() {
		try {
			String str1 = this.request.getParameter("mark");
			System.out.println(str1.equals("0"));
			if (str1.equals("0")) {
				updateTradeTime();
			}
			TradeTime localTradeTime = (TradeTime) this.entity;
			String str2 = "update E_TRADETIME_RT set tradeStartTime='" + localTradeTime.getTradeStartTime() + "',tradeEndTime='"
					+ localTradeTime.getTradeEndTime() + "'";
			super.getService().getDao().executeUpdateBySql(str2);
			this.mgrService.refreshTradeTime();
			writeOperateLog(2306, "交易节实时生效设置,开始时间为：" + localTradeTime.getTradeStartTime() + ",结束时间为：" + localTradeTime.getTradeEndTime(), 1, "");
		} catch (RemoteException localRemoteException) {
			this.logger.error("实时生效RMI调用异常！");
			writeOperateLog(2306, "交易节实时生效设置", 0, localRemoteException.getMessage());
		}
		addReturnValue(1, 230000L);
		return "success";
	}

	public String fowardTradeCalendar() {
		TradeTimeRT localTradeTimeRT = new TradeTimeRT();
		localTradeTimeRT.setId(Long.valueOf(1L));
		localTradeTimeRT = (TradeTimeRT) super.getService().get(localTradeTimeRT);
		Calendar localCalendar = Calendar.getInstance();
		String str1 = this.request.getParameter("month");
		String str2 = this.request.getParameter("year");
		localCalendar.set(5, 1);
		if ((str1 != null) && (!str1.equals("null"))) {
			localCalendar.set(2, Integer.parseInt(str1));
		}
		if ((str2 != null) && (!str2.equals("null"))) {
			localCalendar.set(1, Integer.parseInt(str2));
		}
		this.request.setAttribute("returnYear", String.valueOf(localCalendar.get(1)));
		this.request.setAttribute("returnMonth", String.valueOf(localCalendar.get(2)));
		str2 = String.valueOf(localCalendar.get(1));
		str1 = String.valueOf(localCalendar.get(2));
		localCalendar.setFirstDayOfWeek(1);
		localCalendar.set(5, 1);
		int i = localCalendar.get(7) - 1;
		int j = localCalendar.getActualMaximum(5);
		int k = i + 1;
		String[] arrayOfString1 = new String[42];
		for (int m = 0; m < 42; m++) {
			arrayOfString1[m] = "";
		}
		HashMap localHashMap = new HashMap();
		for (int n = 0; n < j; n++) {
			arrayOfString1[(i + n)] = String.valueOf(n + 1);
			BarginCalendarVO localObject1 = new BarginCalendarVO();
			((BarginCalendarVO) localObject1).setWeek(k);
			k++;
			if (k > 7) {
				k = 1;
			}
			localHashMap.put(String.valueOf(n + 1), localObject1);
		}
		String str3 = localTradeTimeRT.getRestWeekday();
		Object localObject2;
		BarginCalendarVO localBarginCalendarVO;
		if (str3 != null) {
			String[] localObject1 = str3.split(",");
			for (int i1 = 0; i1 < localObject1.length; i1++) {
				if ((localObject1[i1] != null) && (!"".equals(localObject1[i1]))) {
					localObject2 = localHashMap.entrySet();
					Iterator localIterator = ((Set) localObject2).iterator();
					while (localIterator.hasNext()) {
						Map.Entry localEntry = (Map.Entry) localIterator.next();
						localBarginCalendarVO = (BarginCalendarVO) localEntry.getValue();
						if ((localBarginCalendarVO.getWeek() == Integer.parseInt(localObject1[i1])) && (localBarginCalendarVO.getStatus() == 2)) {
							localBarginCalendarVO.setStatus(-2);
						}
					}
				}
			}
		}
		Object localObject1 = localTradeTimeRT.getHoliday();
		if (localObject1 != null) {
			String[] arrayOfString2 = ((String) localObject1).split(",");
			for (String localBarginCalendarVO1 : arrayOfString2) {
				if ((Integer.valueOf(localBarginCalendarVO1.substring(0, 4)).equals(Integer.valueOf(str2)))
						&& (Integer.valueOf(localBarginCalendarVO1.substring(5, 7)).intValue() == Integer.valueOf(str1).intValue() + 1)) {
					((BarginCalendarVO) localHashMap.get(Integer.valueOf(localBarginCalendarVO1.substring(8, 10)) + "")).setStatus(-2);
				}
			}
		}
		this.request.setAttribute("month", str1);
		this.request.setAttribute("year", str2);
		this.request.setAttribute("days", arrayOfString1);
		this.request.setAttribute("bcs", localHashMap);
		return "success";
	}
}

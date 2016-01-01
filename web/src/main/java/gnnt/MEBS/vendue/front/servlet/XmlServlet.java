package gnnt.MEBS.vendue.front.servlet;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import gnnt.MEBS.common.front.model.integrated.User;
import gnnt.MEBS.priceranking.server.model.Commodity;
import gnnt.MEBS.priceranking.server.model.Order;
import gnnt.MEBS.priceranking.server.model.ResultOrder;
import gnnt.MEBS.priceranking.server.model.SystemPartition;
import gnnt.MEBS.priceranking.server.model.SystemStatus;
import gnnt.MEBS.priceranking.server.rmi.ServerRMI;
import gnnt.MEBS.priceranking.server.rmi.TradeRMI;
import gnnt.MEBS.vendue.front.init.Init;
import gnnt.MEBS.vendue.front.init.InitLoad;
import gnnt.MEBS.vendue.front.model.BreedProperty;
import gnnt.MEBS.vendue.front.model.OrderParams;
import gnnt.MEBS.vendue.front.model.ParamValue;
import gnnt.MEBS.vendue.front.model.SettleParams;
import gnnt.MEBS.vendue.front.service.FirmLimit;
import gnnt.MEBS.vendue.front.service.TradeService;

public class XmlServlet extends HttpServlet {
	private static final long serialVersionUID = 3906934490856239410L;
	Logger logger = Logger.getLogger("XMLServletLog");
	private TradeRMI tradeRMI = null;
	private ServerRMI serverRMI = null;
	private TradeService tradeService = null;

	public void init() throws ServletException {
		initRMI();
	}

	public void doGet(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException {
		execute(paramHttpServletRequest, paramHttpServletResponse);
	}

	public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException {
		execute(paramHttpServletRequest, paramHttpServletResponse);
	}

	public void execute(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException {
		String str = "";
		try {
			str = paramHttpServletRequest.getParameter("reqName");
		} catch (Exception localException) {
			this.logger.error("Servlet出错:" + localException);
			localException.printStackTrace();
		}
		if (str.equals("getSystemStatus")) {
			getSystemStatus(paramHttpServletRequest, paramHttpServletResponse);
		} else if (str.equals("getCurCode")) {
			getCurCode(paramHttpServletRequest, paramHttpServletResponse);
		} else if (str.equals("getCodeCount")) {
			getCodeCount(paramHttpServletRequest, paramHttpServletResponse);
		} else if (str.equals("getCodeCountStatus")) {
			getCodeCountStatus(paramHttpServletRequest, paramHttpServletResponse);
		} else if (str.equals("getCommodityByCode")) {
			getCommodityByCode(paramHttpServletRequest, paramHttpServletResponse);
		} else if (str.equals("order")) {
			order(paramHttpServletRequest, paramHttpServletResponse);
		} else if (str.equals("orderYaliCeshi")) {
			orderYaliCeshi(paramHttpServletRequest, paramHttpServletResponse);
		} else if (str.equals("getCommodityDetail")) {
			getCommodityDetail(paramHttpServletRequest, paramHttpServletResponse);
		} else if (str.equals("addCode")) {
			addCode(paramHttpServletRequest, paramHttpServletResponse);
		} else if (str.equals("cancelCode")) {
			cancelCode(paramHttpServletRequest, paramHttpServletResponse);
		} else if (str.equals("getSystemTime")) {
			getSystemTime(paramHttpServletRequest, paramHttpServletResponse);
		} else if (str.equals("addCodeForward")) {
			addCodeForward(paramHttpServletRequest, paramHttpServletResponse);
		} else if (str.equals("codeApply")) {
			codeApply(paramHttpServletRequest, paramHttpServletResponse);
		}
	}

	protected void getSystemStatus(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) {
		short s = Short.parseShort(paramHttpServletRequest.getParameter("partitionId"));
		SystemStatus localSystemStatus = null;
		try {
			localSystemStatus = this.serverRMI.getSystemStatus(s);
		} catch (RemoteException localRemoteException) {
			localRemoteException.printStackTrace();
		}
		int i = localSystemStatus.getStatus();
		int j = localSystemStatus.getUnitId();
		String str1 = localSystemStatus.getPartStartTime().toString().substring(11, 19);
		String str2 = localSystemStatus.getPartLastEndTime().toString().substring(11, 19);
		String str3 = "";
		if (localSystemStatus.getPartCompelEndTime() != null) {
			str3 = localSystemStatus.getPartCompelEndTime().toString().substring(11, 19);
		}
		StringBuffer localStringBuffer = new StringBuffer();
		localStringBuffer.append("<RESULT>").append("<STATUS>").append(i).append("</STATUS>").append("<UNITID>").append(j).append("</UNITID>")
				.append("<STIME>").append(str1).append("</STIME>").append("<ETIME>").append(str2).append("</ETIME>").append("<CTIME>").append(str3)
				.append("</CTIME>");
		localStringBuffer.append("</RESULT>");
		renderXML(paramHttpServletResponse, localStringBuffer.toString());
	}

	protected void getCurCode(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) {
		List localList = null;
		short s = Short.parseShort(paramHttpServletRequest.getParameter("partitionId"));
		try {
			localList = this.tradeRMI.getCommodityCode(s);
		} catch (RemoteException localRemoteException) {
			localRemoteException.printStackTrace();
		}
		StringBuffer localStringBuffer = new StringBuffer();
		localStringBuffer.append("<RESULT>");
		for (int i = 0; i < localList.size(); i++) {
			String str = (String) localList.get(i);
			localStringBuffer.append("<CODE>").append(str).append("</CODE>");
		}
		localStringBuffer.append("</RESULT>");
		renderXML(paramHttpServletResponse, localStringBuffer.toString());
	}

	protected void getCodeCountStatus(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) {
		short s = Short.parseShort(paramHttpServletRequest.getParameter("partitionId"));
		String str1 = "0";
		String str2 = "0";
		String[] arrayOfString = null;
		String str3 = "";
		try {
			str3 = this.tradeRMI.getCounterCommodity(s);
		} catch (RemoteException localRemoteException) {
			localRemoteException.printStackTrace();
		}
		arrayOfString = str3.split(",");
		str1 = arrayOfString[0];
		str2 = arrayOfString[2];
		StringBuffer localStringBuffer = new StringBuffer();
		localStringBuffer.append("<RESULT>");
		localStringBuffer.append("<CS>").append(str1).append("</CS>").append("<OS>").append(str2).append("</OS>");
		localStringBuffer.append("</RESULT>");
		renderXML(paramHttpServletResponse, localStringBuffer.toString());
	}

	protected void getCodeCount(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) {
		short s = Short.parseShort(paramHttpServletRequest.getParameter("partitionId"));
		int i = -1;
		try {
			i = this.tradeRMI.getRightNowCountdown(s);
		} catch (RemoteException localRemoteException) {
			localRemoteException.printStackTrace();
		}
		StringBuffer localStringBuffer = new StringBuffer();
		localStringBuffer.append("<RESULT>");
		localStringBuffer.append("<COUNT>").append(i).append("</COUNT>");
		localStringBuffer.append("</RESULT>");
		renderXML(paramHttpServletResponse, localStringBuffer.toString());
	}

	protected void getCommodityByCode(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
			throws ServletException {
		short s = Short.parseShort(paramHttpServletRequest.getParameter("partitionId"));
		String str = paramHttpServletRequest.getParameter("code");
		Commodity localCommodity = null;
		try {
			localCommodity = this.tradeRMI.getCurCommodity(s, str);
		} catch (RemoteException localRemoteException) {
			localRemoteException.printStackTrace();
		}
		double d = localCommodity.getAmount();
		paramHttpServletRequest.setAttribute("amount", Double.valueOf(d));
		try {
			if (s == 1) {
				paramHttpServletRequest.getRequestDispatcher("/vendue1_nkst/submit/order.jsp").forward(paramHttpServletRequest,
						paramHttpServletResponse);
			} else {
				paramHttpServletRequest.getRequestDispatcher("/vendue2_nkst/submit/order.jsp").forward(paramHttpServletRequest,
						paramHttpServletResponse);
			}
		} catch (IOException localIOException) {
			localIOException.printStackTrace();
		}
	}

	protected void order(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException {
		String str1 = (String) paramHttpServletRequest.getSession().getAttribute("FIRMID");
		Long localLong = (Long) paramHttpServletRequest.getSession().getAttribute("LOGINID");
		String str2 = (String) paramHttpServletRequest.getSession().getAttribute("TRADERID");
		short s1 = Short.parseShort(paramHttpServletRequest.getParameter("partitionId"));
		User localUser = (User) paramHttpServletRequest.getSession().getAttribute("CurrentUser");
		Map localMap = Init.sysPartitions;
		int i = Integer.parseInt(paramHttpServletRequest.getParameter("authorization"));
		int j = 0;
		String str3 = "提交失败！";
		try {
			if (str1 != null) {
				OrderParams localOrderParams = (OrderParams) paramHttpServletRequest.getSession().getAttribute("orderParams");
				int k = -1;
				Order localOrder = new Order();
				String str5 = paramHttpServletRequest.getParameter("commodityId");
				String str6 = paramHttpServletRequest.getRemoteAddr();
				ResultOrder localResultOrder = null;
				HashMap localHashMap = localOrderParams.getMap();
				ParamValue localParamValue = (ParamValue) localHashMap.get(str5);
				if (localParamValue != null) {
					String str7 = localParamValue.getCode();
					String str8 = localParamValue.getCommodityId();
					String str9 = localParamValue.getPrice();
					String str10 = localParamValue.getAmount();
					if ((str7 != null) && (str8 != null) && (str9 != null) && (str10 != null) && (paramHttpServletRequest.getParameter(str7) != null)
							&& (paramHttpServletRequest.getParameter(str8) != null) && (paramHttpServletRequest.getParameter(str9) != null)
							&& (paramHttpServletRequest.getParameter(str10) != null)) {
						String str11 = paramHttpServletRequest.getParameter(str7);
						String str12 = paramHttpServletRequest.getParameter(str8);
						double d1 = Double.parseDouble(paramHttpServletRequest.getParameter(str9));
						double d2 = Double.parseDouble(paramHttpServletRequest.getParameter(str10));
						localHashMap.remove(str5);
						SystemPartition localSystemPartition = (SystemPartition) localMap.get(Short.valueOf(s1));
						short s2 = localSystemPartition.getTradeMode();
						FirmLimit localFirmLimit = (FirmLimit) Class.forName(localSystemPartition.getFirmLimitClass()).newInstance();
						j = localFirmLimit.validateFirm(str11, paramHttpServletRequest, i, s2);
						if (j == 1) {
							int m = 1;
							if ((s2 == 3) && (localSystemPartition.getIsShowPrice() == 1)) {
								Commodity localCommodity = this.tradeRMI.getCurCommodity(s1, str11);
								int n = localCommodity.getBs_flag();
								double d3 = localCommodity.getAlertPrice().doubleValue();
								double d4 = localCommodity.getBeginPrice().doubleValue();
								if (n == 1) {
									if (d1 > d4) {
										m = 0;
										str3 = "提交失败，报单价大于起拍价！";
									} else if (d1 < d3) {
										m = 0;
										str3 = "提交失败，报单价小于报警价！";
									}
								} else if (d1 < d4) {
									m = 0;
									str3 = "提交失败，报单价小于起拍价！";
								} else if (d1 > d3) {
									m = 0;
									str3 = "提交失败，报单价大于报警价！";
								}
							}
							if (m == 1) {
								localOrder.setCode(str11);
								localOrder.setCommodityId(str12);
								localOrder.setTradePartition(s1);
								localOrder.setUserId(str1);
								localOrder.setAmount(d2);
								localOrder.setValidAmount(d2);
								localOrder.setPrice(Double.valueOf(d1));
								localOrder.setTraderId(str2);
								localResultOrder = this.tradeRMI.addOrder(s1, localOrder, localLong.longValue(), 21, localUser.getLogonType());
								k = localResultOrder.getRet();
								if (k == 1) {
									str3 = "提交成功！";
								} else if (k == -1) {
									str3 = "提交失败，登陆超时！";
								} else if (k == -2) {
									str3 = "提交失败，交易员不存在！";
								} else if (k == 101) {
									str3 = "提交失败，禁止下单！";
								} else if (k == 102) {
									str3 = "提交失败，资金不足！";
								} else if (k == 103) {
									str3 = "提交失败，委托进入DB异常！";
								} else if (k == 201) {
									str3 = "提交失败， 禁止连续下单！";
								} else if (k == 202) {
									str3 = "提交失败，交易商未登录！";
								} else if (k == 301) {
									str3 = "提交失败，该商品不存在！";
								} else if (k == 302) {
									str3 = "提交失败， 不在该商品交易时间！";
								} else if (k == 303) {
									str3 = "提交失败，不满足单位交易数量！";
								} else if (k == 304) {
									str3 = "提交失败，不满足最小报单数量！";
								} else if (k == 305) {
									str3 = "提交失败，不满足最大报单数量！";
								} else if (k == 306) {
									str3 = "提交失败，商品已删除，禁止交易！";
								} else if (k == 307) {
									str3 = "提交失败，不满足最小加价幅度 ！";
								} else if (k == 308) {
									str3 = "提交失败，不满足最高加价幅度 ！";
								} else if (k == 309) {
									str3 = "提交失败，委托数量大于商品总量！";
								} else if (k == 310) {
									str3 = "提交失败，不能引起行情变化 ！";
								} else if (k == 311) {
									str3 = "提交失败，报单价格不是加价幅度的倍数 ！";
								} else if (k == 312) {
									str3 = "提交失败，挂单方不允许报单 ！";
								}
								if (s2 == 1) {
									if (k == 401) {
										str3 = "提交失败，报单价小于最起拍价！";
									} else if (k == 402) {
										str3 = "提交失败，报单价大于报警价！";
									} else if (k == 403) {
										str3 = "提交失败，报单价小于或等于最优价！";
									}
								} else if (s2 == 2) {
									if (k == 501) {
										str3 = "提交失败，报单价大于最起拍价！";
									} else if (k == 502) {
										str3 = "提交失败，报单价小于报警价！";
									} else if (k == 503) {
										str3 = "提交失败，报单价大于或等于最优价！";
									}
								} else if ((s2 == 3) && (k == 601)) {
									str3 = "提交失败，已经有一次有效委托！";
								}
							}
						} else if (j == -101) {
							str3 = "提交失败，交易商没有权限  ！";
						} else if (j == -102) {
							str3 = "提交失败，交易商无权参与竞买交易！";
						} else if (j == -103) {
							str3 = "提交失败，交易商无权参与竞卖交易！";
						} else if (j == -104) {
							str3 = "提交失败，交易商无该商品交易权限！";
						}
						this.logger.error("下单信息:" + str3 + ",交易板块:" + s1 + ",交易商:" + str1 + ",标的号:" + str11 + ",商品码:" + str12 + ",重量:" + d2 + ",价格:"
								+ d1 + ",IP:" + str6);
					} else {
						str3 = "提交失败，下单超时！";
					}
				} else {
					str3 = "提交失败，下单超时！";
				}
			} else {
				str3 = "提交失败，登录超时！";
			}
		} catch (RemoteException localRemoteException) {
			str3 = "提交失败，服务器连接异常！";
		} catch (Exception localException) {
			localException.printStackTrace();
		}
		paramHttpServletRequest.setAttribute("msg", str3);
		try {
			String str4 = paramHttpServletRequest.getParameter("tradeModel");
			if ("1".equals(String.valueOf(str4))) {
				paramHttpServletRequest.getRequestDispatcher("/front/app/vendue/vendue1_nkst/submit/order.jsp?partitionId=" + s1)
						.forward(paramHttpServletRequest, paramHttpServletResponse);
			} else if ("2".equals(String.valueOf(str4))) {
				paramHttpServletRequest.getRequestDispatcher("/front/app/vendue/vendue2_nkst/submit/order.jsp?partitionId=" + s1)
						.forward(paramHttpServletRequest, paramHttpServletResponse);
			} else if ("3".equals(String.valueOf(str4))) {
				paramHttpServletRequest.getRequestDispatcher("/front/app/vendue/vendue3_nkst/submit/order.jsp?partitionId=" + s1)
						.forward(paramHttpServletRequest, paramHttpServletResponse);
			}
		} catch (IOException localIOException) {
			localIOException.printStackTrace();
		}
	}

	protected void orderYaliCeshi(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException {
		String str1 = paramHttpServletRequest.getParameter("firmId");
		User localUser = (User) paramHttpServletRequest.getSession().getAttribute("CurrentUser");
		Long localLong = Long.valueOf(123L);
		String str2 = paramHttpServletRequest.getParameter("traderId");
		short s = Short.parseShort(paramHttpServletRequest.getParameter("partitionId"));
		String str3 = "提交失败！";
		int i = -1;
		try {
			if (str1 != null) {
				Order localOrder = new Order();
				String str5 = paramHttpServletRequest.getRemoteAddr();
				ResultOrder localResultOrder = null;
				String str6 = paramHttpServletRequest.getParameter("code");
				String str7 = paramHttpServletRequest.getParameter("commodityId");
				double d1 = Double.parseDouble(paramHttpServletRequest.getParameter("orderPrice"));
				double d2 = Double.parseDouble(paramHttpServletRequest.getParameter("orderAmount"));
				localOrder.setCode(str6);
				localOrder.setCommodityId(str7);
				localOrder.setTradePartition(s);
				localOrder.setUserId(str1);
				localOrder.setAmount(d2);
				localOrder.setPrice(Double.valueOf(d1));
				localOrder.setTraderId(str2);
				localResultOrder = this.tradeRMI.addOrder(s, localOrder, localLong.longValue(), 21, localUser.getLogonType());
				i = localResultOrder.getRet();
				if (i == 1) {
					str3 = "提交成功！";
				} else if (i == -1) {
					str3 = "提交失败，登陆超时！";
				} else if (i == -2) {
					str3 = "提交失败，交易员不存在！";
				} else if (i == 101) {
					str3 = "提交失败，禁止下单！";
				} else if (i == 102) {
					str3 = "提交失败，资金不足！";
				} else if (i == 103) {
					str3 = "提交失败，委托进入DB异常！";
				} else if (i == 401) {
					str3 = "提交失败，交易商不存在！";
				} else if (i == 402) {
					str3 = "提交失败，交易商没有权限  ！";
				} else if (i == 405) {
					str3 = "提交失败，交易商无该商品交易权限！";
				}
				if (s == 1) {
					if (i == 201) {
						str3 = "提交失败，该商品不存在！";
					} else if (i == 202) {
						str3 = "提交失败， 不在该商品交易时间！";
					} else if (i == 203) {
						str3 = "提交失败，不满足单位交易数量！";
					} else if (i == 204) {
						str3 = "提交失败，不满足最小报单数量！";
					} else if (i == 205) {
						str3 = "提交失败，不满足最大报单数量！";
					} else if (i == 206) {
						str3 = "提交失败，不满足起拍价！";
					} else if (i == 207) {
						str3 = "提交失败，不满足加价幅度 ！";
					} else if (i == 208) {
						str3 = "提交失败，不满足最高加价幅度 ！";
					} else if (i == 209) {
						str3 = "提交失败，不满足竞买大于等于预警价！";
					} else if (i == 210) {
						str3 = "提交失败，报单数量异常！";
					} else if (i == 211) {
						str3 = "提交失败，不满足竞买大于上笔委托价！";
					} else if (i == 212) {
						str3 = "提交失败，不满足竞买大于等于上笔委托价！";
					} else if (i == 213) {
						str3 = "提交失败，商品已删除，禁止交易！";
					} else if (i == 403) {
						str3 = "提交失败，交易商无权参与竞买交易！";
					} else if (i == 601) {
						str3 = "提交失败，超过买量限制！";
					}
				} else if (s == 2) {
					if (i == 301) {
						str3 = "提交失败，该商品不存在！";
					} else if (i == 302) {
						str3 = "提交失败， 不在该商品交易时间！";
					} else if (i == 303) {
						str3 = "提交失败，不满足单位交易数量！";
					} else if (i == 304) {
						str3 = "提交失败，不满足最小报单数量！";
					} else if (i == 305) {
						str3 = "提交失败，不满足最大报单数量！";
					} else if (i == 306) {
						str3 = "提交失败，不满足起拍价！";
					} else if (i == 307) {
						str3 = "提交失败，不满足竞卖小于等于预警价 ！";
					} else if (i == 308) {
						str3 = "提交失败，不满足加价幅度  ！";
					} else if (i == 309) {
						str3 = "提交失败，不满足最高加价幅度！";
					} else if (i == 310) {
						str3 = "提交失败，报单数量异常！";
					} else if (i == 311) {
						str3 = "提交失败，大于可委托数量！";
					} else if (i == 312) {
						str3 = "提交失败，不满足竞卖小于上笔委托价！";
					} else if (i == 313) {
						str3 = "提交失败，不满足竞卖小于等于上笔委托价！";
					} else if (i == 314) {
						str3 = "提交失败，商品已删除，禁止交易！";
					} else if (i == 501) {
						str3 = "提交失败，10秒内不能下两笔委托！";
					} else if (i == 502) {
						str3 = "提交失败，1秒内只接受一笔有效单！";
					} else if (i == 503) {
						str3 = "提交失败，已达到60次！";
					} else if (i == 504) {
						str3 = "提交失败，该交易商已存在第60次的有效下单！";
					} else if (i == 404) {
						str3 = "提交失败，交易商无权参与竞卖交易！";
					}
				}
				this.logger.error(
						"下单信息:" + str3 + ",交易板块:" + s + ",交易商:" + str1 + ",标的号:" + str6 + ",商品码:" + str7 + ",重量:" + d2 + ",价格:" + d1 + ",IP:" + str5);
			} else {
				str3 = "提交失败，登录超时！";
			}
		} catch (RemoteException localRemoteException) {
			str3 = "提交失败，服务器连接异常！";
		} catch (Exception localException) {
		}
		System.out.println("返回信息：" + str3 + "," + i);
		paramHttpServletRequest.setAttribute("msg", str3);
		try {
			String str4 = paramHttpServletRequest.getParameter("tradeModel");
			if ("1".equals(String.valueOf(str4))) {
				paramHttpServletRequest.getRequestDispatcher("/front/app/vendue/vendue1_nkst/submit/order.jsp?partitionId=" + s)
						.forward(paramHttpServletRequest, paramHttpServletResponse);
			} else if ("2".equals(String.valueOf(str4))) {
				paramHttpServletRequest.getRequestDispatcher("/front/app/vendue/vendue2_nkst/submit/order.jsp?partitionId=" + s)
						.forward(paramHttpServletRequest, paramHttpServletResponse);
			} else if ("3".equals(String.valueOf(str4))) {
				paramHttpServletRequest.getRequestDispatcher("/front/app/vendue/vendue3_nkst/submit/order.jsp?partitionId=" + s)
						.forward(paramHttpServletRequest, paramHttpServletResponse);
			}
		} catch (IOException localIOException) {
			localIOException.printStackTrace();
		}
	}

	protected void getCommodityDetail(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
			throws ServletException {
		short s1 = Short.parseShort(paramHttpServletRequest.getParameter("partitionId"));
		String str1 = paramHttpServletRequest.getParameter("code");
		String str2 = paramHttpServletRequest.getParameter("flag");
		Commodity localCommodity = null;
		try {
			if ((str2 != null) && ("his".equals(str2))) {
				localCommodity = this.tradeService.getCode(str1);
			} else {
				localCommodity = this.tradeRMI.getCurCommodity(s1, str1);
			}
		} catch (RemoteException localRemoteException) {
			localRemoteException.printStackTrace();
		}
		double d1 = localCommodity.getAmount();
		double d2 = localCommodity.getBeginPrice().doubleValue();
		double d3 = localCommodity.getAlertPrice().doubleValue();
		double d4 = localCommodity.getStepPrice().doubleValue();
		double d5 = localCommodity.getMinAmount();
		double d6 = localCommodity.getMaxStepPrice().doubleValue();
		double d7 = localCommodity.getMaxAmount();
		short s2 = localCommodity.getMarginAlgr();
		double d8 = localCommodity.getB_security().doubleValue();
		double d9 = localCommodity.getS_security().doubleValue();
		short s3 = localCommodity.getFeeAlgr();
		double d10 = localCommodity.getB_fee().doubleValue();
		double d11 = localCommodity.getS_fee().doubleValue();
		paramHttpServletRequest.setAttribute("amount", Double.valueOf(d1));
		paramHttpServletRequest.setAttribute("beginPrice", Double.valueOf(d2));
		paramHttpServletRequest.setAttribute("alertPrice", Double.valueOf(d3));
		paramHttpServletRequest.setAttribute("stepPrice", Double.valueOf(d4));
		paramHttpServletRequest.setAttribute("minAmount", Double.valueOf(d5));
		paramHttpServletRequest.setAttribute("maxStepPrice", Double.valueOf(d6));
		paramHttpServletRequest.setAttribute("maxAmount", Double.valueOf(d7));
		paramHttpServletRequest.setAttribute("marginAlgr", Short.valueOf(s2));
		paramHttpServletRequest.setAttribute("b_security", Double.valueOf(d8));
		paramHttpServletRequest.setAttribute("s_security", Double.valueOf(d9));
		paramHttpServletRequest.setAttribute("feeAlgr", Short.valueOf(s3));
		paramHttpServletRequest.setAttribute("b_fee", Double.valueOf(d10));
		paramHttpServletRequest.setAttribute("s_fee", Double.valueOf(d11));
		try {
			String str3 = paramHttpServletRequest.getParameter("tradeModel");
			if ("1".equals(String.valueOf(str3))) {
				paramHttpServletRequest.getRequestDispatcher("/front/app/vendue/vendue1_nkst/submit/commodityDetail.jsp")
						.forward(paramHttpServletRequest, paramHttpServletResponse);
			} else if ("2".equals(String.valueOf(str3))) {
				paramHttpServletRequest.getRequestDispatcher("/front/app/vendue/vendue2_nkst/submit/commodityDetail.jsp")
						.forward(paramHttpServletRequest, paramHttpServletResponse);
			} else if ("3".equals(String.valueOf(str3))) {
				paramHttpServletRequest.getRequestDispatcher("/front/app/vendue/vendue3_nkst/submit/commodityDetail.jsp")
						.forward(paramHttpServletRequest, paramHttpServletResponse);
			}
		} catch (IOException localIOException) {
			localIOException.printStackTrace();
		}
	}

	protected void addCode(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException {
		String str1 = paramHttpServletRequest.getParameter("code");
		int i = Short.parseShort(paramHttpServletRequest.getParameter("partitionId"));
		String str2 = (String) paramHttpServletRequest.getSession().getAttribute("FIRMID");
		int j = 1;
		try {
			j = this.tradeService.addCode(str1, i, str2);
		} catch (Exception localException) {
		}
		StringBuffer localStringBuffer = new StringBuffer();
		localStringBuffer.append("<RESULT>");
		localStringBuffer.append("<RET>").append(j).append("</RET>");
		localStringBuffer.append("</RESULT>");
		renderXML(paramHttpServletResponse, localStringBuffer.toString());
	}

	protected void cancelCode(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException {
		String str1 = paramHttpServletRequest.getParameter("code");
		int i = Short.parseShort(paramHttpServletRequest.getParameter("partitionId"));
		String str2 = (String) paramHttpServletRequest.getSession().getAttribute("FIRMID");
		String str3 = "";
		int j;
		try {
			j = this.tradeService.cancelCode(str1, i, str2);
			if (j == 1) {
				str3 = this.tradeService.getChoiceCode(i, str2);
			}
		} catch (Exception localException) {
			j = -1;
		}
		StringBuffer localStringBuffer = new StringBuffer();
		localStringBuffer.append("<RESULT>");
		localStringBuffer.append("<RET>").append(j).append("</RET>");
		localStringBuffer.append("<CD>").append(str1).append("</CD>");
		localStringBuffer.append("<CDS>").append(str3).append("</CDS>");
		localStringBuffer.append("</RESULT>");
		renderXML(paramHttpServletResponse, localStringBuffer.toString());
	}

	protected void getSystemTime(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException {
		String str = null;
		try {
			str = this.serverRMI.getSystemTime();
		} catch (RemoteException localRemoteException) {
			localRemoteException.printStackTrace();
		}
		StringBuffer localStringBuffer = new StringBuffer();
		localStringBuffer.append("<RESULT>");
		localStringBuffer.append("<RET>").append(str).append("</RET>");
		localStringBuffer.append("</RESULT>");
		renderXML(paramHttpServletResponse, localStringBuffer.toString());
	}

	protected void addCodeForward(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException {
		short s = Short.parseShort(paramHttpServletRequest.getParameter("partitionId"));
		Map localMap1 = Init.sysPartitions;
		SystemPartition localSystemPartition = (SystemPartition) localMap1.get(Short.valueOf(s));
		int i = localSystemPartition.getTradeMode();
		Map localMap2 = this.tradeService.getBreeds();
		paramHttpServletRequest.setAttribute("breeds", localMap2);
		try {
			if (i == 1) {
				paramHttpServletRequest.getRequestDispatcher("/front/app/vendue/vendue1_nkst/submit/commodities_add.jsp")
						.forward(paramHttpServletRequest, paramHttpServletResponse);
			} else if (i == 2) {
				paramHttpServletRequest.getRequestDispatcher("/front/app/vendue/vendue2_nkst/submit/commodities_add.jsp")
						.forward(paramHttpServletRequest, paramHttpServletResponse);
			} else if (i == 3) {
				paramHttpServletRequest.getRequestDispatcher("/front/app/vendue/vendue3_nkst/submit/commodities_add.jsp")
						.forward(paramHttpServletRequest, paramHttpServletResponse);
			}
		} catch (IOException localIOException) {
			localIOException.printStackTrace();
		}
	}

	protected void codeApply(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException {
		String str1 = "挂单失败！";
		short s1 = Short.parseShort(paramHttpServletRequest.getParameter("partitionId"));
		Short localShort = Short.valueOf(Short.parseShort(paramHttpServletRequest.getParameter("breedid")));
		String str2 = paramHttpServletRequest.getParameter("commodityid");
		Double localDouble1 = Double.valueOf(Double.parseDouble(paramHttpServletRequest.getParameter("beginprice")));
		Double localDouble2 = Double.valueOf(Double.parseDouble(paramHttpServletRequest.getParameter("alertprice")));
		Double localDouble3 = Double.valueOf(Double.parseDouble(paramHttpServletRequest.getParameter("amount")));
		Double localDouble4 = Double.valueOf(Double.parseDouble(paramHttpServletRequest.getParameter("tradeunit")));
		Double localDouble5 = Double.valueOf(Double.parseDouble(paramHttpServletRequest.getParameter("minamount")));
		Double localDouble6 = Double.valueOf(Double.parseDouble(paramHttpServletRequest.getParameter("maxamount")));
		Double localDouble7 = Double.valueOf(Double.parseDouble(paramHttpServletRequest.getParameter("stepprice")));
		Byte localByte1 = Byte.valueOf(Byte.parseByte(paramHttpServletRequest.getParameter("flowamountalgr")));
		Double localDouble8 = Double.valueOf(Double.parseDouble(paramHttpServletRequest.getParameter("flowamount")));
		Byte localByte2 = Byte.valueOf(Byte.parseByte(paramHttpServletRequest.getParameter("marginalgr")));
		Byte localByte3 = Byte.valueOf(Byte.parseByte(paramHttpServletRequest.getParameter("feealgr")));
		Double localDouble9 = Double.valueOf(Double.parseDouble(paramHttpServletRequest.getParameter("sSecurity")));
		Double localDouble10 = Double.valueOf(Double.parseDouble(paramHttpServletRequest.getParameter("bSecurity")));
		Double localDouble11 = Double.valueOf(Double.parseDouble(paramHttpServletRequest.getParameter("sFee")));
		Double localDouble12 = Double.valueOf(Double.parseDouble(paramHttpServletRequest.getParameter("bFee")));
		String str3 = (String) paramHttpServletRequest.getSession().getAttribute("FIRMID");
		short s2 = Short.parseShort(paramHttpServletRequest.getParameter("bs_flag"));
		if (localByte1.byteValue() == 1) {
			localDouble8 = Double.valueOf(localDouble8.doubleValue() / 100.0D);
		}
		if (localByte2.byteValue() == 1) {
			localDouble10 = Double.valueOf(localDouble10.doubleValue() / 100.0D);
			localDouble9 = Double.valueOf(localDouble9.doubleValue() / 100.0D);
		}
		if (localByte3.byteValue() == 1) {
			localDouble12 = Double.valueOf(localDouble12.doubleValue() / 100.0D);
			localDouble11 = Double.valueOf(localDouble11.doubleValue() / 100.0D);
		}
		Commodity localCommodity = new Commodity();
		localCommodity.setAlertPrice(localDouble2);
		localCommodity.setAmount(localDouble3.doubleValue());
		localCommodity.setAuthorization((short) 0);
		localCommodity.setB_fee(localDouble12);
		localCommodity.setB_security(localDouble10);
		localCommodity.setBeginPrice(localDouble1);
		localCommodity.setBreedId(localShort.shortValue());
		localCommodity.setCommodityId(str2);
		localCommodity.setCreateTime(new Date());
		localCommodity.setFeeAlgr((short) localByte3.byteValue());
		localCommodity.setFirstTime(new Date());
		localCommodity.setFlowAmount(localDouble8.doubleValue());
		localCommodity.setFlowAmountAlgr((short) localByte1.byteValue());
		localCommodity.setIsOrder((short) 0);
		localCommodity.setMarginAlgr((short) localByte2.byteValue());
		localCommodity.setMaxAmount(localDouble6.doubleValue());
		localCommodity.setMaxStepPrice(Double.valueOf(0.0D));
		localCommodity.setMinAmount(localDouble5.doubleValue());
		localCommodity.setUserId(str3);
		localCommodity.setS_fee(localDouble11);
		localCommodity.setS_security(localDouble9);
		localCommodity.setSplitId(0);
		localCommodity.setStatus((short) 2);
		localCommodity.setStepPrice(localDouble7);
		localCommodity.setTradePartition(s1);
		localCommodity.setTradeUnit(localDouble4.doubleValue());
		localCommodity.setBs_flag(s2);
		ArrayList localArrayList = new ArrayList();
		Integer localInteger = Integer.valueOf(Integer.parseInt(paramHttpServletRequest.getParameter("propamount")));
		for (int i = 0; i < (localInteger == null ? 0 : localInteger.intValue()); i++) {
			String str4 = paramHttpServletRequest.getParameter("propid_" + i);
			String localObject = paramHttpServletRequest.getParameter("propname_" + i);
			String str5 = paramHttpServletRequest.getParameter("propvalue_" + i);
			SettleParams localSettleParams = new SettleParams();
			localSettleParams.setAttributeid(Long.valueOf(Long.parseLong(str4)));
			localSettleParams.setAttribute((String) localObject);
			localSettleParams.setValue(str5);
			localArrayList.add(localSettleParams);
		}
		int i = -1;
		try {
			i = this.tradeService.addCodeApply(localCommodity, localArrayList);
			if (i == 1) {
				str1 = "挂单成功！";
			}
		} catch (Exception localException) {
			localException.printStackTrace();
		}
		paramHttpServletRequest.setAttribute("msg", str1);
		Map localMap = Init.sysPartitions;
		Object localObject = (SystemPartition) localMap.get(Short.valueOf(s1));
		int j = ((SystemPartition) localObject).getTradeMode();
		try {
			if (j == 1) {
				paramHttpServletRequest.getRequestDispatcher("/front/app/vendue/vendue1_nkst/submit/commodities_add.jsp")
						.forward(paramHttpServletRequest, paramHttpServletResponse);
			} else if (j == 2) {
				paramHttpServletRequest.getRequestDispatcher("/front/app/vendue/vendue2_nkst/submit/commodities_add.jsp")
						.forward(paramHttpServletRequest, paramHttpServletResponse);
			} else if (j == 3) {
				paramHttpServletRequest.getRequestDispatcher("/front/app/vendue/vendue3_nkst/submit/commodities_add.jsp")
						.forward(paramHttpServletRequest, paramHttpServletResponse);
			}
		} catch (IOException localIOException) {
			localIOException.printStackTrace();
		}
	}

	protected void getBreedProperty(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
			throws ServletException {
		String str1 = paramHttpServletRequest.getParameter("breedid");
		List localList1 = this.tradeService.getBreedProperty(str1);
		StringBuffer localStringBuffer = new StringBuffer();
		int i = -1;
		if ((localList1 != null) && (localList1.size() > 0)) {
			localStringBuffer.append("<table>");
			localStringBuffer.append("<tr><td width='25%'></td><td width='25%'></td><td width='25%'></td><td width='25%'></td></tr>");
			for (int j = 0; j < localList1.size(); j++) {
				BreedProperty localObject = (BreedProperty) localList1.get(j);
				if (j % 2 == 0) {
					localStringBuffer.append("<tr>");
				}
				if (("Y".equals(((BreedProperty) localObject).getHasvaluedict())) && (((BreedProperty) localObject).getValues().size() > 0)) {
					localStringBuffer.append("<td align='right'>");
					if ("Y".equals(((BreedProperty) localObject).getIsnecessary())) {
						localStringBuffer.append("<font color='#ff0000'>*</font>");
					}
					localStringBuffer.append(((BreedProperty) localObject).getPropertyname() + "：</td>");
					localStringBuffer.append("<td>");
					localStringBuffer.append("<select id='prop_" + ((BreedProperty) localObject).getPropertyid() + "' value=''>");
					if ("N".equals(((BreedProperty) localObject).getIsnecessary())) {
						localStringBuffer.append("<option id='' value=''>请选择</option>");
					}
					List localList2 = ((BreedProperty) localObject).getValues();
					for (int k = 0; k < localList2.size(); k++) {
						localStringBuffer.append("<option id=='prop_" + ((BreedProperty) localObject).getPropertyid() + "_" + localList2.get(k)
								+ "' value='" + localList2.get(k) + "'>" + localList2.get(k) + "</option>");
					}
					localStringBuffer.append("</select>");
					localStringBuffer.append("</td>");
				} else if ("N".equals(((BreedProperty) localObject).getHasvaluedict())) {
					localStringBuffer.append("<td align='right'>");
					if (((BreedProperty) localObject).getIsnecessary() == "Y") {
						localStringBuffer.append("<font color='#ff0000'>*</font>");
					}
					localStringBuffer.append(((BreedProperty) localObject).getPropertyname() + "：</td>");
					localStringBuffer.append("<td>");
					localStringBuffer.append("<input type='text' id='prop_" + ((BreedProperty) localObject).getPropertyid()
							+ "'  value='' style='width: 100; border:1px solid #9cc'/>");
					localStringBuffer.append("</td>");
				}
				if ((j % 2 == 1) || (j + 1 == localList1.size())) {
					localStringBuffer.append("</tr>");
				}
				i = 1;
			}
			localStringBuffer.append("</table>");
		}
		String str2 = localStringBuffer.toString();
		str2 = str2.replaceAll("<", "[[[");
		str2 = str2.replaceAll(">", "]]]");
		str2 = str2.replaceAll("&", "^^^");
		str2 = str2.replaceAll("/", "***");
		Object localObject = new StringBuffer();
		((StringBuffer) localObject).append("<RESULT>");
		((StringBuffer) localObject).append("<RET>").append(i).append("</RET>");
		((StringBuffer) localObject).append("<CT>").append(str2).append("</CT>");
		((StringBuffer) localObject).append("</RESULT>");
		System.out.println(((StringBuffer) localObject).toString());
		renderXML(paramHttpServletResponse, ((StringBuffer) localObject).toString());
	}

	protected void renderXML(HttpServletResponse paramHttpServletResponse, String paramString) {
		try {
			ServletOutputStream localServletOutputStream = paramHttpServletResponse.getOutputStream();
			paramHttpServletResponse.setHeader("Content-Type", "text/xml");
			BufferedOutputStream localBufferedOutputStream = null;
			localBufferedOutputStream = new BufferedOutputStream(localServletOutputStream);
			localBufferedOutputStream.write(paramString.getBytes());
			localBufferedOutputStream.flush();
			localBufferedOutputStream.close();
		} catch (IOException localIOException) {
			this.logger.error(localIOException.getMessage(), localIOException);
		}
	}

	public void initRMI() {
		this.tradeService = ((TradeService) InitLoad.getTradeObject("tradeService"));
		this.tradeRMI = this.tradeService.getTradeRMI();
		this.serverRMI = this.tradeService.getServerRMI();
	}
}

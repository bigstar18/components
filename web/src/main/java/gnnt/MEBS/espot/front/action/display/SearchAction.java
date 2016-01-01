package gnnt.MEBS.espot.front.action.display;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.front.action.StandardAction;
import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.statictools.ActionUtil;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.front.common.XTradeFrontGlobal;
import gnnt.MEBS.espot.front.dao.jdbc.OrderDAO;
import gnnt.MEBS.espot.front.model.commodity.Category;
import gnnt.MEBS.espot.front.model.trade.Order;
import gnnt.MEBS.espot.front.model.trade.XShop;
import net.sf.json.JSONArray;

@Controller("searchAction")
@Scope("request")
public class SearchAction extends StandardAction {
	private static final long serialVersionUID = 6080350642982096584L;
	@Autowired
	@Qualifier("orderDAO")
	private OrderDAO orderDAO;
	private JSONArray json;

	public String search() {
		String str1 = this.request.getParameter("type");
		if ((str1 == null) || (str1.equals(""))) {
			str1 = "O";
		}
		this.request.setAttribute("type", str1);
		String str2 = this.request.getParameter("param");
		if ((null == str2) || ("".equals(str2))) {
			str2 = "";
		}
		this.logger.debug("type:-------------------------" + str1);
		this.logger.debug("param:-------------------------" + str2);
		this.request.setAttribute("searchParam", str2);
		this.logger.debug("param:" + str2);
		if (str1.equals("O")) {
			return searchForOrder(str2);
		}
		if (str1.equals("U")) {
			return searchForUser(str2);
		}
		return "";
	}

	public String searchForOrder(String paramString) {
		paramString = paramString.toLowerCase();
		String str1 = "from Order o where ( lower(o.orderTitle)  like '%" + paramString + "%' "
				+ "or o.belongtoBreed in (from Breed b where lower(b.breedName) like '%" + paramString + "%')) and (o.status=0 or o.status=1) ";
		String str2 = this.request.getParameter("orderMode");
		try {
			String str3 = this.request.getParameter("priceMaxShow");
			String str4 = this.request.getParameter("priceMinShow");
			this.logger.debug("orderMode=" + str2 + ",priceMax=" + str3 + ",priceMin=" + str4);
			double d1;
			if ((str3 != null) && (!"".equals(str3)) && (str4 != null) && (!"".equals(str4)) && (!str3.equals(str4))) {
				d1 = Tools.strToDouble(str3, -1000.0D);
				double d2 = Tools.strToDouble(str4, -1000.0D);
				if (d1 < d2) {
					str1 = str1 + " and to_number(o.price) <=" + d2 + " and to_number(o.price) >=" + d1;
					this.request.setAttribute("priceMaxShow", str4);
					this.request.setAttribute("priceMinShow", str3);
				} else {
					str1 = str1 + " and to_number(o.price) <=" + d1 + " and to_number(o.price) >=" + d2;
					this.request.setAttribute("priceMaxShow", str3);
					this.request.setAttribute("priceMinShow", str4);
				}
			} else {
				if ((str3 != null) && (!"".equals(str3))) {
					d1 = Tools.strToDouble(str3, -1000.0D);
					str1 = str1 + " and to_number(o.price) <=" + d1;
				}
				if ((str4 != null) && (!"".equals(str4))) {
					d1 = Tools.strToDouble(str4, -1000.0D);
					str1 = str1 + " and to_number(o.price) >=" + d1;
				}
				this.request.setAttribute("priceMaxShow", str3);
				this.request.setAttribute("priceMinShow", str4);
			}
			PageRequest localPageRequest = ActionUtil.getPageRequest(this.request);
			if ((str2 != null) && (!"".equals(str2))) {
				str1 = str1 + " and o.belongtoBreed.tradeMode=" + str2;
			}
			str1 = str1 + " order by orderID desc";
			this.logger.debug("HQL ==" + str1);
			Page localPage = super.getService().getDao().queryByHQL(str1, null, localPageRequest, null);
			this.logger.debug("page:" + localPage);
			this.logger.debug("pageResult:" + localPage.getResult().size());
			this.request.setAttribute("pageInfo", localPage);
			this.request.setAttribute("orderMode", str2);
		} catch (Exception localException) {
			localException.printStackTrace();
		}
		return "success";
	}

	public String searchForUser(String paramString) {
		paramString = paramString.toLowerCase();
		try {
			PageRequest localPageRequest = ActionUtil.getPageRequest(this.request);
			Page localPage = this.orderDAO.getFirmByParamter(paramString, localPageRequest);
			this.logger.debug(Integer.valueOf(localPage.getPageNumber()));
			this.logger.debug("page:" + localPage);
			this.logger.debug("pageResult:" + localPage.getResult().size());
			this.request.setAttribute("pageInfo", localPage);
		} catch (Exception localException) {
			localException.printStackTrace();
		}
		return "success";
	}

	public String firmDetail() throws SQLException {
		XShop localXShop = (XShop) super.getService().get(this.entity);
		this.request.setAttribute("shop", localXShop);
		this.request.setAttribute("pageInfo", XTradeFrontGlobal.getCategoryPage());
		PageRequest localPageRequest = new PageRequest(new QueryConditions());
		localPageRequest.setPageSize(100000);
		Page localPage = this.orderDAO.getOrderByFirmID(localPageRequest, localXShop.getFirmID());
		ArrayList localArrayList = new ArrayList();
		if ((localPage != null) && (localPage.getResult().size() > 0)) {
			Iterator localObject1 = localPage.getResult().iterator();
			while (((Iterator) localObject1).hasNext()) {
				Order localObject2 = (Order) ((Iterator) localObject1).next();
				Iterator localIterator = XTradeFrontGlobal.getCategoryPage().getResult().iterator();
				while (localIterator.hasNext()) {
					Category localCategory = (Category) localIterator.next();
					if (((Order) localObject2).getCategoryID().equals(localCategory.getCategoryID())) {
						localArrayList.add(localCategory);
						break;
					}
				}
			}
		}
		this.request.setAttribute("categoryList", localArrayList);
		Object localObject1 = this.request.getParameter("bsFlag");
		if ((localObject1 == null) || ("".equals(localObject1))) {
			localObject1 = "A";
		}
		this.request.setAttribute("bsFlag", localObject1);
		Object localObject2 = this.request.getParameter("tbln");
		this.request.setAttribute("tbln", localObject2);
		this.request.setAttribute("accessShop", "Y");
		return "success";
	}

	public String showImages() throws IOException {
		this.logger.debug("enter showImages");
		HttpServletResponse localHttpServletResponse = ServletActionContext.getResponse();
		ServletOutputStream localServletOutputStream = null;
		XShop localXShop = (XShop) this.entity;
		localXShop = (XShop) getService().get(localXShop);
		try {
			localHttpServletResponse.setContentType("text/html");
			localServletOutputStream = localHttpServletResponse.getOutputStream();
			if (localXShop.getHeadImage() != null) {
				localServletOutputStream.write(localXShop.getHeadImage());
			} else {
				File localFile = new File(this.request.getSession().getServletContext()
						.getRealPath("/front/skinstyle/default/image/app/espot/display/shop/bg_top.jpg"));
				FileInputStream localFileInputStream = new FileInputStream(localFile);
				byte[] arrayOfByte = new byte['Ѐ'];
				while (localFileInputStream.read(arrayOfByte) > 0) {
					localServletOutputStream.write(arrayOfByte);
				}
				localFileInputStream.close();
			}
			localServletOutputStream.flush();
			localServletOutputStream.close();
			localServletOutputStream = null;
		} catch (Exception localException) {
			localException.printStackTrace();
		} finally {
			if (localServletOutputStream != null) {
				localServletOutputStream.close();
				localServletOutputStream = null;
			}
		}
		return null;
	}

	public JSONArray getJson() {
		return this.json;
	}

	public String getSysStatus() {
		this.json = new JSONArray();
		this.json.add(Integer.valueOf(XTradeFrontGlobal.sysStatus));
		return "success";
	}

	public String orders() {
		String str1 = this.request.getParameter("firmID");
		this.logger.debug(" for Order");
		String str2 = "from Order o where o.belongtoMFirm.firmID='" + str1 + "' and (o.status=0 or o.status=1)";
		try {
			PageRequest localPageRequest = ActionUtil.getPageRequest(this.request);
			Page localPage = super.getService().getDao().queryByHQL(str2, null, localPageRequest, null);
			this.logger.debug("page:" + localPage);
			this.logger.debug("pageResult:" + localPage.getResult().size());
			this.request.setAttribute("pageInfo", localPage);
		} catch (Exception localException) {
			localException.printStackTrace();
		}
		return "success";
	}
}

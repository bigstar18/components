package gnnt.MEBS.espot.front.action.display;

import java.net.URLDecoder;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.front.action.JDBCStandardAction;
import gnnt.MEBS.common.front.common.Condition;
import gnnt.MEBS.common.front.common.Page;
import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;
import gnnt.MEBS.common.front.statictools.ActionUtil;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.front.common.XTradeFrontGlobal;
import gnnt.MEBS.espot.front.dao.jdbc.OrderDAO;
import gnnt.MEBS.espot.front.model.commodity.Category;
import gnnt.MEBS.espot.front.model.commodity.Property;
import gnnt.MEBS.espot.front.model.trade.XShop;

@Controller("indexJDBCAction")
@Scope("request")
public class IndexJDBCAction extends JDBCStandardAction {
	private static final long serialVersionUID = 3302728153040754439L;
	@Autowired
	@Qualifier("orderDAO")
	private OrderDAO orderDAO;

	public String searchShop() {
		this.logger.debug("============ shop ============dd");
		String str = this.request.getParameter("param");
		if (str != null) {
			this.request.setAttribute("paramShop", str);
			str = str.toLowerCase();
		}
		try {
			PageRequest localPageRequest = ActionUtil.getPageRequest(this.request);
			Page localPage = this.orderDAO.getFirmByParamter(str, localPageRequest);
			this.logger.debug("page:" + localPage);
			this.logger.debug("pageResult:" + localPage.getResult().size());
			this.request.setAttribute("pageInfo", localPage);
		} catch (Exception localException) {
			localException.printStackTrace();
		}
		return "success";
	}

	public String getOrdersByCommodity() throws Exception {
		String s = request.getParameter("tbln");
		request.setAttribute("tbln", s);
		logger.debug((new StringBuilder()).append("买卖方向=============::").append(request.getParameter("bsFlag")).toString());
		String s1 = request.getParameter("bsFlag");
		if (s1 == null)
			s1 = "A";
		request.setAttribute("bsFlag", s1);
		PageRequest pagerequest = getPropertyRequest();
		QueryConditions queryconditions = (QueryConditions) pagerequest.getFilters();
		Condition condition;
		for (Iterator iterator = queryconditions.getConditionList().iterator(); iterator.hasNext(); logger.debug((new StringBuilder())
				.append("===============    ").append(condition.getField()).append("==").append(condition.getSqlValue()).toString()))
			condition = (Condition) iterator.next();

		String s2 = "order by orderTime desc";
		if (request.getParameter("sortColumns") != null && !"".equals(request.getParameter("sortColumns")))
			s2 = Tools.getEncoding(request.getParameter("sortColumns"), "GBK");
		pagerequest.setSortColumns(s2);
		if (!s1.equals("A"))
			queryconditions.addCondition("bsFlag", "=", s1);
		String s3 = (String) request.getAttribute("accessShop");
		if (s3 != null && "Y".equals(s3)) {
			XShop xshop = (XShop) request.getAttribute("shop");
			if (xshop != null)
				queryconditions.addCondition("o.firmID", "=", xshop.getFirmID());
		}
		Page page = orderDAO.getOrdersByCommodity(getCategoryID(), propertySearch(), pagerequest);
		request.setAttribute("pageInfo", page);
		return "success";
	}

	public String searchTrade() {
		this.logger.debug("searchTrade============");
		try {
			PageRequest localPageRequest = getPropertyRequest();
			String str = "order by time desc";
			if (this.request.getParameter("sortColumns") != null) {
				str = Tools.getEncoding(this.request.getParameter("sortColumns"), "GBK");
			}
			localPageRequest.setSortColumns(str);
			Page localPage = this.orderDAO.getTradesByCommodity(getCategoryID(), propertySearch(), localPageRequest);
			this.request.setAttribute("pageInfo", localPage);
		} catch (Exception localException) {
			localException.printStackTrace();
		}
		return "success";
	}

	private long getCategoryID() {
		long l = -1000L;
		if (this.request.getParameter("cat") != null) {
			l = Tools.strToLong(this.request.getParameter("cat"), -1000L);
		}
		return l;
	}

	private String propertySearch() {
		String str = null;
		if (this.request.getParameter("propertySearch") != null) {
			str = this.request.getParameter("propertySearch");
			this.request.setAttribute("propertySearch", str);
		}
		return str;
	}

	private PageRequest getPropertyRequest() throws Exception {
		PageRequest pagerequest = ActionUtil.getPageRequest(request);
		QueryConditions queryconditions = (QueryConditions) pagerequest.getFilters();
		long l = getCategoryID();
		if (l != -1000L)
			queryconditions.addCondition("g.categoryID", "=", Long.valueOf(l));
		long l1 = -1000L;
		if (request.getParameter("brd") != null)
			l1 = Tools.strToLong(request.getParameter("brd"), -1000L);
		if (l1 > 0L)
			queryconditions.addCondition("g.breedID", "=", Long.valueOf(l1));
		HashMap hashmap = new HashMap();
		String as[] = request.getParameterValues("pvl");
		if (as != null && as.length > 0)

		{
			String as1[] = as;
			int i = as1.length;
			for (int j = 0; j < i; j++) {
				String s = as1[j];
				s = s.replaceAll("%", "%25");
				s = Tools.getEncoding(s, "UTF-8");
				s = URLDecoder.decode(s, "UTF-8");
				if (s.indexOf(":") > 0) {
					String s3 = s.substring(0, s.indexOf(":"));
					String s5 = s.substring(s.indexOf(":") + 1, s.length());
					hashmap.put(s3, s5);
				}
			}

		}

		TreeSet treeset = new TreeSet(new Comparator() {

			public int compare(Property property2, Property property3) {
				return property2.getSortNo().longValue() <= property3.getSortNo().longValue() ? -1 : 1;
			}

			public int compare(Object obj1, Object obj2) {
				return compare((Property) obj1, (Property) obj2);
			}
		});
		List list = XTradeFrontGlobal.getCategoryPage().getResult();
		Object obj = list.iterator();
		do

		{
			if (!((Iterator) (obj)).hasNext())
				break;
			Category category = (Category) ((Iterator) (obj)).next();
			if (category.getCategoryID().longValue() != l)
				continue;
			Iterator iterator = category.getContainProperty().iterator();
			do {
				if (!iterator.hasNext())
					break;
				Property property = (Property) iterator.next();
				if (property.getSearchable().equals("Y"))
					treeset.add(property);
			} while (true);
			break;
		} while (true);
		obj = hashmap.keySet().iterator();
		do

		{
			if (!((Iterator) (obj)).hasNext())
				break;
			String s1 = (String) ((Iterator) (obj)).next();
			if (treeset != null && treeset.size() > 0) {
				int k = 0;
				Iterator iterator1 = treeset.iterator();
				while (iterator1.hasNext()) {
					Property property1 = (Property) iterator1.next();
					if (property1.getPropertyName().equals(s1))
						queryconditions.addCondition((new StringBuilder()).append("'|'||tableproperty").append(k)
								.append(".propertyvalue||'|'  like  '%|").append((String) hashmap.get(s1)).append("|%'\t").toString(), " ", " ");
					k++;
				}
			}
		} while (true);
		obj = request.getParameter("priceMaxShow");

		String s2 = request.getParameter("priceMinShow");
		if (obj != null && !"".equals(obj) && s2 != null && !"".equals(s2) && !((String) (obj)).equals(s2))

		{
			double d = Tools.strToDouble(((String) (obj)), -1000D);
			double d3 = Tools.strToDouble(s2, -1000D);
			if (d < d3) {
				queryconditions.addCondition("to_number(o.price)", "<=", Double.valueOf(d3));
				queryconditions.addCondition("to_number(o.price)", ">=", Double.valueOf(d));
				request.setAttribute("priceMaxShow", s2);
				request.setAttribute("priceMinShow", obj);
			} else {
				queryconditions.addCondition("to_number(o.price)", "<=", Double.valueOf(d));
				queryconditions.addCondition("to_number(o.price)", ">=", Double.valueOf(d3));
				request.setAttribute("priceMaxShow", obj);
				request.setAttribute("priceMinShow", s2);
			}
		} else

		{
			if (obj != null && !"".equals(obj)) {
				double d1 = Tools.strToDouble(((String) (obj)), -1000D);
				queryconditions.addCondition("to_number(o.price)", "<=", Double.valueOf(d1));
			}
			if (s2 != null && !"".equals(s2)) {
				double d2 = Tools.strToDouble(s2, -1000D);
				queryconditions.addCondition("to_number(o.price)", ">=", Double.valueOf(d2));
			}
			request.setAttribute("priceMaxShow", obj);
			request.setAttribute("priceMinShow", s2);
		}
		if (request.getParameter("tradeTypeShow") != null && !"".equals(request.getParameter("tradeTypeShow")))

		{
			String s4 = request.getParameter("tradeTypeShow");
			queryconditions.addCondition("g.tradeMode", "=", s4);
			request.setAttribute("tradeTypeShow", s4);
		}
		return pagerequest;
	}
}

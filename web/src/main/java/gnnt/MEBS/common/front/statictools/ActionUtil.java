package gnnt.MEBS.common.front.statictools;

import java.util.Enumeration;
import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.util.Assert;

import gnnt.MEBS.common.front.common.PageRequest;
import gnnt.MEBS.common.front.common.QueryConditions;

public class ActionUtil {
	private static final transient Log logger = LogFactory.getLog(ActionUtil.class);
	public static final String PARAMETERPREFIX = "gnnt_";
	public static final String PAGESIZE = "pageSize";
	public static final String PAGENUMBER = "pageNo";
	public static final String SORTCOLUMNS = "sortColumns";
	public static final String ISQUERYDB = "isQueryDB";
	public static final String PAGEINFO = "pageInfo";
	public static final String OLDPARAMETER = "oldParams";

	public static PageRequest<QueryConditions> getPageRequest(HttpServletRequest request) throws Exception {
		PageRequest<QueryConditions> pageRequest = new PageRequest();

		pageRequest.setPageNumber(Tools.strToInt(request.getParameter("pageNo"), 1));

		pageRequest.setPageSize(Tools.strToInt(request.getParameter("pageSize"), 20));

		pageRequest.setSortColumns(request.getParameter("sortColumns"));

		pageRequest.setQueryDB(Tools.strToBoolean(request.getParameter("isQueryDB")));

		request.setAttribute("sortColumns", request.getParameter("sortColumns"));

		pageRequest.setFilters(getQueryConditionsFromRequest(request));

		return pageRequest;
	}

	public static QueryConditions getQueryConditionsFromRequest(HttpServletRequest request) throws Exception {
		QueryConditions qc = new QueryConditions();

		logger.debug("enter getQueryConditionsFromReq...");

		Map<String, Object> mapForParameters = getParametersStartingWith(request, "gnnt_");

		Map<String, String> mapForAttribute = getAttributeStartingWith(request, "gnnt_");

		mapForParameters.putAll(mapForAttribute);
		if ((mapForParameters != null) && (mapForParameters.size() > 0)) {
			logger.debug("parameter size:" + mapForParameters.size());

			Pattern pOperatorDatatype = Pattern.compile("(.+?)\\[(.+)]\\[(.+)]");

			Pattern pOperator = Pattern.compile("(.+?)\\[(.+)]");
			for (Iterator<String> it = mapForParameters.keySet().iterator(); it.hasNext();) {
				String key = (String) it.next();
				Object value = mapForParameters.get(key);
				logger.debug("parameter:" + key);
				Matcher m = pOperatorDatatype.matcher(key);
				String type;
				String param;
				String op;
				if (m.matches()) {
					param = m.group(1);
					op = m.group(2);
					type = m.group(3);
				} else {
					m = pOperator.matcher(key);
					if (m.matches()) {
						param = m.group(1);
						op = m.group(2);
						type = null;
					} else {
						param = null;
						op = null;
						type = null;
					}
				}
				if ((param != null) && (value != null) && (((String) value).trim().length() > 0)) {
					if (qc == null) {
						qc = new QueryConditions();
					}
					if (type != null) {
						value = value.toString().trim();
						value = Tools.convert(value, type);
					} else if ((value != null) && ((value instanceof String))) {
						value = value.toString().trim();
					}
					logger.debug("field:" + param);
					logger.debug("operator:" + op);
					logger.debug("datatype:" + type);
					logger.debug("value:" + value);
					qc.addCondition(param, op, value);
				}
			}
		}
		return qc;
	}

	public static Map<String, Object> getParametersStartingWith(ServletRequest request, String prefix) {
		Assert.notNull(request, "Request must not be null");
		Enumeration<?> paramNames = request.getParameterNames();
		Map<String, Object> params = new TreeMap();
		if (prefix == null) {
			prefix = "";
		}
		while ((paramNames != null) && (paramNames.hasMoreElements())) {
			String paramName = (String) paramNames.nextElement();
			if (("".equals(prefix)) || (paramName.startsWith(prefix))) {
				String unprefixed = paramName.substring(prefix.length());
				String[] values = request.getParameterValues(paramName);
				if ((values != null) && (values.length != 0)) {
					if (values.length > 1) {
						params.put(unprefixed, values);
					} else {
						params.put(unprefixed, values[0].trim());
					}
				}
				logger.debug(unprefixed + ":" + values[0]);
			}
		}
		return params;
	}

	public static Map<String, String> getAttributeStartingWith(ServletRequest request, String prefix) {
		Enumeration<?> namesEnumeration = request.getAttributeNames();
		Map<String, String> params = new TreeMap();
		if (prefix == null) {
			prefix = "";
		}
		while ((namesEnumeration != null) && (namesEnumeration.hasMoreElements())) {
			String paramName = (String) namesEnumeration.nextElement();
			if (("".equals(prefix)) || (paramName.startsWith(prefix))) {
				String unprefixed = paramName.substring(prefix.length());

				String value = (String) request.getAttribute(paramName);
				if (value != null) {
					params.put(unprefixed, value.trim());
				}
			}
		}
		return params;
	}
}

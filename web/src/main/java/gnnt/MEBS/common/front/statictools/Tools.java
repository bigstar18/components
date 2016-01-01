package gnnt.MEBS.common.front.statictools;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.hibernate.proxy.HibernateProxy;

import gnnt.MEBS.common.front.model.StandardModel;

public class Tools {
	public static final DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static final DateFormat dfSimple = new SimpleDateFormat("yyyy-MM-dd");

	public static String capitalize(String source) {
		if ((source == null) || (source.length() == 0)) {
			return source;
		}
		if (source.length() == 1) {
			return source.toUpperCase();
		}
		return source.toUpperCase().charAt(0) + source.substring(1);
	}

	public static List<Field> getFieldList(Object object, Class<?> finalClass) {
		List<Field> list = new ArrayList();
		Class<?> clazz = object.getClass();
		do {
			Field[] originFields = clazz.getDeclaredFields();
			for (int i = 0; i < originFields.length; i++) {
				list.add(originFields[i]);
			}
			if (finalClass == clazz) {
				break;
			}
			clazz = clazz.getSuperclass();
		} while ((clazz != Object.class) &&

		(clazz != finalClass));
		return list;
	}

	public static void CopyValue(Object origin, Object target, Class<?> finalClass) {
		if (origin == null) {
			throw new IllegalArgumentException("源对象为空无法拷贝！");
		}
		if (target == null) {
			throw new IllegalArgumentException("目标对象为空无法拷贝！");
		}
		// 如果是hibernate代理类则获取代理的目标进行反射赋值
		if (target instanceof HibernateProxy) {
			HibernateProxy hibernateProxy = (HibernateProxy) target;
			target = hibernateProxy.getHibernateLazyInitializer().getImplementation();
		}

		// 源对象对应的字段数组
		List<Field> originFields = getFieldList(origin, finalClass);
		// 目标对象对应的字段数组
		List<Field> targetFields = getFieldList(target, finalClass);

		// 循环源对象字段数组
		for (Field originField : originFields) {
			// 循环目标对象字段数组（也可通过源字段名从目标对象中获取相应字段进行赋值 但是每次反射效率要低于双重循环效率）
			for (Field targetField : targetFields) {
				// 如果源字段名称和目标字段名称一致 并且源字段类型和目标字段类型一致 并且字段类型不是Final声明
				if (originField.getName().equals(targetField.getName()) && originField.getType().equals(targetField.getType())
						&& !Modifier.isFinal(targetField.getModifiers())) {
					// 如果源字段声明类型为private则不能获取值 必须setAccessible(true)后方可获取
					if (!originField.isAccessible()) {
						originField.setAccessible(true);
					}
					// 如果目标字段声明类型为private则不能进行赋值 必须setAccessible(true)后方可赋值
					if (!targetField.isAccessible()) {
						targetField.setAccessible(true);
					}

					try {
						// 获取源对象字段值
						Object originFieldValue = originField.get(origin);

						// 如果是StandardModel类型 递归合并
						if (originFieldValue instanceof StandardModel) {
							CombinationValue(originFieldValue, targetField.get(target));
						} else {
							// 从源字段中读取值赋给目标字段
							targetField.set(target, originFieldValue);
						}
						// 从源字段中读取值赋给目标字段
						targetField.set(target, originFieldValue);
					} catch (IllegalArgumentException e) {
						e.printStackTrace();
					} catch (IllegalAccessException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}

	public static void CopyValue(Object origin, Object target) {
		CopyValue(origin, target, origin == null ? null : origin.getClass());
	}

	public static void CombinationValue(Object origin, Object target, Class<?> finalClass) {
		if (origin == null) {
			throw new IllegalArgumentException("源对象为空无法拷贝！");
		}
		if (target == null) {
			throw new IllegalArgumentException("目标对象为空无法拷贝！");
		}
		// 如果是hibernate代理类则获取代理的目标进行反射赋值
		if (target instanceof HibernateProxy) {
			HibernateProxy hibernateProxy = (HibernateProxy) target;
			target = hibernateProxy.getHibernateLazyInitializer().getImplementation();
		}

		// 源对象对应的字段数组
		List<Field> originFields = getFieldList(origin, finalClass);
		// 目标对象对应的字段数组
		List<Field> targetFields = getFieldList(target, finalClass);

		// 循环源对象字段数组
		// 循环源对象字段数组
		for (Field originField : originFields) {
			// 循环目标对象字段数组（也可通过源字段名从目标对象中获取相应字段进行赋值 但是每次反射效率要低于双重循环效率）
			for (Field targetField : targetFields) {

				// 如果源字段名称和目标字段名称一致 并且源字段类型和目标字段类型一致 并且字段类型不是Final声明
				if (originField.getName().equals(targetField.getName()) && originField.getType().equals(targetField.getType())
						&& !Modifier.isFinal(targetField.getModifiers())) {
					// 如果源字段声明类型为private则不能获取值 必须setAccessible(true)后方可获取
					if (!originField.isAccessible()) {
						originField.setAccessible(true);
					}
					// 如果目标字段声明类型为private则不能进行赋值 必须setAccessible(true)后方可赋值
					if (!targetField.isAccessible()) {
						targetField.setAccessible(true);
					}

					try {
						// 获取源对象字段值
						Object originFieldValue = originField.get(origin);
						// 如果字段值为空跳出循环
						if (originFieldValue == null) {
							break;
						}

						// 如果是StandardModel类型 递归合并
						if (originFieldValue instanceof StandardModel) {
							CombinationValue(originFieldValue, targetField.get(target));
						} else {
							// 从源字段中读取值赋给目标字段
							targetField.set(target, originFieldValue);
						}

					} catch (IllegalArgumentException e) {
						e.printStackTrace();
					} catch (IllegalAccessException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}

	public static void CombinationValue(Object origin, Object target) {
		CombinationValue(origin, target, origin == null ? null : origin.getClass());
	}

	public static String convertTS(Timestamp ts) {
		return ts.toString().substring(0, ts.toString().indexOf(" "));
	}

	public static String fmtDouble2(double num) {
		String result = "0.00";
		try {
			DecimalFormat nf = (DecimalFormat) NumberFormat.getNumberInstance();
			nf.applyPattern("###0.00");
			result = nf.format(num);
		} catch (Exception localException) {
		}
		return result;
	}

	public static String fmtDouble(double num) {
		String result = "0";
		try {
			result = String.valueOf(BigDecimal.valueOf(num));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public static String fmtTime(Timestamp time) {
		String result = "";
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			result = sdf.format(time);
		} catch (Exception localException) {
		}
		return result;
	}

	public static String fmtDate(Timestamp time) {
		String result = "";
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			result = sdf.format(time);
		} catch (Exception localException) {
		}
		return result;
	}

	public static String fmtOnlyTime(Timestamp time) {
		String result = "";
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
			result = sdf.format(time);
		} catch (Exception localException) {
		}
		return result;
	}

	public static String fmtTime(java.sql.Date time) {
		String result = "";
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			result = sdf.format(time);
		} catch (Exception localException) {
		}
		return result;
	}

	public static String fmtDate(java.sql.Date time) {
		String result = "";
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			result = sdf.format(time);
		} catch (Exception localException) {
		}
		return result;
	}

	public static String fmtTime(java.util.Date time) {
		String result = "";
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			result = sdf.format(time);
		} catch (Exception localException) {
		}
		return result;
	}

	public static String fmtDate(java.util.Date time) {
		String result = "";
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			result = sdf.format(time);
		} catch (Exception localException) {
		}
		return result;
	}

	public static java.util.Date dateAddSeconds(java.util.Date date, Integer seconds) {
		if (date == null) {
			throw new IllegalArgumentException("指定时间 不能为空！");
		}
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(13, seconds.intValue());
		return calendar.getTime();
	}

	public static java.sql.Date utilDateTosqlDate(java.util.Date date) {
		if (date == null) {
			return null;
		}
		return new java.sql.Date(date.getTime());
	}

	public static int strToInt(String str) {
		return strToInt(str, 64536);
	}

	public static int strToInt(String str, int defaultV) {
		int result = defaultV;
		try {
			if ((str != null) && (str.length() != 0)) {
				result = Integer.parseInt(str);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public static long strToLong(String str) {
		return strToLong(str, -1000L);
	}

	public static long strToLong(String str, long defaultV) {
		long result = defaultV;
		try {
			if ((str != null) && (str.length() != 0)) {
				if ((str.endsWith("L")) || (str.endsWith("l"))) {
					str = str.substring(0, str.length() - 1);
				}
				result = Long.parseLong(str);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public static double strToDouble(String str, double defaultValue) {
		double result = defaultValue;
		try {
			if ((str != null) && (str.length() != 0)) {
				result = Double.parseDouble(str);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public static float strToFloat(String str) {
		return strToFloat(str, 0.0F);
	}

	public static float strToFloat(String str, float defaultValue) {
		float result = defaultValue;
		try {
			if ((str != null) && (str.length() != 0)) {
				result = Float.parseFloat(str);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public static boolean strToBoolean(String source) {
		return (source != null) && ((source.equalsIgnoreCase("true")) || (source.equals("1")));
	}

	public static java.util.Date strToDate(String str) {
		java.util.Date result = null;
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			result = sdf.parse(str);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public static Time convertTime(String time) {
		Time result = null;
		try {
			result = Time.valueOf(time);
		} catch (Exception localException) {
		}
		return result;
	}

	public static String delNull(String str) {
		if (str == null) {
			return "";
		}
		return str;
	}

	public static String combineDateTime(String source) {
		return combineDateTime(source, 0);
	}

	public static String combineDateTime(String source, int lastTimeFlag) {
		String date = null;
		String time = null;
		if (source.indexOf(" ") < 0) {
			if (source.indexOf("-") < 0) {
				date = "";
				time = source;
			} else {
				date = source;
				time = "";
			}
		} else {
			String[] dt = source.split(" ");
			date = dt[0];
			time = dt[1];
		}
		String[] dateFields = date.split("-");
		if (dateFields.length == 2) {
			date = Calendar.getInstance().get(1) + "-" + date;
		} else if (dateFields.length < 2) {
			date = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		}
		if (time == "") {
			if (lastTimeFlag == 1) {
				time = "23:59:59";
			} else {
				time = "00:00:00";
			}
		} else {
			String[] timeFields = time.split(":");
			if (timeFields.length == 0) {
				time = "00:00:00";
			} else if (timeFields.length == 1) {
				time = time + ":00:00";
			} else if (timeFields.length == 2) {
				time = time + ":00";
			}
		}
		return date + " " + time;
	}

	public static Timestamp strToTimestamp(String timeStr) {
		Timestamp result = null;
		Calendar ca = Calendar.getInstance();
		try {
			Integer[] nums = { Integer.valueOf(0), Integer.valueOf(0), Integer.valueOf(0), Integer.valueOf(0), Integer.valueOf(0),
					Integer.valueOf(0) };
			timeStr = timeStr.replaceAll(":|-|/|\\\\| ", "");
			int length = timeStr.length();
			if (length >= 14) {
				nums[5] = Integer.valueOf(Integer.parseInt(timeStr.substring(12, 14)));
			}
			if (length >= 12) {
				nums[4] = Integer.valueOf(Integer.parseInt(timeStr.substring(10, 12)));
			}
			if (length >= 10) {
				nums[3] = Integer.valueOf(Integer.parseInt(timeStr.substring(8, 10)));
			}
			if (length >= 8) {
				nums[2] = Integer.valueOf(Integer.parseInt(timeStr.substring(6, 8)));
			}
			if (length >= 6) {
				nums[1] = Integer.valueOf(Integer.parseInt(timeStr.substring(4, 6)));
			}
			if (length >= 4) {
				nums[0] = Integer.valueOf(Integer.parseInt(timeStr.substring(0, 4)));
			}
			ca.set(nums[0].intValue(), nums[1].intValue() - 1, nums[2].intValue(), nums[3].intValue(), nums[4].intValue(), nums[5].intValue());
			result = new Timestamp(ca.getTime().getTime() / 1000L * 1000L);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public static java.util.Date strToDate(DateFormat df, String date) {
		try {
			return df.parse(date);
		} catch (ParseException e) {
		}
		return null;
	}

	public static String getEncoding(String str, String encoding) {
		if ((str == null) || (str.trim().length() <= 0)) {
			return str;
		}
		if ((!"GBK".equalsIgnoreCase(encoding)) && (!"UTF-8".equalsIgnoreCase(encoding))) {
			encoding = "GBK";
		}
		try {
			return new String(str.getBytes("ISO-8859-1"), encoding);
		} catch (UnsupportedEncodingException e) {
		}
		return "";
	}

	public static Object convert(Object src, String type) throws Exception {
		if (src == null) {
			return src;
		}
		if ("string".equals(type)) {
			return src.toString().trim();
		}
		if ((src instanceof List)) {
			List<?> list = (List) src;
			if (list.size() == 0) {
				return null;
			}
			src = list.get(0);
		}
		if ((src == null) || (!(src instanceof String))) {
			return src;
		}
		String source = (String) src;

		source = source.trim();
		if (source.length() == 0) {
			return null;
		}
		if (type.equals("int")) {
			return Integer.valueOf(strToInt(source));
		}
		if (type.equals("number")) {
			return Float.valueOf(strToFloat(source));
		}
		if (type.equals("Long")) {
			return Long.valueOf(strToLong(source));
		}
		if (type.equals("date")) {
			source = combineDateTime(source);
			return strToDate(df, source);
		}
		if (type.equals("datetime")) {
			source = combineDateTime(source, 1);
			return strToDate(df, source);
		}
		if ("timestamp".equalsIgnoreCase(type)) {
			return strToTimestamp(source);
		}
		if (type.equals("boolean")) {
			return new Boolean(strToBoolean(source));
		}
		return source.trim();
	}

	public static String convertCurrencyToChinese(Object num) {
		if (num == null) {
			return "";
		}
		BigDecimal value = new BigDecimal(num.toString());

		String[] strs = value.toString().split("\\.");
		String preDotNum = strs[0];

		String format = "";
		int i = preDotNum.length();
		for (int j = preDotNum.length(); i > 0; i--) {
			if (preDotNum.charAt(j - i) == '-') {
				format = format + "负";
			} else {
				format = format + numChar2chinese(preDotNum.charAt(j - i), i);
			}
		}
		format = format.replaceAll("零仟零佰零拾零", "零");
		format = format.replaceAll("零仟零佰零拾", "零");
		format = format.replaceAll("零仟零佰", "零");
		format = format.replaceAll("零仟", "零");
		format = format.replaceAll("零佰零拾零", "零");
		format = format.replaceAll("零佰零拾", "零");
		format = format.replaceAll("零佰", "零");
		format = format.replaceAll("零拾零", "零");
		format = format.replaceAll("零拾", "零");
		format = format.replaceAll("零亿", "亿");
		format = format.replaceAll("零万", "万");
		format = format.replaceAll("亿万", "亿零");
		format = format.replaceAll("零零", "零");
		if (format.endsWith("零")) {
			format = format.substring(0, format.length() - 1);
		}
		format = format + "元";
		if ((strs.length == 2) && (!"00".equals(strs[1])) && (!"0".equals(strs[1]))) {
			String afterDotNum = strs[1];
			for (int i1 = 0; (i1 < afterDotNum.length()) && (i1 < 2); i1++) {
				format = format + numChar2chinese(afterDotNum.charAt(i1), 0 - i1);
			}
		}
		return format;
	}

	private static String numChar2chinese(char num, int pos) {
		String str = "";
		switch (num) {
		case '0':
			str = "零";
			break;
		case '1':
			str = "壹";
			break;
		case '2':
			str = "贰";
			break;
		case '3':
			str = "叁";
			break;
		case '4':
			str = "肆";
			break;
		case '5':
			str = "伍";
			break;
		case '6':
			str = "陆";
			break;
		case '7':
			str = "柒";
			break;
		case '8':
			str = "扒";
			break;
		case '9':
			str = "玖";
		}
		String posName = "";
		switch (pos) {
		case -1:
			posName = "分";
			break;
		case 0:
			posName = "角";
			break;
		case 1:
			break;
		case 2:
			posName = "拾";
			break;
		case 3:
			posName = "佰";
			break;
		case 4:
			posName = "仟";
			break;
		case 5:
			posName = "万";
			break;
		case 6:
			posName = "拾";
			break;
		case 7:
			posName = "佰";
			break;
		case 8:
			posName = "仟";
			break;
		case 9:
			posName = "亿";
			break;
		case 10:
			posName = "拾";
			break;
		case 11:
			posName = "佰";
			break;
		case 12:
			posName = "仟";
		}
		return str + posName;
	}

	public static String encodeUrl(String urlStr) {
		String encoderedStr = "";
		if ((urlStr != null) && (urlStr.length() > 0)) {
			String[] strArr = urlStr.split("\\?");

			encoderedStr = strArr[0];

			String paramStr = strArr.length == 1 ? "" : strArr[1];
			if (paramStr.length() > 0) {
				Map<String, String> paramsMap = new HashMap();
				int lastAmpersandIndex = 0;
				int ampersandIndex;
				do {
					ampersandIndex = paramStr.indexOf('&', lastAmpersandIndex) + 1;
					String subStr;
					if (ampersandIndex > 0) {
						subStr = paramStr.substring(lastAmpersandIndex, ampersandIndex - 1);
						lastAmpersandIndex = ampersandIndex;
					} else {
						subStr = paramStr.substring(lastAmpersandIndex);
					}
					String[] paramPair = subStr.split("=");
					String param = paramPair[0];
					String value = paramPair.length == 1 ? "" : paramPair[1];
					try {
						value = URLEncoder.encode(value, "utf-8");
					} catch (UnsupportedEncodingException localUnsupportedEncodingException) {
					}
					paramsMap.put(param, value);
				} while (ampersandIndex > 0);
				encoderedStr = encoderedStr + "?";
				for (String string : paramsMap.keySet()) {
					encoderedStr = encoderedStr + string + "=" + (String) paramsMap.get(string);
				}
			}
		}
		return encoderedStr;
	}

	public static String getExceptionTrace(Throwable e) {
		if (e != null) {
			StringWriter sw = new StringWriter();
			PrintWriter pw = new PrintWriter(sw);
			e.printStackTrace(pw);
			return sw.toString();
		}
		return "No Exception";
	}

	public static Integer secondToHour(Integer num) {
		if (num == null) {
			return null;
		}
		if (num.intValue() < 0) {
			return Integer.valueOf(-1);
		}
		int h = num.intValue() / 60 / 60;
		return Integer.valueOf(h);
	}

	public static Integer HoureToSecond(Integer hour) {
		if (hour == null) {
			return null;
		}
		if (hour.intValue() < 0) {
			return Integer.valueOf(-1);
		}
		return Integer.valueOf(hour.intValue() * 60 * 60);
	}

	public static String getToXml(Map<String, String> extendMap) {
		Set<Map.Entry<String, String>> set = extendMap.entrySet();
		Iterator<Map.Entry<String, String>> i = set.iterator();
		Document document = DocumentHelper.createDocument();
		document.setXMLEncoding("GBK");
		Element booksElement = document.addElement("root");
		while (i.hasNext()) {
			Map.Entry<String, String> me = (Map.Entry) i.next();
			Element oElement = booksElement.addElement("keyValue");
			Element oElement1 = oElement.addElement("key");
			oElement1.addCDATA(((String) me.getKey()).toString());
			Element oElement2 = oElement.addElement("value");
			oElement2.addCDATA(((String) me.getValue()).toString());
		}
		String result = document.asXML();
		return result;
	}

	public static Map<String, String> addToXml(String xml) {
		Map<String, String> extendMap = new HashMap();
		if ((xml != null) && (!"".equals(xml))) {
			Document doc = null;
			try {
				doc = DocumentHelper.parseText(xml);
			} catch (DocumentException e) {
				e.printStackTrace();
			}
			Element root = doc.getRootElement();
			Iterator<Element> i = root.elementIterator();
			while (i.hasNext()) {
				Element e = (Element) i.next();
				String key = e.element("key").getText();
				String value = e.element("value").getText();
				extendMap.put(key, value);
			}
		}
		return extendMap;
	}
}

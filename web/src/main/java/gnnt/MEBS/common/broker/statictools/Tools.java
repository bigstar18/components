package gnnt.MEBS.common.broker.statictools;

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
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import gnnt.MEBS.common.broker.model.StandardModel;

public class Tools {
	public static String capitalize(String source) {
		if ((source == null) || (source.length() == 0)) {
			return source;
		}
		if (source.length() == 1) {
			return source.toUpperCase();
		}
		return source.toUpperCase().charAt(0) + source.substring(1);
	}

	public static void CopyValue(Object origin, Object target) {
		if (origin == null) {
			throw new IllegalArgumentException("源对象为空无法拷贝！");
		}
		if (target == null) {
			throw new IllegalArgumentException("目标对象为空无法拷贝！");
		}
		Field[] originFields = origin.getClass().getDeclaredFields();

		Field[] targetFields = target.getClass().getDeclaredFields();
		for (int i = 0; i < originFields.length; i++) {
			for (int j = 0; j < targetFields.length; j++) {
				if ((originFields[i].getName().equals(targetFields[j].getName())) && (originFields[i].getType().equals(targetFields[j].getType()))) {
					if (!Modifier.isFinal(targetFields[j].getModifiers())) {
						if (!originFields[i].isAccessible()) {
							originFields[i].setAccessible(true);
						}
						if (!targetFields[j].isAccessible()) {
							targetFields[j].setAccessible(true);
						}
						try {
							Object originFieldValue = originFields[i].get(origin);
							if ((originFieldValue instanceof StandardModel)) {
								CombinationValue(originFieldValue, targetFields[i].get(target));
							} else {
								targetFields[j].set(target, originFieldValue);
							}
							targetFields[j].set(target, originFieldValue);
						} catch (IllegalArgumentException e) {
							e.printStackTrace();
						} catch (IllegalAccessException e) {
							e.printStackTrace();
						}
					}
				}
			}
		}
	}

	public static void CombinationValue(Object origin, Object target) {
		if (origin == null) {
			throw new IllegalArgumentException("源对象为空无法合并！");
		}
		if (target == null) {
			throw new IllegalArgumentException("目标对象为空无法合并！");
		}
		Field[] originFields = origin.getClass().getDeclaredFields();

		Field[] targetFields = target.getClass().getDeclaredFields();
		for (int i = 0; i < originFields.length; i++) {
			for (int j = 0; j < targetFields.length; j++) {
				if ((originFields[i].getName().equals(targetFields[j].getName())) && (originFields[i].getType().equals(targetFields[j].getType()))) {
					if (!Modifier.isFinal(targetFields[j].getModifiers())) {
						if (!originFields[i].isAccessible()) {
							originFields[i].setAccessible(true);
						}
						if (!targetFields[j].isAccessible()) {
							targetFields[j].setAccessible(true);
						}
						try {
							Object originFieldValue = originFields[i].get(origin);
							if (originFieldValue == null) {
								break;
							}
							if ((originFieldValue instanceof StandardModel)) {
								CombinationValue(originFieldValue, targetFields[i].get(target));
							} else {
								targetFields[j].set(target, originFieldValue);
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

	public static java.util.Date strToDateTime(String timeStr) {
		java.util.Date result = null;
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
			result = ca.getTime();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public static void main(String[] args) {
		java.util.Date date = strToDateTime("2012-03-04 32:06:07");
		System.out.println(fmtTime(date));
	}

	public static java.util.Date strToDate(DateFormat df, String date) {
		try {
			return df.parse(date);
		} catch (ParseException e) {
		}
		return null;
	}

	public static Object convert(Object src, String type) throws Exception {
		if (src == null) {
			return src;
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
		if (source.length() == 0) {
			return null;
		}
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if (type.equals("int")) {
			return Integer.valueOf(strToInt(source));
		}
		if (type.equals("number")) {
			return Float.valueOf(strToFloat(source));
		}
		if (type.equals("Long")) {
			return Long.valueOf(strToLong(source));
		}
		if (type.equals("simpledate")) {
			source = combineDateTime(source);
			return java.sql.Date.valueOf(fmtDate(strToDate(source)));
		}
		if (type.equals("double")) {
			return Double.valueOf(strToDouble(source, 0.0D));
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
		return source;
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

	public static Integer HourToSecond(Integer hour) {
		if (hour == null) {
			return null;
		}
		if (hour.intValue() < 0) {
			return Integer.valueOf(-1);
		}
		return Integer.valueOf(hour.intValue() * 60 * 60);
	}

	public static java.sql.Date utilDateTosqlDate(java.util.Date date) {
		if (date == null) {
			return null;
		}
		return new java.sql.Date(date.getTime());
	}
}

package gnnt.MEBS.vendue.mgr.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

public class DateUtils {
	private static final String DATE_FORMAT = "yyyy-MM-dd";
	private static ThreadLocal<DateFormat> threadLocal = new ThreadLocal();

	public static DateFormat getDateFormat() {
		DateFormat localObject = (DateFormat) threadLocal.get();
		if (localObject == null) {
			localObject = new SimpleDateFormat("yyyy-MM-dd");
			threadLocal.set(localObject);
		}
		return (DateFormat) localObject;
	}

	public static String formatDate(Date paramDate) throws ParseException {
		return getDateFormat().format(paramDate);
	}

	public static Date parseDate(String paramString) throws ParseException {
		return getDateFormat().parse(paramString);
	}

	public static Date tomorrow(Date paramDate) {
		GregorianCalendar localGregorianCalendar = new GregorianCalendar();
		localGregorianCalendar.setTime(paramDate);
		localGregorianCalendar.add(5, 1);
		return localGregorianCalendar.getTime();
	}

	public static Date tomorrow(String paramString) throws ParseException {
		Date localDate = parseDate(paramString);
		return tomorrow(localDate);
	}

	public static void main(String[] paramArrayOfString) {
		System.out.println(tomorrow(new Date()).toString());
	}
}

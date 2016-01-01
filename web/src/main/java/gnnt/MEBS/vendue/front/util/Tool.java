package gnnt.MEBS.vendue.front.util;

public class Tool {
	public static String word(int paramInt) {
		int i = paramInt;
		char[] arrayOfChar = new char[i];
		for (int j = 0; j < i; j++) {
			int k = 97;
			arrayOfChar[j] = (char) (k + (int) (Math.random() * 26.0D));
		}
		String str = String.valueOf(arrayOfChar);
		return str;
	}
}

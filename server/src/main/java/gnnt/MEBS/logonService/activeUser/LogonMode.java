package gnnt.MEBS.logonService.activeUser;

/**
 * 登录模式
 * <ul>
 * <li>用户登录模式分成SINGLE_MODE和MULTI_MODE两种模。
 * <li>SINGLE_MODE同一时间只允许用一个用户登录一次 ,即同一个用户当他第二次登录时,上一个登录会 自动失效。
 * <li>MULTI_MODE允许同一用户同时多次登录
 * 
 * @author xuejt
 * 
 */
public enum LogonMode {
	/**
	 * 同一时间只允许用一个用户登录一次即同一个用户当他第二次登录时,上一个登录会 自动失效
	 */
	SINGLE_MODE(1),
	/**
	 * 允许同一用户同时多次登录
	 */
	MULTI_MODE(2);

	private final int value;

	/**
	 * 返回枚举值对应的数字
	 * 
	 * @return
	 */
	public int getValue() {
		return value;
	}

	// 构造器默认也只能是private, 从而保证构造函数只能在内部使用
	private LogonMode(int value) {
		this.value = value;
	}

	public static void main(String[] args) {
		System.out.println(LogonMode.SINGLE_MODE);
	}
}

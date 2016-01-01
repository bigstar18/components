package gnnt.MEBS.common.core;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ServerShell {

	/**
	 * 是否启动RMI服务
	 */
	public static boolean OpenRMIService = true;


	/**
	 * 交易服务器启动主线程
	 */
	public static void main(String[] args) {
		Log log = LogFactory.getLog(ServerShell.class);
		parseArgs(args);

		log.info("正在启动后台管理系统核心服务．．．");

		// 产生交易服务器主控制对象的实例，并传递配置参数
		Server server = Server.getInstance();
		server.init();

		// 启动交易服务器
		server.initServer();

		// try {
		// Thread.sleep(2000);
		// } catch (InterruptedException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
		// server.stop();
	}

	/**
	 * 解析启动参数
	 * 
	 * @param args
	 */
	private static void parseArgs(String args[]) {
		for (int i = 0; i < args.length; i++) {
			if (args[i].startsWith("-o")) {
				if (args[i].equalsIgnoreCase("-oOpenRMIService=false")) {
					OpenRMIService = false;
				}
				// 处理其它选项
			}
		}
	}
}


package gnnt.MEBS.logonService;

import gnnt.MEBS.logonService.util.Tool;


/**
 * <P>类说明：AU 服务启动类
 * <br/>
 * <br/>
 * </p>
 * 修改记录:
 * <br/>
 * <ul>
 * 
 * <li> 创建类                    |2014-4-17下午01:28:08|金网安泰 </li>
 * 
 * </ul>
 * @author liuzx
 */
public class ServerShell {
	public static void main(String args[]) throws Exception{
		Server server = Server.getInstance();

		server.initServer();

		printWelcome();
	}

	private static void printWelcome() {
		System.out
				.println("=============================================================================");
		System.out
				.println("=                                                                          =");
		System.out
				.println("=                                                                          =");
		System.out
				.println("=                      欢迎进入 ActiveUser RMI 服务!!                         =");
		System.out
				.println("=                                                                           =");
		System.out
				.println("=                                                                           =");
		System.out
				.println("=                                                                           =");
		System.out
				.println("=                            已成功启动!                                     =");
		System.out
				.println("=                                                                           =");
		System.out
				.println("=                                                                           =");
		System.out
				.println("=                                                                           =");
		System.out
				.println("=                      北京金网安泰信息技术有限公司.                          =");
		System.out
				.println("=                                                                           =");
		System.out
				.println("=                                                                           =");
		System.out
				.println("=                                             "
						+ Tool.fmtTime(new java.util.Date()) + "         =");
		System.out
				.println("=============================================================================");
	}
}


package gnnt.MEBS.util.spring.rmi.test;

import java.util.ArrayList;

import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Server {
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		ArrayList<String> list = new ArrayList<String>();
		list.add("rmi_server.xml");

		new ClassPathXmlApplicationContext(list
				.toArray(new String[list.size()]));
	}
}

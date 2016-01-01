package gnnt.MEBS.common.core.util;

import gnnt.MEBS.common.core.Constants;
import gnnt.MEBS.common.core.ServerShell;

import java.util.ArrayList;
import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.NoSuchBeanDefinitionException;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * 系统BeanFactory
 * 
 * @author xuejt
 * 
 */
public class GnntBeanFactory {
	private static Log log = LogFactory.getLog(GnntBeanFactory.class);

	

	private volatile static BeanFactory factory;

	
	private static Properties errorCodeProps = getErrorCodeProps();

	/**
	 * 初始化context对象，通过beanConfig指定的context file
	 */
	public static void init() {
		log.debug("初始化context:" + Constants.BEANCONFIG);

		ArrayList<String> list = new ArrayList<String>();
		list.add( Constants.BEANCONFIG);
		list.add( Constants.ERRORCODECONFIG);
		
		if (ServerShell.OpenRMIService) {
			list.add( Constants.RMIBEANCONFIG);
			log.debug("加载RMI服务配置文件");
		}

		try {
			factory = new ClassPathXmlApplicationContext(list
					.toArray(new String[list.size()]));
			// 保证虚拟机退出之前 spring中singtleton对象自定义销毁方法会执行
			((AbstractApplicationContext) factory).registerShutdownHook();
		} catch (Exception e) {
			e.printStackTrace();
			log.error("加载配置文件时发生错误" + e);
		}
		// 关闭spring容器 仅供参考
		// ((AbstractApplicationContext)GnntBeanFactory.getBeanFactory()).close();
	}

	/**
	 * 通过beanId得到factory中的bean实例
	 * 
	 * @param beanId
	 * @return Object
	 */
	public static Object getBean(String beanId) {
		Object obj = null;

		if (factory == null) {
			synchronized (GnntBeanFactory.class) {
				if (factory == null) {
					init();
				}
			}
		}
		if (factory != null)
			obj = factory.getBean(beanId);
		return obj;
	}

	/**
	 * 获得BeanFactory实例
	 * 
	 * @return the BeanFactory
	 */
	public static BeanFactory getBeanFactory() {
		if (factory == null) {
			synchronized (GnntBeanFactory.class) {
				if (factory == null) {
					init();
				}
			}
		}
		return factory;
	}
	
	/**
	 * 获得系统错误码表属性对象
	 * 
	 * @return 错误码表属性对象
	 */
	private static Properties getErrorCodeProps() {
		Properties conf = null;
		try {
			conf = (Properties) getBean("errorCode");
		} catch (NoSuchBeanDefinitionException e) {
			log.error("没有找到config的名字！");
		}
		return conf;
	}
	
	/**
	 * 获取错误码对应的详细信息
	 * @param errorCode 错误码
	 * @return			详细信息
	 */
	public static String getErrorInfo(String errorCode) {
		if (errorCodeProps != null)
			return (String) errorCodeProps.getProperty(errorCode);
		else
			return null;
	}
}

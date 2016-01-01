
package gnnt.MEBS.logonService.util;

import java.util.Properties;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * <P>类说明：类实例生成工厂
 * <br/>
 * <br/>
 * </p>
 * 修改记录:
 * <br/>
 * <ul>
 * 
 * <li> 创建类                    |2014-4-17下午01:33:20|金网安泰 </li>
 * 
 * </ul>
 * @author liuzx
 */
public class GnntBeanFactory {
	/** 写日志属性 */
	private static Log logger = LogFactory.getLog(GnntBeanFactory.class);

	/** Spring 类实例 工厂对象 */
	private volatile static BeanFactory factory;

	/** 配置文件中配置通用信息 */
	private static Properties config;

	/**
	 * 
	 * 通过配置名称获取通用配置信息值
	 * <br/><br/>
	 * @param name 配置名称
	 * @return
	 */
	public static String getConfig(String name){
		initConfig();
		if(config != null){
			return config.getProperty(name);
		}
		return null;
	}

	/**
	 * 
	 * 初始化 Spring 通用配置通用信息
	 * <br/><br/>
	 */
	private static void initConfig(){
		if(config == null){
			synchronized(GnntBeanFactory.class){
				if(config == null){
					try{
						config = (Properties)getBean("config");
					}catch(Exception e){
						logger.error("获取配置文件通用配置信息异常",e);
					}
				}
			}
		}
	}

	/**
	 * 
	 * 通过编号获取配置类实例
	 * <br/><br/>
	 * @param beanID 配置编号
	 * @return
	 */
	public static Object getBean(String beanID){
		init();
		//Spring 类构造工程不为空
		if(factory != null){
			return factory.getBean(beanID);
		}

		return null;
	}

	/**
	 * 
	 * 获取 Spring 共造工厂
	 * <br/><br/>
	 * @return
	 */
	public static BeanFactory getBeanFactory(){
		init();
		return factory;
	}

	/**
	 * 
	 * 初始化服务信息
	 * <br/><br/>
	 */
	private static void init(){
		if(factory == null){
			synchronized(GnntBeanFactory.class){
				if(factory == null){
					logger.info("初始化 类实例生成工厂");
					String fileName = "logonService.xml";
					try{
						factory = new ClassPathXmlApplicationContext(fileName);
						// 保证虚拟机退出之前 spring 中 singtleton 对象自定义销毁方法执行
						((AbstractApplicationContext) factory).registerShutdownHook();
					}catch(Exception e){
						logger.error("加载 Spring 文件 "+fileName+"异常：",e);
						System.exit(0);//关闭服务
					}
				}
			}
		}
	}
}


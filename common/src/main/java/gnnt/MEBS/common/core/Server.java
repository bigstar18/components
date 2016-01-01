package gnnt.MEBS.common.core;

import gnnt.MEBS.common.core.jms.ProducerToolSendQueue;
import gnnt.MEBS.common.core.jms.ProducerToolSendTopic;
import gnnt.MEBS.common.core.jms.StaticThreadPool;
import gnnt.MEBS.common.core.util.DateUtil;
import gnnt.MEBS.common.core.util.GnntBeanFactory;

import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.jms.JMSException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.aop.aspectj.autoproxy.AspectJAwareAdvisorAutoProxyCreator;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * 交易服务器主控制类.
 * 
 * @author xuejt
 * 
 */
public class Server implements ApplicationContextAware {

	private Log log = LogFactory.getLog(getClass());

	// Server对象实例
	private volatile static Server instance;
	
	/**
	 * 本机ip地址
	 */
	private String ip;
	/**
	 * 发送消息的静态线程池
	 */
	private StaticThreadPool staticThreadPool;

	/**
	 * 私有构造方法
	 * 
	 */
	private Server() {

	}
	
	/**
	 * 获取对象实例 单例模式
	 * 
	 * @return
	 */
	public static Server getInstance() {
		if (instance == null) {
			synchronized (Server.class) {
				if (instance == null) {
					instance = (Server) GnntBeanFactory.getBean("server");
				}
			}
		}
		return instance;
	}
	
	/**
	 * 对象实例化 包括配置信息、DAO、线程并启动，交易类
	 */
	public void init() {
		staticThreadPool = StaticThreadPool.getInstance();
	}
	
	/**
	 * 交易服务器初始化
	 * 
	 * @return true：初始化成功;false：初始化失败
	 */
	public boolean initServer() {
		try {
			printWelcome();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			log.error("交易服务器初始化失败，原因：" + e);
			return false;
		}
	}
	
	/**
	 * Server 是否退出标志
	 */
	boolean stop = false;

	/**
	 * 停止服务
	 */
	public void stop() {
		if (stop)
			return;
		
		if (staticThreadPool != null) {
			log.info("========释放静态线程池.==========");
			staticThreadPool.exit();
			staticThreadPool = null;
		}

		ProducerToolSendTopic frontProducerTopic = (ProducerToolSendTopic) GnntBeanFactory
				.getBean("frontProducerTopic");
		if (frontProducerTopic != null) {
			log.info("========释放前台消息订阅发送对象.==========");
			try {
				frontProducerTopic.close();
			} catch (JMSException e) {
			}
			frontProducerTopic = null;
		}

		ProducerToolSendTopic mgrProducerTopic = (ProducerToolSendTopic) GnntBeanFactory
				.getBean("mgrProducerTopic");
		if (mgrProducerTopic != null) {
			log.info("========释放 后台消息订阅发送对象.==========");
			try {
				mgrProducerTopic.close();
			} catch (JMSException e) {
			}
			mgrProducerTopic = null;
		}
		ProducerToolSendQueue producerQueue = (ProducerToolSendQueue) GnntBeanFactory
				.getBean("producerQueue");
		if (producerQueue != null) {
			log.info("========释放 点对点消息发送对象 ==========");
			try {
				producerQueue.close();
			} catch (JMSException e) {
			}
			producerQueue = null;
		}

		stop = true;
	}

	/**
	 * 虚拟器退出时调用( destroy方法 )
	 */
	public void close() {
		log.info("close");
		this.stop();
	}

	/**
	 * @return the ip
	 */
	public String getIp() {
		if (ip == null) {
			try {
				ip = InetAddress.getLocalHost().getHostAddress();
			} catch (UnknownHostException e) {
				e.printStackTrace();
			}
		}
		return ip;
	}
	/**
	 * @return 发送消息的静态线程池
	 */
	public StaticThreadPool getStaticThreadPool() {
		return staticThreadPool;
	}

	/**
	 * 打印出欢迎词
	 * 
	 */
	private void printWelcome() {
		System.out
				.println("=============================================================================");
		System.out
				.println("=                                                                          =");
		System.out
				.println("=                                                                          =");
		System.out
				.println("=                      欢迎进入后台管理核心系统!!                            =");
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
				.println("=                                                        "
						+ DateUtil.getCurDate() + "         =");
		System.out
				.println("=============================================================================");
	}
	@Override
	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {
		// 因为使用<aop:config> 所以没有办法使用exposeProxy属性 然而在内部方法事务处理上使用
		// AopContext.currentProxy调用方法所以
		// 通过实现ApplicationContextAware接口设置ExposeProxy属性
		String beanName = "org.springframework.aop.config.internalAutoProxyCreator";
		AspectJAwareAdvisorAutoProxyCreator autoProxyCreatory = (AspectJAwareAdvisorAutoProxyCreator) applicationContext
				.getBean(beanName);
		autoProxyCreatory.setExposeProxy(true);
	}
}

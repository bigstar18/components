package gnnt.MEBS.util.spring.rmi;

import gnnt.MEBS.util.spring.rmi.util.RWPropertiesFile;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.springframework.beans.BeansException;
import org.springframework.beans.MutablePropertyValues;
import org.springframework.beans.PropertyValue;
import org.springframework.beans.factory.BeanInitializationException;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.config.TypedStringValue;
import org.springframework.core.PriorityOrdered;

/**
 * 在容器启动阶段 通过数据库查询模块的配置写信写到rmi配置文件 <br>
 * 1、配置默认属性占位符配置替换数据源占位符<br>
 * 2、配置此BeanFactoryPostProcessor如果需要读取配置信息则读取配置信息写到rmi配置属性文件;属性文件规则
 * 模块英文名称.rmi.ip 模块英文名称.rmi.prot 模块英文名称.rmi.dataport 例如 esport.rmi.ip<br>
 * 3、配置占位符使用$[变量]格式 4、配置属性占位符替换$[]中的配置信息<br>
 * 注:三个BeanFactoryPostProcessor顺序必须固定
 * 
 * 
 * @author xuejt
 * 
 */
public class CreateRMIPropertiesFileByDB implements
		org.springframework.beans.factory.config.BeanFactoryPostProcessor,
		PriorityOrdered {

	// 排序号
	private int order = 1;

	// 从数据库读取配置后设置RMI属性
	private boolean isSetRMIPropertiesFromDB = false;

	// rmi属性文件名称
	private String rmiPropertiesName;

	// 数据源bean名称
	private String dataSource;

	// 模块数组
	private int[] moduleArr;

	/**
	 * BeanFactoryPostProcessor排序号
	 * 
	 * @param order
	 */
	public void setOrder(int order) {
		this.order = order;
	}

	/**
	 * 是否从数据库读取配置后设置RMI属性
	 * 
	 * @param isSetRMIPropertiesFromDB
	 */
	public void setSetRMIPropertiesFromDB(boolean isSetRMIPropertiesFromDB) {
		this.isSetRMIPropertiesFromDB = isSetRMIPropertiesFromDB;
	}

	/**
	 * rmi属性文件名称
	 * 
	 * @param rmiPropertiesName
	 */
	public void setRmiPropertiesName(String rmiPropertiesName) {
		this.rmiPropertiesName = rmiPropertiesName;
	}

	/**
	 * 模块数组
	 * 
	 * @param moduleArr
	 */
	public void setModuleArr(int[] moduleArr) {
		this.moduleArr = moduleArr;
	}

	/**
	 * 数据源bean名称
	 * 
	 * @param dataSource
	 */
	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
	}

	public int getOrder() {
		return this.order;
	}

	@Override
	public void postProcessBeanFactory(
			ConfigurableListableBeanFactory configurableListableBeanFactory)
			throws BeansException {
		// 如果不需要设置则直接返回
		if (!isSetRMIPropertiesFromDB)
			return;

		if (moduleArr == null || moduleArr.length == 0) {
			return;
		}

		if (dataSource == null || dataSource.length() == 0) {
			throw new BeanInitializationException("dataSource is Null ");
		}

		if (rmiPropertiesName == null || rmiPropertiesName.length() == 0) {
			throw new BeanInitializationException("rmiPropertiesName is Null ");
		}

		// 获取数据源beanDefinition
		BeanDefinition beanDefinition = configurableListableBeanFactory
				.getBeanDefinition(dataSource);
		MutablePropertyValues mutablePropertyValues = beanDefinition
				.getPropertyValues();

		// rmi属性文件路径
		String filePath = null;
		try {
			filePath = Thread.currentThread().getContextClassLoader()
					.getResource("").toURI().getPath()
					+ rmiPropertiesName;
		} catch (URISyntaxException e1) {
			throw new BeanInitializationException("Get filePath fail ",e1);
		}

		File file = new File(filePath);
		// 如果文件不存在则创建文件
		if (!file.exists()) {
			try {
				file.createNewFile();
			} catch (IOException e) {
				throw new BeanInitializationException("Create Rmi File fail ",
						e);
			}
		}

		String jndiName = getMutablePropertyValueByName(mutablePropertyValues,
				"jndiName");
		if (jndiName != null) {
			InitialContext ic = null;
			DataSource dataSource = null;
			/** 声明Connection连接对象 */
			Connection conn = null;
			try {
				ic = new InitialContext();
				dataSource = (DataSource) ic.lookup(jndiName);
				conn = dataSource.getConnection();
				writeRmiPropertiesByDB(filePath, conn);
			} catch (Exception e) {
				throw new BeanInitializationException("jndi exception ", e);
			} finally {
				try {
					if (conn != null)
						conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				try {
					ic.close();
				} catch (NamingException e) {
					e.printStackTrace();
				}
				ic = null;
				dataSource = null;
			}
		} else {
			String driverClassName = ((TypedStringValue) mutablePropertyValues
					.getPropertyValue("driverClassName").getValue()).getValue();
			String url = ((TypedStringValue) mutablePropertyValues
					.getPropertyValue("url").getValue()).getValue();
			String username = ((TypedStringValue) mutablePropertyValues
					.getPropertyValue("username").getValue()).getValue();
			String password = ((TypedStringValue) mutablePropertyValues
					.getPropertyValue("password").getValue()).getValue();

			org.apache.commons.dbcp.BasicDataSource dateSource = null;
			try{
				Class<?> clazz = Class.forName("org.apache.commons.dbcp.BasicDataSource");
				dateSource = (org.apache.commons.dbcp.BasicDataSource) clazz.newInstance();
				dateSource.setPassword(password);
				password = dateSource.getPassword();
			}catch(Exception e){
			}catch(Error er){
			}finally{
				try{
					if(dateSource != null){
						dateSource.close();
					}
				}catch(Exception e){
				}
			}

			/** 声明Connection连接对象 */
			Connection conn = null;
			try {
				/** 使用Class.forName()方法自动创建这个驱动程序的实例且自动调用DriverManager来注册它 */
				Class.forName(driverClassName);
				/** 通过DriverManager的getConnection()方法获取数据库连接 */
				
				conn = DriverManager.getConnection(url, username, password);

				writeRmiPropertiesByDB(filePath, conn);
			} catch (Exception e) {
				throw new BeanInitializationException("jdbc exception ", e);
			} finally {
				try {
					if (conn != null)
						conn.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
		}
	}

	private String getMutablePropertyValueByName(
			MutablePropertyValues mutablePropertyValues, String key) {
		PropertyValue propertyValue = mutablePropertyValues
				.getPropertyValue(key);

		if (propertyValue != null) {
			TypedStringValue typedStringValue = (TypedStringValue) propertyValue
					.getValue();
			return typedStringValue.getValue();
		} else {
			return null;
		}
	}

	/**
	 * 通过读取数据库内容写rmi属性文件
	 * 
	 * @param filePath
	 *            文件路径
	 * @param conn
	 *            Connection连接对象
	 */
	private void writeRmiPropertiesByDB(String filePath, Connection conn) {
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String moduleidStr = "";

			// 将module数组转换为字符串
			for (int moduleid : moduleArr) {
				moduleidStr = moduleidStr + moduleid + ",";
			}

			moduleidStr = moduleidStr.substring(0, moduleidStr.length() - 1);

			String sql = "select enname,hostip,port,rmidataport from c_trademodule t where t.moduleid in("
					+ moduleidStr + ")";

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				RWPropertiesFile.writeProperties(filePath, rs
						.getString("enname")
						+ ".rmi.ip", delNull(rs.getString("hostip")));
				RWPropertiesFile.writeProperties(filePath, rs
						.getString("enname")
						+ ".rmi.port", delNull(rs.getString("port")));
				RWPropertiesFile
						.writeProperties(filePath, rs.getString("enname")
								+ ".rmi.dataport", delNull(rs
								.getString("rmidataport")));
			}
		} catch (Exception e) {
			throw new BeanInitializationException("query exception ", e);
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}

			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		}
	}

	/**
	 * 将null字符串转换为""
	 * 
	 * @param str
	 *            原始字符串
	 * @return 转换后字符串
	 */
	private String delNull(String str) {
		if (str == null) {
			return "";
		} else {
			return str;
		}
	}
}
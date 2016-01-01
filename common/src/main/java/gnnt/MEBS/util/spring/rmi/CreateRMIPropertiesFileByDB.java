// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi
// Source File Name: CreateRMIPropertiesFileByDB.java

package gnnt.MEBS.util.spring.rmi;

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
import org.springframework.beans.factory.config.BeanFactoryPostProcessor;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.config.TypedStringValue;
import org.springframework.core.PriorityOrdered;

import gnnt.MEBS.util.spring.rmi.util.RWPropertiesFile;

public class CreateRMIPropertiesFileByDB implements BeanFactoryPostProcessor, PriorityOrdered {

	private int order;
	private boolean isSetRMIPropertiesFromDB;
	private String rmiPropertiesName;
	private String dataSource;
	private int moduleArr[];

	public CreateRMIPropertiesFileByDB() {
		order = 1;
		isSetRMIPropertiesFromDB = false;
	}

	public void setOrder(int order) {
		this.order = order;
	}

	public void setSetRMIPropertiesFromDB(boolean isSetRMIPropertiesFromDB) {
		this.isSetRMIPropertiesFromDB = isSetRMIPropertiesFromDB;
	}

	public void setRmiPropertiesName(String rmiPropertiesName) {
		this.rmiPropertiesName = rmiPropertiesName;
	}

	public void setModuleArr(int moduleArr[]) {
		this.moduleArr = moduleArr;
	}

	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
	}

	public int getOrder() {
		return order;
	}

	public void postProcessBeanFactory(ConfigurableListableBeanFactory configurableListableBeanFactory) throws BeansException {
		MutablePropertyValues mutablePropertyValues;
		String filePath;
		String jndiName;
		if (!isSetRMIPropertiesFromDB)
			return;
		if (moduleArr == null || moduleArr.length == 0)
			return;
		if (this.dataSource == null || this.dataSource.length() == 0)
			throw new BeanInitializationException("dataSource is Null ");
		if (rmiPropertiesName == null || rmiPropertiesName.length() == 0)
			throw new BeanInitializationException("rmiPropertiesName is Null ");
		BeanDefinition beanDefinition = configurableListableBeanFactory.getBeanDefinition(this.dataSource);
		mutablePropertyValues = beanDefinition.getPropertyValues();
		filePath = null;
		try {
			filePath = (new StringBuilder(String.valueOf(Thread.currentThread().getContextClassLoader().getResource("").toURI().getPath())))
					.append(rmiPropertiesName).toString();
		} catch (URISyntaxException e1) {
			throw new BeanInitializationException("Get filePath fail ", e1);
		}
		File file = new File(filePath);
		if (!file.exists())
			try {
				file.createNewFile();
			} catch (IOException e) {
				throw new BeanInitializationException("Create Rmi File fail ", e);
			}
		jndiName = getMutablePropertyValueByName(mutablePropertyValues, "jndiName");
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
			String driverClassName = ((TypedStringValue) mutablePropertyValues.getPropertyValue("driverClassName").getValue()).getValue();
			String url = ((TypedStringValue) mutablePropertyValues.getPropertyValue("url").getValue()).getValue();
			String username = ((TypedStringValue) mutablePropertyValues.getPropertyValue("username").getValue()).getValue();
			String password = ((TypedStringValue) mutablePropertyValues.getPropertyValue("password").getValue()).getValue();

			org.apache.commons.dbcp.BasicDataSource dateSource = null;
			try {
				Class<?> clazz = Class.forName("org.apache.commons.dbcp.BasicDataSource");
				dateSource = (org.apache.commons.dbcp.BasicDataSource) clazz.newInstance();
				dateSource.setPassword(password);
				password = dateSource.getPassword();
			} catch (Exception e) {
			} catch (Error er) {
			} finally {
				try {
					if (dateSource != null) {
						dateSource.close();
					}
				} catch (Exception e) {
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

	private String getMutablePropertyValueByName(MutablePropertyValues mutablePropertyValues, String key) {
		PropertyValue propertyValue = mutablePropertyValues.getPropertyValue(key);
		if (propertyValue != null) {
			TypedStringValue typedStringValue = (TypedStringValue) propertyValue.getValue();
			return typedStringValue.getValue();
		} else {
			return null;
		}
	}

	private void writeRmiPropertiesByDB(String filePath, Connection conn) {
		Statement stmt;
		ResultSet rs;
		stmt = null;
		rs = null;
		try {
			String moduleidStr = "";

			// 将module数组转换为字符串
			for (int moduleid : moduleArr) {
				moduleidStr = moduleidStr + moduleid + ",";
			}

			moduleidStr = moduleidStr.substring(0, moduleidStr.length() - 1);
			String sql = (new StringBuilder(
					"select moduleid,enname,hostip,port,rmidataport from ((select moduleid,enname,hostip,port,rmidataport from c_trademodule) union (select moduleid,enname,hostip,port,rmidataport from C_Submodule ts)) t where t.moduleid in ("))
							.append(moduleidStr).append(")").toString();

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				RWPropertiesFile.writeProperties(filePath, rs.getString("enname") + ".rmi.ip", delNull(rs.getString("hostip")));
				RWPropertiesFile.writeProperties(filePath, rs.getString("enname") + ".rmi.port", delNull(rs.getString("port")));
				RWPropertiesFile.writeProperties(filePath, rs.getString("enname") + ".rmi.dataport", delNull(rs.getString("rmidataport")));
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

	private String delNull(String str) {
		if (str == null)
			return "";
		else
			return str;
	}
}

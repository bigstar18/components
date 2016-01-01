package gnnt.MEBS.common.broker.model;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.Collection;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import gnnt.MEBS.common.broker.model.translate.GetNameByField;
import gnnt.MEBS.common.broker.statictools.ApplicationContextInit;
import gnnt.MEBS.common.broker.statictools.Serialize;

public abstract class StandardModel implements Cloneable, Serializable {
	private final transient Log logger = LogFactory.getLog(StandardModel.class);
	private static final long serialVersionUID = -3032683871122601737L;

	public StandardModel clone() {
		try {
			return (StandardModel) super.clone();
		} catch (CloneNotSupportedException e) {
			System.out.println("Cloning not allowed.");
			e.printStackTrace();
		}
		return this;
	}

	public String serialize() {
		return Serialize.serializeToXml(this);
	}

	public String translate() {
		String result = "";

		GetNameByField getNameByField = (GetNameByField) ApplicationContextInit.getBean("getNameByField");

		Field[] fields = getClass().getDeclaredFields();
		for (int i = 0; i < fields.length; i++) {
			if (!Modifier.isFinal(fields[i].getModifiers())) {
				if (!Modifier.isTransient(fields[i].getModifiers())) {
					if (!fields[i].isAccessible()) {
						fields[i].setAccessible(true);
					}
					String name = getNameByField.getName(fields[i]);
					Object value = null;
					try {
						value = fields[i].get(this);
					} catch (Exception e) {
						this.logger.warn(e.getMessage());
						e.printStackTrace();
					}
					if (value != null) {
						if ((value instanceof StandardModel)) {
							String subResult = ((StandardModel) value).translate();
							if ((subResult != null) && (subResult.length() > 0)) {
								result = result + "子对象" + name + "添加内容[" + subResult + "];";
							}
						} else if ((value instanceof Collection)) {
							if (((Collection) value).size() > 0) {
								result = result + name + ":[";
								Object[] os = ((Collection) value).toArray();
								for (int j = 0; j < os.length; j++) {
									if (j > 0) {
										result = result + ";";
									}
									Object o = os[j];
									if ((o instanceof StandardModel)) {
										result = result + ((StandardModel) o).translate();
									} else {
										result = result + o.toString();
									}
								}
								result = result + "];";
							}
						} else {
							result = result + name + ":" + value.toString() + ";";
						}
					}
				}
			}
		}
		return result;
	}

	public String compareTranslate(StandardModel comparedModel) {
		String result = "";

		GetNameByField getNameByField = (GetNameByField) ApplicationContextInit.getBean("getNameByField");

		Field[] fields = getClass().getDeclaredFields();

		PrimaryInfo pinfo = fetchPKey();
		if ((pinfo != null) && (pinfo.getKey() != null)) {
			Field key = null;
			Field[] arrayOfField1;
			int j = (arrayOfField1 = fields).length;
			for (int i = 0; i < j; i++) {
				Field f = arrayOfField1[i];
				if (pinfo.getKey().equals(f.getName())) {
					key = f;
					break;
				}
			}
			if (key != null) {
				String name = getNameByField.getName(key);
				result = result + name + "为 " + pinfo.getValue() + ";";
			}
		}
		for (int i = 0; i < fields.length; i++) {
			if (!Modifier.isFinal(fields[i].getModifiers())) {
				if (!Modifier.isTransient(fields[i].getModifiers())) {
					if (!fields[i].isAccessible()) {
						fields[i].setAccessible(true);
					}
					String name = getNameByField.getName(fields[i]);
					Object oldValue = null;
					Object newValue = null;
					try {
						oldValue = fields[i].get(this);
						newValue = fields[i].get(comparedModel);
					} catch (Exception e) {
						this.logger.warn(e.getMessage());
						e.printStackTrace();
					}
					if (oldValue == null) {
						oldValue = "";
					}
					if (newValue != null) {
						if ((oldValue instanceof StandardModel)) {
							StandardModel oldModel = (StandardModel) oldValue;
							StandardModel newModel = (StandardModel) newValue;
							String subResult = oldModel.compareTranslate(newModel);
							if ((subResult != null) && (subResult.length() > 0)) {
								result = result + "子对象" + name + "修改内容[" + subResult + "];";
							}
						} else if (!(oldValue instanceof Collection)) {
							if (!oldValue.equals(newValue)) {
								result = result + name + "从" + oldValue.toString() + "修改为" + newValue.toString() + ";";
							}
						}
					}
				}
			}
		}
		return result;
	}

	public abstract PrimaryInfo fetchPKey();

	public class PrimaryInfo {
		private String key;
		private Serializable value;

		public PrimaryInfo(String key, Serializable value) {
			this.key = key;
			this.value = value;
		}

		public String getKey() {
			return this.key;
		}

		public void setKey(String key) {
			this.key = key;
		}

		public Serializable getValue() {
			return this.value;
		}

		public void setValue(Serializable value) {
			this.value = value;
		}
	}
}

package gnnt.MEBS.common.broker.common;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import gnnt.MEBS.common.broker.statictools.ApplicationContextInit;

public class ReturnValue {
	private Log log = LogFactory.getLog(ReturnValue.class);
	private int result = -1;
	private Map<Long, String> errorInfoMap = new HashMap();

	public int getResult() {
		return this.result;
	}

	public void setResult(int result) {
		this.result = result;
	}

	public Map<Long, String> getInfoMap() {
		return this.errorInfoMap;
	}

	public String getInfo() {
		StringBuffer sb = new StringBuffer();
		for (Map.Entry<Long, String> m : this.errorInfoMap.entrySet()) {
			if (this.result == 1) {
				sb.append((String) m.getValue()).append("\\n");
			} else {
				sb.append((String) m.getValue()).append("\\n");
			}
		}
		return sb.toString();
	}

	public void addInfo(long errorCode) {
		this.errorInfoMap.put(Long.valueOf(errorCode), ApplicationContextInit.getErrorInfo(errorCode + ""));
	}

	public void addInfo(long errorCode, Object[] args) {
		String format = ApplicationContextInit.getErrorInfo(errorCode + "");
		String errorInfo = format;
		try {
			errorInfo = String.format(format, args);
		} catch (Exception e) {
			this.log.debug("errorCode:" + errorCode + ";Format Exception!");
			this.log.debug("formatStr:" + format);
			Object[] arrayOfObject;
			int j = (arrayOfObject = args).length;
			for (int i = 0; i < j; i++) {
				Object o = arrayOfObject[i];
				this.log.debug("Object:" + o.toString());
			}
			this.log.debug(e.toString());
		}
		this.errorInfoMap.put(Long.valueOf(errorCode), errorInfo.replaceAll("\n", ""));
	}
}

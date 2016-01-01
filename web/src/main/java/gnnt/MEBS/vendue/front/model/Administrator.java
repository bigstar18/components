package gnnt.MEBS.vendue.front.model;

import gnnt.MEBS.common.front.model.StandardModel;

public class Administrator extends StandardModel {
	private static final long serialVersionUID = -1185871472800004202L;
	private String userId;
	private String name;
	private String description;
	private String type;
	private String isForbid = "N";

	public String getUserId() {
		return this.userId;
	}

	public void setUserId(String paramString) {
		this.userId = paramString;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String paramString) {
		this.type = paramString;
	}

	public String getIsForbid() {
		return this.isForbid;
	}

	public void setIsForbid(String paramString) {
		this.isForbid = paramString;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String paramString) {
		this.name = paramString;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String paramString) {
		this.description = paramString;
	}

	public StandardModel.PrimaryInfo fetchPKey() {
		return new StandardModel.PrimaryInfo("userId", this.userId);
	}
}

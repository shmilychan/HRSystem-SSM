package cn.mldn.travel.vo;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Action implements Serializable {
	private String actid ;
	private String rid ;
	private String title ;
	public String getActid() {
		return actid;
	}
	public void setActid(String actid) {
		this.actid = actid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
}

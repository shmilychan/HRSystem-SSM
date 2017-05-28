package cn.mldn.travel.vo;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Level implements Serializable {
	private String lid ;
	private String title ;
	private Integer level ;
	public String getLid() {
		return lid;
	}
	public void setLid(String lid) {
		this.lid = lid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Integer getLevel() {
		return level;
	}
	public void setLevel(Integer level) {
		this.level = level;
	}
}

package cn.mldn.travel.vo;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Type implements Serializable {
	private Long tpid ;
	private String title ;
	public Long getTpid() {
		return tpid;
	}
	public void setTpid(Long tpid) {
		this.tpid = tpid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
}

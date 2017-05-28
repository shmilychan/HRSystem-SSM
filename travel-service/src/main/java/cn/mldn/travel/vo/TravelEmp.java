package cn.mldn.travel.vo;

import java.io.Serializable;

@SuppressWarnings("serial")
public class TravelEmp implements Serializable {
	private Long teid ;
	private Long tid ;
	private String eid ;
	public Long getTeid() {
		return teid;
	}
	public void setTeid(Long teid) {
		this.teid = teid;
	}
	public Long getTid() {
		return tid;
	}
	public void setTid(Long tid) {
		this.tid = tid;
	}
	public String getEid() {
		return eid;
	}
	public void setEid(String eid) {
		this.eid = eid;
	}
}

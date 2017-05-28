package cn.mldn.travel.vo;

import java.io.Serializable;

@SuppressWarnings("serial")
public class TravelCost implements Serializable {
	private Long tcid ;
	private Long tpid ;
	private Long tid ;
	private Double price ;
	private String title ;
	public Long getTcid() {
		return tcid;
	}
	public void setTcid(Long tcid) {
		this.tcid = tcid;
	}
	public Long getTpid() {
		return tpid;
	}
	public void setTpid(Long tpid) {
		this.tpid = tpid;
	}
	public Long getTid() {
		return tid;
	}
	public void setTid(Long tid) {
		this.tid = tid;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
}

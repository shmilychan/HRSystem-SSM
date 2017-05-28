package cn.mldn.travel.vo;

import java.io.Serializable;
import java.util.Date;

@SuppressWarnings("serial")
public class Emp implements Serializable {
	private String eid ;
	private String lid ;
	private Long did ;
	private String ename ;
	private Double sal ;
	private String phone ;
	private String password ;
	private String photo ;
	private String note ;
	private Date hiredate ;
	private String ineid ;
	private Integer locked ;
	public String getEid() {
		return eid;
	}
	public void setEid(String eid) {
		this.eid = eid;
	}
	public String getLid() {
		return lid;
	}
	public void setLid(String lid) {
		this.lid = lid;
	}
	public Long getDid() {
		return did;
	}
	public void setDid(Long did) {
		this.did = did;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public Double getSal() {
		return sal;
	}
	public void setSal(Double sal) {
		this.sal = sal;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public Date getHiredate() {
		return hiredate;
	}
	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}
	public String getIneid() {
		return ineid;
	}
	public void setIneid(String ineid) {
		this.ineid = ineid;
	}
	public Integer getLocked() {
		return locked;
	}
	public void setLocked(Integer locked) {
		this.locked = locked;
	}
	@Override
	public String toString() {
		return "Emp [eid=" + eid + ", lid=" + lid + ", did=" + did + ", ename="
				+ ename + ", sal=" + sal + ", phone=" + phone + ", password="
				+ password + ", photo=" + photo + ", note=" + note
				+ ", hiredate=" + hiredate + ", ineid=" + ineid + ", locked="
				+ locked + "]";
	}
}

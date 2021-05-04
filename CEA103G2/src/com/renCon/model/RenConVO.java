package com.renCon.model;

public class RenConVO implements java.io.Serializable{
	private Integer rtct_no;
	private Integer hos_no;
	private Integer mem_no;
	private java.sql.Date rtct_eff_date;
	private java.sql.Date rtct_end_date;
	private java.sql.Date rtct_tmt_date;
	private byte[] rtct_pic;
	private Integer rtct_deposit;
	
	public Integer getRtct_no() {
		return rtct_no;
	}
	public void setRtct_no(Integer rtct_no) {
		this.rtct_no = rtct_no;
	}
	public Integer getHos_no() {
		return hos_no;
	}
	public void setHos_no(Integer hos_no) {
		this.hos_no = hos_no;
	}
	public Integer getMem_no() {
		return mem_no;
	}
	public void setMem_no(Integer mem_no) {
		this.mem_no = mem_no;
	}
	public java.sql.Date getRtct_eff_date() {
		return rtct_eff_date;
	}
	public void setRtct_eff_date(java.sql.Date rtct_eff_date) {
		this.rtct_eff_date = rtct_eff_date;
	}
	public java.sql.Date getRtct_end_date() {
		return rtct_end_date;
	}
	public void setRtct_end_date(java.sql.Date rtct_end_date) {
		this.rtct_end_date = rtct_end_date;
	}
	public java.sql.Date getRtct_tmt_date() {
		return rtct_tmt_date;
	}
	public void setRtct_tmt_date(java.sql.Date rtct_tmt_date) {
		this.rtct_tmt_date = rtct_tmt_date;
	}
	public byte[] getRtct_pic() {
		return rtct_pic;
	}
	public void setRtct_pic(byte[] rtct_pic) {
		this.rtct_pic = rtct_pic;
	}
	public Integer getRtct_deposit() {
		return rtct_deposit;
	}
	public void setRtct_deposit(Integer rtct_deposit) {
		this.rtct_deposit = rtct_deposit;
	}
}

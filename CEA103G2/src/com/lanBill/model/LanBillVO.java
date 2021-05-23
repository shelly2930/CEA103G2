package com.lanBill.model;

import java.sql.Date;

public class LanBillVO implements java.io.Serializable {
	private Integer lldb_no;
	private Integer lld_no;
	private Integer hos_no;
	private Date lldb_date;
	private Date lldb_due;
	private Byte lldb_status;
	
	public Integer getLldb_no() {
		return lldb_no;
	}
	public void setLldb_no(Integer lldb_no) {
		this.lldb_no = lldb_no;
	}
	public Integer getLld_no() {
		return lld_no;
	}
	public void setLld_no(Integer lld_no) {
		this.lld_no = lld_no;
	}
	public Integer getHos_no() {
		return hos_no;
	}
	public void setHos_no(Integer hos_no) {
		this.hos_no = hos_no;
	}
	public Date getLldb_date() {
		return lldb_date;
	}
	public void setLldb_date(Date lldb_date) {
		this.lldb_date = lldb_date;
	}
	public Date getLldb_due() {
		return lldb_due;
	}
	public void setLldb_due(Date lldb_due) {
		this.lldb_due = lldb_due;
	}
	public Byte getLldb_status() {
		return lldb_status;
	}
	public void setLldb_status(Byte lldb_status) {
		this.lldb_status = lldb_status;
	}
	
	
}

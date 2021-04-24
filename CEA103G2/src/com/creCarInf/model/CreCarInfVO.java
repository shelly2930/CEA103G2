package com.creCarInf.model;

import java.sql.Date;

public class CreCarInfVO implements java.io.Serializable {
	private Integer cci_no;
	private Integer mem_no;
	private String cci_name;
	private String cci_id;
	private Date cci_due;
	private Integer cci_code;
	
	public Integer getCci_no() {
		return cci_no;
	}
	public void setCci_no(Integer cci_no) {
		this.cci_no = cci_no;
	}
	public Integer getMem_no() {
		return mem_no;
	}
	public void setMem_no(Integer mem_no) {
		this.mem_no = mem_no;
	}
	public String getCci_name() {
		return cci_name;
	}
	public void setCci_name(String cci_name) {
		this.cci_name = cci_name;
	}
	public String getCci_id() {
		return cci_id;
	}
	public void setCci_id(String cci_id) {
		this.cci_id = cci_id;
	}
	public Date getCci_due() {
		return cci_due;
	}
	public void setCci_due(Date cci_due) {
		this.cci_due = cci_due;
	}
	public Integer getCci_code() {
		return cci_code;
	}
	public void setCci_code(Integer cci_code) {
		this.cci_code = cci_code;
	}	
}

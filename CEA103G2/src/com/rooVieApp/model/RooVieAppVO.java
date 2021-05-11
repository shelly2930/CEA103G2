package com.rooVieApp.model;

public class RooVieAppVO implements java.io.Serializable{
	private Integer rva_no;
	private Integer mem_no;
	private Integer hos_no;
	private Integer emp_no;
	private java.sql.Timestamp rva_app_time;
	private java.sql.Timestamp rva_order_time;
	private java.sql.Timestamp rva_end_time;
	private Byte rva_status;
	public Integer getRva_no() {
		return rva_no;
	}
	public void setRva_no(Integer rva_no) {
		this.rva_no = rva_no;
	}
	public Integer getMem_no() {
		return mem_no;
	}
	public void setMem_no(Integer mem_no) {
		this.mem_no = mem_no;
	}
	public Integer getHos_no() {
		return hos_no;
	}
	public void setHos_no(Integer hos_no) {
		this.hos_no = hos_no;
	}
	public Integer getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(Integer emp_no) {
		this.emp_no = emp_no;
	}
	public java.sql.Timestamp getRva_app_time() {
		return rva_app_time;
	}
	public void setRva_app_time(java.sql.Timestamp rva_app_time) {
		this.rva_app_time = rva_app_time;
	}
	public java.sql.Timestamp getRva_order_time() {
		return rva_order_time;
	}
	public void setRva_order_time(java.sql.Timestamp rva_order_time) {
		this.rva_order_time = rva_order_time;
	}
	public java.sql.Timestamp getRva_end_time() {
		return rva_end_time;
	}
	public void setRva_end_time(java.sql.Timestamp rva_end_time) {
		this.rva_end_time = rva_end_time;
	}
	public Byte getRva_status() {
		return rva_status;
	}
	public void setRva_status(Byte rva_status) {
		this.rva_status = rva_status;
	}

}

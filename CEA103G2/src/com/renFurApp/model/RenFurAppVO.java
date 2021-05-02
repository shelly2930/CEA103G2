package com.renFurApp.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class RenFurAppVO implements java.io.Serializable {
	private Integer rfa_no;
	private Integer mem_no;
	private Integer emp_no;
	private Timestamp rfa_order_date;
	private Integer rfa_total;
	private Timestamp rfa_apct_date;
	private Byte rfa_status;
	
	
	public Integer getRfa_no() {
		return rfa_no;
	}
	public void setRfa_no(Integer rfa_no) {
		this.rfa_no = rfa_no;
	}
	public Integer getMem_no() {
		return mem_no;
	}
	public void setMem_no(Integer mem_no) {
		this.mem_no = mem_no;
	}
	public Integer getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(Integer emp_no) {
		this.emp_no = emp_no;
	}
	public Timestamp getRfa_order_date() {
		return rfa_order_date;
	}
	public void setRfa_order_date(Timestamp rfa_order_date) {
		this.rfa_order_date = rfa_order_date;
	}
	public Integer getRfa_total() {
		return rfa_total;
	}
	public void setRfa_total(Integer rfa_total) {
		this.rfa_total = rfa_total;
	}
	public Timestamp getRfa_apct_date() {
		return rfa_apct_date;
	}
	public void setRfa_apct_date(Timestamp rfa_apct_date) {
		this.rfa_apct_date = rfa_apct_date;
	}
	public Byte getRfa_status() {
		return rfa_status;
	}
	public void setRfa_status(Byte rfa_status) {
		this.rfa_status = rfa_status;
	}
	
	
}

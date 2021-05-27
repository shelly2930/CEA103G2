package com.bill.model;

import java.sql.Date;

public class BillVO implements java.io.Serializable { // why implements java.io.Serializable? p218 beanname
	private Integer bill_no;
	private Integer mem_no;
	private Integer hos_no;
	private Date bill_date;
	private Date bill_due;
	private Integer bill_power;
	private Integer bill_water;
	private Byte bill_p_status;
	private Byte bill_r_status;
	
	public Integer getBill_no() {
		return bill_no;
	}
	public void setBill_no(Integer bill_no) {
		this.bill_no = bill_no;
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
	public Date getBill_date() {
		return bill_date;
	}
	public void setBill_date(Date bill_date) {
		this.bill_date = bill_date;
	}
	public Date getBill_due() {
		return bill_due;
	}
	public void setBill_due(Date bill_due) {
		this.bill_due = bill_due;
	}
	public Integer getBill_power() {
		return bill_power;
	}
	public void setBill_power(Integer bill_power) {
		this.bill_power = bill_power;
	}
	public Integer getBill_water() {
		return bill_water;
	}
	public void setBill_water(Integer bill_water) {
		this.bill_water = bill_water;
	}
	public Byte getBill_p_status() {
		return bill_p_status;
	}
	public void setBill_p_status(Byte bill_p_status) {
		this.bill_p_status = bill_p_status;
	}
	public Byte getBill_r_status() {
		return bill_r_status;
	}
	public void setBill_r_status(Byte bill_r_status) {
		this.bill_r_status = bill_r_status;
	}
}

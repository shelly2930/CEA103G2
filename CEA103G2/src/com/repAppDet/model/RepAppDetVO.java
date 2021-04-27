package com.repAppDet.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class RepAppDetVO implements Serializable {
	private Integer rad_no;
	private Integer ra_no;
	private Timestamp rad_order_time;
	private String rad_dmg_dsc;
	private Byte rad_status;
	private Integer rad_expz;
	private Byte rad_tr_dmg;
	
	public Integer getRad_no() {
		return rad_no;
	}
	public void setRad_no(Integer rad_no) {
		this.rad_no = rad_no;
	}
	public Integer getRa_no() {
		return ra_no;
	}
	public void setRa_no(Integer ra_no) {
		this.ra_no = ra_no;
	}
	public Timestamp getRad_order_time() {
		return rad_order_time;
	}
	public void setRad_order_time(Timestamp rad_order_time) {
		this.rad_order_time = rad_order_time;
	}
	public String getRad_dmg_dsc() {
		return rad_dmg_dsc;
	}
	public void setRad_dmg_dsc(String rad_dmg_dsc) {
		this.rad_dmg_dsc = rad_dmg_dsc;
	}
	public Byte getRad_status() {
		return rad_status;
	}
	public void setRad_status(Byte rad_status) {
		this.rad_status = rad_status;
	}
	public Integer getRad_expz() {
		return rad_expz;
	}
	public void setRad_expz(Integer rad_expz) {
		this.rad_expz = rad_expz;
	}
	public Byte getRad_tr_dmg() {
		return rad_tr_dmg;
	}
	public void setRad_tr_dmg(Byte rad_tr_dmg) {
		this.rad_tr_dmg = rad_tr_dmg;
	}
	
}

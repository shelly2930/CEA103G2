package com.renFurDet.model;

import java.sql.Timestamp;

public class RenFurDetVO implements java.io.Serializable {
	private Integer rfa_no;
	private Integer fnt_id;
	private Integer rtct_no;
	private Timestamp rent_date;
	private Timestamp rent_end_date;
	private Timestamp rent_tmt_date;
	
	
	public Integer getRfa_no() {
		return rfa_no;
	}
	public void setRfa_no(Integer rfa_no) {
		this.rfa_no = rfa_no;
	}
	public Integer getFnt_id() {
		return fnt_id;
	}
	public void setFnt_id(Integer fnt_id) {
		this.fnt_id = fnt_id;
	}
	public Integer getRtct_no() {
		return rtct_no;
	}
	public void setRtct_no(Integer rtct_no) {
		this.rtct_no = rtct_no;
	}
	public Timestamp getRent_date() {
		return rent_date;
	}
	public void setRent_date(Timestamp rent_date) {
		this.rent_date = rent_date;
	}
	public Timestamp getRent_end_date() {
		return rent_end_date;
	}
	public void setRent_end_date(Timestamp rent_end_date) {
		this.rent_end_date = rent_end_date;
	}
	public Timestamp getRent_tmt_date() {
		return rent_tmt_date;
	}
	public void setRent_tmt_date(Timestamp rent_tmt_date) {
		this.rent_tmt_date = rent_tmt_date;
	}
	
	
}

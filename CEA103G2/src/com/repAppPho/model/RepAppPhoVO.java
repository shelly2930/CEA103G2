package com.repAppPho.model;

import java.io.Serializable;

public class RepAppPhoVO implements Serializable {
	private Integer rap_no;
	private Integer ra_no;
	private byte[] rap_photo;
	
	public Integer getRap_no() {
		return rap_no;
	}
	public void setRap_no(Integer rap_no) {
		this.rap_no = rap_no;
	}
	public Integer getRa_no() {
		return ra_no;
	}
	public void setRa_no(Integer ra_no) {
		this.ra_no = ra_no;
	}
	public byte[] getRap_photo() {
		return rap_photo;
	}
	public void setRap_photo(byte[] rap_photo) {
		this.rap_photo = rap_photo;
	}
	
}

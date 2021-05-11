package com.repAppPho.model;

import java.io.Serializable;

import com.repAppDet.model.RepAppDetVO;

public class RepAppPhoVO implements Serializable {
	private Integer rap_no;
	private RepAppDetVO repAppDetVO;
	private byte[] rap_photo;
	
	public Integer getRap_no() {
		return rap_no;
	}
	public void setRap_no(Integer rap_no) {
		this.rap_no = rap_no;
	}
	public RepAppDetVO getRepAppDetVO() {
		return repAppDetVO;
	}
	public void setRepAppDetVO(RepAppDetVO repAppDetVO) {
		this.repAppDetVO = repAppDetVO;
	}
	public byte[] getRap_photo() {
		return rap_photo;
	}
	public void setRap_photo(byte[] rap_photo) {
		this.rap_photo = rap_photo;
	}
	
}

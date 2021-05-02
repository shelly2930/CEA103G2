package com.furPho.model;

import java.io.Serializable;

public class FurPhoVO implements java.io.Serializable {
	private Integer fnt_pic_no;
	private Integer fnt_it_no;
	private byte[] fnt_pic;
	
	
	public Integer getFnt_pic_no() {
		return fnt_pic_no;
	}
	public void setFnt_pic_no(Integer fnt_pic_no) {
		this.fnt_pic_no = fnt_pic_no;
	}
	public Integer getFnt_it_no() {
		return fnt_it_no;
	}
	public void setFnt_it_no(Integer fnt_it_no) {
		this.fnt_it_no = fnt_it_no;
	}
	public byte[] getFnt_pic() {
		return fnt_pic;
	}
	public void setFnt_pic(byte[] fnt_pic) {
		this.fnt_pic = fnt_pic;
	}
	
	
}

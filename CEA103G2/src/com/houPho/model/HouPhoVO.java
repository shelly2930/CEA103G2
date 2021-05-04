package com.houPho.model;

public class HouPhoVO implements java.io.Serializable{
	private Integer hos_pic_no;
	private Integer hos_no;
	private byte[] hos_pic;
	public Integer getHos_pic_no() {
		return hos_pic_no;
	}
	public void setHos_pic_no(Integer hos_pic_no) {
		this.hos_pic_no = hos_pic_no;
	}
	public Integer getHos_no() {
		return hos_no;
	}
	public void setHos_no(Integer hos_no) {
		this.hos_no = hos_no;
	}
	public byte[] getHos_pic() {
		return hos_pic;
	}
	public void setHos_pic(byte[] hos_pic) {
		this.hos_pic = hos_pic;
	}
}

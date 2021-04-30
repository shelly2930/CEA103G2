package com.notice.model;

import java.sql.Timestamp;

public class NoticeVO implements java.io.Serializable{
	private Integer ntc_no;
	private Integer mem_no;
	private Timestamp ntc_time;
	private String ntc_content;
	private Byte ntc_read;
	
	
	public Integer getNtc_no() {
		return ntc_no;
	}
	public void setNtc_no(Integer ntc_no) {
		this.ntc_no = ntc_no;
	}
	public Integer getMem_no() {
		return mem_no;
	}
	public void setMem_no(Integer mem_no) {
		this.mem_no = mem_no;
	}
	public Timestamp getNtc_time() {
		return ntc_time;
	}
	public void setNtc_time(Timestamp ntc_time) {
		this.ntc_time = ntc_time;
	}
	public String getNtc_content() {
		return ntc_content;
	}
	public void setNtc_content(String ntc_content) {
		this.ntc_content = ntc_content;
	}
	public Byte getNtc_read() {
		return ntc_read;
	}
	public void setNtc_read(Byte ntc_read) {
		this.ntc_read = ntc_read;
	}
	
	
}

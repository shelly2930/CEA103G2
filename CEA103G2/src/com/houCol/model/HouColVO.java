package com.houCol.model;

public class HouColVO implements java.io.Serializable{
	private Integer mem_no;
	private Integer hos_no;
	private String hos_col_note;
	
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
	public String getHos_col_note() {
		return hos_col_note;
	}
	public void setHos_col_note(String hos_col_note) {
		this.hos_col_note = hos_col_note;
	}
}

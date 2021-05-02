package com.furCol.model;

import java.io.Serializable;
import java.sql.Timestamp;
//家具收藏
public class FurColVO implements java.io.Serializable {
	private Integer mem_no;   //會員編號
	private Integer fnt_it_no; //家具品項編號
	private Timestamp fnt_col_date; //加入收藏時間
	private String fnt_col_note; //備註
	
	
	public Integer getMem_no() {
		return mem_no;
	}
	public void setMem_no(Integer mem_no) {
		this.mem_no = mem_no;
	}
	public Integer getFnt_it_no() {
		return fnt_it_no;
	}
	public void setFnt_it_no(Integer fnt_it_no) {
		this.fnt_it_no = fnt_it_no;
	}
	public Timestamp getFnt_col_date() {
		return fnt_col_date;
	}
	public void setFnt_col_date(Timestamp fnt_col_date) {
		this.fnt_col_date = fnt_col_date;
	}
	public String getFnt_col_note() {
		return fnt_col_note;
	}
	public void setFnt_col_note(String fnt_col_note) {
		this.fnt_col_note = fnt_col_note;
	}
	
	
}

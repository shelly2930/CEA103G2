package com.furCol.model;

import java.io.Serializable;
import java.sql.Timestamp;
//�a�㦬��
public class FurColVO implements java.io.Serializable {
	private Integer mem_no;   //�|���s��
	private Integer fnt_it_no; //�a��~���s��
	private Timestamp fnt_col_date; //�[�J���îɶ�
	private String fnt_col_note; //�Ƶ�
	
	
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

package com.lanlord.model;

import java.sql.Timestamp;

public class LanlordVO implements java.io.Serializable {
	private Integer lld_no;
	private Integer mem_no;
	private Timestamp lld_apptime;
	private String lld_bank;
	private String lld_account;
	private byte[] lld_acc_pic;
	private Byte lld_status;
	private Timestamp lld_id_isvrfed;
	private String lld_id_disapprove;
	private String lld_suspend;
	
	public Integer getLld_no() {
		return lld_no;
	}
	public void setLld_no(Integer lld_no) {
		this.lld_no = lld_no;
	}
	public Integer getMem_no() {
		return mem_no;
	}
	public void setMem_no(Integer mem_no) {
		this.mem_no = mem_no;
	}
	public Timestamp getLld_apptime() {
		return lld_apptime;
	}
	public void setLld_apptime(Timestamp lld_apptime) {
		this.lld_apptime = lld_apptime;
	}
	public String getLld_bank() {
		return lld_bank;
	}
	public void setLld_bank(String lld_bank) {
		this.lld_bank = lld_bank;
	}
	public String getLld_account() {
		return lld_account;
	}
	public void setLld_account(String lld_account) {
		this.lld_account = lld_account;
	}
	public byte[] getLld_acc_pic() {
		return lld_acc_pic;
	}
	public void setLld_acc_pic(byte[] lld_acc_pic) {
		this.lld_acc_pic = lld_acc_pic;
	}
	public Byte getLld_status() {
		return lld_status;
	}
	public void setLld_status(Byte lld_status) {
		this.lld_status = lld_status;
	}
	public Timestamp getLld_id_isvrfed() {
		return lld_id_isvrfed;
	}
	public void setLld_id_isvrfed(Timestamp lld_id_isvrfed) {
		this.lld_id_isvrfed = lld_id_isvrfed;
	}
	public String getLld_id_disapprove() {
		return lld_id_disapprove;
	}
	public void setLld_id_disapprove(String lld_id_disapprove) {
		this.lld_id_disapprove = lld_id_disapprove;
	}
	public String getLld_suspend() {
		return lld_suspend;
	}
	public void setLld_suspend(String lld_suspend) {
		this.lld_suspend = lld_suspend;
	}
}

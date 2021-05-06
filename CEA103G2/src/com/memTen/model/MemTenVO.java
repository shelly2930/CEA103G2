package com.memTen.model;

import java.sql.Date;

public class MemTenVO implements java.io.Serializable {
	private Integer mem_no;
	private String mem_username;
	private String mem_password;
	private byte[] mem_pic;
	private String mem_name;
	private Byte mem_gender;
	private String mem_id;
	private Date mem_birthday;
	private String mem_phone;
	private String mem_mobile;
	private String mem_email;
	private String mem_city;
	private String mem_dist;
	private String mem_addr;
	private Byte mem_status;
	private byte[] mem_idcard_f;
	private byte[] mem_idcard_r;
	private Byte mem_id_status;
	private String mem_suspend;
	private String mem_refuse;
	
	public Integer getMem_no() {
		return mem_no;
	}
	public void setMem_no(Integer mem_no) {
		this.mem_no = mem_no;
	}
	public String getMem_username() {
		return mem_username;
	}
	public void setMem_username(String mem_username) {
		this.mem_username = mem_username;
	}
	public String getMem_password() {
		return mem_password;
	}
	public void setMem_password(String mem_password) {
		this.mem_password = mem_password;
	}
	public byte[] getMem_pic() {
		return mem_pic;
	}
	public void setMem_pic(byte[] mem_pic) {
		this.mem_pic = mem_pic;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public Byte getMem_gender() {
		return mem_gender;
	}
	public void setMem_gender(Byte mem_gender) {
		this.mem_gender = mem_gender;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public Date getMem_birthday() {
		return mem_birthday;
	}
	public void setMem_birthday(Date mem_birthday) {
		this.mem_birthday = mem_birthday;
	}
	public String getMem_phone() {
		return mem_phone;
	}
	public void setMem_phone(String mem_phone) {
		this.mem_phone = mem_phone;
	}
	public String getMem_mobile() {
		return mem_mobile;
	}
	public void setMem_mobile(String mem_mobile) {
		this.mem_mobile = mem_mobile;
	}
	public String getMem_email() {
		return mem_email;
	}
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}
	public String getMem_city() {
		return mem_city;
	}
	public void setMem_city(String mem_city) {
		this.mem_city = mem_city;
	}
	public String getMem_dist() {
		return mem_dist;
	}
	public void setMem_dist(String mem_dist) {
		this.mem_dist = mem_dist;
	}
	public String getMem_addr() {
		return mem_addr;
	}
	public void setMem_addr(String mem_addr) {
		this.mem_addr = mem_addr;
	}
	public Byte getMem_status() {
		return mem_status;
	}
	public void setMem_status(Byte mem_status) {
		this.mem_status = mem_status;
	}
	public byte[] getMem_idcard_f() {
		return mem_idcard_f;
	}
	public void setMem_idcard_f(byte[] mem_idcard_f) {
		this.mem_idcard_f = mem_idcard_f;
	}
	public byte[] getMem_idcard_r() {
		return mem_idcard_r;
	}
	public void setMem_idcard_r(byte[] mem_idcard_r) {
		this.mem_idcard_r = mem_idcard_r;
	}
	public Byte getMem_id_status() {
		return mem_id_status;
	}
	public void setMem_id_status(Byte mem_id_status) {
		this.mem_id_status = mem_id_status;
	}
	public String getMem_suspend() {
		return mem_suspend;
	}
	public void setMem_suspend(String mem_suspend) {
		this.mem_suspend = mem_suspend;
	}
	public String getMem_refuse() {
		return mem_refuse;
	}
	public void setMem_refuse(String mem_refuse) {
		this.mem_refuse = mem_refuse;
	}	
}

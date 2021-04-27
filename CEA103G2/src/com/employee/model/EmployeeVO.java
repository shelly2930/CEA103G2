package com.employee.model;

import java.io.Serializable;
import java.sql.Date;

public class EmployeeVO implements Serializable {
	private Integer emp_no;
	private String emp_name;
	private String emp_job;
	private String emp_username;
	private String emp_password;
	private Byte emp_gender;
	private String emp_id;
	private Date emp_birthday;
	private String emp_phone;
	private String emp_mobile;
	private String emp_addr;
	private Date emp_hiredate;
	private Date emp_quitdate;
	private String emp_email;
	private String emp_bank;
	private String emp_account;
	private Integer emp_sal;
	private Integer emp_bonus;
	private byte[] emp_pic;
	
	public Integer getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(Integer emp_no) {
		this.emp_no = emp_no;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public String getEmp_job() {
		return emp_job;
	}
	public void setEmp_job(String emp_job) {
		this.emp_job = emp_job;
	}
	public String getEmp_username() {
		return emp_username;
	}
	public void setEmp_username(String emp_username) {
		this.emp_username = emp_username;
	}
	public String getEmp_password() {
		return emp_password;
	}
	public void setEmp_password(String emp_password) {
		this.emp_password = emp_password;
	}
	public Byte getEmp_gender() {
		return emp_gender;
	}
	public void setEmp_gender(Byte emp_gender) {
		this.emp_gender = emp_gender;
	}
	public String getEmp_id() {
		return emp_id;
	}
	public void setEmp_id(String emp_id) {
		this.emp_id = emp_id;
	}
	public Date getEmp_birthday() {
		return emp_birthday;
	}
	public void setEmp_birthday(Date emp_birthday) {
		this.emp_birthday = emp_birthday;
	}
	public String getEmp_phone() {
		return emp_phone;
	}
	public void setEmp_phone(String emp_phone) {
		this.emp_phone = emp_phone;
	}
	public String getEmp_mobile() {
		return emp_mobile;
	}
	public void setEmp_mobile(String emp_mobile) {
		this.emp_mobile = emp_mobile;
	}
	public String getEmp_addr() {
		return emp_addr;
	}
	public void setEmp_addr(String emp_addr) {
		this.emp_addr = emp_addr;
	}
	public Date getEmp_hiredate() {
		return emp_hiredate;
	}
	public void setEmp_hiredate(Date emp_hiredate) {
		this.emp_hiredate = emp_hiredate;
	}
	public Date getEmp_quitdate() {
		return emp_quitdate;
	}
	public void setEmp_quitdate(Date emp_quitdate) {
		this.emp_quitdate = emp_quitdate;
	}
	public String getEmp_email() {
		return emp_email;
	}
	public void setEmp_email(String emp_email) {
		this.emp_email = emp_email;
	}
	public String getEmp_bank() {
		return emp_bank;
	}
	public void setEmp_bank(String emp_bank) {
		this.emp_bank = emp_bank;
	}
	public String getEmp_account() {
		return emp_account;
	}
	public void setEmp_account(String emp_account) {
		this.emp_account = emp_account;
	}
	public int getEmp_sal() {
		return emp_sal;
	}
	public void setEmp_sal(int emp_sal) {
		this.emp_sal = emp_sal;
	}
	public int getEmp_bonus() {
		return emp_bonus;
	}
	public void setEmp_bonus(int emp_bonus) {
		this.emp_bonus = emp_bonus;
	}
	public byte[] getEmp_pic() {
		return emp_pic;
	}
	public void setEmp_pic(byte[] emp_pic) {
		this.emp_pic = emp_pic;
	}
}

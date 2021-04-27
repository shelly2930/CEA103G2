package com.staFun.model;

import java.io.Serializable;

public class StaFunVO implements Serializable {
	private Integer fun_no;
	private String fun_name;
	
	public Integer getFun_no() {
		return fun_no;
	}
	public void setFun_no(Integer fun_no) {
		this.fun_no = fun_no;
	}
	public String getFun_name() {
		return fun_name;
	}
	public void setFun_name(String fun_name) {
		this.fun_name = fun_name;
	}
	
}

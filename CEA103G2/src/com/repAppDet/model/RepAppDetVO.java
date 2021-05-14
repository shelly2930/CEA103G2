package com.repAppDet.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.repApp.model.RepAppVO;
import com.repAppPho.model.RepAppPhoVO;

public class RepAppDetVO implements Serializable {
	private Integer rad_no;
	private RepAppVO repAppVO;
	private String rad_dmg;
	private String rad_dsc;
	private Byte rad_status;
	private Integer rad_expz;
	private Byte rad_tr_dmg;
	private Set<RepAppPhoVO> set_RepAppPhoVO = new HashSet<RepAppPhoVO>();
	
	public Integer getRad_no() {
		return rad_no;
	}
	public void setRad_no(Integer rad_no) {
		this.rad_no = rad_no;
	}
	public RepAppVO getRepAppVO() {
		return repAppVO;
	}
	public void setRepAppVO(RepAppVO repAppVO) {
		this.repAppVO = repAppVO;
	}
	public String getRad_dmg() {
		return rad_dmg;
	}
	public void setRad_dmg(String rad_dmg) {
		this.rad_dmg = rad_dmg;
	}
	public String getRad_dsc() {
		return rad_dsc;
	}
	public void setRad_dsc(String rad_dsc) {
		this.rad_dsc = rad_dsc;
	}
	public Byte getRad_status() {
		return rad_status;
	}
	public void setRad_status(Byte rad_status) {
		this.rad_status = rad_status;
	}
	public Integer getRad_expz() {
		return rad_expz;
	}
	public void setRad_expz(Integer rad_expz) {
		this.rad_expz = rad_expz;
	}
	public Byte getRad_tr_dmg() {
		return rad_tr_dmg;
	}
	public void setRad_tr_dmg(Byte rad_tr_dmg) {
		this.rad_tr_dmg = rad_tr_dmg;
	}
	public Set<RepAppPhoVO> getSet_RepAppPhoVO() {
		return set_RepAppPhoVO;
	}
	public void setSet_RepAppPhoVO(Set<RepAppPhoVO> set_RepAppPhoVO) {
		this.set_RepAppPhoVO = set_RepAppPhoVO;
	}
	
}

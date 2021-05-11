package com.repApp.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.employee.model.EmployeeVO;
import com.memTen.model.MemTenVO;
import com.renCon.model.RenConVO;
import com.repAppDet.model.RepAppDetVO;

public class RepAppVO implements Serializable {
	private Integer ra_no;
	private MemTenVO memTenVO;
	private RenConVO renConVO;
	private EmployeeVO employeeVO;
	private Timestamp ra_app_time;
	private Timestamp ra_order_time;
	private Timestamp ra_end_time;
	private Byte ra_status;
	private List<RepAppDetVO> list_RepAppDetVO = new ArrayList<RepAppDetVO>();
	
	public Integer getRa_no() {
		return ra_no;
	}
	public void setRa_no(Integer ra_no) {
		this.ra_no = ra_no;
	}
	public MemTenVO getMemTenVO() {
		return memTenVO;
	}
	public void setMemTenVO(MemTenVO memTenVO) {
		this.memTenVO = memTenVO;
	}
	public RenConVO getRenConVO() {
		return renConVO;
	}
	public void setRenConVO(RenConVO renConVO) {
		this.renConVO = renConVO;
	}
	public EmployeeVO getEmployeeVO() {
		return employeeVO;
	}
	public void setEmployeeVO(EmployeeVO employeeVO) {
		this.employeeVO = employeeVO;
	}
	public Timestamp getRa_app_time() {
		return ra_app_time;
	}
	public void setRa_app_time(Timestamp ra_app_time) {
		this.ra_app_time = ra_app_time;
	}
	public Timestamp getRa_order_time() {
		return ra_order_time;
	}
	public void setRa_order_time(Timestamp ra_order_time) {
		this.ra_order_time = ra_order_time;
	}
	public Timestamp getRa_end_time() {
		return ra_end_time;
	}
	public void setRa_end_time(Timestamp ra_end_time) {
		this.ra_end_time = ra_end_time;
	}
	public Byte getRa_status() {
		return ra_status;
	}
	public void setRa_status(Byte ra_status) {
		this.ra_status = ra_status;
	}
	public List<RepAppDetVO> getList_RepAppDetVO() {
		return list_RepAppDetVO;
	}
	public void setList_RepAppDetVO(List<RepAppDetVO> list_RepAppDetVO) {
		this.list_RepAppDetVO = list_RepAppDetVO;
	}
	
}

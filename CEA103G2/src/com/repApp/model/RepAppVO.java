package com.repApp.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

import com.employee.model.EmployeeVO;
import com.memTen.model.MemTenVO;
import com.renCon.model.RenConVO;
import com.repAppDet.model.RepAppDetVO;

public class RepAppVO implements Serializable {
	private Integer ra_no;
//	private MemTenVO memTenVO;
//	private RenConVO renConVO;
//	private EmployeeVO employeeVO;
	private Integer mem_no;
	private Integer rtct_no;
	private Integer emp_no;
	private Timestamp ra_app_time;
	private Timestamp ra_order_time;
	private Timestamp ra_end_time;
	private Byte ra_status;
	private Set<RepAppDetVO> set_RepAppDetVO = new HashSet<RepAppDetVO>();
	
	public Integer getRa_no() {
		return ra_no;
	}
	public void setRa_no(Integer ra_no) {
		this.ra_no = ra_no;
	}
//	public MemTenVO getMemTenVO() {
//		return memTenVO;
//	}
//	public void setMemTenVO(MemTenVO memTenVO) {
//		this.memTenVO = memTenVO;
//	}
//	public RenConVO getRenConVO() {
//		return renConVO;
//	}
//	public void setRenConVO(RenConVO renConVO) {
//		this.renConVO = renConVO;
//	}
//	public EmployeeVO getEmployeeVO() {
//		return employeeVO;
//	}
//	public void setEmployeeVO(EmployeeVO employeeVO) {
//		this.employeeVO = employeeVO;
//	}
	public Integer getMem_no() {
		return mem_no;
	}
	public void setMem_no(Integer mem_no) {
		this.mem_no = mem_no;
	}
	public Integer getRtct_no() {
		return rtct_no;
	}
	public void setRtct_no(Integer rtct_no) {
		this.rtct_no = rtct_no;
	}
	public Integer getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(Integer emp_no) {
		this.emp_no = emp_no;
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
	public Set<RepAppDetVO> getSet_RepAppDetVO() {
		return set_RepAppDetVO;
	}
	public void setSet_RepAppDetVO(Set<RepAppDetVO> set_RepAppDetVO) {
		this.set_RepAppDetVO = set_RepAppDetVO;
	}
	
}

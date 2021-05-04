package com.employee.model;

import java.util.List;

import com.staRig.model.StaRigVO;

public interface EmployeeDAO_interface {
	public void insert(EmployeeVO employeeVO, List<Integer> list_Fun_no);
	public void updateBySup(EmployeeVO employeeVO, List<Integer> list_Fun_no);
	public void updateByEmp(EmployeeVO employeeVO);
	public void delete(Integer emp_no);
	public EmployeeVO getByPK(Integer emp_no);
	public List<EmployeeVO> getAll();
	public boolean doesItExist(String emp_username);
//  public List<EmployeeVO> getAll(Map<String, String[]> map); 
}

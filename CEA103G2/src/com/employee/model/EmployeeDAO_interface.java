package com.employee.model;

import java.util.List;

public interface EmployeeDAO_interface {
	public void insert(EmployeeVO employeeVO);
	public void updateBySup(EmployeeVO employeeVO);
	public void updateByEmp(EmployeeVO employeeVO);
	public void delete(Integer emp_no);
	public EmployeeVO getByPK(Integer emp_no);
	public List<EmployeeVO> getAll();
	public boolean doesItExist(String emp_username);
//  public List<EmployeeVO> getAll(Map<String, String[]> map); 
}

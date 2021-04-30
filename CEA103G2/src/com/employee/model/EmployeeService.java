package com.employee.model;

import java.sql.Date;
import java.util.List;

public class EmployeeService {
	private EmployeeDAO_interface employeeDAO;

	public EmployeeService() {
		employeeDAO = new EmployeeDAO();
	}

	public EmployeeVO addEmp(String emp_job, String emp_username, String emp_password, Date emp_hiredate, String emp_email, Integer emp_sal) {

		EmployeeVO employeeVO = new EmployeeVO();
		employeeVO.setEmp_job(emp_job);
		employeeVO.setEmp_username(emp_username);
		employeeVO.setEmp_password(emp_password);
		employeeVO.setEmp_hiredate(emp_hiredate);
		employeeVO.setEmp_email(emp_email);
		employeeVO.setEmp_sal(emp_sal);
		employeeDAO.insert(employeeVO);

		return employeeVO;
	}

	public EmployeeVO updateBySup(Integer emp_no, String emp_job, Date emp_hiredate, Date emp_quitdate, String emp_email, Integer emp_sal, Integer emp_bonus) {

		EmployeeVO employeeVO = new EmployeeVO();
		employeeVO.setEmp_no(emp_no);
		employeeVO.setEmp_job(emp_job);
		employeeVO.setEmp_hiredate(emp_hiredate);
		employeeVO.setEmp_quitdate(emp_quitdate);
		employeeVO.setEmp_email(emp_email);
		employeeVO.setEmp_sal(emp_sal);
		employeeVO.setEmp_bonus(emp_bonus);
		employeeDAO.updateBySup(employeeVO);

		employeeVO = employeeDAO.getByPK(emp_no);
		return employeeVO;
	}
	
	public EmployeeVO updateByEmp(Integer emp_no, String emp_name, String emp_password, Byte emp_gender, String emp_id, Date emp_birthday, String emp_phone, String emp_mobile, String emp_addr, String emp_email, String emp_bank, String emp_account, byte[] emp_pic) {
		
		EmployeeVO employeeVO = new EmployeeVO();
		employeeVO.setEmp_no(emp_no);
		employeeVO.setEmp_name(emp_name);
		employeeVO.setEmp_password(emp_password);
		employeeVO.setEmp_gender(emp_gender);
		employeeVO.setEmp_id(emp_id);
		employeeVO.setEmp_birthday(emp_birthday);
		employeeVO.setEmp_phone(emp_phone);
		employeeVO.setEmp_mobile(emp_mobile);
		employeeVO.setEmp_addr(emp_addr);
		employeeVO.setEmp_email(emp_email);
		employeeVO.setEmp_bank(emp_bank);
		employeeVO.setEmp_account(emp_account);
		employeeVO.setEmp_pic(emp_pic);
		employeeDAO.updateByEmp(employeeVO);
		
		employeeVO = employeeDAO.getByPK(emp_no);
		return employeeVO;
	}

	public void deleteEmp(Integer emp_no) {
		employeeDAO.delete(emp_no);
	}

	public EmployeeVO getOneEmp(Integer emp_no) {
		return employeeDAO.getByPK(emp_no);
	}

	public List<EmployeeVO> getAll() {
		return employeeDAO.getAll();
	}
	
	public boolean doesItExist(String emp_username) {
		return employeeDAO.doesItExist(emp_username);
	}
}
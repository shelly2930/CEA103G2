package com.repApp.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.employee.model.EmployeeVO;
import com.memTen.model.MemTenVO;
import com.renCon.model.RenConVO;
import com.repAppDet.model.RepAppDetVO;
import com.repAppPho.model.RepAppPhoVO;

public class RepAppService {
	RepAppDAO_interface repAppDAO;
	
	public RepAppService() {
		repAppDAO = new RepAppDAO();
	}
	
	public RepAppVO addRepApp(Integer mem_no, Integer rtct_no, Timestamp ra_order_time, List<RepAppDetVO> list_RepAppDetVO, List<RepAppPhoVO> list_RepAppPhoVO) {
		RepAppVO repAppVO = new RepAppVO();
		
		MemTenVO memTenVO = new MemTenVO();
		memTenVO.setMem_no(mem_no);
		repAppVO.setMemTenVO(memTenVO);
		RenConVO renConVO = new RenConVO();
		renConVO.setRtct_no(rtct_no);
		repAppVO.setRenConVO(renConVO);
		repAppVO.setRa_order_time(ra_order_time);
		repAppDAO.insert(repAppVO, list_RepAppDetVO, list_RepAppPhoVO);
		
		return repAppVO;
	}
	
	public RepAppVO updateRepApp(Integer ra_no, Integer emp_no, Timestamp ra_order_time, Timestamp ra_end_time, Byte ra_status) {
		RepAppVO repAppVO = new RepAppVO();
		
		repAppVO.setRa_no(ra_no);
		EmployeeVO employeeVO = new EmployeeVO();
		employeeVO.setEmp_no(emp_no);
		repAppVO.setEmployeeVO(employeeVO);
		repAppVO.setRa_order_time(ra_order_time);
		repAppVO.setRa_end_time(ra_end_time);
		repAppVO.setRa_status(ra_status);
		repAppDAO.update(repAppVO);
		
		return repAppVO;
	}
	
	public RepAppVO getOneRepApp(Integer ra_no) {
		return repAppDAO.getByPK(ra_no);
	}
	public List<RepAppVO> getAllRepApp() {
		return repAppDAO.getAll();
	}
	
	public List<RepAppDetVO> getRepAppDets(Integer ra_no) {
		return repAppDAO.getDetsByPK(ra_no);
	}
	
}

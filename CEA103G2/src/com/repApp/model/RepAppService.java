package com.repApp.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

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
	
//	public RepAppVO addRepApp(Integer mem_no, Integer rtct_no, Timestamp ra_order_time, Set<RepAppDetVO> set_RepAppDetVO, Set<RepAppPhoVO> set_RepAppPhoVO) {
	public RepAppVO addRepApp(Integer mem_no, Integer rtct_no, Timestamp ra_order_time, Set<RepAppDetVO> set_RepAppDetVO) {
//	public RepAppVO addRepApp(Integer mem_no, Integer rtct_no, Timestamp ra_order_time) {
		RepAppVO repAppVO = new RepAppVO();
		
		repAppVO.setMem_no(mem_no);
		repAppVO.setRtct_no(rtct_no);
		repAppVO.setRa_order_time(ra_order_time);
		for(RepAppDetVO repAppDetVO : set_RepAppDetVO) {
			repAppDetVO.setRepAppVO(repAppVO);
		}
		repAppVO.setSet_RepAppDetVO(set_RepAppDetVO);
//		repAppDAO.insert(repAppVO, list_RepAppDetVO, list_RepAppPhoVO);
		repAppDAO.insert(repAppVO);
		
		return repAppVO;
	}
	
	public RepAppVO updateRepApp(Integer ra_no, Integer emp_no, Timestamp ra_order_time, Timestamp ra_end_time, Byte ra_status) {
		RepAppVO repAppVO = new RepAppVO();
		
		repAppVO.setRa_no(ra_no);
		repAppVO.setEmp_no(emp_no);
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
	
	public Set<RepAppDetVO> getRepAppDets(Integer ra_no) {
		return repAppDAO.getDetsByPK(ra_no);
	}
	
}

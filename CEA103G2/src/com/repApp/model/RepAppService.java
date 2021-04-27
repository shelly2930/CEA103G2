package com.repApp.model;

import java.sql.Timestamp;
import java.util.List;

import com.repAppDet.model.RepAppDetVO;

public class RepAppService {
	RepAppDAO_interface repAppDAO;
	
	public RepAppService() {
		repAppDAO = new RepAppDAO();
	}
	
	public RepAppVO addRepApp(Integer mem_no, Integer rtct_no, Timestamp ra_app_time, List<RepAppDetVO> list) {
		RepAppVO repAppVO = new RepAppVO();
		
		repAppVO.setMem_no(mem_no);
		repAppVO.setRtct_no(rtct_no);
		repAppVO.setRa_app_time(ra_app_time);
		repAppDAO.insert(repAppVO, list);
		
		return repAppVO;
	}
	
	public RepAppVO updateRepApp(Integer ra_no, Integer emp_no, Timestamp ra_end_time, Byte ra_status) {
		RepAppVO repAppVO = new RepAppVO();
		
		repAppVO.setRa_no(ra_no);
		repAppVO.setEmp_no(emp_no);
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
}

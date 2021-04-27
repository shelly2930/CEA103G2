package com.repAppDet.model;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.List;

public class RepAppDetService {
	RepAppDetDAO_interface repAppDetDAO;
	
	public RepAppDetService() {
		repAppDetDAO = new RepAppDetDAO();
	}
	
	public RepAppDetVO addRepAppDet(Integer ra_no, Timestamp rad_order_time, String rad_dmg_dsc, Connection con) {
		RepAppDetVO repAppDetVO = new RepAppDetVO();
		
		repAppDetVO.setRa_no(ra_no);
		repAppDetVO.setRad_order_time(rad_order_time);
		repAppDetVO.setRad_dmg_dsc(rad_dmg_dsc);
		repAppDetDAO.insert(repAppDetVO, con);
		
		return repAppDetVO;
	}
	
	public RepAppDetVO updateRepAppDet(Integer rad_no, Byte rad_status, Integer rad_expz, Byte rad_tr_dmg) {
		RepAppDetVO repAppDetVO = new RepAppDetVO();
		
		repAppDetVO.setRad_no(rad_no);
		repAppDetVO.setRad_status(rad_status);
		repAppDetVO.setRad_expz(rad_expz);
		repAppDetVO.setRad_tr_dmg(rad_tr_dmg);
		repAppDetDAO.update(repAppDetVO);
		
		return repAppDetVO;
	}
	
	public RepAppDetVO getOneRepAppDet(Integer rad_no) {
		return repAppDetDAO.getByPK(rad_no);
	}
	
	public List<RepAppDetVO> getGroupRepAppDet(Integer ra_no) {
		return repAppDetDAO.getByFK(ra_no);
	}
	
	public List<RepAppDetVO> getAllRepAppDet() {
		return repAppDetDAO.getAll();
	}
}

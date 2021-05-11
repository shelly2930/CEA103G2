package com.repAppDet.model;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.repApp.model.RepAppService;
import com.repApp.model.RepAppVO;
import com.repAppPho.model.RepAppPhoVO;

public class RepAppDetService {
	RepAppDetDAO_interface repAppDetDAO;
	
	public RepAppDetService() {
		repAppDetDAO = new RepAppDetDAO();
	}
	
	public RepAppDetVO addRepAppDet(Integer ra_no, String rad_dmg, String rad_dsc) {
		RepAppDetVO repAppDetVO = new RepAppDetVO();
		
		RepAppVO repAppVO = new RepAppVO();
		repAppVO.setRa_no(ra_no);
		repAppDetVO.setRepAppVO(repAppVO);
		repAppDetVO.setRad_dmg(rad_dmg);
		repAppDetVO.setRad_dsc(rad_dsc);
		repAppDetDAO.insert(repAppDetVO);
		
		return repAppDetVO;
	}
	
	public RepAppDetVO updateRepAppDet(Integer rad_no, String rad_dmg, String rad_dsc, Byte rad_status, Integer rad_expz, Byte rad_tr_dmg) {
		RepAppDetVO repAppDetVO = new RepAppDetVO();
		
		repAppDetVO.setRad_no(rad_no);
		repAppDetVO.setRad_dmg(rad_dmg);
		repAppDetVO.setRad_dsc(rad_dsc);
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
	
	public List<RepAppPhoVO> getRepAppPhos(Integer rad_no) {
		return repAppDetDAO.getPhosByPK(rad_no);
	}
	
}

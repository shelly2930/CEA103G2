package com.repAppPho.model;

import java.util.List;

import com.repAppDet.model.RepAppDetVO;

public class RepAppPhoService {
	private RepAppPhoDAO repAppPhoDAO;
	
	public RepAppPhoService() {
		repAppPhoDAO = new RepAppPhoDAO();
	}
	
	public RepAppPhoVO addRepAppPho(Integer rad_no, byte[] rap_photo) {
		RepAppPhoVO repAppPhoVO = new RepAppPhoVO();
		
		RepAppDetVO repAppDetVO= new RepAppDetVO();
		repAppDetVO.setRad_no(rad_no);
		repAppPhoVO.setRepAppDetVO(repAppDetVO);
		repAppPhoVO.setRap_photo(rap_photo);
		repAppPhoDAO.insert(repAppPhoVO);
		
		return repAppPhoVO;
	}
	
	public RepAppPhoVO updateRepAppPho(Integer rap_no, byte[] rap_photo) {
		RepAppPhoVO repAppPhoVO = new RepAppPhoVO();
		
		repAppPhoVO.setRap_no(rap_no);
		repAppPhoVO.setRap_photo(rap_photo);
		repAppPhoDAO.update(repAppPhoVO);
		
		return repAppPhoVO;
	}
	
	public void deleteRepAppPho(Integer rap_no) {
		repAppPhoDAO.delete(rap_no);
	}
	
	public RepAppPhoVO getOneRepAppPho(Integer rap_no) {
		return repAppPhoDAO.getByPK(rap_no);
	}
	
	public List<RepAppPhoVO> getGroupRepAppPho(Integer rad_no) {
		return repAppPhoDAO.getByFK(rad_no);
	}
}

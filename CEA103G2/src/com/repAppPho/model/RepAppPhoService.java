package com.repAppPho.model;

import java.util.List;

public class RepAppPhoService {
	private RepAppPhoDAO repAppPhoDAO;
	
	public RepAppPhoService() {
		repAppPhoDAO = new RepAppPhoDAO();
	}
	
	public RepAppPhoVO addRepAppPho(Integer ra_no, byte[] rap_photo) {
		RepAppPhoVO repAppPhoVO = new RepAppPhoVO();
		
		repAppPhoVO.setRa_no(ra_no);
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
	
	public List<RepAppPhoVO> getGroupRepAppPho(Integer ra_no) {
		return repAppPhoDAO.getByFK(ra_no);
	}
}

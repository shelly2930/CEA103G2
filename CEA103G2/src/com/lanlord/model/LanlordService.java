package com.lanlord.model;

import java.sql.Date;
import java.util.List;

public class LanlordService {
	private LanlordDAO_interface dao;
	
	public LanlordService() {
		dao = new LanlordDAO();
	}
	
	public LanlordVO addLanlord(Integer mem_no, Date lld_apptime, String lld_bank, String lld_account,
			byte[] lld_acc_pic) {
		
		LanlordVO lanlordVO = new LanlordVO();
				
		lanlordVO.setMem_no(mem_no);
		lanlordVO.setLld_apptime(lld_apptime);
		lanlordVO.setLld_bank(lld_bank);
		lanlordVO.setLld_account(lld_account);
		lanlordVO.setLld_acc_pic(lld_acc_pic);
		dao.insert(lanlordVO);

		return lanlordVO;
	}
	
	public LanlordVO updateLanlord(Integer lld_no,Integer mem_no, Date lld_apptime, String lld_bank, String lld_account,
			byte[] lld_acc_pic, Byte lld_status, Date lld_id_isvrfed, String lld_id_disapprove,
			String lld_suspend) {
		
		LanlordVO lanlordVO = new LanlordVO();
		
		lanlordVO.setLld_no(lld_no);		
		lanlordVO.setMem_no(mem_no);
		lanlordVO.setLld_apptime(lld_apptime);
		lanlordVO.setLld_bank(lld_bank);
		lanlordVO.setLld_account(lld_account);
		lanlordVO.setLld_acc_pic(lld_acc_pic);
		lanlordVO.setLld_status(lld_status);
		lanlordVO.setLld_id_isvrfed(lld_id_isvrfed);
		lanlordVO.setLld_id_disapprove(lld_id_disapprove);	
		dao.update(lanlordVO);

		return lanlordVO;
	}
	
	public LanlordVO getOneLandlord(Integer lld_no) {
		return dao.findByPrimaryKey(lld_no);
	}
	
	public List<LanlordVO> getAll() {
		return dao.getAll();
	}
	
	public LanlordVO getOneLanlordByMemTen(Integer mem_no) {
		return dao.findByMemTen(mem_no);
	}
}

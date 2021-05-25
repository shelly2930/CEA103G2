package com.renFurDet.model;

import java.sql.Timestamp;
import java.util.List;

public class RenFurDetService {

	private RenFurDetDAO_interface dao;

	public RenFurDetService() {
		dao = new RenFurDetDAO();
	}

//	public RenFurDetVO addRenFurDet(Integer rfa_no, Integer fnt_id, Integer rtct_no, Timestamp rent_date,
//			Timestamp rent_end_date, Timestamp rent_tmt_date) {
//
//		RenFurDetVO renFurDetVO = new RenFurDetVO();
//		renFurDetVO.setRfa_no(rfa_no);
//		renFurDetVO.setFnt_id(fnt_id);
//		renFurDetVO.setRtct_no(rtct_no);
//		renFurDetVO.setRent_date(rent_date);
//		renFurDetVO.setRent_end_date(rent_end_date);
//		renFurDetVO.setRent_tmt_date(rent_tmt_date);
//		dao.insert(renFurDetVO);
//
//		return renFurDetVO;
//	}

	public RenFurDetVO updateRenFurDet(Integer rfa_no, Integer fnt_id, Integer rtct_no, Timestamp rent_date,
			Timestamp rent_end_date, Timestamp rent_tmt_date) {

		RenFurDetVO renFurDetVO = new RenFurDetVO();
		renFurDetVO.setRfa_no(rfa_no);
		renFurDetVO.setFnt_id(fnt_id);
		renFurDetVO.setRtct_no(rtct_no);
		renFurDetVO.setRent_date(rent_date);
		renFurDetVO.setRent_end_date(rent_end_date);
		renFurDetVO.setRent_tmt_date(rent_tmt_date);

		dao.update(renFurDetVO);

		return renFurDetVO;
	}
	//刪一個明細
	public void deleteRenFurDet(Integer rfa_no,Integer fnt_id) {
		dao.deleteOne(rfa_no, fnt_id);
	}
	//刪一整張單
	public void deleteRenFurList(Integer rfa_no) {
		dao.deleteList(rfa_no);
	}
	//查一個明細
	public RenFurDetVO getOneRenFurDet(Integer rfa_no,Integer fnt_id) {
		return dao.findByPrimaryKey(rfa_no, fnt_id);
	}
	//查一整張單的所有明細
	public List<RenFurDetVO> getOneList(Integer rfa_no){
		return dao.getOneList(rfa_no);
	}
	//查全部
	public List<RenFurDetVO> getAll() {
		return dao.getAll();
	}
}

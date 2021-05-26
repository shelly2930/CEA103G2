package com.furLis.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

public class FurLisService {

	private FurLisDAO_interface dao;

	public FurLisService() {
		dao = new FurLisDAO();
	}

	public FurLisVO addFurLis(Integer fnt_it_no,Timestamp fnt_acq_date,Byte fnt_status, Byte fnt_rent_status,Timestamp fnt_unusable_date) {

		FurLisVO furLisVO = new FurLisVO();
		furLisVO.setFnt_it_no(fnt_it_no);
		furLisVO.setFnt_acq_date(fnt_acq_date);
		furLisVO.setFnt_status(fnt_status);
		furLisVO.setFnt_rent_status(fnt_rent_status);
		furLisVO.setFnt_unusable_date(fnt_unusable_date);
		dao.insert(furLisVO);

		return furLisVO;
	}

	public FurLisVO updateFurLis(Integer fnt_id, Integer fnt_it_no, Timestamp fnt_acq_date,Byte fnt_status, Byte fnt_rent_status,Timestamp fnt_unusable_date) {

		FurLisVO furLisVO = new FurLisVO();
		furLisVO.setFnt_id(fnt_id);
		furLisVO.setFnt_it_no(fnt_it_no);
		furLisVO.setFnt_acq_date(fnt_acq_date);
		furLisVO.setFnt_status(fnt_status);
		furLisVO.setFnt_rent_status(fnt_rent_status);
		furLisVO.setFnt_unusable_date(fnt_unusable_date);

		dao.update(furLisVO);

		return furLisVO;
	}

	public void deleteFurLis(Integer fnt_id) {
		dao.delete(fnt_id);
	}

	public FurLisVO getOneFurLis(Integer fnt_id) {
		return dao.findByPrimaryKey(fnt_id);
	}

	public List<FurLisVO> getAll() {
		return dao.getAll();
	}
//查某個品項的所有家具(家具清單 控制單筆家具)
	public List<FurLisVO> getOneFur_Item_Lis(Integer fnt_it_no) {
		return dao.getOneFur_Item_Lis(fnt_it_no);
	}
	//多表格查詢
//	public List<FurLisVO> getMultiQuery(Integer furCatSelect,Integer furIteSelect,Integer fntStatusSelect,Integer rentStatusSelect) {
//		return dao.getMultiQuery(furCatSelect,furIteSelect,fntStatusSelect,rentStatusSelect);
//	}
	
	public List<FurLisVO> getAll(Map<String, String[]> map) {
		return dao.getAll();
	}
}

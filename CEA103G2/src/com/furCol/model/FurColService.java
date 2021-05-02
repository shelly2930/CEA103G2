package com.furCol.model;

import java.sql.Timestamp;
import java.util.List;

public class FurColService {

	private FurColDAO_interface dao;

	public FurColService() {
		dao = new FurColDAO();
	}

	public FurColVO addFurCol(Integer mem_no, Integer fnt_it_no, Timestamp fnt_col_date,
			String fnt_col_note) {

		FurColVO furColVO = new FurColVO();
		furColVO.setMem_no(mem_no);
		furColVO.setFnt_it_no(fnt_it_no);
		furColVO.setFnt_col_date(fnt_col_date);
		furColVO.setFnt_col_note(fnt_col_note);
		dao.insert(furColVO);

		return furColVO;
	}

	public FurColVO updateFurCol(Integer mem_no, Integer fnt_it_no, Timestamp fnt_col_date,
			String fnt_col_note){

		FurColVO furColVO = new FurColVO();
		furColVO.setMem_no(mem_no);
		furColVO.setFnt_it_no(fnt_it_no);
		furColVO.setFnt_col_date(fnt_col_date);
		furColVO.setFnt_col_note(fnt_col_note);

		dao.update(furColVO);

		return furColVO;
	}
	//�R�@�ө���
	public void deleteFurCol(Integer rfa_no,Integer fnt_id) {
		dao.delete(rfa_no, fnt_id);
	}
	
	//�d�@�ө���
	public FurColVO getOneFurCol(Integer rfa_no,Integer fnt_id) {
		return dao.findByPrimaryKey(rfa_no, fnt_id);
	}
	//�d�@��i�檺�Ҧ�����
	public List<FurColVO> getOneMemCol(Integer mem_no){
		return dao.getFurColsByMem_no(mem_no);
	}
	//�d����
	public List<FurColVO> getAll() {
		return dao.getAll();
	}
}

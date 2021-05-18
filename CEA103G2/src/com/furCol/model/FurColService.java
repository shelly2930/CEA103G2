package com.furCol.model;

import java.sql.Timestamp;
import java.util.List;

import com.houCol.model.HouColService;
import com.houCol.model.HouColVO;

public class FurColService {

	private FurColDAO_interface dao;

	public FurColService() {
		dao = new FurColDAO();
	}

	public FurColVO addFurCol(Integer mem_no, Integer fnt_it_no, String fnt_col_note) {

		FurColVO furColVO = new FurColVO();
		furColVO.setMem_no(mem_no);
		furColVO.setFnt_it_no(fnt_it_no);
		furColVO.setFnt_col_note(fnt_col_note);
		dao.insert(furColVO);

		return furColVO;
	}

	public FurColVO updateFurCol(Integer mem_no, Integer fnt_it_no, String fnt_col_note){

		FurColVO furColVO = new FurColVO();
		furColVO.setMem_no(mem_no);
		furColVO.setFnt_it_no(fnt_it_no);
		furColVO.setFnt_col_note(fnt_col_note);
		dao.update(furColVO);

		return furColVO;
	}
	//刪一個明細
	public void deleteFurCol(Integer mem_no, Integer fnt_it_no) {
		dao.delete(mem_no, fnt_it_no);
	}
	
	//查一個會員的某個收藏
	public FurColVO getOneFurCol(Integer mem_no,Integer fnt_it_no) {
		return dao.findByPrimaryKey(mem_no, fnt_it_no);
	}
	//查一個會員的收藏
	public List<FurColVO> getOneMemCol(Integer mem_no){
		return dao.getFurColsByMem_no(mem_no);
	}
	//查全部
	public List<FurColVO> getAll() {
		return dao.getAll();
	}
	
}

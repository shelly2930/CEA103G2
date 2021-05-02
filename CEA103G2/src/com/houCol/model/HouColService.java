package com.houCol.model;

import java.util.List;

import com.houAddFur.model.HouAddFurDAO;
import com.houAddFur.model.HouAddFurDAO_interface;
import com.houAddFur.model.HouAddFurVO;

public class HouColService {
	HouColDAO_interface dao = null;

	public HouColService() {
		dao = new HouColDAO();
	}
	public HouColVO addHouCol(Integer mem_no,Integer hos_no,String hos_col_note) {
		HouColVO houColVO = new HouColVO();
		houColVO.setMem_no(mem_no);
		houColVO.setHos_no(hos_no);
		houColVO.setHos_col_note(hos_col_note);
		dao.insert(houColVO);
		return houColVO;
	}
	
	public HouColVO updateHouCol(Integer mem_no,Integer hos_no,String hos_col_note) {
		HouColVO houColVO = new HouColVO();
		houColVO.setMem_no(mem_no);
		houColVO.setHos_no(hos_no);
		houColVO.setHos_col_note(hos_col_note);
		
		dao.update(houColVO);
		return houColVO;
	}
	
	public void deleteTotalByPk1(Integer houPhono) {
		dao.deleteTotalByPk1(houPhono);
	}
	
	public List<HouColVO> getAll(Integer hos_no) {
		return dao.getAll(hos_no);
	}
	
	public void deleteOneByPk1AndPk2(Integer mem_no,Integer hos_no,String hos_col_note) {
		HouColVO houColVO = new HouColVO();
		houColVO.setMem_no(mem_no);
		houColVO.setHos_no(hos_no);
		houColVO.setHos_col_note(hos_col_note);
		dao.deleteOneByPk1AndPk2(houColVO);
	}
	
	public HouColVO findByPrimaryKey(Integer mem_no,Integer hos_no,String hos_col_note) {
		HouColVO houColVO = new HouColVO();
		houColVO.setMem_no(mem_no);
		houColVO.setHos_no(hos_no);
		houColVO.setHos_col_note(hos_col_note);
		dao.findByPrimaryKey(houColVO);
		return houColVO;
	}
}

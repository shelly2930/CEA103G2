package com.houAddFur.model;

import java.util.List;



public class HouAddFurService {
	HouAddFurDAO_interface dao = null;

	public HouAddFurService() {
		dao = new HouAddFurDAO();
	}
	public HouAddFurVO addhouAddFur(Integer hos_no,Integer add_fnt_no) {
		HouAddFurVO houAddFurVO = new HouAddFurVO();
		houAddFurVO.setHos_no(hos_no);
		houAddFurVO.setAdd_fnt_no(add_fnt_no);
		dao.insert(houAddFurVO);
		return houAddFurVO;
	}
	
	public HouAddFurVO updateAddFur(Integer hos_no, Integer add_fnt_no) {
		HouAddFurVO houAddFurVO = new HouAddFurVO();
		houAddFurVO.setHos_no(hos_no);
		houAddFurVO.setAdd_fnt_no(add_fnt_no);
		
		dao.update(houAddFurVO);
		return houAddFurVO;
	}
	
	public void deleteTotalByPk1(Integer houPhono) {
		dao.deleteTotalByPk1(houPhono);
	}
	
	public List<HouAddFurVO> getAll(Integer hos_no) {
		return dao.getAll(hos_no);
	}
	
	public void deleteOneByPk1AndPk2(Integer hos_no, Integer add_fnt_no) {
		HouAddFurVO houAddFurVO = new HouAddFurVO();
		houAddFurVO.setHos_no(hos_no);
		houAddFurVO.setAdd_fnt_no(add_fnt_no);
		dao.deleteOneByPk1AndPk2(houAddFurVO);
	}
	
	public HouAddFurVO findByPrimaryKey(Integer hos_no, Integer add_fnt_no) {
		HouAddFurVO houAddFurVO = new HouAddFurVO();
		houAddFurVO.setHos_no(hos_no);
		houAddFurVO.setAdd_fnt_no(add_fnt_no);
		dao.findByPrimaryKey(houAddFurVO);
		return houAddFurVO;
	}
	

}

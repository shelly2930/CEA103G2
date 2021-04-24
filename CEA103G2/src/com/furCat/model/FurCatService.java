package com.furCat.model;

import java.util.List;

public class FurCatService {

	private FurCatDAO_interface dao;

	public FurCatService() {
		dao = new FurCatDAO();
	}

	public FurCatVO addFurCat(String fnt_ctgr_name) {

		FurCatVO furCatVO = new FurCatVO();
		furCatVO.setFnt_ctgr_name(fnt_ctgr_name);
		dao.insert(furCatVO);

		return furCatVO;
	}

	public FurCatVO updateFurCat(Integer fnt_ctgr_no, String fnt_ctgr_name) {

		FurCatVO furCatVO = new FurCatVO();

		furCatVO.setFnt_ctgr_no(fnt_ctgr_no);
		furCatVO.setFnt_ctgr_name(fnt_ctgr_name);
		dao.update(furCatVO);

		return furCatVO;
	}

	public void deleteFurCat(Integer fnt_ctgr_no) {
		dao.delete(fnt_ctgr_no);
	}

	public FurCatVO getOneFurCat(Integer fnt_ctgr_no) {
		return dao.findByPrimaryKey(fnt_ctgr_no);
	}

	public List<FurCatVO> getAll() {
		return dao.getAll();
	}
}

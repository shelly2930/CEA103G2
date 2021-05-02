package com.furIte.model;

import java.util.List;
import java.util.Set;


public class FurIteService {

	private FurIteDAO_interface dao;

	public FurIteService() {
		dao = new FurIteDAO();
	}

	public FurIteVO addFurIte(Integer fnt_ctgr_no, String fnt_name, Integer fnt_unrent, Integer fnt_repair,
			Integer fnt_total, Integer fnt_price, Double fnt_length, Double fnt_width, Double fnt_height,
			Double fnt_weight, String fnt_standard, String fnt_info, Integer fnt_views) {

		FurIteVO furIteVO = new FurIteVO();
		furIteVO.setFnt_ctgr_no(fnt_ctgr_no);
		furIteVO.setFnt_name(fnt_name);
		furIteVO.setFnt_unrent(fnt_unrent);
		furIteVO.setFnt_repair(fnt_repair);
		furIteVO.setFnt_total(fnt_total);
		furIteVO.setFnt_price(fnt_price);
		furIteVO.setFnt_length(fnt_length);
		furIteVO.setFnt_width(fnt_width);
		furIteVO.setFnt_height(fnt_height);
		furIteVO.setFnt_weight(fnt_weight);
		furIteVO.setFnt_standard(fnt_standard);
		furIteVO.setFnt_info(fnt_info);
		furIteVO.setFnt_views(fnt_views);

		dao.insert(furIteVO);

		return furIteVO;
	}

	public FurIteVO updateFurIte(Integer fnt_it_no, Integer fnt_ctgr_no, String fnt_name, Integer fnt_unrent, Integer fnt_repair,
			Integer fnt_total, Integer fnt_price, Double fnt_length, Double fnt_width, Double fnt_height,
			Double fnt_weight, String fnt_standard, String fnt_info, Integer fnt_views) {

		FurIteVO furIteVO = new FurIteVO();
		furIteVO.setFnt_it_no(fnt_it_no);
		furIteVO.setFnt_ctgr_no(fnt_ctgr_no);
		furIteVO.setFnt_name(fnt_name);
		furIteVO.setFnt_unrent(fnt_unrent);
		furIteVO.setFnt_repair(fnt_repair);
		furIteVO.setFnt_total(fnt_total);
		furIteVO.setFnt_price(fnt_price);
		furIteVO.setFnt_length(fnt_length);
		furIteVO.setFnt_width(fnt_width);
		furIteVO.setFnt_height(fnt_height);
		furIteVO.setFnt_weight(fnt_weight);
		furIteVO.setFnt_standard(fnt_standard);
		furIteVO.setFnt_info(fnt_info);
		furIteVO.setFnt_views(fnt_views);
		dao.update(furIteVO);

		return furIteVO;
	}

	public void deleteFurIte(Integer fnt_it_no) {
		dao.delete(fnt_it_no);
	}

	public FurIteVO getOneFurIte(Integer fnt_it_no) {
		return dao.findByPrimaryKey(fnt_it_no);
	}

	public List<FurIteVO> getAll() {
		return dao.getAll();
	}
	
	public List<FurIteVO> getOneFurCat_Item(Integer fnt_ctgr_no) {
		return dao.getOneFurCat_Item(fnt_ctgr_no);
	}
	
	public FurIteVO getOneFurList(String fnt_name) {
		return dao.findByFurName(fnt_name);
	}
	
	public List<FurIteVO> getFurItesByFurCat(Integer fnt_ctgr_no){
		return dao.getFurItesByFurCat(fnt_ctgr_no);
	}
	
	public String selectByPrimaryKey(Integer fnt_ctgr_no) {
		return dao.selectByPrimaryKey(fnt_ctgr_no); 
	}

	public String getAllFntName() {
		return dao.getAllFntName();
	}
	public Integer GetLastFnt_it_no(){
		return dao.GetLastFnt_it_no();
	}
}

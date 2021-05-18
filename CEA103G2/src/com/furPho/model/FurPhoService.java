package com.furPho.model;
//照片部分待修改
import java.util.List;

public class FurPhoService {

	private FurPhoDAO_interface dao;

	public FurPhoService() {
		dao = new FurPhoDAO();
	}

	public FurPhoVO addFurPho(Integer fnt_it_no, byte[] fnt_pic) {

		FurPhoVO furPhoVO = new FurPhoVO();
		furPhoVO.setFnt_it_no(fnt_it_no);
		furPhoVO.setFnt_pic(fnt_pic);
		dao.insert(furPhoVO);

		return furPhoVO;
	}
	public void insert(FurPhoVO furPhoVO) {
		dao.insert(furPhoVO);
	}
	
	
	public FurPhoVO updateFurPho(Integer fnt_pic_no, Integer fnt_it_no, byte[] fnt_pic) {

		FurPhoVO furPhoVO = new FurPhoVO();
		furPhoVO.setFnt_pic_no(fnt_pic_no);
		furPhoVO.setFnt_it_no(fnt_it_no);
		furPhoVO.setFnt_pic(fnt_pic);
		
		dao.update(furPhoVO);

		return furPhoVO;
	}

	public void deleteFurPho(Integer fnt_pic_no) {
		dao.delete(fnt_pic_no);
	}

	public FurPhoVO getOneFurPho(Integer fnt_pic_no) {
		return dao.findByPrimaryKey(fnt_pic_no);
	}
	//拿所查品項的第一個照片編號(測試寫法${furPhoSvc.getThisIteFirstFnt_pic_no(furIteVO.fnt_it_no)}無法執行)
	public Integer getThisIteFirstFnt_pic_no(Integer fnt_it_no) {
		return dao.getThisIteFirstFnt_pic_no(fnt_it_no);
	}
	//拿所查品項的第一個照片FurPhoVO
	public FurPhoVO getThisIteFurPho(Integer fnt_it_no) {
		return dao.getThisIteFurPho(fnt_it_no);
	}
	
	public List<FurPhoVO> getAll() {
		return dao.getAll();
	}
	public List<FurPhoVO> getOneFntItePics(Integer fnt_it_no){
		return dao.getOneFntItePics(fnt_it_no);
	}
	public List<Integer> getFnt_pic_noByFK(Integer fnt_it_no){
		return dao.getThisIteFnt_pic_no(fnt_it_no);
	}
}

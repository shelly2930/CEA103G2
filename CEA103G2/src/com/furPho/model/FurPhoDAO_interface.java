package com.furPho.model;

import java.util.*;

public interface FurPhoDAO_interface {
	 public void insert(FurPhoVO furPhoVO);
     public void update(FurPhoVO furPhoVO);
     public void delete(Integer fnt_pic_no);
     public FurPhoVO findByPrimaryKey(Integer fnt_pic_no);
     public List<FurPhoVO> getAll();
     public List<FurPhoVO> getOneFntItePics(Integer fnt_it_no);
   //查詢某家具品項編號的照片(一對多)(回傳 Set) 待確認
   // public Set<FurPhoVO> getFntPicsByFnt_it_no(Integer fnt_it_no);
 	//拿所查品項的第一個照片編號(測試寫法${furPhoSvc.getThisIteFirstFnt_pic_no(furIteVO.fnt_it_no)}無法執行)
     public Integer getThisIteFirstFnt_pic_no(Integer fnt_it_no);
   //拿所查品項的第一個照片FurPhoVO
 	public FurPhoVO getThisIteFurPho(Integer fnt_it_no);
 	public List<Integer> getThisIteFnt_pic_no(Integer fnt_it_no);
}

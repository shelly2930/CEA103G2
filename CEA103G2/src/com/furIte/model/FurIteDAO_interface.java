package com.furIte.model;

import java.util.*;


public interface FurIteDAO_interface {
	 public void insert(FurIteVO furIteVO);
     public void update(FurIteVO furIteVO);
     public void delete(Integer fnt_it_no); 
     public FurIteVO findByPrimaryKey(Integer fnt_it_no);
     public FurIteVO findByFurName(String fnt_name); 
     public List<FurIteVO> getAll();
     //查詢某家具類別的品項(一對多)(回傳 Set)
     public List<FurIteVO> getFurItesByFurCat(Integer fnt_ctgr_no);
     //連動下拉式選單用
     public String selectByPrimaryKey(Integer fnt_ctgr_no);
	public String getAllFntName();
	
	public List<FurIteVO> getOneFurCat_Item(Integer fnt_ctgr_no);
	//找最後一筆品項編號給新增照片用
	public Integer GetLastFnt_it_no();
	
	//<前台用>查所有上架商品
	 public List<FurIteVO> getAllGetOnFurIte();
	//<前台用>依家具分類查所有上架商品
	 public List<FurIteVO> getGetOnFurIteByCat(Integer fnt_ctgr_no);
	
	 //顯示品項至前台(處理換行問題)
    public FurIteVO showOneFurIteToFE(Integer fnt_it_no);
	 
	//關鍵字查詢
	public List<FurIteVO> getOneFurIteByKW(String keyword);
	
	//前台模糊查詢
	public List<FurIteVO> getOneFurIteByKWtoFE(String keyword);
	}

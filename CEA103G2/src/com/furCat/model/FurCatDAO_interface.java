package com.furCat.model;

import java.util.*;

public interface FurCatDAO_interface {
	 public void insert(FurCatVO furCatVO);
     public void update(FurCatVO furCatVO);
     public void delete(Integer fnt_ctgr_no);
     public FurCatVO findByPrimaryKey(Integer fnt_ctgr_no);
     public List<FurCatVO> getAll();
   //萬用複合查詢(傳入參數型態Map)(回傳 List)
//   public List<FurCatVO> getAll(Map<String, String[]> map); 
}

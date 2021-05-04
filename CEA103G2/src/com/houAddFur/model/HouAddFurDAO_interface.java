package com.houAddFur.model;

import java.util.List;



public interface HouAddFurDAO_interface {
	public void insert(HouAddFurVO houAddFurVO);
    public void update(HouAddFurVO houAddFurVO);
    
//  刪除所有(pk1)物件編號為houAddFurno的附設家具編號
    public void deleteTotalByPk1(Integer houAddFurno);
    
//  刪除所有(pk1)物件編號且(pk2)附設家具編號，為houAddFurno的附設家具編號
    public void deleteOneByPk1AndPk2(HouAddFurVO houAddFurVO);
    
//  從(pk1)物件編號和(pk2)附設家具編號找出，對應的列
//    GET_ONE_BY_PK1_PK2
    public HouAddFurVO findByPrimaryKey(HouAddFurVO houAddFurVO);
    
//  從(pk1)物件編號找到所有附設家具編號
//    GET_ALL_BY_PK1
    public List<HouAddFurVO> getAll(Integer houAddFurno);
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<houAddFurVO> getAll(Map<String, String[]> map); 
    
    
}

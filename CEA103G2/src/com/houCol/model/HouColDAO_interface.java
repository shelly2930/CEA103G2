package com.houCol.model;

import java.util.List;

import com.houAddFur.model.HouAddFurVO;


public interface HouColDAO_interface {
	public void insert(HouColVO houColVO);
    public void update(HouColVO houColVO);
    
//  刪除所有(pk1)物件編號為houAddFurno的附設家具編號
    public void deleteTotalByPk1(Integer houColno);
    
//  刪除所有(pk1)物件編號且(pk2)附設家具編號，為houAddFurno的附設家具編號
    public void deleteOneByPk1AndPk2(HouColVO houColVO);
    
//  從(pk1)物件編號和(pk2)附設家具編號找出，對應的列
//    GET_ONE_BY_PK1_PK2
    public HouColVO findByPrimaryKey(HouColVO houColVO);
    
//  從(pk1)物件編號找到所有附設家具編號
//    GET_ALL_BY_PK1
    public List<HouColVO> getAll(Integer mem_no);
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<HouColVO> getAll(Map<String, String[]> map); 
    public Integer judge(HouColVO houColVO);
}

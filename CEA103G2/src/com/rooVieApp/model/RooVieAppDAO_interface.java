package com.rooVieApp.model;

import java.util.List;


public interface RooVieAppDAO_interface {
	public void insert(RooVieAppVO rooVieAppVO);
    public void update(RooVieAppVO rooVieAppVO);
    public void delete(Integer rooVieAppno);
    public RooVieAppVO findByPrimaryKey(Integer rooVieAppno);
    public List<RooVieAppVO> getAll();

    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<RooVieAppVO> getAll(Map<String, String[]> map); 
}

package com.addFur.model;

import java.util.List;

public interface AddFurDAO_interface{
    public void insert(AddFurVO addFurVO);
    public void update(AddFurVO addFurVO);
    public void delete(Integer addFurno);
    public AddFurVO findByPrimaryKey(Integer addFurno);
    public List<AddFurVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<AddFurVO> getAll(Map<String, String[]> map); 
}
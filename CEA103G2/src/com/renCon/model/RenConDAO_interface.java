package com.renCon.model;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

public interface RenConDAO_interface {
	public void insert(RenConVO renConVO);
    public void update(RenConVO renConVO);
    public void delete(Integer renConno);
    public RenConVO findByPrimaryKey(Integer renConno);
    public List<RenConVO> getAll();
//    為了存入圖片
    public void listarImg(Integer picno, HttpServletResponse response);
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<RenConVO> getAll(Map<String, String[]> map); 
    public void insert2(RenConVO renConVO);
}

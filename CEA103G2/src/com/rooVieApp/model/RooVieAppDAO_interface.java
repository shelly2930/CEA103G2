package com.rooVieApp.model;

import java.util.List;


public interface RooVieAppDAO_interface {
	public void insert(RooVieAppVO rooVieAppVO);
    public void update(RooVieAppVO rooVieAppVO);
    public void delete(Integer rooVieAppno);
    public RooVieAppVO findByPrimaryKey(Integer rooVieAppno);
    public List<RooVieAppVO> getAll();
    //新增預約時間 
    public void addpicktime(RooVieAppVO rooVieAppVO);
    //取消預約時間by 會員 物件 選取時間
    public void cancelpicktime(RooVieAppVO rooVieAppVO);
    //查看所有預約時間by物件編號
    public List<RooVieAppVO> listallpickTime(RooVieAppVO rooVieAppVO);
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<RooVieAppVO> getAll(Map<String, String[]> map); 
}

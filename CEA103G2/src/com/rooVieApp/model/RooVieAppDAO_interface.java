package com.rooVieApp.model;

import java.util.List;
import java.util.Map;
import java.sql.Timestamp;

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
    //查看所有預約時間by物件編號
    public List<RooVieAppVO> listallpickTime_noassign(RooVieAppVO rooVieAppVO);
    //查看 新預約的時間by物件編號
    public List<RooVieAppVO> listNewPickTime();
    //查看最新預約 的物件
    public Map<Integer,Timestamp> listNewRooVieApp();
    //更改員工 和指派員工
    public void changeEmp(Integer emp_no,Byte rva_status,Integer rva_no);
    //查看該員工所有負責預約清單
    public List<RooVieAppVO> getEmpApp(Integer emp_no);
    
    public Map<RooVieAppVO,Integer> listTheEmpApp(Byte rva_status,Integer emp_no);
    //查詢該物件所有預約單時間
    public List<RooVieAppVO> listOrderTime(RooVieAppVO rooVieAppVO);
    
    public List<RooVieAppVO> showTheEmpApp(Integer emp_no,Byte status);
    public void updateEndTime(Integer rva_no,Timestamp end_time);
    public List<RooVieAppVO> showTheMemApp(Integer mem_no,Byte status);
    public void updateTheHouseStatus(Integer hos_no);
}

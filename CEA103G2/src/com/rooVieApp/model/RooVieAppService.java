package com.rooVieApp.model;

import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import java.sql.Timestamp;
public class RooVieAppService {
//	宣告DAO介面，存放DAO實體
//	為什麼要用介面宣告，為了好維護，哪天DAO如果需要更換，可以直接重寫DAO而這裡就直接更換實體部分即可
	private RooVieAppDAO_interface dao;
//	呼叫EMPService建構子，順便new EmpDAO
	public RooVieAppService() {
		dao = new RooVieAppDAO();
	}
//當servlet想要針對emp表格新增一筆資料，就需要呼叫以下方法，並傳對應欄位參數
	public RooVieAppVO addRooVieApp(Integer mem_no,Integer hos_no,Integer emp_no, java.sql.Timestamp rva_app_time,
			java.sql.Timestamp rva_order_time,java.sql.Timestamp rva_end_time, Byte rva_status) {
//傳進來的參數，先包裝成VO，how to do?
//先建立vo物件，在針對所有屬性，進行set
		RooVieAppVO rooVieAppVO = new RooVieAppVO();
		rooVieAppVO.setMem_no(mem_no);
		rooVieAppVO.setHos_no(hos_no);
		rooVieAppVO.setEmp_no(emp_no);
		rooVieAppVO.setRva_app_time(rva_app_time);
		rooVieAppVO.setRva_order_time(rva_order_time);
		rooVieAppVO.setRva_end_time(rva_end_time);
		rooVieAppVO.setRva_status(rva_status);
//把參數轉成vo物件，就可以呼叫dao來對資料庫進行insert
		dao.insert(rooVieAppVO);
		return rooVieAppVO;
	}

	public RooVieAppVO updateRooVieApp(Integer rva_no, Integer mem_no,Integer hos_no,Integer emp_no, java.sql.Timestamp rva_app_time,
			java.sql.Timestamp rva_order_time,java.sql.Timestamp rva_end_time, Byte rva_status) {

	
		RooVieAppVO rooVieAppVO = new RooVieAppVO();
		rooVieAppVO.setRva_no(rva_no);
		rooVieAppVO.setMem_no(mem_no);
		rooVieAppVO.setHos_no(hos_no);
		rooVieAppVO.setEmp_no(emp_no);
		rooVieAppVO.setRva_app_time(rva_app_time);
		rooVieAppVO.setRva_order_time(rva_order_time);
		rooVieAppVO.setRva_end_time(rva_end_time);
		rooVieAppVO.setRva_status(rva_status);
		dao.update(rooVieAppVO);

		return rooVieAppVO;
	}

	public void deleteRooVieApp(Integer rooVieAppno) {
		dao.delete(rooVieAppno);
	}

	public RooVieAppVO getOneRooVieApp(Integer rooVieAppno) {
		return dao.findByPrimaryKey(rooVieAppno);
	}

	public List<RooVieAppVO> getAll() {
		return dao.getAll();
	}
	public void addpicktime(Integer mem_no,Integer hos_no,java.sql.Timestamp rva_order_time,Byte rva_status) {
		RooVieAppVO rooVieAppVO = new RooVieAppVO();
		rooVieAppVO.setMem_no(mem_no);
		rooVieAppVO.setHos_no(hos_no);
		rooVieAppVO.setRva_order_time(rva_order_time);
		rooVieAppVO.setRva_status(rva_status);
		dao.addpicktime(rooVieAppVO);
	}
	public void cancelpicktime(Integer mem_no,Integer hos_no,java.sql.Timestamp rva_order_time) {
		RooVieAppVO rooVieAppVO = new RooVieAppVO();
		rooVieAppVO.setMem_no(mem_no);
		rooVieAppVO.setHos_no(hos_no);
		rooVieAppVO.setRva_order_time(rva_order_time);
		dao.cancelpicktime(rooVieAppVO);
	}
	public List<RooVieAppVO> listallpickTime(Integer hos_no){
		RooVieAppVO rooVieAppVO = new RooVieAppVO();
		rooVieAppVO.setHos_no(hos_no);
		return dao.listallpickTime(rooVieAppVO);
	}
	
	public List<RooVieAppVO> listNewPickTime(){
		return dao.listNewPickTime();
	}
	public Map<Integer,Timestamp> listNewRooVieApp(){
		return dao.listNewRooVieApp();
	}
	public void changeEmp(Integer emp_no,Byte rva_status, Integer rva_no) {
		dao.changeEmp(emp_no,rva_status,rva_no);
	}
	public List<RooVieAppVO> getEmpApp(Integer emp_no){
		return dao.getEmpApp(emp_no);
	}
	public List<RooVieAppVO> listallpickTime_noassign(Integer hos_no){
		RooVieAppVO rooVieAppVO = new RooVieAppVO();
		rooVieAppVO.setHos_no(hos_no);
		return dao.listallpickTime_noassign(rooVieAppVO);
	}
}

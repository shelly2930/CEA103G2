package com.rooVieApp.model;

import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import java.sql.Timestamp;
public class RooVieAppService {
//	�ŧiDAO�����A�s��DAO����
//	������n�Τ����ŧi�A���F�n���@�A����DAO�p�G�ݭn�󴫡A�i�H�������gDAO�ӳo�̴N�����󴫹��鳡���Y�i
	private RooVieAppDAO_interface dao;
//	�I�sEMPService�غc�l�A���Knew EmpDAO
	public RooVieAppService() {
		dao = new RooVieAppDAO();
	}
//��servlet�Q�n�w��emp���s�W�@����ơA�N�ݭn�I�s�H�U��k�A�öǹ������Ѽ�
	public RooVieAppVO addRooVieApp(Integer mem_no,Integer hos_no,Integer emp_no, java.sql.Timestamp rva_app_time,
			java.sql.Timestamp rva_order_time,java.sql.Timestamp rva_end_time, Byte rva_status) {
//�Ƕi�Ӫ��ѼơA���]�˦�VO�Ahow to do?
//���إ�vo����A�b�w��Ҧ��ݩʡA�i��set
		RooVieAppVO rooVieAppVO = new RooVieAppVO();
		rooVieAppVO.setMem_no(mem_no);
		rooVieAppVO.setHos_no(hos_no);
		rooVieAppVO.setEmp_no(emp_no);
		rooVieAppVO.setRva_app_time(rva_app_time);
		rooVieAppVO.setRva_order_time(rva_order_time);
		rooVieAppVO.setRva_end_time(rva_end_time);
		rooVieAppVO.setRva_status(rva_status);
//��Ѽ��নvo����A�N�i�H�I�sdao�ӹ��Ʈw�i��insert
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

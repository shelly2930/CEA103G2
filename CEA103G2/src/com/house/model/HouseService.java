package com.house.model;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.houPho.model.HouPhoVO;



public class HouseService {
	//�ŧiDAO�����A�s��DAO����
	//������n�Τ����ŧi�A���F�n���@�A
	//1.����DAO�p�G�ݭn�󴫡A�i�H�������gDAO�ӳo�̴N�����󴫹��鳡���Y�i
	//2.���եΡA�i�H������JDBC���ո�� �����ഫ��JNDI
	private HouseDAO_interface dao;
	//�I�sEMPService�غc�l�A���Knew EmpDAO
	public HouseService() {
		dao = new HouseDAO();
	}
	//�s�W����
	public HouseVO addHouse(Integer lld_no, String hos_name, Integer hos_rent, Integer hos_expense,
			java.sql.Timestamp hos_date, Integer hos_views, String hos_city, String hos_dist, String hos_address,
			Double hos_lon, Double hos_lat, Byte hos_type, String hos_info, Integer hos_age, Integer hos_floor,
			Byte hos_ele, Byte hos_parking, Byte hos_pet, Byte hos_cook, Double hos_squares, Byte hos_gender,
			Double hos_water, Double hos_power, Integer hos_internet, java.sql.Timestamp hos_apptime,
			java.sql.Timestamp hos_order_date, Integer emp_no, Byte hos_status, Byte hos_result, byte[] hos_loc_pic,
			Byte hos_state, String hos_refuse) {
		//�Ƕi�Ӫ��ѼơA���]�˦�VO�Ahow to do?
		//���إ�vo����A�b�w��Ҧ��ݩʡA�i��set
		HouseVO houseVO = new HouseVO();
		houseVO.setLld_no(lld_no);
		houseVO.setHos_name(hos_name);
		houseVO.setHos_rent(hos_rent);
		houseVO.setHos_expense(hos_expense);
		houseVO.setHos_date(hos_date);
		houseVO.setHos_views(hos_views);
		houseVO.setHos_city(hos_city);
		houseVO.setHos_dist(hos_dist);
		houseVO.setHos_address(hos_address);
		houseVO.setHos_lon(hos_lon);
		houseVO.setHos_lat(hos_lat);
		houseVO.setHos_type(hos_type);
		houseVO.setHos_info(hos_info);
		houseVO.setHos_age(hos_age);
		houseVO.setHos_floor(hos_floor);
		houseVO.setHos_ele(hos_ele);
		houseVO.setHos_parking(hos_parking);
		houseVO.setHos_pet(hos_pet);
		houseVO.setHos_cook(hos_cook);
		houseVO.setHos_squares(hos_squares);
		houseVO.setHos_gender(hos_gender);
		houseVO.setHos_water(hos_water);
		houseVO.setHos_power(hos_power);
		houseVO.setHos_internet(hos_internet);
		houseVO.setHos_apptime(hos_apptime);
		houseVO.setHos_order_date(hos_order_date);
		houseVO.setEmp_no(emp_no);
		houseVO.setHos_status(hos_status);
		houseVO.setHos_result(hos_result);
		houseVO.setHos_loc_pic(hos_loc_pic);
		houseVO.setHos_state(hos_state);
		houseVO.setHos_refuse(hos_refuse);
		//��Ѽ��নvo����A�N�i�H�I�sdao�ӹ��Ʈw�i��insert
		dao.insert(houseVO);
		return houseVO;
	}
	//�ק磌��
	public HouseVO updateHouse(Integer hos_no,Integer lld_no, String hos_name, Integer hos_rent, Integer hos_expense,
			java.sql.Timestamp hos_date, Integer hos_views, String hos_city, String hos_dist, String hos_address,
			Double hos_lon, Double hos_lat, Byte hos_type, String hos_info, Integer hos_age, Integer hos_floor,
			Byte hos_ele, Byte hos_parking, Byte hos_pet, Byte hos_cook, Double hos_squares, Byte hos_gender,
			Double hos_water, Double hos_power, Integer hos_internet, java.sql.Timestamp hos_apptime,
			java.sql.Timestamp hos_order_date, Integer emp_no, Byte hos_status, Byte hos_result, byte[] hos_loc_pic,
			Byte hos_state, String hos_refuse) {

		HouseVO houseVO = new HouseVO();
		
		houseVO.setHos_no(hos_no);
		houseVO.setLld_no(lld_no);
		houseVO.setHos_name(hos_name);
		houseVO.setHos_rent(hos_rent);
		houseVO.setHos_expense(hos_expense);
		houseVO.setHos_date(hos_date);
		houseVO.setHos_views(hos_views);
		houseVO.setHos_city(hos_city);
		houseVO.setHos_dist(hos_dist);
		houseVO.setHos_address(hos_address);
		houseVO.setHos_lon(hos_lon);
		houseVO.setHos_lat(hos_lat);
		houseVO.setHos_type(hos_type);
		houseVO.setHos_info(hos_info);
		houseVO.setHos_age(hos_age);
		houseVO.setHos_floor(hos_floor);
		houseVO.setHos_ele(hos_ele);
		houseVO.setHos_parking(hos_parking);
		houseVO.setHos_pet(hos_pet);
		houseVO.setHos_cook(hos_cook);
		houseVO.setHos_squares(hos_squares);
		houseVO.setHos_gender(hos_gender);
		houseVO.setHos_water(hos_water);
		houseVO.setHos_power(hos_power);
		houseVO.setHos_internet(hos_internet);
		houseVO.setHos_apptime(hos_apptime);
		houseVO.setHos_order_date(hos_order_date);
		houseVO.setEmp_no(emp_no);
		houseVO.setHos_status(hos_status);
		houseVO.setHos_result(hos_result);
		houseVO.setHos_loc_pic(hos_loc_pic);
		houseVO.setHos_state(hos_state);
		houseVO.setHos_refuse(hos_refuse);
		dao.update(houseVO);
		return houseVO;
	}
	//�q����s���ԥX�@��
	public HouseVO getOneHouse(Integer houseno) {
		return dao.findByPrimaryKey(houseno);
	}
	//�º�ԥX�Ҧ�����
	public List<HouseVO> getAll() {
		return dao.getAll();
	}
	//�ƦX�d�ߥ�
	public List<HouseVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}
	public List<HouseVO> getAll_Back(Map<String, String[]> map) {
		return dao.getAll_Back(map);
	}
	//���x�޲z�� �޲z��׻P�Ӥ�
	//���x�޲z���� (0,2)��ܧ����ץ� ���ݤW�[[�W�[���s] (1,2)�W�[��[�U�[���s] (2,2)�U�[�i���s�W�[[�W�[���s](3,2)�U�[ �A�o��[�ȨѬd��]
	//�D�ޥ�  list ����(0,2) �h�^->��i�׬�(0,1)�B�i�H���s���� �A���s�������u(�����אּ���x�޲z��)��ܳq�L�ץ�       
	public List<HouseVO> getAllByState(Byte state,Byte status) {
		return dao.getAllByState(state,status);
	}
	
	public void updateHouseContent(String hos_name,String hos_info, Integer houseno) {
		HouseVO houseVO = new HouseVO();
		houseVO.setHos_no(houseno);
		houseVO.setHos_name(hos_name);
		houseVO.setHos_info(hos_info);
		dao.updateHouseContent(houseVO);
	}
	public void updateHouseState(Byte hos_state,Byte hos_status,java.sql.Timestamp hos_date, Integer houseno) {
		HouseVO houseVO = new HouseVO();
		houseVO.setHos_no(houseno);
		houseVO.setHos_state(hos_state);
		houseVO.setHos_status(hos_status);
		houseVO.setHos_date(hos_date);
		dao.updateHouseState(houseVO);
	}
	
	
//	�H�U: �@(����)��h(����Ӥ�)===============================================================    
    //����s�� �h�ԥX�Ҧ��ݩ�o���󪺷Ӥ�
	public Set<HouPhoVO> getHouPhoByHouse(Integer houseno) {
		return dao.getHouPhoByHouse(houseno);
	}
	

}



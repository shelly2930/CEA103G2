package com.house.model;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.houPho.model.HouPhoVO;



public class HouseService {
	//宣告DAO介面，存放DAO實體
	//為什麼要用介面宣告，為了好維護，
	//1.哪天DAO如果需要更換，可以直接重寫DAO而這裡就直接更換實體部分即可
	//2.測試用，可以切換成JDBC測試資料 測完轉換成JNDI
	private HouseDAO_interface dao;
	//呼叫EMPService建構子，順便new EmpDAO
	public HouseService() {
		dao = new HouseDAO();
	}
	//新增物件
	public HouseVO addHouse(Integer lld_no, String hos_name, Integer hos_rent, Integer hos_expense,
			java.sql.Timestamp hos_date, Integer hos_views, String hos_city, String hos_dist, String hos_address,
			Double hos_lon, Double hos_lat, Byte hos_type, String hos_info, Integer hos_age, Integer hos_floor,
			Byte hos_ele, Byte hos_parking, Byte hos_pet, Byte hos_cook, Double hos_squares, Byte hos_gender,
			Double hos_water, Double hos_power, Integer hos_internet, java.sql.Timestamp hos_apptime,
			java.sql.Timestamp hos_order_date, Integer emp_no, Byte hos_status, Byte hos_result, byte[] hos_loc_pic,
			Byte hos_state, String hos_refuse) {
		//傳進來的參數，先包裝成VO，how to do?
		//先建立vo物件，在針對所有屬性，進行set
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
		//把參數轉成vo物件，就可以呼叫dao來對資料庫進行insert
		dao.insert(houseVO);
		return houseVO;
	}
	//修改物件
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
	//從物件編號拉出一個
	public HouseVO getOneHouse(Integer houseno) {
		return dao.findByPrimaryKey(houseno);
	}
	//純粹拉出所有物件
	public List<HouseVO> getAll() {
		return dao.getAll();
	}
	//複合查詢用
	public List<HouseVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}
	public List<HouseVO> getAll_Back(Map<String, String[]> map) {
		return dao.getAll_Back(map);
	}
	//平台管理員 管理文案與照片
	//平台管理員用 (0,2)表示完成案件 等待上架[上架按鈕] (1,2)上架中[下架按鈕] (2,2)下架可重新上架[上架按鈕](3,2)下架 ，廢棄[僅供查看]
	//主管用  list 全部(0,2) 退回->改進度為(0,1)、可以重新指派 ，重新指派員工(指派改為平台管理員)表示通過案件       
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
	
	
//	以下: 一(物件)對多(物件照片)===============================================================    
    //物件編號 去拉出所有屬於這物件的照片
	public Set<HouPhoVO> getHouPhoByHouse(Integer houseno) {
		return dao.getHouPhoByHouse(houseno);
	}
	

}



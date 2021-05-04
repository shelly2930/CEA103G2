package com.house.model;

import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import com.addFur.model.AddFurVO;
import com.houPho.model.HouPhoVO;

public interface HouseDAO_interface {
	//新增物件
	public void insert(HouseVO houseVO);
	//修改物件
    public void update(HouseVO houseVO);
    //更改物件 中繼站用，因為要取出舊有資料再進行更改
    public HouseVO findByPrimaryKey(Integer houseno);
    //純粹拉出所有物件
    public List<HouseVO> getAll();
    //複合查詢用
    public List<HouseVO> getAll(Map<String, String[]> map);
    public List<HouseVO> getAll_Back(Map<String, String[]> map);
//	以下: 一(物件)對多(物件照片)===============================================================    
    //物件編號 去拉出所有屬於這物件的照片
	public Set<HouPhoVO> getHouPhoByHouse(Integer houseno);
	public List<HouseVO> getAllByState(Integer state, Integer status);
}

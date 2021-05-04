package com.houPho.model;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
public interface HouPhoDAO_interface{
	//新增照片
    public void insert(HouPhoVO houPhoVO);
    //更新照片
    public void update(HouPhoVO houPhoVO);
    //刪除照片
    public void delete(Integer houPhono);
    
    public HouPhoVO findByPrimaryKey(Integer houPhono);
    //以下 找出所有物件編號和照片編號
    public List<HouPhoVO> getHousenoAndHouPhono();
    
}

package com.houPho.model;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
public interface HouPhoDAO_interface{
	//�s�W�Ӥ�
    public void insert(HouPhoVO houPhoVO);
    //��s�Ӥ�
    public void update(HouPhoVO houPhoVO);
    //�R���Ӥ�
    public void delete(Integer houPhono);
    
    public HouPhoVO findByPrimaryKey(Integer houPhono);
    //�H�U ��X�Ҧ�����s���M�Ӥ��s��
    public List<HouPhoVO> getHousenoAndHouPhono();
    
}

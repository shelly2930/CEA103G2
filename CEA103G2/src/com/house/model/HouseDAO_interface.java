package com.house.model;

import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import com.addFur.model.AddFurVO;
import com.houPho.model.HouPhoVO;

public interface HouseDAO_interface {
	//�s�W����
	public void insert(HouseVO houseVO);
	//�ק磌��
    public void update(HouseVO houseVO);
    //��磌�� ���~���ΡA�]���n���X�¦���ƦA�i����
    public HouseVO findByPrimaryKey(Integer houseno);
    //�º�ԥX�Ҧ�����
    public List<HouseVO> getAll();
    //�ƦX�d�ߥ�
    public List<HouseVO> getAll(Map<String, String[]> map);
    public List<HouseVO> getAll_Back(Map<String, String[]> map);
//	�H�U: �@(����)��h(����Ӥ�)===============================================================    
    //����s�� �h�ԥX�Ҧ��ݩ�o���󪺷Ӥ�
	public Set<HouPhoVO> getHouPhoByHouse(Integer houseno);
	public List<HouseVO> getAllByState(Integer state, Integer status);
}

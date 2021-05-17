package com.houCol.model;

import java.util.List;

import com.houAddFur.model.HouAddFurVO;


public interface HouColDAO_interface {
	public void insert(HouColVO houColVO);
    public void update(HouColVO houColVO);
    
//  �R���Ҧ�(pk1)����s����houAddFurno�����]�a��s��
    public void deleteTotalByPk1(Integer houColno);
    
//  �R���Ҧ�(pk1)����s���B(pk2)���]�a��s���A��houAddFurno�����]�a��s��
    public void deleteOneByPk1AndPk2(HouColVO houColVO);
    
//  �q(pk1)����s���M(pk2)���]�a��s����X�A�������C
//    GET_ONE_BY_PK1_PK2
    public HouColVO findByPrimaryKey(HouColVO houColVO);
    
//  �q(pk1)����s�����Ҧ����]�a��s��
//    GET_ALL_BY_PK1
    public List<HouColVO> getAll(Integer mem_no);
    //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//  public List<HouColVO> getAll(Map<String, String[]> map); 
    public Integer judge(HouColVO houColVO);
}

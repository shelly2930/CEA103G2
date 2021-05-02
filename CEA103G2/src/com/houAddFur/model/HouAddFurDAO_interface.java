package com.houAddFur.model;

import java.util.List;



public interface HouAddFurDAO_interface {
	public void insert(HouAddFurVO houAddFurVO);
    public void update(HouAddFurVO houAddFurVO);
    
//  �R���Ҧ�(pk1)����s����houAddFurno�����]�a��s��
    public void deleteTotalByPk1(Integer houAddFurno);
    
//  �R���Ҧ�(pk1)����s���B(pk2)���]�a��s���A��houAddFurno�����]�a��s��
    public void deleteOneByPk1AndPk2(HouAddFurVO houAddFurVO);
    
//  �q(pk1)����s���M(pk2)���]�a��s����X�A�������C
//    GET_ONE_BY_PK1_PK2
    public HouAddFurVO findByPrimaryKey(HouAddFurVO houAddFurVO);
    
//  �q(pk1)����s�����Ҧ����]�a��s��
//    GET_ALL_BY_PK1
    public List<HouAddFurVO> getAll(Integer houAddFurno);
    //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//  public List<houAddFurVO> getAll(Map<String, String[]> map); 
    
    
}

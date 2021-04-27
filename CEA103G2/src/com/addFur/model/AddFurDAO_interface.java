package com.addFur.model;

import java.util.List;

public interface AddFurDAO_interface{
    public void insert(AddFurVO addFurVO);
    public void update(AddFurVO addFurVO);
    public void delete(Integer addFurno);
    public AddFurVO findByPrimaryKey(Integer addFurno);
    public List<AddFurVO> getAll();
    //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//  public List<AddFurVO> getAll(Map<String, String[]> map); 
}
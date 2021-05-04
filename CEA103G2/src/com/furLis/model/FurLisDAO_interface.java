package com.furLis.model;

import java.util.*;

public interface FurLisDAO_interface {
	public void insert(FurLisVO furLisVO);
    public void update(FurLisVO furLisVO);
    public void delete(Integer fnt_id);
    public FurLisVO findByPrimaryKey(Integer fnt_id);
    public List<FurLisVO> getAll();
  //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
  public List<FurLisVO> getAll(Map<String, String[]> map);
  public List<FurLisVO> getOneFur_Item_Lis(Integer fnt_it_no); 
}

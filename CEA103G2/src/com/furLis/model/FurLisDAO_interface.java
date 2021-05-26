package com.furLis.model;

import java.util.*;

public interface FurLisDAO_interface {
	public void insert(FurLisVO furLisVO);
    public void update(FurLisVO furLisVO);
    public void delete(Integer fnt_id);
    public FurLisVO findByPrimaryKey(Integer fnt_id);
    public List<FurLisVO> getAll();
  //窾ノ狡琩高(肚把计篈Map)(肚 List)
  public List<FurLisVO> getAll(Map<String, String[]> map);
  public List<FurLisVO> getOneFur_Item_Lis(Integer fnt_it_no); 
  //琩高
//  public List<FurLisVO> getMultiQuery(Integer furCatSelect,Integer furIteSelect,Integer fntStatusSelect,Integer rentStatusSelect);
}

package com.furCol.model;

import java.util.*;

public interface FurColDAO_interface {
	 public void insert(FurColVO furColVO);
     public void update(FurColVO furColVO);
     public void delete(Integer mem_no, Integer fnt_it_no); 
     public FurColVO findByPrimaryKey(Integer mem_no, Integer fnt_it_no); 
     public List<FurColVO> getAll();
   //�d�߬Y�|�����a�㦬��(�@��h)
     public List<FurColVO> getFurColsByMem_no(Integer mem_no);
}

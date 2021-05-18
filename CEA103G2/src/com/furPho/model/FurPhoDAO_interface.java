package com.furPho.model;

import java.util.*;

public interface FurPhoDAO_interface {
	 public void insert(FurPhoVO furPhoVO);
     public void update(FurPhoVO furPhoVO);
     public void delete(Integer fnt_pic_no);
     public FurPhoVO findByPrimaryKey(Integer fnt_pic_no);
     public List<FurPhoVO> getAll();
     public List<FurPhoVO> getOneFntItePics(Integer fnt_it_no);
   //�d�߬Y�a��~���s�����Ӥ�(�@��h)(�^�� Set) �ݽT�{
   // public Set<FurPhoVO> getFntPicsByFnt_it_no(Integer fnt_it_no);
 	//���Ҭd�~�����Ĥ@�ӷӤ��s��(���ռg�k${furPhoSvc.getThisIteFirstFnt_pic_no(furIteVO.fnt_it_no)}�L�k����)
     public Integer getThisIteFirstFnt_pic_no(Integer fnt_it_no);
   //���Ҭd�~�����Ĥ@�ӷӤ�FurPhoVO
 	public FurPhoVO getThisIteFurPho(Integer fnt_it_no);
 	public List<Integer> getThisIteFnt_pic_no(Integer fnt_it_no);
}

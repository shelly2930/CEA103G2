package com.furIte.model;

import java.util.*;


public interface FurIteDAO_interface {
	 public void insert(FurIteVO furIteVO);
     public void update(FurIteVO furIteVO);
     public void delete(Integer fnt_it_no); 
     public FurIteVO findByPrimaryKey(Integer fnt_it_no);
     public FurIteVO findByFurName(String fnt_name); 
     public List<FurIteVO> getAll();
     //�d�߬Y�a�����O���~��(�@��h)(�^�� Set)
     public List<FurIteVO> getFurItesByFurCat(Integer fnt_ctgr_no);
     //�s�ʤU�Ԧ�����
     public String selectByPrimaryKey(Integer fnt_ctgr_no);
	public String getAllFntName();
	
	public List<FurIteVO> getOneFurCat_Item(Integer fnt_ctgr_no);
	//��̫�@���~���s�����s�W�Ӥ���
	public Integer GetLastFnt_it_no();
	
	//<�e�x��>�d�Ҧ��W�[�ӫ~
	 public List<FurIteVO> getAllGetOnFurIte();
	//<�e�x��>�̮a������d�Ҧ��W�[�ӫ~
	 public List<FurIteVO> getGetOnFurIteByCat(Integer fnt_ctgr_no);
	
	 //��ܫ~���ܫe�x(�B�z������D)
    public FurIteVO showOneFurIteToFE(Integer fnt_it_no);
	 
	//����r�d��
	public List<FurIteVO> getOneFurIteByKW(String keyword);
	
	//�e�x�ҽk�d��
	public List<FurIteVO> getOneFurIteByKWtoFE(String keyword);
	}

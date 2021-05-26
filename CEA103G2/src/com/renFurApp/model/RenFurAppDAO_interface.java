package com.renFurApp.model;

import java.util.*;

import com.renFurDet.model.RenFurDetVO;

public interface RenFurAppDAO_interface {
	public void  insertWithDetail(RenFurAppVO renFurAppVO,List<RenFurDetVO> renFurDetList);
    public void update(RenFurAppVO renFurAppVO);
    public void delete(Integer rfa_no);
    public RenFurAppVO findByPrimaryKey(Integer rfa_no);
    public List<RenFurAppVO> getAll();
  //�d�߬Y�ӽг�s�� �^�Ǧh�ө���(�@��h)(�^�� Set) �g�k�ݽT�{
   // public Set<RenFurDetVO> getRenFurDetByRfa_no(Integer rfa_no);
    //�d�߬Y���u�t�d���ӽг� �^�Ǧh�i�ӽг�(�@��h)(�^�� Set) �g�k�ݽT�{
   // public Set<MenTenVO> getRfasByMem_no(Integer mem_no);
	
	//�d�ӽг檺���ɪ��A��
	public Byte getRenFurAppStatus(Integer rfa_no);
	public Integer getRentCon(Integer rfa_no);
	// ���� �d�|�����Ҧ��ӽг�
	public List<RenFurAppVO> getAllByMem(Integer mem_no,Byte rfa_status);
	public void updateStatusByPK(RenFurAppVO renFurAppVO);
}

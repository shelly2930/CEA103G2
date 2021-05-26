package com.renFurApp.model;

import java.util.*;

import com.renFurDet.model.RenFurDetVO;

public interface RenFurAppDAO_interface {
	public void  insertWithDetail(RenFurAppVO renFurAppVO,List<RenFurDetVO> renFurDetList);
    public void update(RenFurAppVO renFurAppVO);
    public void delete(Integer rfa_no);
    public RenFurAppVO findByPrimaryKey(Integer rfa_no);
    public List<RenFurAppVO> getAll();
  //查詢某申請單編號 回傳多個明細(一對多)(回傳 Set) 寫法待確認
   // public Set<RenFurDetVO> getRenFurDetByRfa_no(Integer rfa_no);
    //查詢某員工負責之申請單 回傳多張申請單(一對多)(回傳 Set) 寫法待確認
   // public Set<MenTenVO> getRfasByMem_no(Integer mem_no);
	
	//查申請單的租借狀態用
	public Byte getRenFurAppStatus(Integer rfa_no);
	public Integer getRentCon(Integer rfa_no);
	// 蔡佳 查會員的所有申請單
	public List<RenFurAppVO> getAllByMem(Integer mem_no,Byte rfa_status);
	public void updateStatusByPK(RenFurAppVO renFurAppVO);
}

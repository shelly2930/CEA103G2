package com.renFurDet.model;

import java.sql.Connection;
import java.util.*;

import com.renCon.model.RenConVO;

public interface RenFurDetDAO_interface {
//	public void insert(RenFurDetVO renFurDetVO);
    public void update(RenFurDetVO renFurDetVO);
    public void deleteOne(Integer fra_no,Integer fnt_id);
    public RenFurDetVO findByPrimaryKey(Integer fra_no,Integer fnt_id);
    public List<RenFurDetVO> getAll();
    public void deleteList(Integer rfa_no);
	List<RenFurDetVO> getOneList(Integer rfa_no);
	void insert(RenFurDetVO renFurDetVO, Connection con);
	public void updateTmtDate(RenFurDetVO renFurDetVO); 
}

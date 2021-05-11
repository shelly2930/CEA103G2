package com.repApp.model;

import java.util.List;

import com.repApp.model.RepAppVO;
import com.repAppDet.model.RepAppDetVO;
import com.repAppPho.model.RepAppPhoVO;

public interface RepAppDAO_interface {
	public void insert(RepAppVO repAppVO, List<RepAppDetVO> list_RepAppDetVO, List<RepAppPhoVO> list_RepAppPhoVO);
	public void update(RepAppVO repAppVO);
	public RepAppVO getByPK(Integer ra_no);
	public List<RepAppVO> getAll();
	public List<RepAppDetVO> getDetsByPK(Integer ra_no);
}

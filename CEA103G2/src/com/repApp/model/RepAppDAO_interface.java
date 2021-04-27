package com.repApp.model;

import java.util.List;

import com.repApp.model.RepAppVO;
import com.repAppDet.model.RepAppDetVO;

public interface RepAppDAO_interface {
	public void insert(RepAppVO repAppVO, List<RepAppDetVO> list);
	public void update(RepAppVO repAppVO);
	public RepAppVO getByPK(Integer ra_no);
	public List<RepAppVO> getAll();
}

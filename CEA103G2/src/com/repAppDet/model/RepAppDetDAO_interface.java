package com.repAppDet.model;

import java.sql.Connection;
import java.util.List;
import java.util.Set;

import com.repAppPho.model.RepAppPhoVO;

public interface RepAppDetDAO_interface {
	public void insert(RepAppDetVO repAppDetVO);
	public void update(RepAppDetVO repAppDetVO);
	public RepAppDetVO getByPK(Integer rad_no);
	public List<RepAppDetVO> getByFK(Integer ra_no);
	public List<RepAppDetVO> getAll();
	public List<RepAppPhoVO> getPhosByPK(Integer rad_no);
}

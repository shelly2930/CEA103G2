package com.repAppDet.model;

import java.sql.Connection;
import java.util.List;

public interface RepAppDetDAO_interface {
	public void insert(RepAppDetVO repAppDetVO, Connection con);
	public void update(RepAppDetVO repAppDetVO);
	public RepAppDetVO getByPK(Integer rad_no);
	public List<RepAppDetVO> getByFK(Integer ra_no);
	public List<RepAppDetVO> getAll();
}

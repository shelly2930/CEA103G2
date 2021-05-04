package com.staRig.model;

import java.sql.Connection;
import java.util.List;

import com.staRig.model.StaRigVO;

public interface StaRigDAO_interface {
	public void insert(StaRigVO srv, Connection con);
	public void delete(StaRigVO srv, Connection con);
	public List<StaRigVO> getOne(Integer emp_no);
	public List<StaRigVO> getAll();
}

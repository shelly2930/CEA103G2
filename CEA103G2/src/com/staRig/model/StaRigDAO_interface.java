package com.staRig.model;

import java.util.List;

import com.staRig.model.StaRigVO;

public interface StaRigDAO_interface {
	public void insert(StaRigVO srv);
	public void delete(StaRigVO srv);
	public List<StaRigVO> getOne(Integer emp_no);
	public List<StaRigVO> getAll();
}

package com.creCarInf.model;

import java.util.List;

public interface CreCarInfDAO_interface {
	public void insert(CreCarInfVO creCarInfVO);
	public void update(CreCarInfVO creCarInfVO);
	public void delete(Integer cci_no);
	public CreCarInfVO findByPrimaryKey(Integer cci_no);
	public List<CreCarInfVO> getAll();
}

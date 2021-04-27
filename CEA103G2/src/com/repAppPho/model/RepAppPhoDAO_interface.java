package com.repAppPho.model;

import java.util.List;

public interface RepAppPhoDAO_interface {
	public void insert(RepAppPhoVO repAppPhoVO);
	public void update(RepAppPhoVO repAppPhoVO);
	public void delete(Integer rap_no);
	public RepAppPhoVO getByPK(Integer rap_no);
	public List<RepAppPhoVO> getByFK(Integer ra_no);
	
}

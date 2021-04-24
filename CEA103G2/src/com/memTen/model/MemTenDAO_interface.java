package com.memTen.model;

import java.util.*;

public interface MemTenDAO_interface {
	public void insert(MemTenVO memTenVO);
	public void update(MemTenVO memTenVO);
	public void delete(Integer mem_no);
	public MemTenVO findByPrimaryKey(Integer mem_no);
	public List<MemTenVO> getAll();
}

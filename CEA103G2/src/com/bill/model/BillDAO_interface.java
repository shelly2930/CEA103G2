package com.bill.model;

import java.util.*;

public interface BillDAO_interface {
	public void insert(BillVO billVO);
	public void update(BillVO billVO);
	public void delete(Integer bill_no);
	public BillVO findByPrimaryKey(Integer bill_no);
	public List<BillVO> getAll();
	public void autoInsert(BillVO billVO);
	public boolean isExist(Integer mem_no, java.sql.Date bill_date);
}

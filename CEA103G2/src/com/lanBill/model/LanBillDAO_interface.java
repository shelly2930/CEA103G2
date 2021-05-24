package com.lanBill.model;

import java.util.*;

public interface LanBillDAO_interface {
	public void insert(LanBillVO lanBillVO);
	public void update(LanBillVO lanBillVO);
//	public void delete(Integer lldb_no);
	public LanBillVO findByPrimaryKey(Integer lldb_no);
	public List<LanBillVO> getAll();
	public void updateStatus(LanBillVO lanBillVO);
}

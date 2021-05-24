package com.lanBill.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class LanBillService {

	private LanBillDAO_interface dao;
	
	public LanBillService() {
		dao = new LanBillDAO();
	}
	
	public LanBillVO addLanBill(Integer lld_no, Integer hos_no, Date lldb_date, Date lldb_due) {
		
		LanBillVO lanBillVO = new LanBillVO();
				
		lanBillVO.setLld_no(lld_no);
		lanBillVO.setHos_no(hos_no);
		lanBillVO.setLldb_date(lldb_date);
		lanBillVO.setLldb_due(lldb_due);
		dao.insert(lanBillVO);

		return lanBillVO;
	}
	
	public LanBillVO updateLanBill(Integer lldb_no, Integer lld_no, Integer hos_no, Date lldb_date, 
			Date lldb_due, Byte lldb_status) {
		
		LanBillVO lanBillVO = new LanBillVO();
		
		lanBillVO.setLldb_no(lldb_no);
		lanBillVO.setLld_no(lld_no);
		lanBillVO.setHos_no(hos_no);
		lanBillVO.setLldb_date(lldb_date);
		lanBillVO.setLldb_due(lldb_due);
		lanBillVO.setLldb_status(lldb_status);
		dao.update(lanBillVO);

		return lanBillVO;
	}
	
	public LanBillVO getOneLanBill(Integer lldb_no) {
		return dao.findByPrimaryKey(lldb_no);
	}
	
	public List<LanBillVO> getAll() {
		return dao.getAll();
	}
	
	public LanBillVO updateStatus(Integer lldb_no, Byte lldb_status) {
		
		LanBillVO lanBillVO = new LanBillVO();
		
		lanBillVO.setLldb_no(lldb_no);		
		lanBillVO.setLldb_status(lldb_status);
		dao.updateStatus(lanBillVO);
		
		return lanBillVO;
	}
}

package com.bill.model;

import java.sql.Date;
import java.util.List;

public class BillService {
	private BillDAO_interface dao;
	
	public BillService() {
		dao = new BillDAO();
	}
	
	public BillVO addBill(Integer mem_no, Integer hos_no, Date bill_date, Date bill_due,
			Integer bill_power, Integer bill_water) {
		
		BillVO billVO = new BillVO();
				
		billVO.setMem_no(mem_no);
		billVO.setHos_no(hos_no);
		billVO.setBill_date(bill_date);
		billVO.setBill_due(bill_due);
		billVO.setBill_power(bill_power);
		billVO.setBill_water(bill_water);
//		billVO.setBill_p_status(bill_p_status);
//		billVO.setBill_r_status(bill_r_status);			
		dao.insert(billVO);

		return billVO;
	}
	
	public BillVO updateBill(Integer bill_no, Integer mem_no, Integer hos_no, Date bill_date, Date bill_due,
			Integer bill_power, Integer bill_water, Byte bill_p_status, Byte bill_r_status) {
		
		BillVO billVO = new BillVO();
		
		billVO.setBill_no(bill_no);
		billVO.setMem_no(mem_no);
		billVO.setHos_no(hos_no);
		billVO.setBill_date(bill_date);
		billVO.setBill_due(bill_due);
		billVO.setBill_power(bill_power);
		billVO.setBill_water(bill_water);
		billVO.setBill_p_status(bill_p_status);
		billVO.setBill_r_status(bill_r_status);			
		dao.update(billVO);

		return billVO;
	}
	
	public void deleteBill(Integer bill_no) {
		dao.delete(bill_no);
	}
	
	public BillVO getOneBill(Integer bill_no) {
		return dao.findByPrimaryKey(bill_no);
	}
	
	public List<BillVO> getAll() {
		return dao.getAll();
	}
}

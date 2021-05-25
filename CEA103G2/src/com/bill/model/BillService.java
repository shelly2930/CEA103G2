package com.bill.model;

import java.sql.Date;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

import com.renCon.model.RenConService;
import com.renCon.model.RenConVO;

public class BillService {
	private BillDAO_interface dao;
	
	public BillService() {
		dao = new BillDAO();
	}
	
	public BillVO addBill(Integer mem_no, Date bill_date, Date bill_due,
			Integer bill_power, Integer bill_water) {
		
		BillVO billVO = new BillVO();
				
		billVO.setMem_no(mem_no);
		billVO.setBill_date(bill_date);
		billVO.setBill_due(bill_due);
		billVO.setBill_power(bill_power);
		billVO.setBill_water(bill_water);
		dao.insert(billVO);

		return billVO;
	}
	
	public BillVO updateBill(Integer bill_no, Integer mem_no, Date bill_date, Date bill_due,
			Integer bill_power, Integer bill_water, Byte bill_p_status, Byte bill_r_status) {
		
		BillVO billVO = new BillVO();
		
		billVO.setBill_no(bill_no);
		billVO.setMem_no(mem_no);
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
	
	public int autoAddBill() {
		RenConService renConSvc = new RenConService();
		List<RenConVO> list = renConSvc.getAll();
		java.util.Date now = new java.util.Date();
		int amountOfInsert = 0;
		for(RenConVO renConVO : list) {
			Integer mem_no = renConVO.getMem_no();
			//現在時間在合約起始日之後才剛始生帳單
			if(now.getTime() > renConVO.getRtct_eff_date().getTime()) {
				if(renConVO.getRtct_status() == 2 || renConVO.getRtct_status() == 4 || renConVO.getRtct_status() == 5) {
					Calendar cal = Calendar.getInstance();
					cal.setTime(now);
					int year_now = cal.get(Calendar.YEAR); //現在年份
					int month_now = cal.get(Calendar.MONTH); //現在月份
					cal.setTime(renConVO.getRtct_eff_date());
					int year_eff = cal.get(Calendar.YEAR); //合約起始日年份
					int month_eff = cal.get(Calendar.MONTH); //合約起始日月份
					int amountOfBill; //帳單數量
					
					//解約日非空值,依解約日判斷
					if(renConVO.getRtct_tmt_date() != null) {
						cal.setTime(renConVO.getRtct_tmt_date());
						int year_tmt = cal.get(Calendar.YEAR);
						int month_tmt = cal.get(Calendar.MONTH);
						
						//現在時間在解約日之後
						if(now.getTime() > renConVO.getRtct_tmt_date().getTime()) {
							amountOfBill = (year_tmt - year_eff)*12 + (month_tmt - month_eff) + 1;
						//現在時間在解約日之前
						}else {
							amountOfBill = (year_now - year_eff)*12 + (month_now - month_eff);
						}
						
					//解約日為空值,依終止日判斷
					}else {
						cal.setTime(renConVO.getRtct_end_date());
						int year_end = cal.get(Calendar.YEAR);
						int month_end = cal.get(Calendar.MONTH);
						
						//現在時間在終止日之後
						if(now.getTime() > renConVO.getRtct_end_date().getTime()) {
							amountOfBill = (year_end - year_eff)*12 + (month_end - month_eff) + 1;
						//現在時間在終止日之前
						}else {
							amountOfBill = (year_now - year_eff)*12 + (month_now - month_eff);
						}
					}
					
					for(int i = 0; i < amountOfBill; i++) {
						month_eff++;
						if(month_eff > 12) {
							month_eff -= 12;
							year_eff += 1;
						}
						GregorianCalendar greCal = new GregorianCalendar(year_eff, month_eff, 1);
						java.util.Date bill_util_date = greCal.getTime();
						java.sql.Date bill_date = new java.sql.Date(bill_util_date.getTime());
						java.sql.Date bill_due = new java.sql.Date(bill_date.getTime() + 15*24*60*60*1000);
						
						if(!dao.isExist(mem_no, bill_date)) {
							BillVO billVO = new BillVO();
							billVO.setMem_no(mem_no);
							billVO.setBill_date(bill_date);
							billVO.setBill_due(bill_due);
							dao.autoInsert(billVO);
							amountOfInsert++;
						}
					}
				}
			}
		}
		return amountOfInsert;
	}
}

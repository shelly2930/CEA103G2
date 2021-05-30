package com.bill.model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.furIte.model.FurIteService;
import com.furLis.model.FurLisService;
import com.house.model.HouseService;
import com.renCon.model.RenConService;
import com.renCon.model.RenConVO;
import com.renFurApp.model.RenFurAppService;
import com.renFurApp.model.RenFurAppVO;
import com.renFurDet.model.RenFurDetService;
import com.renFurDet.model.RenFurDetVO;

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
	
	public BillVO update(Integer bill_no, Integer mem_no, Integer hos_no, Date bill_date, Date bill_due,
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
	
	public List<BillVO> getMemMonthlyBill(Integer mem_no, java.sql.Date bill_date) {
		return dao.getMemMonthlyBill(mem_no, bill_date);
	}
	
	public int autoAddBill() {
		RenConService renConSvc = new RenConService();
		List<RenConVO> list = renConSvc.getAll();
		java.util.Date now = new java.util.Date();
		int amountOfInsert = 0;
		for(RenConVO renConVO : list) {
			Integer mem_no = renConVO.getMem_no();
			Integer hos_no = renConVO.getHos_no();
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
//						java.sql.Date bill_due = new java.sql.Date(bill_date.getTime() + 15*24*60*60*1000);
						
						if(!dao.isExist(mem_no, hos_no, bill_date)) {
							BillVO billVO = new BillVO();
							billVO.setMem_no(mem_no);
							billVO.setHos_no(hos_no);;
							billVO.setBill_date(bill_date);
//							billVO.setBill_due(bill_due);
							dao.autoInsert(billVO);
							if(getMemMonthlyBill(mem_no, bill_date).size() == 1) {
								amountOfInsert++;
							}
						}
					}
				}
			}
		}
		return amountOfInsert;
	}
	
	public RenConVO getCurrentRenCon(BillVO billVO) {
		Integer mem_no = billVO.getMem_no();
		Integer hos_no = billVO.getHos_no();
		Date bill_date = billVO.getBill_date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(bill_date);
		int year_bill = cal.get(Calendar.YEAR); //帳單年份
		int month_bill = cal.get(Calendar.MONTH); //帳單月份
		List<RenConVO> list = new RenConService().getAll();
		for(RenConVO renConVO : list) {
			if(renConVO.getMem_no() == mem_no && renConVO.getHos_no() == hos_no) {
				if(renConVO.getRtct_eff_date().getTime() <= bill_date.getTime()) {
					if(renConVO.getRtct_tmt_date() == null) {
						cal.setTime(renConVO.getRtct_end_date());
						int year_end = cal.get(Calendar.YEAR); //合約終止日年份
						int month_end = cal.get(Calendar.MONTH); //合約終止日月份
						int betweenMonth = (year_bill - year_end)*12 + (month_bill - month_end); //帳單日期與合約終止日相差月份
						if(betweenMonth <= 1)
							return renConVO;
					}else {
						cal.setTime(renConVO.getRtct_tmt_date());
						int year_tmt = cal.get(Calendar.YEAR); //合約解約日年份
						int month_tmt = cal.get(Calendar.MONTH); //合約解約日月份
						int betweenMonth = (year_bill - year_tmt)*12 + (month_bill - month_tmt); //帳單日期與合約解約日相差月份
						if(betweenMonth <= 1)
							return renConVO;
					}
				}
			}
		}
		return null;
	}
	
	public Map<String,String> getHousePeriodAndMoney(BillVO billVO) {
		Map<String,String> map = new HashMap<String,String>();
		String period = null;
		Integer money_rent = null;
		Integer money_internet = null;
		RenConVO renConVO = getCurrentRenCon(billVO);
		System.out.println(renConVO);
		int hos_rent = new HouseService().getOneHouse(renConVO.getHos_no()).getHos_rent();
		int hos_internet = new HouseService().getOneHouse(renConVO.getHos_no()).getHos_internet();
		
		Date bill_date = billVO.getBill_date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(bill_date);
		int year_bill = cal.get(Calendar.YEAR); //帳單年份
		int month_bill = cal.get(Calendar.MONTH); //帳單月份
		cal.roll(Calendar.MONTH, -1); //日期回滾一個月
		cal.set(Calendar.DATE, 1); //把日期設定為當月第一天
		cal.roll(Calendar.DATE, -1); //日期回滾一天，也就是最後一天
		int lastMonth_bill = cal.get(Calendar.MONTH)+1; //帳單上個月月份(實際)
		int DaysOfLastMonth_bill = cal.get(Calendar.DATE); //帳單上個月總天數
		
		cal.setTime(renConVO.getRtct_eff_date());
		int year_eff = cal.get(Calendar.YEAR); //合約起始日年份
		int month_eff = cal.get(Calendar.MONTH); //合約起始日帳單月份
		int dateOfMonth_eff = cal.get(Calendar.DATE); //合約起始日為當月第幾天
		
		//解約日為空值,依終止日判斷
		if(renConVO.getRtct_tmt_date() == null) {
			cal.setTime(renConVO.getRtct_end_date());
			int dateOfMonth_end = cal.get(Calendar.DATE); //合約終止日為當月第幾天
			
			//合約終止日在帳單日期之後
			if(renConVO.getRtct_end_date().getTime() > bill_date.getTime()) {
				int betweenMonth = (year_bill - year_eff)*12 + (month_bill - month_eff); //帳單日期與合約起始日相差月份
				
				if(betweenMonth == 1) {
					period = lastMonth_bill + "/" + dateOfMonth_eff + " - " + lastMonth_bill + "/" + DaysOfLastMonth_bill;
					double percent = (double)(DaysOfLastMonth_bill - dateOfMonth_eff + 1) / (double)DaysOfLastMonth_bill;
					money_rent = (int)Math.round(percent * hos_rent);
					money_internet = (int)Math.round(percent * hos_internet);
				}else {
					period = lastMonth_bill + "/1 - " + lastMonth_bill + "/" + DaysOfLastMonth_bill;
					money_rent = hos_rent;
					money_internet = hos_internet;
				}
			//合約終止日在帳單日期之前,且一定是在上個月(getCurrentRenCon已過濾過)
			}else {
				period = lastMonth_bill + "/1 - " + lastMonth_bill + "/" + dateOfMonth_end;
				double percent = (double)dateOfMonth_end / (double)DaysOfLastMonth_bill;
		    	money_rent = (int)Math.round(percent * hos_rent);
		    	money_internet = (int)Math.round(percent * hos_internet);
			}
		//解約日非空值,依解約日判斷
		}else {
			cal.setTime(renConVO.getRtct_tmt_date()); //將合約解約日轉為Calendar
			int year_tmt = cal.get(Calendar.YEAR); //合約解約日年份
			int month_tmt = cal.get(Calendar.MONTH); //合約解約日月份
			int dateOfMonth_tmt = cal.get(Calendar.DATE); //合約解約日為當月第幾天
			
			//合約解約日在帳單日期之後
			if(renConVO.getRtct_tmt_date().getTime() > bill_date.getTime()) {
				int betweenMonth = (year_bill - year_eff)*12 + (month_bill - month_eff); //帳單日期與合約起始日相差月份
				
				if(betweenMonth == 1) {
					period = lastMonth_bill + "/" + dateOfMonth_eff + " - " + lastMonth_bill + "/" + DaysOfLastMonth_bill;
					double percent = (double)(DaysOfLastMonth_bill - dateOfMonth_eff + 1) / (double)DaysOfLastMonth_bill;
					money_rent = (int)Math.round(percent * hos_rent);
					money_internet = (int)Math.round(percent * hos_internet);
				}else {
					period = lastMonth_bill + "/1 - " + lastMonth_bill + "/" + DaysOfLastMonth_bill;
					money_rent = hos_rent;
					money_internet = hos_internet;
				}
			//合約解約日在帳單日期之前,且一定是在上個月(getCurrentRenCon已過濾過)
			}else {
				//當月租當月退的情況
				if(year_tmt == year_eff && month_tmt == month_eff){
					period = lastMonth_bill + "/" + dateOfMonth_eff + " - " + lastMonth_bill + "/" + dateOfMonth_tmt;
					int betweenDay = dateOfMonth_tmt - dateOfMonth_eff;
					double percent = (double)betweenDay / (double)DaysOfLastMonth_bill;
					money_rent = (int)Math.round(percent * hos_rent);
					money_internet = (int)Math.round(percent * hos_internet);
				}else {
					period = lastMonth_bill + "/1 - " + lastMonth_bill + "/" + dateOfMonth_tmt;
					double percent = (double)dateOfMonth_tmt / (double)DaysOfLastMonth_bill;
			    	money_rent = (int)Math.round(percent * hos_rent);
			    	money_internet = (int)Math.round(percent * hos_internet);
				}
			}
		}
		
		map.put("period", period);
		map.put("money_rent", money_rent.toString());
		map.put("money_internet", money_internet.toString());
		return map;
	}
	
	public List<RenFurAppVO> getCurrentRenFurApp(BillVO billVO) {
		List<RenFurAppVO> list = new ArrayList<RenFurAppVO>();
		RenFurAppService renFurAppSvc = new RenFurAppService();
		RenFurDetService renFurDetSvc = new RenFurDetService();
		Integer mem_no = billVO.getMem_no();
		Date bill_date = billVO.getBill_date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(bill_date);
		int year_bill = cal.get(Calendar.YEAR); //帳單年份
		int month_bill = cal.get(Calendar.MONTH); //帳單月份
		
		for(RenFurAppVO renFurAppVO : renFurAppSvc.getAll()) {
			if(renFurAppVO.getMem_no() == mem_no) {
				boolean isValid = false;
				for(RenFurDetVO renFurDetVO : renFurDetSvc.getOneList(renFurAppVO.getRfa_no())) {
					//出租日期不為空值 且 帳單日期在出租日期之後
					if(renFurDetVO.getRent_date() != null && renFurDetVO.getRent_date().getTime() < bill_date.getTime()) {
						if(renFurDetVO.getRent_tmt_date() == null) {
							cal.setTime(renFurDetVO.getRent_end_date());
							int year_end = cal.get(Calendar.YEAR); //訂單明細終止日年份
							int month_end = cal.get(Calendar.MONTH); //訂單明細終止日月份
							int betweenMonth = (year_bill - year_end)*12 + (month_bill - month_end); //帳單日期與明細終止日相差月份
							if(betweenMonth <= 1)
								isValid = true;
						}else {
							cal.setTime(renFurDetVO.getRent_tmt_date());
							int year_tmt = cal.get(Calendar.YEAR); //訂單明細解約日年份
							int month_tmt = cal.get(Calendar.MONTH); //訂單明細解約日月份
							int betweenMonth = (year_bill - year_tmt)*12 + (month_bill - month_tmt); //帳單日期與明細解約日相差月份
							if(betweenMonth <= 1)
								isValid = true;
						}
					}
				}
				if(isValid)
					list.add(renFurAppVO);
			}
		}
		return list;
	}
	
	public Map<String,String> getRenFurDetPeriodAndMoney(RenFurDetVO renFurDetVO,BillVO billVO) {
		Map<String,String> map = new HashMap<String,String>();
		FurIteService furIteSvc = new FurIteService();
		FurLisService furLisSvc = new FurLisService();
		String period = null;
		Integer money = null;
		Date bill_date = billVO.getBill_date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(bill_date);
		int year_bill = cal.get(Calendar.YEAR); //帳單年份
		int month_bill = cal.get(Calendar.MONTH); //帳單月份
		cal.roll(Calendar.MONTH, -1); //日期回滾一個月
		cal.set(Calendar.DATE, 1); //把日期設定為當月第一天
		cal.roll(Calendar.DATE, -1); //日期回滾一天，也就是最後一天
		int lastMonth_Year = cal.get(Calendar.YEAR); //帳單上個月年份
		int lastMonth_bill = cal.get(Calendar.MONTH)+1; //帳單上個月月份(實際)
		int DaysOfLastMonth_bill = cal.get(Calendar.DATE); //帳單上個月總天數
		
		int fnt_price = furIteSvc.getOneFurIte(furLisSvc.getOneFurLis(renFurDetVO.getFnt_id()).getFnt_it_no()).getFnt_price();
		cal.setTime(renFurDetVO.getRent_date()); //將出租日期轉為Calendar
		int year_rent = cal.get(Calendar.YEAR); //出租日期年份
		int month_rent = cal.get(Calendar.MONTH); //出租日期月份
		int dateOfMonth_rent = cal.get(Calendar.DATE); //出租日期為當月第幾天
		
//		System.out.println("bill_date:"+bill_date);
		//解約日為空值,依終止日判斷
		if(renFurDetVO.getRent_tmt_date() == null) {
			cal.setTime(renFurDetVO.getRent_end_date());
			int dateOfMonth_end = cal.get(Calendar.DATE); //終止日為當月第幾天
			
			//終止日在帳單日期之後
			if(renFurDetVO.getRent_end_date().getTime() > bill_date.getTime()) {
				int betweenMonth = (year_bill - year_rent)*12 + (month_bill - month_rent); //帳單日期與起始日相差月份
				
				if(betweenMonth == 1) {
					period = lastMonth_bill + "/" + dateOfMonth_rent + " - " + lastMonth_bill + "/" + DaysOfLastMonth_bill;
					int partOf_fnt_price = (int)Math.round((double)(DaysOfLastMonth_bill - dateOfMonth_rent + 1) / (double)DaysOfLastMonth_bill * fnt_price);
				    money = partOf_fnt_price;
				}else {
					period = lastMonth_bill + "/1 - " + lastMonth_bill + "/" + DaysOfLastMonth_bill;
					money = fnt_price;
				}
			//終止日在帳單日期之前,且一定是在上個月(getCurrentRenFurApp已過濾過)
			}else {
				period = lastMonth_bill + "/1 - " + lastMonth_bill + "/" + dateOfMonth_end;
		    	int partOf_fnt_price = (int)Math.round((double)dateOfMonth_end / (double)DaysOfLastMonth_bill * fnt_price);
		    	money = partOf_fnt_price;
			}
		//解約日非空值,依解約日判斷
		}else {
			cal.setTime(renFurDetVO.getRent_tmt_date()); //將解約日轉為Calendar
			int year_tmt = cal.get(Calendar.YEAR); //解約日年份
			int month_tmt = cal.get(Calendar.MONTH); //解約日月份
			int dateOfMonth_tmt = cal.get(Calendar.DATE); //解約日為當月第幾天
			
			//解約日在帳單日期之後
			if(renFurDetVO.getRent_tmt_date().getTime() > bill_date.getTime()) {
				int betweenMonth = (year_bill - year_rent)*12 + (month_bill - month_rent); //帳單日期與合約起始日相差月份
				
				if(betweenMonth == 1) {
					period = lastMonth_bill + "/" + dateOfMonth_rent + " - " + lastMonth_bill + "/" + DaysOfLastMonth_bill;
					int partOf_fnt_price = (int)Math.round((double)(DaysOfLastMonth_bill - dateOfMonth_rent + 1) / (double)DaysOfLastMonth_bill * fnt_price);
				    money = partOf_fnt_price;
				}else {
					period = lastMonth_bill + "/1 - " + lastMonth_bill + "/" + DaysOfLastMonth_bill;
					money = fnt_price;
				}
			//解約日在帳單日期之前,不一定在上個月
			}else {
				int betweenMonth = (year_bill - year_tmt)*12 + (month_bill - month_tmt); //帳單日期與解約日相差月份
				
				if(betweenMonth == 1) {
					//當月租當月退的情況
					if(year_tmt == year_rent && month_tmt == month_rent){
						period = lastMonth_bill + "/" + dateOfMonth_rent + " - " + lastMonth_bill + "/" + dateOfMonth_tmt;
						int betweenDay = dateOfMonth_tmt - dateOfMonth_rent;
						int partOf_fnt_price = (int)Math.round((double)betweenDay / (double)DaysOfLastMonth_bill * fnt_price);
						money = partOf_fnt_price;
					}else {
						period = lastMonth_bill + "/1 - " + lastMonth_bill + "/" + dateOfMonth_tmt;
						int partOf_fnt_price = (int)Math.round((double)dateOfMonth_tmt / (double)DaysOfLastMonth_bill * fnt_price);
						money = partOf_fnt_price;
					}
				//帳單日期與解約日超過一個月
				}else {
					period = "已退租";
					money = 0;
				}
			}
		}
		map.put("period", period);
		map.put("money", money.toString());
		return map;
	}
	
	public BillVO updateBill(Integer bill_no, Date bill_due, Integer bill_power, Integer bill_water, Byte bill_p_status, Byte bill_r_status) {
		
		BillVO billVO = new BillVO();
		
		billVO.setBill_no(bill_no);
		billVO.setBill_due(bill_due);
		billVO.setBill_power(bill_power);
		billVO.setBill_water(bill_water);
		billVO.setBill_p_status(bill_p_status);
		billVO.setBill_r_status(bill_r_status);			
		dao.updateBill(billVO);

		return billVO;
	}
	
	
}

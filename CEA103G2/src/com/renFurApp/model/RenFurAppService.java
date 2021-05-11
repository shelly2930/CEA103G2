package com.renFurApp.model;

import java.sql.Timestamp;
import java.util.List;

public class RenFurAppService {

	private RenFurAppDAO_interface dao;

	public RenFurAppService() {
		dao = new RenFurAppDAO();
	}

	public RenFurAppVO addRenFurApp(Integer mem_no, Integer emp_no, Timestamp rfa_order_date,
			Integer rfa_total, Timestamp rfa_apct_date, Byte rfa_status) {

		RenFurAppVO renFurAppVO = new RenFurAppVO();
		renFurAppVO.setMem_no(mem_no);
		renFurAppVO.setEmp_no(emp_no);
		renFurAppVO.setRfa_order_date(rfa_order_date);
		renFurAppVO.setRfa_total(rfa_total);
		renFurAppVO.setRfa_apct_date(rfa_apct_date);
		renFurAppVO.setRfa_status(rfa_status);

		dao.insert(renFurAppVO);

		return renFurAppVO;
	}

	public RenFurAppVO updateRenFurApp(Integer rfa_no, Integer emp_no, Timestamp rfa_order_date) {
//		public RenFurAppVO updateRenFurApp(Integer rfa_no, Integer mem_no, Integer emp_no, Timestamp rfa_order_date,
//				Integer rfa_total, Byte rfa_status) {

		RenFurAppVO renFurAppVO = new RenFurAppVO();
		renFurAppVO.setRfa_no(rfa_no);
//		renFurAppVO.setMem_no(mem_no);
		renFurAppVO.setEmp_no(emp_no);
		renFurAppVO.setRfa_order_date(rfa_order_date);
//		renFurAppVO.setRfa_total(rfa_total);
//		renFurAppVO.setRfa_apct_date(rfa_apct_date);
//		renFurAppVO.setRfa_status(rfa_status);

		dao.update(renFurAppVO);

		return renFurAppVO;
	}

	public void deleteRenFurApp(Integer rfa_no) {
		dao.delete(rfa_no);
	}

	public RenFurAppVO getOneRenFurApp(Integer rfa_no) {
		return dao.findByPrimaryKey(rfa_no);
	}

	public List<RenFurAppVO> getAll() {
		return dao.getAll();
	}
	
	//因一張申請單家具全租或全退 所以查一個明細的解租日期即可知道目前的租借狀態 
	//查租借狀態方法
	public Byte getRenFurAppStatus(Integer rfa_no) {
		return dao.getRenFurAppStatus(rfa_no);
	}
	//因租家具明細有租屋合約欄位 此方法未取邊耗用 以查需寄送的物件地址
	public Integer getRentCon(Integer rfa_no) {
		return dao.getRentCon(rfa_no);
	}
}

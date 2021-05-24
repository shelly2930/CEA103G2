package com.renFurApp.model;

import java.sql.Timestamp;
import java.util.List;

import com.renFurDet.model.RenFurDetDAO;
import com.renFurDet.model.RenFurDetService;
import com.renFurDet.model.RenFurDetVO;

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

	public RenFurAppVO updateRenFurApp(Integer rfa_no, Integer emp_no, Timestamp rfa_order_date, Byte rfa_status) {
//		public RenFurAppVO updateRenFurApp(Integer rfa_no, Integer mem_no, Integer emp_no, Timestamp rfa_order_date,
//				Integer rfa_total, Byte rfa_status) {

		RenFurAppVO renFurAppVO = new RenFurAppVO();
		renFurAppVO.setRfa_no(rfa_no);
//		renFurAppVO.setMem_no(mem_no);
		renFurAppVO.setEmp_no(emp_no);
		renFurAppVO.setRfa_order_date(rfa_order_date);
//		renFurAppVO.setRfa_total(rfa_total);
//		renFurAppVO.setRfa_apct_date(rfa_apct_date);
		
		if(rfa_status == 2) {
			RenFurDetDAO renFurDetDAO = new RenFurDetDAO();
			List<RenFurDetVO> list = renFurDetDAO.getOneList(rfa_no);
			for(RenFurDetVO renFurDetVO : list) {
				renFurDetVO.setRent_date(new Timestamp(System.currentTimeMillis()));
				renFurDetDAO.update(renFurDetVO);
				System.out.println("�o!!!!!!");
			}
		} else {
			if(emp_no == 0)
				rfa_status = new Byte("0");
			else
				rfa_status = new Byte("1");
		}
		renFurAppVO.setRfa_status(rfa_status);

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
	
	//�]�@�i�ӽг�a������Υ��h �ҥH�d�@�ө��Ӫ��ѯ�����Y�i���D�ثe�����ɪ��A 
	//�d���ɪ��A��k
	public Byte getRenFurAppStatus(Integer rfa_no) {
		return dao.getRenFurAppStatus(rfa_no);
	}
	//�]���a����Ӧ����ΦX����� ����k������ӥ� �H�d�ݱH�e������a�}
	public Integer getRentCon(Integer rfa_no) {
		return dao.getRentCon(rfa_no);
	}
	// ���� �d�|�����Ҧ��ӽг�
	public List<RenFurAppVO> getAllByMem(Integer mem_no,Byte rfa_status) {
		return dao.getAllByMem(mem_no, rfa_status);
	}
}

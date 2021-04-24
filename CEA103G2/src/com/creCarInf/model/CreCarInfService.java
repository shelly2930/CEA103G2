package com.creCarInf.model;

import java.sql.Date;
import java.util.List;

public class CreCarInfService {
	
	private CreCarInfDAO_interface dao;

	public CreCarInfService() {
		dao = new CreCarInfDAO();
	}
	
	public CreCarInfVO addCreCarInf(Integer mem_no, String cci_name, String cci_id,
			Date cci_due, Integer cci_code) {

		CreCarInfVO creCarInfVO = new CreCarInfVO();

		creCarInfVO.setMem_no(mem_no);
		creCarInfVO.setCci_name(cci_name);
		creCarInfVO.setCci_id(cci_id);
		creCarInfVO.setCci_due(cci_due);
		creCarInfVO.setCci_code(cci_code);
		dao.insert(creCarInfVO);

		return creCarInfVO;
	}

	public CreCarInfVO updateCreCarInf(Integer cci_no, Integer mem_no, String cci_name, String cci_id,
			Date cci_due, Integer cci_code) {

		CreCarInfVO creCarInfVO = new CreCarInfVO();

		creCarInfVO.setCci_no(cci_no);
		creCarInfVO.setMem_no(mem_no);
		creCarInfVO.setCci_name(cci_name);
		creCarInfVO.setCci_id(cci_id);
		creCarInfVO.setCci_due(cci_due);
		creCarInfVO.setCci_code(cci_code);
		dao.update(creCarInfVO);

		return creCarInfVO;
	}
	
	public void deleteCreCarInf(Integer cci_no) {
		dao.delete(cci_no);
	}

	public CreCarInfVO getOneCreCarInf(Integer cci_no) {
		return dao.findByPrimaryKey(cci_no);
	}

	public List<CreCarInfVO> getAll() {
		return dao.getAll();
	}
}

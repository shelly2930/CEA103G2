package com.staRig.model;

import java.sql.Connection;
import java.util.List;

public class StaRigService {
	private StaRigDAO_interface srd;
	
	public StaRigService() {
		srd = new StaRigDAO();
	}
	
	public StaRigVO addStaRig(Integer emp_no, Integer fun_no, Connection con) {
		StaRigVO srv = new StaRigVO();
		
		srv.setEmp_no(emp_no);
		srv.setFun_no(fun_no);
		srd.insert(srv, con);;
		
		return srv;
	}
	
	public StaRigVO deleteStaRig(Integer emp_no, Integer fun_no, Connection con) {
		StaRigVO srv = new StaRigVO();
		
		srv.setEmp_no(emp_no);
		srv.setFun_no(fun_no);
		srd.delete(srv, con);;
		
		return srv;
	}
	
	public List<StaRigVO> getOneEmpStaRig(Integer emp_no) {
		return srd.getOne(emp_no);
	}
	
	public List<StaRigVO> getAllEmpStaRig() {
		return srd.getAll();
	}
	
}

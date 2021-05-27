package com.memTen.model;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.renCon.model.RenConVO;

public class MemTenService {
	private MemTenDAO_interface dao;
	
	public MemTenService() {
		dao = new MemTenDAO();
	}
	
	public MemTenVO addMemTen(String mem_username, String mem_password, byte[] mem_pic, String mem_name,
			Byte mem_gender, String mem_id, Date mem_birthday, String mem_phone, String mem_mobile,
			String mem_email, String mem_city, String mem_dist, String mem_addr) {
		
		MemTenVO memTenVO = new MemTenVO();
				
		memTenVO.setMem_username(mem_username);
		memTenVO.setMem_password(mem_password);
		memTenVO.setMem_pic(mem_pic);
		memTenVO.setMem_name(mem_name);
		memTenVO.setMem_gender(mem_gender);
		memTenVO.setMem_id(mem_id);
		memTenVO.setMem_birthday(mem_birthday);
		memTenVO.setMem_phone(mem_phone);
		memTenVO.setMem_mobile(mem_mobile);
		memTenVO.setMem_email(mem_email);
		memTenVO.setMem_city(mem_city);
		memTenVO.setMem_dist(mem_dist);
		memTenVO.setMem_addr(mem_addr);
		dao.insert(memTenVO);

		return memTenVO;
	}
	
	public MemTenVO updateMemTen(Integer mem_no,String mem_username, String mem_password, byte[] mem_pic,
			String mem_name, Byte mem_gender, String mem_id, Date mem_birthday, String mem_phone,
			String mem_mobile, String mem_email, String mem_city, String mem_dist, String mem_addr,
			byte[] mem_idcard_f, byte[] mem_idcard_r) {
		
		MemTenVO memTenVO = new MemTenVO();
		
		memTenVO.setMem_no(mem_no);		
		memTenVO.setMem_username(mem_username);
		memTenVO.setMem_password(mem_password);
		memTenVO.setMem_pic(mem_pic);
		memTenVO.setMem_name(mem_name);
		memTenVO.setMem_gender(mem_gender);
		memTenVO.setMem_id(mem_id);
		memTenVO.setMem_birthday(mem_birthday);
		memTenVO.setMem_phone(mem_phone);
		memTenVO.setMem_mobile(mem_mobile);
		memTenVO.setMem_email(mem_email);
		memTenVO.setMem_city(mem_city);
		memTenVO.setMem_dist(mem_dist);
		memTenVO.setMem_addr(mem_addr);
//		memTenVO.setMem_status(mem_status);
		memTenVO.setMem_idcard_f(mem_idcard_f);
		memTenVO.setMem_idcard_r(mem_idcard_r);
//		memTenVO.setMem_id_status(mem_id_status);
//		memTenVO.setMem_suspend(mem_suspend);
//		memTenVO.setMem_refuse(mem_refuse);		
		dao.update(memTenVO);

		return memTenVO;
	}
	
	public void deleteMemTen(Integer mem_no) {
		dao.delete(mem_no);
	}
	
	public MemTenVO getOneMemTen(Integer mem_no) {
		return dao.findByPrimaryKey(mem_no);
	}
	
	public List<MemTenVO> getAll() {
		return dao.getAll();
	}
	
	public MemTenVO loginCheck(String mem_username) {
		return dao.loginCheck(mem_username);
	}
	
	public void updateMemStatus(String mem_username, Byte mem_status) {
		dao.updateMemStatus(mem_username, mem_status);
	}
	
	public MemTenVO findByEmail(String mem_username,String mem_email) {
		return dao.findByEmail(mem_username,mem_email);
	}
	
	public void updatePwd(String mem_email, String mem_password) {
		dao.updatePwd(mem_email, mem_password);
	}
	
	public MemTenVO rentalConfirm(Integer mem_no, String mem_name, String mem_id, String mem_mobile,
			String mem_city, String mem_dist, String mem_addr, byte[] mem_idcard_f, byte[] mem_idcard_r, 
			byte mem_id_status) {
		
		MemTenVO memTenVO = new MemTenVO();
		
		memTenVO.setMem_no(mem_no);		
		memTenVO.setMem_name(mem_name);
		memTenVO.setMem_id(mem_id);
		memTenVO.setMem_mobile(mem_mobile);
		memTenVO.setMem_city(mem_city);
		memTenVO.setMem_dist(mem_dist);
		memTenVO.setMem_addr(mem_addr);
		memTenVO.setMem_idcard_f(mem_idcard_f);
		memTenVO.setMem_idcard_r(mem_idcard_r);
		memTenVO.setMem_id_status(mem_id_status);
		dao.rentalConfirm(memTenVO);

		return memTenVO;
	}
	
	//¹F
	public Byte judgelld(Integer mem_no) {
		return dao.judgelld(mem_no);
	}
}

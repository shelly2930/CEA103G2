package com.memTen.model;

import java.util.*;

import com.renCon.model.RenConVO;

public interface MemTenDAO_interface {
	public void insert(MemTenVO memTenVO);
	public void update(MemTenVO memTenVO);
	public void delete(Integer mem_no);
	public MemTenVO findByPrimaryKey(Integer mem_no);
	public List<MemTenVO> getAll();
	public MemTenVO loginCheck(String mem_username); // 會員登入
	public void updateMemStatus(String mem_username, Byte mem_status); // 新會員帳號驗證
	public MemTenVO findByEmail(String mem_email); // 忘記密碼
	public void updatePwd(String mem_email, String mem_password); // 改密碼
	public void rentalConfirm(MemTenVO memTenVO);
	public List<RenConVO> findBillMem();
	public Map<Integer,Integer> findBill(); 
	//敬達增加
	public Byte judgelld(Integer mem_no);
}

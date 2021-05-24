package com.memTen.model;

import java.util.*;

import com.renCon.model.RenConVO;

public interface MemTenDAO_interface {
	public void insert(MemTenVO memTenVO);
	public void update(MemTenVO memTenVO);
	public void delete(Integer mem_no);
	public MemTenVO findByPrimaryKey(Integer mem_no);
	public List<MemTenVO> getAll();
	public MemTenVO loginCheck(String mem_username); // �|���n�J
	public void updateMemStatus(String mem_username, Byte mem_status); // �s�|���b������
	public MemTenVO findByEmail(String mem_email); // �ѰO�K�X
	public void updatePwd(String mem_email, String mem_password); // ��K�X
	public void rentalConfirm(MemTenVO memTenVO);
	public List<RenConVO> findBillMem();
	public Map<Integer,Integer> findBill(); 
	//�q�F�W�[
	public Byte judgelld(Integer mem_no);
}

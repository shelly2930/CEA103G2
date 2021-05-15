package com.renCon.model;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

public interface RenConDAO_interface {
	public void insert(RenConVO renConVO);
    public void update(RenConVO renConVO);
    public void delete(Integer renConno);
    public RenConVO findByPrimaryKey(Integer renConno);
    public List<RenConVO> getAll();
//    ���F�s�J�Ϥ�
    public void listarImg(Integer picno, HttpServletResponse response);
    //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//  public List<RenConVO> getAll(Map<String, String[]> map); 
    public void insert2(RenConVO renConVO);
}

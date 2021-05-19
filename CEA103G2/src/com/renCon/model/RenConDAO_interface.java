package com.renCon.model;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.lanlord.model.LanlordVO;

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
    // ����
    public void insert2(RenConVO renConVO);
    public RenConVO findByPK(Integer rtct_no);
    public List<RenConVO> findByStatus(Byte rtct_status);
    public void updateStatus(RenConVO renConVO);
    //�q�F
    public List<Integer> getMem(RenConVO renConVO);
    public List<Integer> getMemHou(RenConVO renConVO);
    public List<Integer> getMemHouCon(RenConVO renConVO);
    public void updatePic(RenConVO renConVO);
    public byte[] getPic(Integer rtct_no);
    public List<RenConVO> getAllCon(RenConVO renConVO);
    public List<RenConVO> getAllByMem();
}

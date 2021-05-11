package com.rooVieApp.model;

import java.util.List;


public interface RooVieAppDAO_interface {
	public void insert(RooVieAppVO rooVieAppVO);
    public void update(RooVieAppVO rooVieAppVO);
    public void delete(Integer rooVieAppno);
    public RooVieAppVO findByPrimaryKey(Integer rooVieAppno);
    public List<RooVieAppVO> getAll();
    //�s�W�w���ɶ� 
    public void addpicktime(RooVieAppVO rooVieAppVO);
    //�����w���ɶ�by �|�� ���� ����ɶ�
    public void cancelpicktime(RooVieAppVO rooVieAppVO);
    //�d�ݩҦ��w���ɶ�by����s��
    public List<RooVieAppVO> listallpickTime(RooVieAppVO rooVieAppVO);
    //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//  public List<RooVieAppVO> getAll(Map<String, String[]> map); 
}

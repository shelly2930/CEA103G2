package com.rooVieApp.model;

import java.util.List;
import java.util.Map;
import java.sql.Timestamp;

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
    //�d�ݩҦ��w���ɶ�by����s��
    public List<RooVieAppVO> listallpickTime_noassign(RooVieAppVO rooVieAppVO);
    //�d�� �s�w�����ɶ�by����s��
    public List<RooVieAppVO> listNewPickTime();
    //�d�ݳ̷s�w�� ������
    public Map<Integer,Timestamp> listNewRooVieApp();
    //�����u �M�������u
    public void changeEmp(Integer emp_no,Byte rva_status,Integer rva_no);
    //�d�ݸӭ��u�Ҧ��t�d�w���M��
    public List<RooVieAppVO> getEmpApp(Integer emp_no);
    
    
}

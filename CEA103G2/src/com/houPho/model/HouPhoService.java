package com.houPho.model;

import java.util.List;



public class HouPhoService {
//	�ŧiDAO�����A�s��DAO����
//	������n�Τ����ŧi�A���F�n���@�A����DAO�p�G�ݭn�󴫡A�i�H�������gDAO�ӳo�̴N�����󴫹��鳡���Y�i
	private HouPhoDAO_interface dao;
//	�I�sEMPService�غc�l�A���Knew EmpDAO
	public HouPhoService() {
		dao = new HouPhoDAO();
	}
//��servlet�Q�n�w��emp���s�W�@����ơA�N�ݭn�I�s�H�U��k�A�öǹ������Ѽ�
	//V
	public HouPhoVO addHouPho(Integer hos_no, byte[] hos_pic) {
//�Ƕi�Ӫ��ѼơA���]�˦�VO�Ahow to do?
//���إ�vo����A�b�w��Ҧ��ݩʡA�i��set
		HouPhoVO houPhoVO = new HouPhoVO();
		houPhoVO.setHos_no(hos_no);
		houPhoVO.setHos_pic(hos_pic);
//��Ѽ��নvo����A�N�i�H�I�sdao�ӹ��Ʈw�i��insert
dao.insert(houPhoVO);
		return houPhoVO;
	}
	//V
	public HouPhoVO updateHouPho(Integer hos_pic_no, Integer hos_no, byte[] hos_pic) {

		HouPhoVO houPhoVO = new HouPhoVO();
		houPhoVO.setHos_pic_no(hos_pic_no);
		houPhoVO.setHos_no(hos_no);
		houPhoVO.setHos_pic(hos_pic);
		dao.update(houPhoVO);

		return houPhoVO;
	}
	//V
	public void deleteHouPho(Integer houPhono) {
		dao.delete(houPhono);
	}
	//V
	public HouPhoVO getOneHouPho(Integer houPhono) {
		return dao.findByPrimaryKey(houPhono);
	}
	//V
	public List<HouPhoVO> getHousenoAndHouPhono(){
		return dao.getHousenoAndHouPhono();
	}
}

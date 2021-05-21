package com.renCon.model;

import java.sql.Timestamp;
import java.util.List;

import com.houPho.model.HouPhoDAO;
import com.houPho.model.HouPhoDAO_interface;
import com.houPho.model.HouPhoVO;

public class RenConService {
//	�ŧiDAO�����A�s��DAO����
//	������n�Τ����ŧi�A���F�n���@�A����DAO�p�G�ݭn�󴫡A�i�H�������gDAO�ӳo�̴N�����󴫹��鳡���Y�i
	private RenConDAO_interface dao;
//	�I�sEMPService�غc�l�A���Knew EmpDAO
	public RenConService() {
		dao = new RenConDAO();
	}
//��servlet�Q�n�w��emp���s�W�@����ơA�N�ݭn�I�s�H�U��k�A�öǹ������Ѽ�
	public RenConVO addRenCon(Integer hos_no,Integer mem_no, java.sql.Date rtct_eff_date,
			java.sql.Date rtct_end_date,java.sql.Date rtct_tmt_date, byte[] rtct_pic,Integer rtct_deposit) {
//�Ƕi�Ӫ��ѼơA���]�˦�VO�Ahow to do?
//���إ�vo����A�b�w��Ҧ��ݩʡA�i��set
		RenConVO renConVO = new RenConVO();
		renConVO.setHos_no(hos_no);
		renConVO.setMem_no(mem_no);
		renConVO.setRtct_eff_date(rtct_eff_date);
		renConVO.setRtct_end_date(rtct_end_date);
		renConVO.setRtct_tmt_date(rtct_tmt_date);
		renConVO.setRtct_pic(rtct_pic);
		renConVO.setRtct_deposit(rtct_deposit);
//��Ѽ��নvo����A�N�i�H�I�sdao�ӹ��Ʈw�i��insert
		dao.insert(renConVO);
		return renConVO;
	}

	public RenConVO updateRenCon(Integer rtct_no, Integer hos_no,Integer mem_no, java.sql.Date rtct_eff_date,
			java.sql.Date rtct_end_date,java.sql.Date rtct_tmt_date, byte[] rtct_pic,Integer rtct_deposit) {

		RenConVO renConVO = new RenConVO();
		renConVO.setRtct_no(rtct_no);
		renConVO.setHos_no(hos_no);
		renConVO.setMem_no(mem_no);
		renConVO.setRtct_eff_date(rtct_eff_date);
		renConVO.setRtct_end_date(rtct_end_date);
		renConVO.setRtct_tmt_date(rtct_tmt_date);
		renConVO.setRtct_pic(rtct_pic);
		renConVO.setRtct_deposit(rtct_deposit);
		dao.update(renConVO);

		return renConVO;
	}

	public void deleteRenCon(Integer renConno) {
		dao.delete(renConno);
	}

	public RenConVO getOneRenCon(Integer renConno) {
		return dao.findByPrimaryKey(renConno);
	}

	public List<RenConVO> getAll() {
		return dao.getAll();
	}
	
/*===================== ���ηs�W ====================*/	
	public RenConVO addRenCon2(Integer hos_no,Integer mem_no, java.sql.Date rtct_eff_date,
			java.sql.Date rtct_end_date, Timestamp rtct_apptime, Integer rtct_deposit) {
		
		RenConVO renConVO = new RenConVO();
		renConVO.setHos_no(hos_no);
		renConVO.setMem_no(mem_no);
		renConVO.setRtct_eff_date(rtct_eff_date);
		renConVO.setRtct_end_date(rtct_end_date);
		renConVO.setRtct_apptime(rtct_apptime);
		renConVO.setRtct_deposit(rtct_deposit);
		dao.insert2(renConVO);
		return renConVO;
	}
	
	public RenConVO findByPK(Integer rtct_no) {
		return dao.findByPK(rtct_no);
	}
	
	public List<RenConVO> findByStatus(Byte rtct_status){
		return dao.findByStatus(rtct_status);
	}
	
	public RenConVO updateStatus(Integer rtct_no, Byte rtct_status) {
		RenConVO renConVO = new RenConVO();
		renConVO.setRtct_no(rtct_no);
		renConVO.setRtct_status(rtct_status);
		dao.updateStatus(renConVO);
		return renConVO;
	}
	
/*===================== ���ηs�W ====================*/	
	
	//�q�F
	public List<Integer> getMem(Byte status){
		RenConVO renConVO = new RenConVO();
		renConVO.setRtct_status(status);
		return dao.getMem(renConVO);
	}
	
	public List<Integer> getMemHou(Byte status,Integer mem_no){
		RenConVO renConVO = new RenConVO();
		renConVO.setRtct_status(status);
		renConVO.setMem_no(mem_no);
		return dao.getMemHou(renConVO);
	}
	public List<Integer> getMemHouCon(Byte status,Integer mem_no,Integer hos_no){
		RenConVO renConVO = new RenConVO();
		renConVO.setRtct_status(status);
		renConVO.setMem_no(mem_no);
		renConVO.setHos_no(hos_no);
		return dao.getMemHouCon(renConVO);
	}
	public List<RenConVO> getAllCon(Byte status,Integer mem_no){
		RenConVO renConVO = new RenConVO();
		renConVO.setRtct_status(status);
		renConVO.setMem_no(mem_no);
		return dao.getAllCon(renConVO);
	}
	public byte[] getPic(Integer rtct_no) {
		return dao.getPic(rtct_no);
	}
	public void updatePic(byte[] pic, Integer con_no) {
		RenConVO renConVO = new RenConVO();
		renConVO.setRtct_pic(pic);
		renConVO.setRtct_no(con_no);
		dao.updatePic(renConVO);
	}
	public List<RenConVO> getAllByMem() {
		return dao.getAllByMem();
	}
}

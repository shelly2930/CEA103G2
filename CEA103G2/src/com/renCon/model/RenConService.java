package com.renCon.model;

import java.util.List;

import com.houPho.model.HouPhoDAO;
import com.houPho.model.HouPhoDAO_interface;
import com.houPho.model.HouPhoVO;

public class RenConService {
//	宣告DAO介面，存放DAO實體
//	為什麼要用介面宣告，為了好維護，哪天DAO如果需要更換，可以直接重寫DAO而這裡就直接更換實體部分即可
	private RenConDAO_interface dao;
//	呼叫EMPService建構子，順便new EmpDAO
	public RenConService() {
		dao = new RenConDAO();
	}
//當servlet想要針對emp表格新增一筆資料，就需要呼叫以下方法，並傳對應欄位參數
	public RenConVO addRenCon(Integer hos_no,Integer mem_no, java.sql.Date rtct_eff_date,
			java.sql.Date rtct_end_date,java.sql.Date rtct_tmt_date, byte[] rtct_pic,Integer rtct_deposit) {
//傳進來的參數，先包裝成VO，how to do?
//先建立vo物件，在針對所有屬性，進行set
		RenConVO renConVO = new RenConVO();
		renConVO.setHos_no(hos_no);
		renConVO.setMem_no(mem_no);
		renConVO.setRtct_eff_date(rtct_eff_date);
		renConVO.setRtct_end_date(rtct_end_date);
		renConVO.setRtct_tmt_date(rtct_tmt_date);
		renConVO.setRtct_pic(rtct_pic);
		renConVO.setRtct_deposit(rtct_deposit);
//把參數轉成vo物件，就可以呼叫dao來對資料庫進行insert
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
}

package com.houPho.model;

import java.util.List;



public class HouPhoService {
//	宣告DAO介面，存放DAO實體
//	為什麼要用介面宣告，為了好維護，哪天DAO如果需要更換，可以直接重寫DAO而這裡就直接更換實體部分即可
	private HouPhoDAO_interface dao;
//	呼叫EMPService建構子，順便new EmpDAO
	public HouPhoService() {
		dao = new HouPhoDAO();
	}
//當servlet想要針對emp表格新增一筆資料，就需要呼叫以下方法，並傳對應欄位參數
	//V
	public HouPhoVO addHouPho(Integer hos_no, byte[] hos_pic) {
//傳進來的參數，先包裝成VO，how to do?
//先建立vo物件，在針對所有屬性，進行set
		HouPhoVO houPhoVO = new HouPhoVO();
		houPhoVO.setHos_no(hos_no);
		houPhoVO.setHos_pic(hos_pic);
//把參數轉成vo物件，就可以呼叫dao來對資料庫進行insert
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

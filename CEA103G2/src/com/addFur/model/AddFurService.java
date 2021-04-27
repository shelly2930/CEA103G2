package com.addFur.model;

import java.util.List;

public class AddFurService {
	AddFurDAO_interface dao = null;

	public AddFurService() {
		dao = new AddFurDAO();
	}
	public AddFurVO addAddFur(String add_fnt_name) {
		AddFurVO addFurVO = new AddFurVO();
		addFurVO.setAdd_fnt_name(add_fnt_name);
		
		dao.insert(addFurVO);
		return addFurVO;
	}

	public AddFurVO updateAddFur(Integer add_fnt_no, String add_fnt_name) {
		AddFurVO addFurVO = new AddFurVO();
		
		addFurVO.setAdd_fnt_no(add_fnt_no);
		addFurVO.setAdd_fnt_name(add_fnt_name);
		
		dao.update(addFurVO);
		return addFurVO;
	}

	public void deleteAddFur(Integer addFurno) {
		dao.delete(addFurno);
	}

	public AddFurVO getOneAddFur(Integer addFurno) {
		return dao.findByPrimaryKey(addFurno);
	}

	public List<AddFurVO> getAll() {
		return dao.getAll();
	}
}

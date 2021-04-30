package com.staFun.model;

import java.util.List;

public class StaFunService {
	private StaFunDAO_interface sfd;
	
	public StaFunService() {
		sfd = new StaFunDAO();
	}
	
	public List<StaFunVO> getAllStaFun() {
		return sfd.getAll();
	}
}

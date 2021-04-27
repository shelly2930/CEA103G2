package com.staFun.model;

import java.util.List;

public class StaFunServie {
	private StaFunDAO_interface sfd;
	
	public StaFunServie() {
		sfd = new StaFunDAO();
	}
	
	public List<StaFunVO> getAllStaFun() {
		return sfd.getAll();
	}
}

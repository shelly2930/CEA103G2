package com.notice.model;

import java.util.List;

public interface NoticeDAO_interface {

	public void insert (NoticeVO noticeVO);
	public void update (NoticeVO noticeVO);
	public void delete(Integer ntc_no);
	 public List<NoticeVO> findByMemKey(Integer mem_no);
	    public List<NoticeVO> getAll();
	
}

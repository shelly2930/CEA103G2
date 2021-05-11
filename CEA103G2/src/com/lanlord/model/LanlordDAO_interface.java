package com.lanlord.model;

import java.sql.Timestamp;
import java.util.*;

public interface LanlordDAO_interface {
	public void insert(LanlordVO lanlordVO);
	public void update(LanlordVO lanlordVO);
	public LanlordVO findByPrimaryKey(Integer lld_no);
	public List<LanlordVO> getAll();
	public LanlordVO findByMemTen(Integer mem_no);
	public List<LanlordVO> findByLldstatus(Byte lld_status);
	public void updatelldstatus(LanlordVO lanlordVO);
}

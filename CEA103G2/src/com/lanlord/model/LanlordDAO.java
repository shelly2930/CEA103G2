package com.lanlord.model;

import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.memTen.model.MemTenDAO_interface;
import com.memTen.model.MemTenVO;

public class LanlordDAO implements MemTenDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/HowTrueProject");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = "INSERT INTO LANLORD (lld_no, mem_no, lld_apptime, lld_bank,"
				+ " lld_account, lld_acc_pic, lld_status, lld_id_isvrfed, lld_id_disapprove, lld_suspend)"
				+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM LANLORD ORDER BY lli_no";
	private static final String GET_ONE_STMT = "SELECT * FROM LANLORD WHERE lli_no=?";
	private static final String UPDATE = "UPDATE LANLORD SET mem_no= ?, lld_apptime=?, lld_bank=?, lld_account=?,"
				+ " lld_acc_pic=?, lld_status=?, lld_id_isvrfed=?, lld_id_disapprove=?, lld_suspend=? WHERE lli_no =?";
	
	
	@Override
	public void insert(MemTenVO memTenVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(MemTenVO memTenVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(Integer mem_no) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MemTenVO findByPrimaryKey(Integer mem_no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MemTenVO> getAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MemTenVO loginCheck(String mem_username) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateMemStatus(String mem_username, Byte mem_status) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MemTenVO findByEmail(String mem_email) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updatePwd(String mem_email, String mem_password) {
		// TODO Auto-generated method stub
		
	}

}

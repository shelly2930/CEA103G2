package com.lanlord.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class LanlordDAO implements LanlordDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/HowTrueProject");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = "INSERT INTO LANLORD (mem_no, lld_apptime, lld_bank,"
				+ " lld_account, lld_acc_pic) VALUES (?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM LANLORD ORDER BY lld_no";
	private static final String GET_ONE_STMT = "SELECT * FROM LANLORD WHERE lld_no=?";
	private static final String UPDATE = "UPDATE LANLORD SET mem_no= ?, lld_bank=?, lld_account=?,"
				+ " lld_acc_pic=?, lld_status=?, lld_id_isvrfed=?, lld_id_disapprove=?, lld_suspend=? WHERE lld_no =?";
	private static final String FIND_BY_MEMTEN = "SELECT * FROM LANLORD WHERE mem_no=?";
	private static final String FIND_BY_LLDSTATUS = "SELECT * FROM LANLORD WHERE lld_status=?";
	private static final String FIND_BY_LLDSTATUS2 = "SELECT lld_no, mem_no, lld_status, lld_apptime, lld_id_isvrfed FROM LANLORD WHERE lld_status=?";
	private static final String UPDATE_LLDSTATUS = "UPDATE LANLORD SET lld_status=?, lld_id_isvrfed=?, "
				+ "lld_id_disapprove=? WHERE lld_no =?";
	
	
	@Override
	public void insert(LanlordVO lanlordVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, lanlordVO.getMem_no());
			pstmt.setTimestamp(2, lanlordVO.getLld_apptime());
			pstmt.setString(3, lanlordVO.getLld_bank());
			pstmt.setString(4, lanlordVO.getLld_account());
			pstmt.setBytes(5, lanlordVO.getLld_acc_pic());
			
			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
	@Override
	public void update(LanlordVO lanlordVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, lanlordVO.getMem_no());
			pstmt.setString(2, lanlordVO.getLld_bank());
			pstmt.setString(3, lanlordVO.getLld_account());
			pstmt.setBytes(4, lanlordVO.getLld_acc_pic());
			pstmt.setByte(5, lanlordVO.getLld_status());
			pstmt.setTimestamp(6, lanlordVO.getLld_id_isvrfed());
			pstmt.setString(7, lanlordVO.getLld_id_disapprove());
			pstmt.setString(8, lanlordVO.getLld_suspend());
			pstmt.setInt(9, lanlordVO.getLld_no());
			
			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}
	@Override
	public LanlordVO findByPrimaryKey(Integer lld_no) {
		LanlordVO lanlordVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, lld_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				lanlordVO = new LanlordVO();
				lanlordVO.setLld_no(rs.getInt("lld_no"));
				lanlordVO.setMem_no(rs.getInt("mem_no"));
				lanlordVO.setLld_apptime(rs.getTimestamp("lld_apptime"));
				lanlordVO.setLld_bank(rs.getString("lld_bank"));
				lanlordVO.setLld_account(rs.getString("lld_account"));
				lanlordVO.setLld_acc_pic(rs.getBytes("lld_acc_pic"));
				lanlordVO.setLld_status(rs.getByte("lld_status"));
				lanlordVO.setLld_id_isvrfed(rs.getTimestamp("lld_id_isvrfed"));
				lanlordVO.setLld_id_disapprove(rs.getString("lld_id_disapprove"));
				lanlordVO.setLld_suspend(rs.getString("lld_suspend"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return lanlordVO;
	}
	@Override
	public List<LanlordVO> getAll() {
		List<LanlordVO> list = new ArrayList<LanlordVO>();
		LanlordVO lanlordVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO �]�٬� Domain objects
				lanlordVO = new LanlordVO();
				lanlordVO.setLld_no(rs.getInt("lld_no"));
				lanlordVO.setMem_no(rs.getInt("mem_no"));
				lanlordVO.setLld_apptime(rs.getTimestamp("lld_apptime"));
				lanlordVO.setLld_bank(rs.getString("lld_bank"));
				lanlordVO.setLld_account(rs.getString("lld_account"));
				lanlordVO.setLld_acc_pic(rs.getBytes("lld_acc_pic"));
				lanlordVO.setLld_status(rs.getByte("lld_status"));
				lanlordVO.setLld_id_isvrfed(rs.getTimestamp("lld_id_isvrfed"));
				lanlordVO.setLld_id_disapprove(rs.getString("lld_id_disapprove"));
				lanlordVO.setLld_suspend(rs.getString("lld_suspend"));
				list.add(lanlordVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	@Override
	public LanlordVO findByMemTen(Integer mem_no) {
		LanlordVO lanlordVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_MEMTEN);

			pstmt.setInt(1, mem_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				lanlordVO = new LanlordVO();
				lanlordVO.setLld_no(rs.getInt("lld_no"));
				lanlordVO.setMem_no(rs.getInt("mem_no"));
				lanlordVO.setLld_apptime(rs.getTimestamp("lld_apptime"));
				lanlordVO.setLld_bank(rs.getString("lld_bank"));
				lanlordVO.setLld_account(rs.getString("lld_account"));
				lanlordVO.setLld_acc_pic(rs.getBytes("lld_acc_pic"));
				lanlordVO.setLld_status(rs.getByte("lld_status"));
				lanlordVO.setLld_id_isvrfed(rs.getTimestamp("lld_id_isvrfed"));
				lanlordVO.setLld_id_disapprove(rs.getString("lld_id_disapprove"));
				lanlordVO.setLld_suspend(rs.getString("lld_suspend"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return lanlordVO;
	}
	@Override
	public List<LanlordVO> findByLldstatus(Byte lld_status) {
		List<LanlordVO> list = new ArrayList<LanlordVO>();
		LanlordVO lanlordVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_LLDSTATUS);

			pstmt.setByte(1, lld_status);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				lanlordVO = new LanlordVO();
				lanlordVO.setLld_no(rs.getInt("lld_no"));
				lanlordVO.setMem_no(rs.getInt("mem_no"));
				lanlordVO.setLld_status(rs.getByte("lld_status"));
				lanlordVO.setLld_apptime(rs.getTimestamp("lld_apptime"));
				lanlordVO.setLld_bank(rs.getString("lld_bank"));
				lanlordVO.setLld_account(rs.getString("lld_account"));
				lanlordVO.setLld_acc_pic(rs.getBytes("lld_acc_pic"));
				lanlordVO.setLld_id_isvrfed(rs.getTimestamp("lld_id_isvrfed"));
				lanlordVO.setLld_id_disapprove(rs.getString("lld_id_disapprove"));
				lanlordVO.setLld_suspend(rs.getString("lld_suspend"));
				list.add(lanlordVO);
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	
	
	@Override
	public void updatelldstatus(LanlordVO lanlordVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_LLDSTATUS);
			pstmt.setByte(1, lanlordVO.getLld_status());
			pstmt.setTimestamp(2, lanlordVO.getLld_id_isvrfed());
			pstmt.setString(3, lanlordVO.getLld_id_disapprove());
			pstmt.setInt(4, lanlordVO.getLld_no());
			pstmt.executeUpdate();
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}
	
	
	
	
}

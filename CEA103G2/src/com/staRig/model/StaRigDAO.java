package com.staRig.model;

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

public class StaRigDAO implements StaRigDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/HowTrueProject");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT = "INSERT INTO STAFF_RIGHT(EMP_NO, FUN_NO) VALUES (?, ?)";
	private static final String DELETE = "DELETE FROM STAFF_RIGHT WHEWE EMP_NO = ? AND FUN_NO = ?";
	private static final String GETONE = "SELECT * FROM STAFF_RIGHT WHERE EMP_NO = ? ORDER BY FUN_NO";
	private static final String GETALL = "SELECT * FROM STAFF_RIGHT ORDER BY EMP_NO, FUN_NO";
	
	public void insert(StaRigVO srv) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
			
			pstmt.setInt(1, srv.getEmp_no());
			pstmt.setInt(2, srv.getFun_no());
			pstmt.executeQuery();
			
		} catch(SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
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

	public void delete(StaRigVO srv) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setInt(1, srv.getEmp_no());
			pstmt.setInt(2, srv.getFun_no());
			pstmt.executeQuery();
			
		} catch(SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
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

	public List<StaRigVO> getOne(Integer emp_no) {
		List<StaRigVO> list = new ArrayList<StaRigVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GETONE);
			pstmt.setInt(1, emp_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				StaRigVO srv = new StaRigVO();
				
				srv.setEmp_no(rs.getInt("EMP_NO"));
				srv.setFun_no(rs.getInt("FUN_NO"));
				list.add(srv);
			}
			
		} catch(SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
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

	public List<StaRigVO> getAll() {
		List<StaRigVO> list = new ArrayList<StaRigVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GETALL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				StaRigVO srv = new StaRigVO();
				
				srv.setEmp_no(rs.getInt("EMP_NO"));
				srv.setFun_no(rs.getInt("FUN_NO"));
				list.add(srv);
			}
			
		} catch(SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
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

}

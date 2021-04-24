package com.creCarInf.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CreCarInfDAO implements CreCarInfDAO_interface {
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/HowTrueProject");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = 
		"INSERT INTO CREDIT_CARD_INFO (mem_no, cci_name, cci_id, cci_due, cci_code)"
									+ " VALUES (?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT * FROM CREDIT_CARD_INFO ORDER BY cci_no";
	private static final String GET_ONE_STMT = 
		"SELECT * FROM CREDIT_CARD_INFO WHERE cci_no=?";
	private static final String DELETE = 
		"DELETE FROM CREDIT_CARD_INFO WHERE cci_no=?";
	private static final String UPDATE = 
		"UPDATE CREDIT_CARD_INFO SET mem_no= ?, cci_name=?, cci_id=?, cci_due=?, cci_code=? WHERE cci_no =?";
		
	@Override
	public void insert(CreCarInfVO creCarInfVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, creCarInfVO.getMem_no());
			pstmt.setString(2, creCarInfVO.getCci_name());
			pstmt.setString(3, creCarInfVO.getCci_id());
			pstmt.setDate(4, creCarInfVO.getCci_due());
			pstmt.setInt(5, creCarInfVO.getCci_code());

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
	public void update(CreCarInfVO creCarInfVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, creCarInfVO.getMem_no());
			pstmt.setString(2, creCarInfVO.getCci_name());
			pstmt.setString(3, creCarInfVO.getCci_id());
			pstmt.setDate(4, creCarInfVO.getCci_due());
			pstmt.setInt(5, creCarInfVO.getCci_code());
			pstmt.setInt(6, creCarInfVO.getCci_no());

			pstmt.executeUpdate();

			// Handle any driver errors
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
	public void delete(Integer cci_no) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, cci_no);

			pstmt.executeUpdate();

			// Handle any driver errors
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
	public CreCarInfVO findByPrimaryKey(Integer cci_no) {
		
		CreCarInfVO creCarInfVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, cci_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				creCarInfVO = new CreCarInfVO();
				creCarInfVO.setCci_no(rs.getInt("cci_no"));
				creCarInfVO.setMem_no(rs.getInt("mem_no"));
				creCarInfVO.setCci_name(rs.getString("cci_name"));
				creCarInfVO.setCci_id(rs.getString("cci_id"));
				creCarInfVO.setCci_due(rs.getDate("cci_due"));
				creCarInfVO.setCci_code(rs.getInt("cci_code"));
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
		return creCarInfVO;
	}
	
	@Override
	public List<CreCarInfVO> getAll() {
		List<CreCarInfVO> list = new ArrayList<CreCarInfVO>();
		CreCarInfVO creCarInfVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// creCarInfVO ¤]ºÙ¬° Domain objects
				creCarInfVO = new CreCarInfVO();
				creCarInfVO.setCci_no(rs.getInt("cci_no"));
				creCarInfVO.setMem_no(rs.getInt("mem_no"));
				creCarInfVO.setCci_name(rs.getString("cci_name"));
				creCarInfVO.setCci_id(rs.getString("cci_id"));
				creCarInfVO.setCci_due(rs.getDate("cci_due"));
				creCarInfVO.setCci_code(rs.getInt("cci_code"));
				list.add(creCarInfVO); // Store the row in the list
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
	
	
	
}

package com.renFurApp.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class RenFurAppDAO implements RenFurAppDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/HowTrueProject");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	private static final String TABLE="RENT_FURNITURE_APPLICATION";
	private static final String INSERT_ITEM="(mem_no,emp_no,rfa_order_date,rfa_total,rfa_apct_date,rfa_status)";
	private static final String UPDATE_ITEM="mem_no= ?,emp_no= ?,rfa_order_date= ?,rfa_total= ?,rfa_apct_date= ?,rfa_status= ?";
	private static final String PK="rfa_no";
	
	private static final String INSERT_STMT = 
		"INSERT INTO"+TABLE+INSERT_ITEM + 
		" VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT * FROM"+TABLE+ "order by fnt_it_no";
	private static final String GET_ONE_STMT = 
		"SELECT * FROM "+TABLE+"  where "+PK+"= ?";
	private static final String DELETE_LIST = 
		"DELETE FROM"+ TABLE+" where "+PK+"= ?";
	private static final String DELETE_DETAIL = 
			"DELETE FROM RENT_FURNTURE_DETAIL where "+PK+"= ?";
	private static final String UPDATE = 
		"UPDATE"+TABLE+" set "+UPDATE_ITEM+" where "+PK+" = ?";

	@Override
	public void insert(RenFurAppVO renFurAppVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			//由此開始改
			pstmt.setInt(1, renFurAppVO.getMem_no());
			pstmt.setInt(2, renFurAppVO.getEmp_no());
			pstmt.setTimestamp(3, renFurAppVO.getRfa_order_date());
			pstmt.setInt(4, renFurAppVO.getRfa_total());
			pstmt.setTimestamp(5, renFurAppVO.getRfa_apct_date());
			pstmt.setByte(6, renFurAppVO.getRfa_status());

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
	public void update(RenFurAppVO renFurAppVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setInt(1, renFurAppVO.getMem_no());
			pstmt.setInt(2, renFurAppVO.getEmp_no());
			pstmt.setTimestamp(3, renFurAppVO.getRfa_order_date());
			pstmt.setInt(4, renFurAppVO.getRfa_total());
			pstmt.setTimestamp(5, renFurAppVO.getRfa_apct_date());
			pstmt.setByte(6, renFurAppVO.getRfa_status());
			pstmt.setInt(7, renFurAppVO.getRfa_no());

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
	public void delete(Integer rfa_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			//刪申請單同步刪明細 交易控制 設定於pstmt.executeUpdate()之前
			con.setAutoCommit(false);
			
			//先刪除申請單明細
			pstmt = con.prepareStatement(DELETE_DETAIL);
			pstmt.setInt(1, rfa_no);
			pstmt.executeUpdate();
			//再刪除申請單
			pstmt = con.prepareStatement(DELETE_LIST);
			pstmt.setInt(1, rfa_no);
			pstmt.executeUpdate();
			//送出交易 並結束控制
			con.commit();
			con.setAutoCommit(true);

			// Handle any driver errors
		} catch (SQLException se) {
				try {
					//交易失敗時
					con.rollback();
				} catch(SQLException excep){
					throw new RuntimeException("Rollback error occured. "
							+ excep.getMessage());
				}
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
	public RenFurAppVO findByPrimaryKey(Integer rfa_no) {

		RenFurAppVO renFurAppVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, rfa_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				renFurAppVO = new RenFurAppVO();
				renFurAppVO.setRfa_no(rs.getInt("rfa_no"));
				renFurAppVO.setMem_no(rs.getInt("mem_no"));
				renFurAppVO.setEmp_no(rs.getInt("emp_no"));
				renFurAppVO.setRfa_order_date(rs.getTimestamp("rfa_order_date"));
				renFurAppVO.setRfa_total(rs.getInt("rfa_total"));
				renFurAppVO.setRfa_apct_date(rs.getTimestamp("rfa_apct_date"));
				renFurAppVO.setRfa_status(rs.getByte("rfa_status"));

			}

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
		return renFurAppVO;
	}

	@Override
	public List<RenFurAppVO> getAll() {
		List<RenFurAppVO> list = new ArrayList<RenFurAppVO>();
		RenFurAppVO renFurAppVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				renFurAppVO = new RenFurAppVO();
				renFurAppVO.setRfa_no(rs.getInt("rfa_no"));
				renFurAppVO.setMem_no(rs.getInt("mem_no"));
				renFurAppVO.setEmp_no(rs.getInt("emp_no"));
				renFurAppVO.setRfa_order_date(rs.getTimestamp("rfa_order_date"));
				renFurAppVO.setRfa_total(rs.getInt("rfa_total"));
				renFurAppVO.setRfa_apct_date(rs.getTimestamp("rfa_apct_date"));
				renFurAppVO.setRfa_status(rs.getByte("rfa_status"));
				list.add(renFurAppVO); // Store the row in the list
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
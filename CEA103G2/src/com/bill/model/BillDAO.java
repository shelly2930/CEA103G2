package com.bill.model;

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

import com.memTen.model.MemTenVO;

public class BillDAO implements BillDAO_interface {
	
	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
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
			"INSERT INTO BILL (mem_no, bill_date, bill_due, bill_power, bill_water)"
							+ " VALUES (?, ?, ?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT * FROM BILL ORDER BY bill_no";
		private static final String GET_ONE_STMT = 
			"SELECT * FROM BILL WHERE bill_no = ?";
		private static final String DELETE = 
			"DELETE FROM BILL WHERE bill_no = ?";
		private static final String UPDATE = 
			"UPDATE BILL SET mem_no=?, bill_date=?, bill_due=?, bill_power=?, bill_water=?,"
							+ " bill_p_status=?, bill_r_status=? WHERE bill_no =?";
		
		//東新增
		private static final String AUTO_INSERT = 
				"INSERT INTO BILL (mem_no, bill_date, bill_due)" + " VALUES (?, ?, ?)";
		private static final String IS_EXIST = 
				"SELECT * FROM BILL WHERE mem_no = ? and bill_date = ?";
		//東新增
	
	@Override
	public void insert(BillVO billVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, billVO.getMem_no());
			pstmt.setDate(2, billVO.getBill_date());
			pstmt.setDate(3, billVO.getBill_due());
			pstmt.setInt(4, billVO.getBill_power());
			pstmt.setInt(5, billVO.getBill_water());
			
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
	public void update(BillVO billVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, billVO.getMem_no());
			pstmt.setDate(2, billVO.getBill_date());
			pstmt.setDate(3, billVO.getBill_due());
			pstmt.setInt(4, billVO.getBill_power());
			pstmt.setInt(5, billVO.getBill_water());
			pstmt.setByte(6, billVO.getBill_p_status());
			pstmt.setByte(7, billVO.getBill_r_status());
			pstmt.setInt(8, billVO.getBill_no());
			
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
	public void delete(Integer bill_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, bill_no);

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
	public BillVO findByPrimaryKey(Integer bill_no) {
		BillVO billVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, bill_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				billVO = new BillVO();
				billVO.setBill_no(rs.getInt("bill_no"));
				billVO.setMem_no(rs.getInt("mem_no"));
				billVO.setBill_date(rs.getDate("bill_date"));
				billVO.setBill_due(rs.getDate("bill_due"));
				billVO.setBill_power(rs.getInt("bill_power"));
				billVO.setBill_water(rs.getInt("bill_water"));
				billVO.setBill_p_status(rs.getByte("bill_p_status"));
				billVO.setBill_r_status(rs.getByte("bill_r_status"));				
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
		return billVO;
	}

	@Override
	public List<BillVO> getAll() {
		List<BillVO> list = new ArrayList<BillVO>();
		BillVO billVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				billVO = new BillVO();
				billVO.setBill_no(rs.getInt("bill_no"));
				billVO.setMem_no(rs.getInt("mem_no"));
				billVO.setBill_date(rs.getDate("bill_date"));
				billVO.setBill_due(rs.getDate("bill_due"));
				billVO.setBill_power(rs.getInt("bill_power"));
				billVO.setBill_water(rs.getInt("bill_water"));
				billVO.setBill_p_status(rs.getByte("bill_p_status"));
				billVO.setBill_r_status(rs.getByte("bill_r_status"));
				list.add(billVO); // Store the row in the list
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
	public void autoInsert(BillVO billVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(AUTO_INSERT);

			pstmt.setInt(1, billVO.getMem_no());
			pstmt.setDate(2, billVO.getBill_date());
			pstmt.setDate(3, billVO.getBill_due());
			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public boolean isExist(Integer mem_no, java.sql.Date bill_date) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(IS_EXIST);
			pstmt.setInt(1, mem_no);
			pstmt.setDate(2, bill_date);
			rs = pstmt.executeQuery();

			return rs.next();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	}
	
}

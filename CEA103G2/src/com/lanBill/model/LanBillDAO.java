package com.lanBill.model;

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

public class LanBillDAO implements LanBillDAO_interface {
	
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
				"INSERT INTO LANLORD_BILL (lld_no, hos_no, lldb_date, lldb_due) VALUES (?, ?, ?, ?)";
		private static final String GET_ALL_STMT = 
				"SELECT * FROM LANLORD_BILL ORDER BY lldb_no";
		private static final String GET_ONE_STMT = 
				"SELECT * FROM LANLORD_BILL WHERE lldb_no = ?";
		private static final String UPDATE = 
				"UPDATE LANLORD_BILL SET lld_no=?, hos_no=?, lldb_date=?, lldb_due=?, lldb_status=? WHERE lldb_no=?";
		private static final String FIND_BY_STATUS =  
				"SELECT * FROM LANLORD_BILL WHERE lldb_status = ?";
		private static final String UPDATE_LLDSTATUS = "UPDATE LANLORD_BILL SET lldb_status=? WHERE lldb_no =?";
		
		@Override
		public void insert(LanBillVO lanBillVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(INSERT_STMT);

				pstmt.setInt(1, lanBillVO.getLld_no());
				pstmt.setInt(2, lanBillVO.getHos_no());
				pstmt.setDate(3, lanBillVO.getLldb_date());
				pstmt.setDate(4, lanBillVO.getLldb_due());
				
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
		public void update(LanBillVO lanBillVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				System.out.println("HI");
				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE);

				pstmt.setInt(1, lanBillVO.getLld_no());
				pstmt.setInt(2, lanBillVO.getHos_no());
				pstmt.setDate(3, lanBillVO.getLldb_date());
				pstmt.setDate(4, lanBillVO.getLldb_due());
				pstmt.setByte(5, lanBillVO.getLldb_status());
				pstmt.setInt(6, lanBillVO.getLldb_no());
				
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
		public LanBillVO findByPrimaryKey(Integer lldb_no) {
			LanBillVO lanBillVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ONE_STMT);

				pstmt.setInt(1, lldb_no);

				rs = pstmt.executeQuery();

				while (rs.next()) {
					lanBillVO = new LanBillVO();
					lanBillVO.setLldb_no(rs.getInt("lldb_no"));
					lanBillVO.setLld_no(rs.getInt("lld_no"));
					lanBillVO.setHos_no(rs.getInt("hos_no"));
					lanBillVO.setLldb_date(rs.getDate("lldb_date"));
					lanBillVO.setLldb_due(rs.getDate("lldb_due"));
					lanBillVO.setLldb_status(rs.getByte("lldb_status"));				
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
			return lanBillVO;
		}
		
		
		@Override
		public List<LanBillVO> getAll() {
			List<LanBillVO> list = new ArrayList<LanBillVO>();
			LanBillVO lanBillVO = null;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ALL_STMT);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					// empVO 也稱為 Domain objects
					lanBillVO = new LanBillVO();
					lanBillVO.setLldb_no(rs.getInt("lldb_no"));
					lanBillVO.setLld_no(rs.getInt("lld_no"));
					lanBillVO.setHos_no(rs.getInt("hos_no"));
					lanBillVO.setLldb_date(rs.getDate("lldb_date"));
					lanBillVO.setLldb_due(rs.getDate("lldb_due"));
					lanBillVO.setLldb_status(rs.getByte("lldb_status"));
					list.add(lanBillVO); // Store the row in the list
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
		public void updateStatus(LanBillVO lanBillVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE_LLDSTATUS);
				pstmt.setByte(1, lanBillVO.getLldb_status());
				pstmt.setInt(2, lanBillVO.getLldb_no());
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

package com.memTen.model;

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

public class MemTenDAO implements MemTenDAO_interface {
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
			"INSERT INTO MEMBER_TENANT (mem_username, mem_password, mem_pic, mem_name, mem_gender, mem_id,"
									+ " mem_birthday, mem_phone, mem_mobile, mem_email, mem_addr, mem_status,"
									+ " mem_id_status, mem_suspend, mem_refuse)"
									+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT * FROM MEMBER_TENANT ORDER BY mem_no";
		private static final String GET_ONE_STMT = 
			"SELECT * FROM MEMBER_TENANT WHERE mem_no = ?";
		private static final String DELETE = 
				"DELETE FROM MEMBER_TENANT WHERE mem_no = ?";
		private static final String UPDATE = 
			"UPDATE MEMBER_TENANT SET mem_username=?, mem_password=?, mem_pic=?, mem_name=?, mem_gender=?, mem_id=?,"
									+ " mem_birthday=?, mem_phone=?, mem_mobile=?, mem_email=?, mem_addr=? WHERE mem_no = ?";
//		public static final String GET_ONE_PIC = // 不能用private // 多餘的?
//				"SELECT mem_pic FROM MEMBER_TENANT WHERE mem_no = ?";
		
		@Override
		public void insert(MemTenVO memTenVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(INSERT_STMT);

				pstmt.setString(1, memTenVO.getMem_username());
				pstmt.setString(2, memTenVO.getMem_password());
				pstmt.setBytes(3, memTenVO.getMem_pic());
				pstmt.setString(4, memTenVO.getMem_name());
				pstmt.setByte(5, memTenVO.getMem_gender());
				pstmt.setString(6, memTenVO.getMem_id());
				pstmt.setDate(7, memTenVO.getMem_birthday());
				pstmt.setString(8, memTenVO.getMem_phone());
				pstmt.setString(9, memTenVO.getMem_mobile());
				pstmt.setString(10, memTenVO.getMem_email());
				pstmt.setString(11, memTenVO.getMem_addr());
				pstmt.setByte(12, memTenVO.getMem_status());
//				pstmt.setBytes(13, memTenVO.getMem_idcard_f());
//				pstmt.setBytes(14, memTenVO.getMem_idcard_r());
				pstmt.setByte(13, memTenVO.getMem_id_status());
				pstmt.setString(14, memTenVO.getMem_suspend());
				pstmt.setString(15, memTenVO.getMem_refuse());
				
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
		public void delete(Integer mem_no) {
			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(DELETE);

				pstmt.setInt(1, mem_no);

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
		public void update(MemTenVO memTenVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE);

				pstmt.setString(1, memTenVO.getMem_username());
				pstmt.setString(2, memTenVO.getMem_password());
				pstmt.setBytes(3, memTenVO.getMem_pic());
				pstmt.setString(4, memTenVO.getMem_name());
				pstmt.setByte(5, memTenVO.getMem_gender());
				pstmt.setString(6, memTenVO.getMem_id());
				pstmt.setDate(7, memTenVO.getMem_birthday());
				pstmt.setString(8, memTenVO.getMem_phone());
				pstmt.setString(9, memTenVO.getMem_mobile());
				pstmt.setString(10, memTenVO.getMem_email());
				pstmt.setString(11, memTenVO.getMem_addr());
//				pstmt.setByte(12, memTenVO.getMem_status());
//				pstmt.setBytes(13, memTenVO.getMem_idcard_f());
//				pstmt.setBytes(14, memTenVO.getMem_idcard_r());
//				pstmt.setByte(13, memTenVO.getMem_id_status());
//				pstmt.setString(12, memTenVO.getMem_suspend());
//				pstmt.setString(13, memTenVO.getMem_refuse());
				pstmt.setInt(12, memTenVO.getMem_no());
				
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
		public MemTenVO findByPrimaryKey(Integer mem_no) {
			MemTenVO memTenVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ONE_STMT);

				pstmt.setInt(1, mem_no);

				rs = pstmt.executeQuery();

				while (rs.next()) {
					memTenVO = new MemTenVO();
					memTenVO.setMem_no(rs.getInt("mem_no"));
					memTenVO.setMem_username(rs.getString("mem_username"));
					memTenVO.setMem_password(rs.getString("mem_password"));
					memTenVO.setMem_pic(rs.getBytes("mem_pic"));
					memTenVO.setMem_name(rs.getString("mem_name"));
					memTenVO.setMem_gender(rs.getByte("mem_gender"));
					memTenVO.setMem_id(rs.getString("mem_id"));
					memTenVO.setMem_birthday(rs.getDate("mem_birthday"));
					memTenVO.setMem_phone(rs.getString("mem_phone"));
					memTenVO.setMem_mobile(rs.getString("mem_mobile"));
					memTenVO.setMem_email(rs.getString("mem_email"));
					memTenVO.setMem_addr(rs.getString("mem_addr"));
					memTenVO.setMem_status(rs.getByte("mem_status"));
					memTenVO.setMem_idcard_f(rs.getBytes("mem_idcard_f"));
					memTenVO.setMem_idcard_r(rs.getBytes("mem_idcard_r"));
					memTenVO.setMem_id_status(rs.getByte("mem_id_status"));
					memTenVO.setMem_suspend(rs.getString("mem_suspend"));
					memTenVO.setMem_refuse(rs.getString("mem_refuse"));
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
			return memTenVO;
		}
		
		@Override
		public List<MemTenVO> getAll() {
			List<MemTenVO> list = new ArrayList<MemTenVO>();
			MemTenVO memTenVO = null;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ALL_STMT);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					// empVO 也稱為 Domain objects
					memTenVO = new MemTenVO();
					memTenVO.setMem_no(rs.getInt("mem_no"));
					memTenVO.setMem_username(rs.getString("mem_username"));
					memTenVO.setMem_password(rs.getString("mem_password"));
					memTenVO.setMem_pic(rs.getBytes("mem_pic"));
					memTenVO.setMem_name(rs.getString("mem_name"));
					memTenVO.setMem_gender(rs.getByte("mem_gender"));
					memTenVO.setMem_id(rs.getString("mem_id"));
					memTenVO.setMem_birthday(rs.getDate("mem_birthday"));
					memTenVO.setMem_phone(rs.getString("mem_phone"));
					memTenVO.setMem_mobile(rs.getString("mem_mobile"));
					memTenVO.setMem_email(rs.getString("mem_email"));
					memTenVO.setMem_addr(rs.getString("mem_addr"));
					memTenVO.setMem_status(rs.getByte("mem_status"));
					memTenVO.setMem_idcard_f(rs.getBytes("mem_idcard_f"));
					memTenVO.setMem_idcard_r(rs.getBytes("mem_idcard_r"));
					memTenVO.setMem_id_status(rs.getByte("mem_id_status"));
					memTenVO.setMem_suspend(rs.getString("mem_suspend"));
					memTenVO.setMem_refuse(rs.getString("mem_refuse"));
					list.add(memTenVO); // Store the row in the list
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

package com.memTen.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.renCon.model.RenConVO;

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
		
		private static final String INSERT_STMT = "INSERT INTO MEMBER_TENANT (mem_username, mem_password, mem_pic,"
									+ " mem_name, mem_gender, mem_id, mem_birthday, mem_phone, mem_mobile, mem_email,"
									+ " mem_city, mem_dist, mem_addr) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		private static final String GET_ALL_STMT = "SELECT * FROM MEMBER_TENANT ORDER BY mem_no";
		private static final String GET_ONE_STMT = "SELECT * FROM MEMBER_TENANT WHERE mem_no = ?";
		private static final String DELETE = "DELETE FROM MEMBER_TENANT WHERE mem_no = ?";
		private static final String UPDATE = "UPDATE MEMBER_TENANT SET mem_password=?, mem_pic=?,"
									+ " mem_name=?, mem_gender=?, mem_id=?, mem_birthday=?, mem_phone=?,"
									+ " mem_mobile=?, mem_email=?, mem_city=?, mem_dist=?, mem_addr=?, mem_idcard_f=?,"
									+ " mem_idcard_r=? WHERE mem_no=?";
		private static final String LOGIN_STMT = "SELECT * FROM MEMBER_TENANT WHERE mem_username=?";
		private static final String FIND_BY_EMAIL = "SELECT * FROM MEMBER_TENANT WHERE mem_email=?";
		private static final String UPDATE_PWD_BY_EMAIL = "UPDATE MEMBER_TENANT set mem_password=? WHERE mem_email=?";
		private static final String UPDATE_MEMSTATUS = "UPDATE MEMBER_TENANT SET mem_status=? WHERE mem_username=?";
		private static final String RENTAL_CONFIRM = "UPDATE MEMBER_TENANT SET mem_name=?, mem_id=?, mem_mobile=?, mem_city=?, mem_dist=?,"
									+ " mem_addr=?, mem_idcard_f=?, mem_idcard_r=?, mem_id_status=? WHERE mem_no=?";
		private static final String UPDATE_MEM_ID_STATUS = "UPDATE MEMBER_TENANT SET mem_id_status=? WHERE mem_no=?";
		//敬達增加
		private static final String JUDGELLD = "SELECT COUNT(*) AS JUDGE FROM HOWTRUE.MEMBER_TENANT M LEFT JOIN LANLORD L ON M.MEM_NO = L.MEM_NO WHERE M.MEM_NO=? AND LLD_STATUS =1";
		
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
				pstmt.setString(11, memTenVO.getMem_city());
				pstmt.setString(12, memTenVO.getMem_dist());
				pstmt.setString(13, memTenVO.getMem_addr());
				
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

//				pstmt.setString(1, memTenVO.getMem_username());
				pstmt.setString(1, memTenVO.getMem_password());
				pstmt.setBytes(2, memTenVO.getMem_pic());
				pstmt.setString(3, memTenVO.getMem_name());
				pstmt.setByte(4, memTenVO.getMem_gender());
				pstmt.setString(5, memTenVO.getMem_id());
				pstmt.setDate(6, memTenVO.getMem_birthday());
				pstmt.setString(7, memTenVO.getMem_phone());
				pstmt.setString(8, memTenVO.getMem_mobile());
				pstmt.setString(9, memTenVO.getMem_email());
				pstmt.setString(10, memTenVO.getMem_city());
				pstmt.setString(11, memTenVO.getMem_dist());
				pstmt.setString(12, memTenVO.getMem_addr());
//				pstmt.setByte(12, memTenVO.getMem_status());
				pstmt.setBytes(13, memTenVO.getMem_idcard_f());
				pstmt.setBytes(14, memTenVO.getMem_idcard_r());
//				pstmt.setByte(13, memTenVO.getMem_id_status());
//				pstmt.setString(12, memTenVO.getMem_suspend());
//				pstmt.setString(13, memTenVO.getMem_refuse());
				pstmt.setInt(15, memTenVO.getMem_no());
				
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
					memTenVO.setMem_city(rs.getString("mem_city"));
					memTenVO.setMem_dist(rs.getString("mem_dist"));
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
					memTenVO.setMem_city(rs.getString("mem_city"));
					memTenVO.setMem_dist(rs.getString("mem_dist"));
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
		
		public MemTenVO loginCheck(String mem_username) {
			MemTenVO memTenVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(LOGIN_STMT);
				
				pstmt.setString(1, mem_username);
				
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
					memTenVO.setMem_city(rs.getString("mem_city"));
					memTenVO.setMem_dist(rs.getString("mem_dist"));
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
				throw new RuntimeException("A database error occured. " + se.getMessage());
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
		
		public MemTenVO findByEmail(String mem_email) {
			MemTenVO memTenVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(FIND_BY_EMAIL);
	
				pstmt.setString(1, mem_email);
	
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
					memTenVO.setMem_city(rs.getString("mem_city"));
					memTenVO.setMem_dist(rs.getString("mem_dist"));
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
		
		
		public void updatePwd(String mem_email, String mem_password) {
			
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				
				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE_PWD_BY_EMAIL);

				pstmt.setString(1, mem_password);
				pstmt.setString(2, mem_email);
				
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
		
		
		public void updateMemStatus(String mem_username, Byte mem_status) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE_MEMSTATUS);

				pstmt.setByte(1, mem_status);
				pstmt.setString(2, mem_username);
				
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
		public void rentalConfirm(MemTenVO memTenVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(RENTAL_CONFIRM);

				pstmt.setString(1, memTenVO.getMem_name());
				pstmt.setString(2, memTenVO.getMem_id());
				pstmt.setString(3, memTenVO.getMem_mobile());
				pstmt.setString(4, memTenVO.getMem_city());
				pstmt.setString(5, memTenVO.getMem_dist());
				pstmt.setString(6, memTenVO.getMem_addr());
				pstmt.setBytes(7, memTenVO.getMem_idcard_f());
				pstmt.setBytes(8, memTenVO.getMem_idcard_r());
				pstmt.setByte(9, memTenVO.getMem_id_status());
				pstmt.setInt(10, memTenVO.getMem_no());
				
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

		//達
		@Override
		public Byte judgelld(Integer mem_no) {
			Byte lld_status = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(JUDGELLD);
				pstmt.setInt(1, mem_no);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					lld_status = rs.getByte("JUDGE");
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
			return lld_status;
		}

}

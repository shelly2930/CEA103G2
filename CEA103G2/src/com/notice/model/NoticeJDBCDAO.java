package com.notice.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NoticeJDBCDAO implements NoticeDAO_interface {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/HOWTRUE?serverTimezone=Asia/Taipei";
	String userid = "David";
	String passwd = "123456";

	private static final String INSERT_STMT = "INSERT INTO notice (mem_no, ntc_content, ntc_read) VALUES (?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT ntc_no, mem_no, ntc_time, ntc_content, ntc_read FROM notice order by ntc_time";
	private static final String GET_All_BY_MEM_STMT = "SELECT ntc_no, mem_no, ntc_time, ntc_content, ntc_read FROM notice where mem_no = ?";
	private static final String DELETE = "DELETE FROM notice where ntc_no = ?";
	private static final String UPDATE = "UPDATE notice set ntc_no=?, mem_no=?, ntc_time=?, ntc_content=?, ntc_read=? where ntc_no = ?";

	public void insert(NoticeVO noticeVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, noticeVO.getMem_no());
			pstmt.setString(2, noticeVO.getNtc_content());
			pstmt.setByte(3, noticeVO.getNtc_read());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	public void update(NoticeVO noticeVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);

			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, noticeVO.getNtc_no());
			pstmt.setInt(2, noticeVO.getMem_no());
			pstmt.setTimestamp(3, noticeVO.getNtc_time());
			pstmt.setString(4, noticeVO.getNtc_content());
			pstmt.setByte(5, noticeVO.getNtc_read());
			pstmt.setInt(6, noticeVO.getNtc_no());

			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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

	public void delete(Integer ntc_no) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, ntc_no);

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	
	public List<NoticeVO> findByMemKey(Integer mem_no) {
		// TODO Auto-generated method stub
		List<NoticeVO> list = new ArrayList<NoticeVO>();
		NoticeVO noticeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_All_BY_MEM_STMT);
			
			pstmt.setInt(1, mem_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				noticeVO = new NoticeVO();
				noticeVO.setNtc_no(rs.getInt("ntc_no"));
				noticeVO.setMem_no(rs.getInt("mem_no"));
				noticeVO.setNtc_time(rs.getTimestamp("ntc_time"));
				noticeVO.setNtc_content(rs.getNString("ntc_content"));
				noticeVO.setNtc_read(rs.getByte("ntc_read"));
				
				list.add(noticeVO);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
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
		return list;
	}

	public List<NoticeVO> getAll() {
		// TODO Auto-generated method stub
		List<NoticeVO> list = new ArrayList<NoticeVO>();
		NoticeVO noticeVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				noticeVO = new NoticeVO();
				noticeVO.setNtc_no(rs.getInt("ntc_no"));
				noticeVO.setMem_no(rs.getInt("mem_no"));
				noticeVO.setNtc_time(rs.getTimestamp("ntc_time"));
				noticeVO.setNtc_content(rs.getNString("ntc_content"));
				noticeVO.setNtc_read(rs.getByte("ntc_read"));

				list.add(noticeVO);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
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
		return list;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		NoticeJDBCDAO dao = new NoticeJDBCDAO();

//		NoticeVO noticeVO1 = new NoticeVO();
//		noticeVO1.setMem_no(1);
//		noticeVO1.setNtc_content("TEST DATA");
//		noticeVO1.setNtc_read((byte) 1);
//		dao.insert(noticeVO1);
//		//新增OK

//		NoticeVO noticeVO2 = new NoticeVO();
//		noticeVO2.setNtc_no(1);
//		noticeVO2.setMem_no(7);
//		noticeVO2.setNtc_time(java.sql.Timestamp.valueOf("2020-03-04 20:20:20"));
//		noticeVO2.setNtc_content("你倒是給我改進去阿!!!");
//		noticeVO2.setNtc_read((byte) 1);
//		
//		dao.update(noticeVO2);
//		//修改OK

//		dao.delete(1);
//		//刪除OK
		
		

		List<NoticeVO> list = dao.findByMemKey(7);
		for(NoticeVO bNtc : list) {
			System.out.println("通知編號: "+bNtc.getNtc_no()+",");
			System.out.println("會員編號: "+bNtc.getMem_no()+",");
			System.out.println("通知時間: "+bNtc.getNtc_time()+",");
			System.out.println("通知內容: "+bNtc.getNtc_content()+",");
			System.out.println("通知已讀否: "+bNtc.getNtc_read());
			System.out.println("==========================");
			
//			//查詢一個mem_no的通知
		}
		
//		List<NoticeVO> list = dao.getAll();
//		for(NoticeVO aNtc : list) {
//			System.out.println("通知編號: "+aNtc.getNtc_no()+",");
//			System.out.println("會員編號: "+aNtc.getMem_no()+",");
//			System.out.println("通知時間: "+aNtc.getNtc_time()+",");
//			System.out.println("通知內容: "+aNtc.getNtc_content()+",");
//			System.out.println("通知已讀否: "+aNtc.getNtc_read());
//			System.out.println("==========================");
//		}
		
	}

}

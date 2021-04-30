package com.notice.model;

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

public class NoticeDAO implements NoticeDAO_interface {
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/HowTrueProject");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}


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
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, noticeVO.getMem_no());
			pstmt.setString(2, noticeVO.getNtc_content());
			pstmt.setByte(3, noticeVO.getNtc_read());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public void update(NoticeVO noticeVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

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
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, ntc_no);

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	
	public List<NoticeVO> findByMemKey(Integer mem_no) {
		// TODO Auto-generated method stub
		List<NoticeVO> list = new ArrayList<NoticeVO>();
		NoticeVO noticeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
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
}
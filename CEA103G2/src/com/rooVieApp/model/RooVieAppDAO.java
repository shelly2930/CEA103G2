package com.rooVieApp.model;

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

import com.renCon.model.RenConVO;

public class RooVieAppDAO implements RooVieAppDAO_interface{
	private static DataSource ds = null;
	private static String qm = "?";
//	COUNTQUESTION用在insert需要幾個?(不含PK)
	private static final int COUNTQUESTION = 7; 
	static {
		for(int i =0;i<COUNTQUESTION-1;i++) {
			qm+=",?";
		}
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/HowTrueProject");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	private static final String TABLE = "ROOM_VIEWING_APPLICATION";
	private static final String PK = "rva_no";
	private static final String QUESTIONMARKS = qm; 
	private static final String REDUCE_PK_COL = "mem_no, " + 
			"hos_no, " + 
			"emp_no, "+
			"rva_app_time, "+
			"rva_order_time, "+ 
			"rva_end_time, "+
			"rva_status ";
	private static final String TOTAL_COL = "rva_no, "+REDUCE_PK_COL;
	private static final String FOR_SET = "mem_no=?, " + 
			"hos_no=?, " + 
			"emp_no=?, "+
			"rva_app_time=?, "+
			"rva_order_time=?, "+ 
			"rva_end_time=?, "+
			"rva_status=? ";

	private static final String INSERT = "INSERT INTO " + TABLE + "(" + REDUCE_PK_COL + ") VALUES ("+QUESTIONMARKS+")";
	private static final String GET_ALL = "SELECT " + TOTAL_COL + " FROM " + TABLE + " order by " + PK;
	private static final String GET_ONE = "SELECT " + TOTAL_COL + " FROM " + TABLE + " where " + PK + "= ?";
	private static final String DELETE = "DELETE FROM " + TABLE + " where +" + PK + "= ?";
	private static final String UPDATE = "UPDATE " + TABLE + " set "+FOR_SET+" where " + PK + "=?";

	@Override
	public void insert(RooVieAppVO rooVieAppVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
//		========VO取值並設給preparedStatement=============
			pstmt.setInt(1,rooVieAppVO.getMem_no());
			pstmt.setInt(2, rooVieAppVO.getHos_no());
			pstmt.setInt(3,rooVieAppVO.getEmp_no());
			pstmt.setDate(4,rooVieAppVO.getRva_app_time());
			pstmt.setDate(5,rooVieAppVO.getRva_order_time());
			pstmt.setDate(6,rooVieAppVO.getRva_end_time());
			pstmt.setByte(7,rooVieAppVO.getRva_status());
//	   =================送出指令========================
			pstmt.executeUpdate();
		} catch (SQLException e) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
			throw new RuntimeException("資料庫發生錯誤! "
					+ e.getMessage());
		}finally {
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
	public void update(RooVieAppVO rooVieAppVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			

//		========VO取值並設給preparedStatement=============
			pstmt.setInt(1,rooVieAppVO.getMem_no());
			pstmt.setInt(2, rooVieAppVO.getHos_no());
			pstmt.setInt(3,rooVieAppVO.getEmp_no());
			pstmt.setDate(4,rooVieAppVO.getRva_app_time());
			pstmt.setDate(5,rooVieAppVO.getRva_order_time());
			pstmt.setDate(6,rooVieAppVO.getRva_end_time());
			pstmt.setByte(7,rooVieAppVO.getRva_status());
			pstmt.setInt(8,rooVieAppVO.getRva_no());
//	   =================送出指令========================
			pstmt.executeUpdate();
		} catch (SQLException e) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
			throw new RuntimeException("資料庫發生錯誤! "
					+ e.getMessage());
		}finally {
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
	public void delete(Integer rooVieAppno) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, rooVieAppno);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
			throw new RuntimeException("資料庫發生錯誤! "
					+ se.getMessage());
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
	public RooVieAppVO findByPrimaryKey(Integer rooVieAppno) {
		RooVieAppVO rooVieAppVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE);

			pstmt.setInt(1, rooVieAppno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				rooVieAppVO  = new RooVieAppVO();
				rooVieAppVO.setRva_no(rs.getInt("rva_no"));
				rooVieAppVO.setMem_no(rs.getInt("mem_no"));
				rooVieAppVO.setHos_no(rs.getInt("hos_no"));
				rooVieAppVO.setEmp_no(rs.getInt("emp_no"));
				rooVieAppVO.setRva_app_time(rs.getDate("rva_app_time"));
				rooVieAppVO.setRva_order_time(rs.getDate("rva_order_time"));
				rooVieAppVO.setRva_end_time(rs.getDate("rva_end_time"));
				rooVieAppVO.setRva_status(rs.getByte("rva_status"));
//				===================
			}
		} catch (SQLException se) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
			throw new RuntimeException("資料庫發生錯誤! "
					+ se.getMessage());
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
		return rooVieAppVO;
	}

	@Override
	public List<RooVieAppVO> getAll() {
		List<RooVieAppVO> list = new ArrayList<RooVieAppVO>();
		RooVieAppVO rooVieAppVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				rooVieAppVO = new RooVieAppVO();
				rooVieAppVO.setRva_no(rs.getInt("rva_no"));
				rooVieAppVO.setMem_no(rs.getInt("mem_no"));
				rooVieAppVO.setHos_no(rs.getInt("hos_no"));
				rooVieAppVO.setEmp_no(rs.getInt("emp_no"));
				rooVieAppVO.setRva_app_time(rs.getDate("rva_app_time"));
				rooVieAppVO.setRva_order_time(rs.getDate("rva_order_time"));
				rooVieAppVO.setRva_end_time(rs.getDate("rva_end_time"));
				rooVieAppVO.setRva_status(rs.getByte("rva_status"));
				list.add(rooVieAppVO); // Store the row in the list
			}
			// Handle any driver errors
		} catch (SQLException se) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
			throw new RuntimeException("資料庫發生錯誤! "
					+ se.getMessage());
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

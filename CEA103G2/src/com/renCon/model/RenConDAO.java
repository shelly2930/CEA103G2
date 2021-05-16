package com.renCon.model;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.houPho.model.HouPhoVO;

public class RenConDAO implements RenConDAO_interface{
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
	private static final String TABLE = "RENTAL_CONTRACT";
	private static final String PK = "rtct_no";
	private static final String QUESTIONMARKS = qm; 
	private static final String REDUCE_PK_COL = "hos_no, " + 
			"mem_no, " + 
			"rtct_eff_date, "+
			"rtct_end_date, "+
			"rtct_tmt_date, "+ 
			"rtct_pic, "+
			"rtct_deposit ";
	private static final String TOTAL_COL = "rtct_no, "+REDUCE_PK_COL;
	private static final String FOR_SET = "hos_no=?, " + 
			"mem_no=?, " + 
			"rtct_eff_date=?, "+
			"rtct_end_date=?, "+
			"rtct_tmt_date=?, "+ 
			"rtct_pic=?, "+
			"rtct_deposit=? ";

	private static final String INSERT = "INSERT INTO " + TABLE + "(" + REDUCE_PK_COL + ") VALUES ("+QUESTIONMARKS+")";
	// 蔡佳
	private static final String INSERT2 = "INSERT INTO RENTAL_CONTRACT (hos_no, mem_no, rtct_deposit) VALUES (?, ?, ?)";
//	private static final String GET_ALL = "SELECT " + TOTAL_COL + " FROM " + TABLE + " order by " + PK;
	private static final String GET_ALL = "SELECT " + TOTAL_COL + " FROM " + TABLE + " order by rtct_eff_date desc";
	private static final String GET_ONE = "SELECT " + TOTAL_COL + " FROM " + TABLE + " where " + PK + "= ?";
	private static final String DELETE = "DELETE FROM " + TABLE + " where +" + PK + "= ?";
	private static final String UPDATE = "UPDATE " + TABLE + " set "+FOR_SET+" where " + PK + "=?";

	@Override
	public void insert(RenConVO renConVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
//		========VO取值並設給preparedStatement=============
			pstmt.setInt(1,renConVO.getHos_no());
			pstmt.setInt(2, renConVO.getMem_no());
			pstmt.setDate(3,renConVO.getRtct_eff_date());
			pstmt.setDate(4,renConVO.getRtct_end_date());
			pstmt.setDate(5,renConVO.getRtct_tmt_date());
			pstmt.setBytes(6,renConVO.getRtct_pic());
			pstmt.setInt(7,renConVO.getRtct_deposit());
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
	public void update(RenConVO renConVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			

//		========VO取值並設給preparedStatement=============
			pstmt.setInt(1,renConVO.getHos_no());
			pstmt.setInt(2, renConVO.getMem_no());
			pstmt.setDate(3,renConVO.getRtct_eff_date());
			pstmt.setDate(4,renConVO.getRtct_end_date());
			pstmt.setDate(5,renConVO.getRtct_tmt_date());
			pstmt.setBytes(6,renConVO.getRtct_pic());
			pstmt.setInt(7,renConVO.getRtct_deposit());
			pstmt.setInt(8,renConVO.getRtct_no());
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
	public void delete(Integer renConno) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, renConno);

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
	public RenConVO findByPrimaryKey(Integer renConno) {
		RenConVO renConVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE);

			pstmt.setInt(1, renConno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				renConVO  = new RenConVO();
				renConVO.setRtct_no(rs.getInt("rtct_no"));
				renConVO.setHos_no(rs.getInt("hos_no"));
				renConVO.setMem_no(rs.getInt("mem_no"));
				renConVO.setRtct_eff_date(rs.getDate("rtct_eff_date"));
				renConVO.setRtct_end_date(rs.getDate("rtct_end_date"));
				renConVO.setRtct_tmt_date(rs.getDate("rtct_tmt_date"));
				renConVO.setRtct_pic(rs.getBytes("rtct_pic"));
				renConVO.setRtct_deposit(rs.getInt("rtct_deposit"));
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
		return renConVO;
	}

	@Override
	public List<RenConVO> getAll() {
		List<RenConVO> list = new ArrayList<RenConVO>();
		RenConVO renConVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				renConVO = new RenConVO();
				renConVO.setRtct_no(rs.getInt("rtct_no"));
				renConVO.setHos_no(rs.getInt("hos_no"));
				renConVO.setMem_no(rs.getInt("mem_no"));
				renConVO.setRtct_eff_date(rs.getDate("rtct_eff_date"));
				renConVO.setRtct_end_date(rs.getDate("rtct_end_date"));
				renConVO.setRtct_tmt_date(rs.getDate("rtct_tmt_date"));
				renConVO.setRtct_pic(rs.getBytes("rtct_pic"));
				renConVO.setRtct_deposit(rs.getInt("rtct_deposit"));
				list.add(renConVO); // Store the row in the list
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

	@Override
	public void listarImg(Integer picno, HttpServletResponse response) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		OutputStream output = null;
		response.setContentType("image/*");
		try {
			output = response.getOutputStream();
			con = ds.getConnection();
			String getImage = "SELECT rtct_pic FROM RENTAL_CONTRACT where rtct_no= ?";
			pstmt = con.prepareStatement(getImage);
			pstmt.setInt(1, picno);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				byte[] b= rs.getBytes("rtct_pic");
				if(b!=null) {
					output.write(b);
				}
			
			}


			// Handle any driver errors
		} catch (SQLException se) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
			throw new RuntimeException("資料庫發生錯誤! "
					+ se.getMessage());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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

	@Override
	public void insert2(RenConVO renConVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT2);
//		========VO取值並設給preparedStatement=============
			pstmt.setInt(1,renConVO.getHos_no());
			pstmt.setInt(2, renConVO.getMem_no());
			pstmt.setInt(3,renConVO.getRtct_deposit());
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

}

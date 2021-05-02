package com.houPho.model;

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


public class HouPhoDAO implements HouPhoDAO_interface{
	private static DataSource ds = null;
	private static String qm = "?";
//	COUNTQUESTION用在insert需要幾個?(不含PK)
	private static final int COUNTQUESTION = 2; 
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
	private static final String TABLE = "HOUSE_PHOTO";
	private static final String PK = "hos_pic_no";
	private static final String QUESTIONMARKS = qm; 
	private static final String REDUCE_PK_COL = "hos_no, " + 
			"hos_pic";
	private static final String TOTAL_COL = "hos_pic_no,"+REDUCE_PK_COL;
	private static final String FOR_SET = "hos_no=?"
			+ ", hos_pic=?";

	private static final String INSERT = "INSERT INTO " + TABLE + "(" + REDUCE_PK_COL + ") VALUES ("+QUESTIONMARKS+")";
	private static final String GET_ALL = "SELECT " + TOTAL_COL + " FROM " + TABLE + " order by " + PK;
	private static final String GET_ONE = "SELECT " + TOTAL_COL + " FROM " + TABLE + " where " + PK + "= ?";
	private static final String DELETE = "DELETE FROM " + TABLE + " where +" + PK + "= ?";
	private static final String UPDATE = "UPDATE " + TABLE + " set "+FOR_SET+" where " + PK + "=?";

	@Override
	public void insert(HouPhoVO houPhoVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
//		========VO取值並設給preparedStatement=============
			pstmt.setInt(1,houPhoVO.getHos_no());
			pstmt.setBytes(2, houPhoVO.getHos_pic());
//	   =================送出指令========================
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
//			e.printStackTrace();
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
	public void update(HouPhoVO houPhoVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			

//		========VO取值並設給preparedStatement=============
			pstmt.setInt(1,houPhoVO.getHos_no());
			pstmt.setBytes(2,houPhoVO.getHos_pic());
			pstmt.setInt(3,houPhoVO.getHos_pic_no());
//	   =================送出指令========================
			pstmt.executeUpdate();
		} catch (SQLException e) {
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
	public void delete(Integer houPhono) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, houPhono);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
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
	public HouPhoVO findByPrimaryKey(Integer houPhono) {
		HouPhoVO houPhoVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE);

			pstmt.setInt(1, houPhono);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				houPhoVO = new HouPhoVO();
				houPhoVO.setHos_pic_no(rs.getInt("hos_pic_no"));
				houPhoVO.setHos_no(rs.getInt("hos_no"));
				houPhoVO.setHos_pic(rs.getBytes("hos_pic"));
//				===================
			}
		} catch (SQLException se) {
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
		return houPhoVO;
	}

	


	@Override
	public List<HouPhoVO> getHousenoAndHouPhono() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<HouPhoVO> list = new ArrayList<HouPhoVO>();
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement("SELECT HOS_NO,HOS_PIC_NO FROM HOUSE_PHOTO ORDER BY HOS_NO");
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				HouPhoVO houPhoVO = new HouPhoVO();
				houPhoVO.setHos_no(rs.getInt("HOS_NO"));
				houPhoVO.setHos_pic_no(rs.getInt("HOS_PIC_NO"));
				list.add(houPhoVO);
//				===================
			}
		} catch (SQLException se) {
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

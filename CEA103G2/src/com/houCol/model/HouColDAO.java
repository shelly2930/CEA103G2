package com.houCol.model;

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

import com.houAddFur.model.HouAddFurVO;

public class HouColDAO implements HouColDAO_interface{
	private static DataSource ds = null;
	private static String qm = "?";
//	COUNTQUESTION用在insert需要幾個?(不含PK)
	private static final int COUNTQUESTION = 3; 
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
	private static final String TABLE = "HOUSE_COLLECTION";
	private static final String PK1 = "MEM_NO";
	private static final String PK2 = "HOS_NO";
	private static final String QUESTIONMARKS = qm; 
	private static final String AIMED_AT_COL = "MEM_NO";
	private static final String TOTAL_COL = "HOS_NO, HOS_COL_NOTE, "+AIMED_AT_COL;
	private static final String FOR_SET = "MEM_NO=?"
			+"HOS_NO=?"
			+ ", ADD_FNT_NO=?";

	private static final String INSERT = "INSERT INTO " + TABLE + "(" + TOTAL_COL + ") VALUES ("+QUESTIONMARKS+")";
	private static final String GET_ALL_BY_PK1 = "SELECT " + TOTAL_COL + " FROM " + TABLE + " where " + PK1+"= ?";
	private static final String GET_ONE_BY_PK1_PK2 = "SELECT " + TOTAL_COL + " FROM " + TABLE + " where " + PK1 + "= ? and "+PK2+"=?";
	private static final String DELETE_TOTAL_BY_PK1 = "DELETE FROM " + TABLE + " where +" + PK1 + "= ?";
	private static final String DELETE_ONE_BY_PK1_AND_PK2 = "DELETE FROM " + TABLE + " where +" + PK1 + "= ? and "+PK2+"=?";
	private static final String UPDATE = "UPDATE " + TABLE + " set "+FOR_SET+" where +" + PK1 + "= ? and "+PK2+"=?";
	@Override
	public void insert(HouColVO houColVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
//		========VO取值並設給preparedStatement=============
			
			pstmt.setInt(1,houColVO.getHos_no());
			pstmt.setString(2,houColVO.getHos_col_note());
			pstmt.setInt(3,houColVO.getMem_no());
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
	public void update(HouColVO houColVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			

//		========VO取值並設給preparedStatement=============
			pstmt.setInt(1,houColVO.getMem_no());
			pstmt.setInt(2,houColVO.getHos_no());
			pstmt.setString(3,houColVO.getHos_col_note());
	
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
	public void deleteTotalByPk1(Integer houColno) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_TOTAL_BY_PK1);

			pstmt.setInt(1, houColno);

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
	public void deleteOneByPk1AndPk2(HouColVO houColVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_ONE_BY_PK1_AND_PK2);

			pstmt.setInt(1, houColVO.getMem_no());
			pstmt.setInt(2, houColVO.getHos_no());
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
	public HouColVO findByPrimaryKey(HouColVO houColVOParam) {

		HouColVO houColVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_BY_PK1_PK2);

			pstmt.setInt(1, houColVOParam.getMem_no());
			pstmt.setInt(2, houColVOParam.getHos_no());
			pstmt.setString(3, houColVOParam.getHos_col_note());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				houColVO = new HouColVO();
				houColVO.setMem_no(rs.getInt("mem_no"));
				houColVO.setHos_no(rs.getInt("hos_no"));
				houColVO.setHos_col_note(rs.getString("hos_col_note"));

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
		return houColVO;
	}
	@Override
	public List<HouColVO> getAll(Integer mem_no) {

		List<HouColVO> list = new ArrayList<HouColVO>();
		HouColVO houColVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_BY_PK1);
			pstmt.setInt(1, mem_no);
		
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				houColVO = new HouColVO();
				houColVO.setMem_no(rs.getInt("mem_no"));
				houColVO.setHos_no(rs.getInt("hos_no"));
				houColVO.setHos_col_note(rs.getString("hos_col_note"));
				list.add(houColVO); // Store the row in the list
			}
			// Handle any driver errors
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

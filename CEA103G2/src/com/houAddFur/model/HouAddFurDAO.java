package com.houAddFur.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class HouAddFurDAO implements HouAddFurDAO_interface {
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
	private static final String TABLE = "HOUSE_ADDITIONAL_FURNITURE";
	private static final String PK1 = "HOS_NO";
	private static final String PK2 = "ADD_FNT_NO";
	private static final String QUESTIONMARKS = qm; 
	private static final String AIMED_AT_COL = "ADD_FNT_NO";
	private static final String TOTAL_COL = "HOS_NO,"+AIMED_AT_COL;
	private static final String FOR_SET = "HOS_NO=?"
			+ ", ADD_FNT_NO=?";

	private static final String INSERT = "INSERT INTO " + TABLE + "(" + TOTAL_COL + ") VALUES ("+QUESTIONMARKS+")";
	private static final String GET_ALL_BY_PK1 = "SELECT " + TOTAL_COL + " FROM " + TABLE + " where " + PK1+"= ?";
	private static final String GET_ONE_BY_PK1_PK2 = "SELECT " + TOTAL_COL + " FROM " + TABLE + " where " + PK1 + "= ? and "+PK2+"=?";
	private static final String DELETE_TOTAL_BY_PK1 = "DELETE FROM " + TABLE + " where +" + PK1 + "= ?";
	private static final String DELETE_ONE_BY_PK1_AND_PK2 = "DELETE FROM " + TABLE + " where +" + PK1 + "= ? and "+PK2+"=?";
	private static final String UPDATE = "UPDATE " + TABLE + " set "+FOR_SET+" where +" + PK1 + "= ? and "+PK2+"=?";

	@Override
	public void insert(HouAddFurVO houAddFurVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
//		========VO取值並設給preparedStatement=============
			pstmt.setInt(1,houAddFurVO.getHos_no());
			pstmt.setInt(2,houAddFurVO.getAdd_fnt_no());
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
	public void update(HouAddFurVO houAddFurVO) {
		// TODO Auto-generated method stub
					Connection con = null;
					PreparedStatement pstmt = null;
					try {
						con = ds.getConnection();
						pstmt = con.prepareStatement(UPDATE);
						

//					========VO取值並設給preparedStatement=============
						pstmt.setInt(1,houAddFurVO.getHos_no());
						pstmt.setInt(2,houAddFurVO.getAdd_fnt_no());
						pstmt.setInt(3,houAddFurVO.getHos_no());
						pstmt.setInt(4,houAddFurVO.getAdd_fnt_no());
//				   =================送出指令========================
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
	public void deleteTotalByPk1(Integer houAddFurno) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_TOTAL_BY_PK1);

			pstmt.setInt(1, houAddFurno);

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
	public List<HouAddFurVO> getAll(Integer houAddFurno) {
		List<HouAddFurVO> list = new ArrayList<HouAddFurVO>();
		HouAddFurVO houAddFurVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			System.out.println("S");
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_BY_PK1);
			pstmt.setInt(1, houAddFurno);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				houAddFurVO = new HouAddFurVO();
				houAddFurVO.setHos_no(rs.getInt("hos_no"));
				houAddFurVO.setAdd_fnt_no(rs.getInt("add_fnt_no"));
				
				list.add(houAddFurVO); // Store the row in the list
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

	@Override
	public void deleteOneByPk1AndPk2(HouAddFurVO houAddFurVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_ONE_BY_PK1_AND_PK2);

			pstmt.setInt(1, houAddFurVO.getHos_no());
			pstmt.setInt(2, houAddFurVO.getAdd_fnt_no());
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
	public HouAddFurVO findByPrimaryKey(HouAddFurVO houAddFurVOParam) {
		HouAddFurVO houAddFurVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_BY_PK1_PK2);

			pstmt.setInt(1, houAddFurVOParam.getHos_no());
			pstmt.setInt(2, houAddFurVOParam.getAdd_fnt_no());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				houAddFurVO = new HouAddFurVO();
				houAddFurVO.setHos_no(rs.getInt("hos_no"));
				houAddFurVO.setAdd_fnt_no(rs.getInt("add_fnt_no"));

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
		return houAddFurVO;
	}

}

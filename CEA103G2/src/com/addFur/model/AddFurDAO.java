package com.addFur.model;

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

public class AddFurDAO implements com.addFur.model.AddFurDAO_interface {
	private static DataSource ds = null;

	static {
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/HowTrueProject");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	private static final String TABLE = "ADDITIONAL_FURNITURE";
	private static final String PK = "add_fnt_no";
	private static final String REDUCE_PK_COL = "add_fnt_name";
	private static final String TOTAL_COL = "add_fnt_no, add_fnt_name";
	private static final String FOR_SET = "add_fnt_name=?";

	private static final String INSERT = "INSERT INTO " + TABLE + "(" + REDUCE_PK_COL + ") VALUES (?)";
	private static final String GET_ALL = "SELECT " + TOTAL_COL + " FROM " + TABLE + " order by " + PK;
	private static final String GET_ONE = "SELECT " + TOTAL_COL + " FROM " + TABLE + " where " + PK + "= ?";
	private static final String DELETE = "DELETE FROM " + TABLE + " where +" + PK + "= ?";
	private static final String UPDATE = "UPDATE " + TABLE + " set "+FOR_SET+" where " + PK + "=?";

	@Override
	public void insert(AddFurVO addFurVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
//		========VO取值並設給preparedStatement=============
			pstmt.setString(1,addFurVO.getAdd_fnt_name());
//	   =================送出指令========================
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			throw new RuntimeException("資料庫錯誤囉");
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
	public void update(AddFurVO addFurVO) {
			// TODO Auto-generated method stub
			Connection con = null;
			PreparedStatement pstmt = null;
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE);
				

//			========VO取值並設給preparedStatement=============
				pstmt.setString(1,addFurVO.getAdd_fnt_name());
				pstmt.setInt(2,addFurVO.getAdd_fnt_no());
//		   =================送出指令========================
				pstmt.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				throw new RuntimeException("資料庫錯誤囉");
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
	public void delete(Integer addFurno) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, addFurno);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("資料庫錯誤囉");
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
	public AddFurVO findByPrimaryKey(Integer addFurno) {
		AddFurVO addFurVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE);

			pstmt.setInt(1, addFurno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				addFurVO = new AddFurVO();
				addFurVO.setAdd_fnt_no(rs.getInt("add_fnt_no"));
				addFurVO.setAdd_fnt_name(rs.getString("add_fnt_name"));

//				===================
			}
		} catch (SQLException se) {
			throw new RuntimeException("資料庫錯了"
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
		return addFurVO;
	}

	@Override
	public List<AddFurVO> getAll() {
		// TODO Auto-generated method stub
				List<AddFurVO> list = new ArrayList<AddFurVO>();
				AddFurVO addFurVO = null;

				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;

				try {

					con = ds.getConnection();
					pstmt = con.prepareStatement(GET_ALL);
					rs = pstmt.executeQuery();

					while (rs.next()) {
						addFurVO = new AddFurVO();
						addFurVO.setAdd_fnt_no(rs.getInt("add_fnt_no"));
						addFurVO.setAdd_fnt_name(rs.getString("add_fnt_name"));
						
						list.add(addFurVO); // Store the row in the list
					}
					// Handle any driver errors
				} catch (SQLException se) {
					throw new RuntimeException("資料庫錯拉"
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

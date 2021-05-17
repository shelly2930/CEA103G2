package com.renFurDet.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class RenFurDetDAO implements RenFurDetDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/HowTrueProject");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	private static final String TABLE="RENT_FURNITURE_DETAIL";
	private static final String INSERT_ITEM="(rfa_no,fnt_id,rtct_no,rent_date,rent_end_date,rent_tmt_date)";
	private static final String UPDATE_ITEM="rtct_no= ?,rent_date= ?,rent_end_date= ?,rent_tmt_date= ?";
	private static final String PK1="rfa_no";
	private static final String PK2="fnt_id";
	
	private static final String INSERT_STMT = 
		"INSERT INTO "+TABLE+INSERT_ITEM + " VALUES (?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL = 
		"SELECT * FROM "+TABLE+ " order by "+PK1;
	private static final String GET_ONE_BY_PK1_PK2 = 
		"SELECT * FROM "+TABLE+"  where "+PK1+"= ? and "+PK2+"=?";
	private static final String GET_ONE_BY_PK1 = 
			"SELECT * FROM "+TABLE+"  where "+PK1+"= ?";
	private static final String DELETE_ONE_BY_PK1_AND_PK2 = 
		"DELETE FROM "+TABLE+" where "+PK1+"= ? and "+PK2+"=?";
	 private static final String DELETE_LIST_BY_PK1 = 
		"DELETE FROM " + TABLE + " where " + PK1 + "= ?";
	private static final String UPDATE = 
		"UPDATE "+TABLE+" set "+UPDATE_ITEM+" where "+PK1+"= ? and "+PK2+"=?";

	@Override
	public void insert(RenFurDetVO renFurDetVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, renFurDetVO.getRfa_no());
			pstmt.setInt(2, renFurDetVO.getFnt_id());
			pstmt.setInt(3, renFurDetVO.getRtct_no());
			pstmt.setTimestamp(4, renFurDetVO.getRent_date());
			pstmt.setTimestamp(5, renFurDetVO.getRent_end_date());
			pstmt.setTimestamp(6, renFurDetVO.getRent_tmt_date());

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
	public void update(RenFurDetVO renFurDetVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			System.out.println(renFurDetVO.getRtct_no());
			pstmt.setInt(1, renFurDetVO.getRtct_no());
			System.out.println(renFurDetVO.getRent_date());
			pstmt.setTimestamp(2, renFurDetVO.getRent_date());
			System.out.println(renFurDetVO.getRent_end_date());
			pstmt.setTimestamp(3, renFurDetVO.getRent_end_date());
			System.out.println(renFurDetVO.getRent_tmt_date());
			pstmt.setTimestamp(4, renFurDetVO.getRent_tmt_date());
			System.out.println(renFurDetVO.getRfa_no());
			pstmt.setInt(5, renFurDetVO.getRfa_no());
			System.out.println(renFurDetVO.getFnt_id());
			pstmt.setInt(6, renFurDetVO.getFnt_id());
			System.out.println("!");
			pstmt.executeUpdate();
			System.out.println("!!!");
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
	//刪一個明細
	public void deleteOne(Integer rfa_no, Integer fnt_id) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_ONE_BY_PK1_AND_PK2);

			pstmt.setInt(1, rfa_no);
			pstmt.setInt(2, fnt_id);

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
	//刪一整張單
	public void deleteList(Integer rfa_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_LIST_BY_PK1);

			pstmt.setInt(1, rfa_no);

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
	//找那一張單的單一明細
	@Override
	public RenFurDetVO findByPrimaryKey(Integer rfa_no,Integer fnt_id) {

		RenFurDetVO renFurDetVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_BY_PK1_PK2);

			pstmt.setInt(1, rfa_no);
			pstmt.setInt(2, fnt_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				renFurDetVO = new RenFurDetVO();
				renFurDetVO.setRfa_no(rs.getInt("rfa_no"));
				renFurDetVO.setFnt_id(rs.getInt("fnt_id"));
				renFurDetVO.setRtct_no(rs.getInt("rtct_no"));
				renFurDetVO.setRent_date(rs.getTimestamp("rent_date"));
				renFurDetVO.setRent_end_date(rs.getTimestamp("rent_end_date"));
				renFurDetVO.setRent_tmt_date(rs.getTimestamp("rent_tmt_date"));

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
		return renFurDetVO;
	}
	//查全部
	@Override
	public List<RenFurDetVO> getAll() {
		List<RenFurDetVO> list = new ArrayList<RenFurDetVO>();
		RenFurDetVO renFurDetVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				renFurDetVO = new RenFurDetVO();
				renFurDetVO.setRfa_no(rs.getInt("rfa_no"));
				renFurDetVO.setFnt_id(rs.getInt("fnt_id"));
				renFurDetVO.setRtct_no(rs.getInt("rtct_no"));
				renFurDetVO.setRent_date(rs.getTimestamp("rent_date"));
				renFurDetVO.setRent_end_date(rs.getTimestamp("rent_end_date"));
				renFurDetVO.setRent_tmt_date(rs.getTimestamp("rent_tmt_date"));
				list.add(renFurDetVO); // Store the row in the list
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
	//查一張單的所有明細
	@Override
	public List<RenFurDetVO> getOneList(Integer rfa_no) {
		List<RenFurDetVO> list = new ArrayList<RenFurDetVO>();
		RenFurDetVO renFurDetVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_BY_PK1);
			pstmt.setInt(1, rfa_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				renFurDetVO = new RenFurDetVO();
				renFurDetVO.setRfa_no(rs.getInt("rfa_no"));
				renFurDetVO.setFnt_id(rs.getInt("fnt_id"));
				renFurDetVO.setRtct_no(rs.getInt("rtct_no"));
				renFurDetVO.setRent_date(rs.getTimestamp("rent_date"));
				renFurDetVO.setRent_end_date(rs.getTimestamp("rent_end_date"));
				renFurDetVO.setRent_tmt_date(rs.getTimestamp("rent_tmt_date"));
				list.add(renFurDetVO); // Store the row in the list
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
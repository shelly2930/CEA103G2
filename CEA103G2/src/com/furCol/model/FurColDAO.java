package com.furCol.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class FurColDAO implements FurColDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/HowTrueProject");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	private static final String TABLE="FURNITURE_COLLECT";
	private static final String INSERT_ITEM="(mem_no,fnt_it_no,fnt_col_date,fnt_col_note)";
	private static final String UPDATE_ITEM="mem_no= ?,fnt_it_no= ?,fnt_col_date= ?,fnt_col_note= ?";
	private static final String PK1="mem_no";
	private static final String PK2="fnt_it_no";
	
	private static final String INSERT_STMT = 
		"INSERT INTO "+TABLE+INSERT_ITEM + " VALUES (?, ?, ?, ?)";
	private static final String GET_ALL = 
		"SELECT * FROM "+TABLE+ " order by "+PK1;
	private static final String GET_ONE_BY_PK1_PK2 = 
		"SELECT * FROM "+TABLE+"  where "+PK1+"= ? and "+PK2+"=?";
	private static final String GET_ONE_BY_PK1 = 
			"SELECT * FROM "+TABLE+"  where "+PK1+"= ?";
	private static final String DELETE_ONE_BY_PK1_AND_PK2 = 
		"DELETE FROM "+TABLE+" where "+PK1+"= ? and "+PK2+"=?";
	private static final String UPDATE = 
		"UPDATE"+TABLE+" set "+UPDATE_ITEM+" where "+PK1+"= ? and "+PK2+"=?";

	@Override
	public void insert(FurColVO furColVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, furColVO.getMem_no());
			pstmt.setInt(2, furColVO.getFnt_it_no());
			pstmt.setTimestamp(3, furColVO.getFnt_col_date());
			pstmt.setString(4, furColVO.getFnt_col_note());
		
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
	public void update(FurColVO furColVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setInt(1, furColVO.getMem_no());
			pstmt.setInt(2, furColVO.getFnt_it_no());
			pstmt.setTimestamp(3, furColVO.getFnt_col_date());
			pstmt.setString(4, furColVO.getFnt_col_note());
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
	//刪某會員的其中一個收藏
	public void delete(Integer mem_no, Integer fnt_it_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_ONE_BY_PK1_AND_PK2);

			pstmt.setInt(1, mem_no);
			pstmt.setInt(2, fnt_it_no);

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

	//找那一個會員的一個收藏
	@Override
	public FurColVO findByPrimaryKey(Integer mem_no,Integer fnt_it_no) {

		FurColVO furColVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_BY_PK1_PK2);

			pstmt.setInt(1, mem_no);
			pstmt.setInt(2,fnt_it_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				furColVO = new FurColVO();
				furColVO.setMem_no(rs.getInt("mem_no"));
				furColVO.setFnt_it_no(rs.getInt("fnt_it_no"));
				furColVO.setFnt_col_date(rs.getTimestamp("fnt_col_date"));
				furColVO.setFnt_col_note(rs.getString("fnt_col_note"));
				
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
		return furColVO;
	}
	//查全部
	@Override
	public List<FurColVO> getAll() {
		List<FurColVO> list = new ArrayList<FurColVO>();
		FurColVO furColVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				furColVO = new FurColVO();
				furColVO.setMem_no(rs.getInt("mem_no"));
				furColVO.setFnt_it_no(rs.getInt("fnt_it_no"));
				furColVO.setFnt_col_date(rs.getTimestamp("fnt_col_date"));
				furColVO.setFnt_col_note(rs.getString("fnt_col_note"));
				list.add(furColVO); // Store the row in the list
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
	//查一個會員的所有收藏
	@Override
	public List<FurColVO> getFurColsByMem_no(Integer mem_no) {
		List<FurColVO> list = new ArrayList<FurColVO>();
		FurColVO furColVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_BY_PK1);
			pstmt.setInt(1, mem_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				furColVO = new FurColVO();
				furColVO.setMem_no(rs.getInt("mem_no"));
				furColVO.setFnt_it_no(rs.getInt("fnt_it_no"));
				furColVO.setFnt_col_date(rs.getTimestamp("fnt_col_date"));
				furColVO.setFnt_col_note(rs.getString("fnt_col_note"));
				list.add(furColVO); // Store the row in the list
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
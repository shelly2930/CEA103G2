package com.furPho.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
//圖片取得及存入待詢問
public class FurPhoDAO implements FurPhoDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/HowTrueProject");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	private static final String TABLE="FURNITURE_PHOTO";
	private static final String INSERT_ITEM="(fnt_it_no,fnt_pic)";
	private static final String UPDATE_ITEM="fnt_it_no=?,fnt_pic= ?";
	private static final String PK="fnt_pic_no";
	
	private static final String INSERT_STMT = 
		"INSERT INTO "+TABLE+INSERT_ITEM + 
		" VALUES (?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT * FROM "+TABLE+ " order by "+PK;
	private static final String GET_ONE_STMT = 
		"SELECT * FROM "+TABLE+"  where "+PK+"= ?";
	private static final String DELETE = 
		"DELETE FROM "+TABLE+" where "+PK+"= ?";
	private static final String UPDATE = 
		"UPDATE "+TABLE+" set "+UPDATE_ITEM+" where "+PK+" = ?";
	private static final String GET_ONE_FNT_ITE_PICS_STMT="SELECT * FROM "+TABLE+"  where fnt_it_no= ?";
   //查所查品項的所有照片中的第一張照片編號
	private static final String GET_THIS_FUR_ITE_FIRST_PIC_NO_STMT="SELECT fnt_pic_no FROM "+TABLE+ " where fnt_it_no=? order by fnt_pic_no limit 0,1";
	private static final String GET_THIS_FUR_ITE_FIRST_PHOVO_STMT="SELECT * FROM "+TABLE+ " where fnt_it_no=? order by fnt_pic_no limit 0,1";
	
	@Override
	public void insert(FurPhoVO furPhoVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, furPhoVO.getFnt_it_no());
			pstmt.setBytes(2, furPhoVO.getFnt_pic());
			
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
	public void update(FurPhoVO furPhoVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setInt(1, furPhoVO.getFnt_it_no());
			pstmt.setBytes(2, furPhoVO.getFnt_pic());	
			//圖片待找
			pstmt.setInt(3, furPhoVO.getFnt_pic_no());
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
	public void delete(Integer fnt_pic_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, fnt_pic_no);

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
	public FurPhoVO findByPrimaryKey(Integer fnt_pic_no) {

		FurPhoVO furPhoVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1,fnt_pic_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				furPhoVO = new FurPhoVO();
				furPhoVO.setFnt_pic_no(rs.getInt("fnt_pic_no"));
				furPhoVO.setFnt_it_no(rs.getInt("fnt_it_no"));
				furPhoVO.setFnt_pic(rs.getBytes("fnt_pic"));	
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
		return furPhoVO;
	}

	@Override
	public List<FurPhoVO> getAll() {
		List<FurPhoVO> list = new ArrayList<FurPhoVO>();
		FurPhoVO furPhoVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				furPhoVO = new FurPhoVO();
				furPhoVO.setFnt_pic_no(rs.getInt("fnt_pic_no"));
				furPhoVO.setFnt_it_no(rs.getInt("fnt_it_no"));
				furPhoVO.setFnt_pic(rs.getBytes("fnt_pic"));;
				list.add(furPhoVO); // Store the row in the list
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

	@Override
	public List<FurPhoVO> getOneFntItePics(Integer fnt_it_no) {
		List<FurPhoVO> list = new ArrayList<FurPhoVO>();
		FurPhoVO furPhoVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_FNT_ITE_PICS_STMT);
			pstmt.setInt(1,fnt_it_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				furPhoVO = new FurPhoVO();
				furPhoVO.setFnt_pic_no(rs.getInt("fnt_pic_no"));
				furPhoVO.setFnt_it_no(rs.getInt("fnt_it_no"));
				furPhoVO.setFnt_pic(rs.getBytes("fnt_pic"));;
				list.add(furPhoVO); // Store the row in the list
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

	//拿所查品項的第一個照片編號(測試寫法${furPhoSvc.getThisIteFirstFnt_pic_no(furIteVO.fnt_it_no)}無法執行)
	@Override
	public Integer getThisIteFirstFnt_pic_no(Integer fnt_it_no) {
		Integer thisFurIteFirst_pic_no = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_THIS_FUR_ITE_FIRST_PIC_NO_STMT);

			pstmt.setInt(1,fnt_it_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				thisFurIteFirst_pic_no=rs.getInt("fnt_pic_no");
			}
		   System.out.println(thisFurIteFirst_pic_no);
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
		return thisFurIteFirst_pic_no;		
	}

	@Override
	public FurPhoVO getThisIteFurPho(Integer fnt_it_no) {
		FurPhoVO furPhoVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_THIS_FUR_ITE_FIRST_PHOVO_STMT);

			pstmt.setInt(1,fnt_it_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				furPhoVO = new FurPhoVO();
				furPhoVO.setFnt_pic_no(rs.getInt("fnt_pic_no"));
				furPhoVO.setFnt_it_no(rs.getInt("fnt_it_no"));
				furPhoVO.setFnt_pic(rs.getBytes("fnt_pic"));	
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
		return furPhoVO;
	}

	
	
}
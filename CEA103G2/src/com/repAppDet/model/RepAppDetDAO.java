package com.repAppDet.model;

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

public class RepAppDetDAO implements RepAppDetDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/HowTrueProject");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	public static final String INSERT = "INSERT INTO REPAIR_APPLICATION_DETAILS(RA_NO, RAD_ORDER_TIME, RAD_DMG_DSC) VALUES (?, ?, ?)";
	public static final String UPDATE = "UPDATE REPAIR_APPLICATION_DETAILS SET RAD_STATUS=?, RAD_EXPZ=?, RAD_TR_DMG=? WHERE RAD_NO=?";
	public static final String GET_BY_PK = "SELECT * FROM REPAIR_APPLICATION_DETAILS WHERE RAD_NO=?";
	public static final String GET_BY_FK = "SELECT * FROM REPAIR_APPLICATION_DETAILS WHERE RA_NO=?";
	public static final String GET_ALL = "SELECT * FROM REPAIR_APPLICATION_DETAILS";
	
	public void insert(RepAppDetVO repAppDetVO, Connection con) {
		PreparedStatement pstmt = null;
		
		try {
			pstmt = con.prepareStatement(INSERT);
			
			pstmt.setInt(1, repAppDetVO.getRa_no());
			pstmt.setTimestamp(2, repAppDetVO.getRad_order_time());
			pstmt.setString(3, repAppDetVO.getRad_dmg_dsc());
			pstmt.executeQuery();
			
		} catch (SQLException se) {
			if (con != null) {
				try {
					System.err.print("Transaction is being ");
					System.err.println("rolled back(RepAppDet)");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured." + excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured." + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
		}
	}

	public void update(RepAppDetVO repAppDetVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setByte(1, repAppDetVO.getRad_status());
			pstmt.setInt(2, repAppDetVO.getRad_expz());
			pstmt.setByte(3, repAppDetVO.getRad_tr_dmg());
			pstmt.setInt(4, repAppDetVO.getRad_no());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
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

	public RepAppDetVO getByPK(Integer rad_no) {
		RepAppDetVO repAppDetVO = new RepAppDetVO();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_BY_PK);
			pstmt.setInt(1, rad_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				repAppDetVO.setRad_no(rs.getInt(1));
				repAppDetVO.setRa_no(rs.getInt(2));
				repAppDetVO.setRad_order_time(rs.getTimestamp(3));
				repAppDetVO.setRad_dmg_dsc(rs.getString(4));
				repAppDetVO.setRad_status(rs.getByte(5));
				repAppDetVO.setRad_expz(rs.getInt(6));
				repAppDetVO.setRad_tr_dmg(rs.getByte(7));
			}
			
		} catch(SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
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
		return repAppDetVO;
	}

	public List<RepAppDetVO> getByFK(Integer ra_no) {
		List<RepAppDetVO> list = new ArrayList<RepAppDetVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_BY_FK);
			pstmt.setInt(1, ra_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				RepAppDetVO repAppDetVO = new RepAppDetVO();
				
				repAppDetVO.setRad_no(rs.getInt(1));
				repAppDetVO.setRa_no(rs.getInt(2));
				repAppDetVO.setRad_order_time(rs.getTimestamp(3));
				repAppDetVO.setRad_dmg_dsc(rs.getString(4));
				repAppDetVO.setRad_status(rs.getByte(5));
				repAppDetVO.setRad_expz(rs.getInt(6));
				repAppDetVO.setRad_tr_dmg(rs.getByte(7));
				list.add(repAppDetVO);
			}
			
		} catch(SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
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

	public List<RepAppDetVO> getAll() {
		List<RepAppDetVO> list = new ArrayList<RepAppDetVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				RepAppDetVO repAppDetVO = new RepAppDetVO();
				
				repAppDetVO.setRad_no(rs.getInt(1));
				repAppDetVO.setRa_no(rs.getInt(2));
				repAppDetVO.setRad_order_time(rs.getTimestamp(3));
				repAppDetVO.setRad_dmg_dsc(rs.getString(4));
				repAppDetVO.setRad_status(rs.getByte(5));
				repAppDetVO.setRad_expz(rs.getInt(6));
				repAppDetVO.setRad_tr_dmg(rs.getByte(7));
				list.add(repAppDetVO);
			}
			
		} catch(SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
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

package com.repAppPho.model;

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

import com.repAppPho.model.RepAppPhoVO;

public class RepAppPhoDAO implements RepAppPhoDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/HowTrueProject");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT = "INSERT INTO REPAIR_APPLICATION_PHOTO(RA_NO, RAP_PHOTO) VALUES (?, ?)";
	private static final String UPDATE = "UPDATE REPAIR_APPLICATION_PHOTO SET RAP_PHOTO=? WHERE RAP_NO=?";
	private static final String DELETE = "DELETE FROM REPAIR_APPLICATION_PHOTO WHERE RAP_NO=?";
	private static final String GET_BY_PK = "SELECT * FROM REPAIR_APPLICATION_PHOTO WHERE RAP_NO=?";
	private static final String GET_BY_FK = "SELECT * FROM REPAIR_APPLICATION_PHOTO WHERE RA_NO=?";
	
	public void insert(RepAppPhoVO repAppPhoVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
			
			pstmt.setInt(1, repAppPhoVO.getRa_no());
			pstmt.setBytes(2, repAppPhoVO.getRap_photo());
			pstmt.executeUpdate();
			
		} catch(SQLException se) {
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

	public void update(RepAppPhoVO repAppPhoVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setBytes(1, repAppPhoVO.getRap_photo());
			pstmt.setInt(2, repAppPhoVO.getRap_no());
			pstmt.executeUpdate();
			
		} catch(SQLException se) {
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

	public void delete(Integer rap_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setInt(1, rap_no);
			pstmt.executeUpdate();
			
		} catch(SQLException se) {
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

	public RepAppPhoVO getByPK(Integer rap_no) {
		RepAppPhoVO repAppPhoVO = new RepAppPhoVO();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_BY_PK);
			pstmt.setInt(1, rap_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				repAppPhoVO.setRap_no(rs.getInt(1));
				repAppPhoVO.setRa_no(rs.getInt(2));
				repAppPhoVO.setRap_photo(rs.getBytes(3));
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
		return repAppPhoVO;
	}

	public List<RepAppPhoVO> getByFK(Integer ra_no) {
		List<RepAppPhoVO> list = new ArrayList<RepAppPhoVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_BY_FK);
			pstmt.setInt(1, ra_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				RepAppPhoVO repAppPhoVO = new RepAppPhoVO();
				
				repAppPhoVO.setRap_no(rs.getInt(1));
				repAppPhoVO.setRa_no(rs.getInt(2));
				repAppPhoVO.setRap_photo(rs.getBytes(3));
				list.add(repAppPhoVO);
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

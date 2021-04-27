package com.repApp.model;

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

import com.repApp.model.RepAppVO;
import com.repAppDet.model.RepAppDetDAO;
import com.repAppDet.model.RepAppDetVO;

public class RepAppDAO implements RepAppDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/HowTrue");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT = "INSERT INTO REPAIR_APPLICATION(MEM_NO, RTCT_NO, RA_APP_TIME) VALUES (?, ?, ?)";
	private static final String UPDATE = "UPDATE REPAIR_APPLICATION SET EMP_NO=?, RA_END_TIME=?, RA_STATUS=? WHERE RA_NO=?";
	private static final String GET_BY_PK = "SELECT * FROM REPAIR_APPLICATION WHERE=?";
	private static final String GET_ALL = "SELECT * FROM REPAIR_APPLICATION";
	
	public void insert(RepAppVO repAppVO, List<RepAppDetVO> list) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT, 1);
			
			con.setAutoCommit(false);
			
			pstmt.setInt(1, repAppVO.getMem_no());
			pstmt.setInt(2, repAppVO.getRtct_no());
			pstmt.setTimestamp(3, repAppVO.getRa_app_time());
			pstmt.executeQuery();
			
			rs = pstmt.getGeneratedKeys();
			Integer ra_no = null;
			if(rs.next()) {
				ra_no = rs.getInt(1);
			} else {
				System.out.println("未取得自增主鍵值");
			}
			
			RepAppDetDAO repAppDetDAO = new RepAppDetDAO();
			for(RepAppDetVO repAppDetVO : list) {
				repAppDetVO.setRa_no(ra_no);
				repAppDetDAO.insert(repAppDetVO, con);
			}
			
			con.commit();
			con.setAutoCommit(true);
			
		} catch (SQLException se) {
			if (con != null) {
				try {
					System.err.println("rolled back(RepApp)");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured." + excep.getMessage());
				}
			}
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
	}

	public void update(RepAppVO repAppVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setInt(1, repAppVO.getEmp_no());
			pstmt.setTimestamp(2, repAppVO.getRa_end_time());
			pstmt.setByte(3, repAppVO.getRa_status());
			pstmt.setInt(4, repAppVO.getRa_no());
			pstmt.executeQuery();
			
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

	public RepAppVO getByPK(Integer ra_no) {
		RepAppVO rav = new RepAppVO();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_BY_PK);
			pstmt.setInt(1, ra_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				rav.setRa_no(rs.getInt(1));
				rav.setMem_no(rs.getInt(2));
				rav.setRtct_no(rs.getInt(3));
				rav.setEmp_no(rs.getInt(4));
				rav.setRa_app_time(rs.getTimestamp(5));
				rav.setRa_end_time(rs.getTimestamp(6));
				rav.setRa_status(rs.getByte(7));
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
		return rav;
	}

	public List<RepAppVO> getAll() {
	List<RepAppVO> list = new ArrayList<RepAppVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				RepAppVO rav = new RepAppVO();
				
				rav.setRa_no(rs.getInt(1));
				rav.setMem_no(rs.getInt(2));
				rav.setRtct_no(rs.getInt(3));
				rav.setEmp_no(rs.getInt(4));
				rav.setRa_app_time(rs.getTimestamp(5));
				rav.setRa_end_time(rs.getTimestamp(6));
				rav.setRa_status(rs.getByte(7));
				list.add(rav);
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

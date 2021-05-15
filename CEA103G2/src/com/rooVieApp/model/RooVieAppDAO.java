package com.rooVieApp.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class RooVieAppDAO implements RooVieAppDAO_interface{
	private static DataSource ds = null;
	private static String qm = "?";
//	COUNTQUESTION用在insert需要幾個?(不含PK)
	private static final int COUNTQUESTION = 7; 
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
	private static final String TABLE = "ROOM_VIEWING_APPLICATION";
	private static final String PK = "rva_no";
	private static final String QUESTIONMARKS = qm; 
	private static final String REDUCE_PK_COL = "mem_no, " + 
			"hos_no, " + 
			"emp_no, "+
			"rva_app_time, "+
			"rva_order_time, "+ 
			"rva_end_time, "+
			"rva_status ";
	private static final String TOTAL_COL = "rva_no, "+REDUCE_PK_COL;
	private static final String FOR_SET = "mem_no=?, " + 
			"hos_no=?, " + 
			"emp_no=?, "+
			"rva_app_time=?, "+
			"rva_order_time=?, "+ 
			"rva_end_time=?, "+
			"rva_status=? ";

	private static final String INSERT = "INSERT INTO " + TABLE + "(" + REDUCE_PK_COL + ") VALUES ("+QUESTIONMARKS+")";
	private static final String GET_ALL = "SELECT " + TOTAL_COL + " FROM " + TABLE + " order by " + PK;
	private static final String GET_ONE = "SELECT " + TOTAL_COL + " FROM " + TABLE + " where " + PK + "= ?";
	private static final String DELETE = "DELETE FROM " + TABLE + " where +" + PK + "= ?";
	private static final String UPDATE = "UPDATE " + TABLE + " set "+FOR_SET+" where " + PK + "=?";
	private static final String ADDPICKTIME = "INSERT INTO "+TABLE+"(MEM_NO, HOS_NO,RVA_ORDER_TIME,RVA_STATUS) VALUES (?, ?, ?, ?)";
	private static final String CANCELPICKTIME = "DELETE FROM "+TABLE+" WHERE MEM_NO=? and HOS_NO=? and RVA_ORDER_TIME =?";
	//針對個別物件SHOW出全部
	private static final String LISTALLPICKTIME = "SELECT " + TOTAL_COL + " FROM " + TABLE + " WHERE HOS_NO=? and DATEDIFF(RVA_ORDER_TIME,NOW()) > 0  order by RVA_ORDER_TIME";
	//針對個別物件SHOW出全部(未指派)
	private static final String LISTALLPICKTIME_NOASSIGN = "SELECT " + TOTAL_COL + " FROM " + TABLE + " WHERE HOS_NO=? and EMP_NO is NULL and DATEDIFF(RVA_ORDER_TIME,NOW()) > 0  order by RVA_ORDER_TIME";
	private static final String LISTNEWPICKTIME  = "SELECT * FROM room_viewing_application WHERE TIMEDIFF(RVA_APP_TIME,NOW()) < 0";
	//找到所有沒指派 且 今天以後的預約看房
	private static final String LISTNEWROOVIEAPP = "SELECT  HOS_NO,MAX(RVA_ORDER_TIME) FROM ROOM_VIEWING_APPLICATION  GROUP BY HOS_NO HAVING DATEDIFF(MAX(RVA_ORDER_TIME),NOW()) > 0 ORDER BY MAX(RVA_ORDER_TIME)";
	
	private static final String CHANGEEMP = "UPDATE ROOM_VIEWING_APPLICATION SET EMP_NO=?,RVA_STATUS=? WHERE RVA_NO=?;"; 
	
	private static final String GETEMPAPP = "SELECT * FROM room_viewing_application where emp_no=?";
	
	private static final String LISTTHEEMPAPP = "SELECT HOS_NO,COUNT(MEM_NO),MAX(RVA_ORDER_TIME) FROM room_viewing_application where rva_status=? and EMP_NO =? group by HOS_NO having DATEDIFF(MAX(RVA_ORDER_TIME),NOW()) > 0";
	@Override
	public void insert(RooVieAppVO rooVieAppVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
//		========VO取值並設給preparedStatement=============
			pstmt.setInt(1,rooVieAppVO.getMem_no());
			pstmt.setInt(2, rooVieAppVO.getHos_no());
			pstmt.setInt(3,rooVieAppVO.getEmp_no());
			pstmt.setTimestamp(4,rooVieAppVO.getRva_app_time());
			pstmt.setTimestamp(5,rooVieAppVO.getRva_order_time());
			pstmt.setTimestamp(6,rooVieAppVO.getRva_end_time());
			pstmt.setByte(7,rooVieAppVO.getRva_status());
//	   =================送出指令========================
			pstmt.executeUpdate();
		} catch (SQLException e) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
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
	public void update(RooVieAppVO rooVieAppVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			

//		========VO取值並設給preparedStatement=============
			pstmt.setInt(1,rooVieAppVO.getMem_no());
			pstmt.setInt(2, rooVieAppVO.getHos_no());
			pstmt.setInt(3,rooVieAppVO.getEmp_no());
			pstmt.setTimestamp(4,rooVieAppVO.getRva_app_time());
			pstmt.setTimestamp(5,rooVieAppVO.getRva_order_time());
			pstmt.setTimestamp(6,rooVieAppVO.getRva_end_time());
			pstmt.setByte(7,rooVieAppVO.getRva_status());
			pstmt.setInt(8,rooVieAppVO.getRva_no());
//	   =================送出指令========================
			pstmt.executeUpdate();
		} catch (SQLException e) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
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
	public void delete(Integer rooVieAppno) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, rooVieAppno);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
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
	public RooVieAppVO findByPrimaryKey(Integer rooVieAppno) {
		RooVieAppVO rooVieAppVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE);

			pstmt.setInt(1, rooVieAppno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				rooVieAppVO  = new RooVieAppVO();
				rooVieAppVO.setRva_no(rs.getInt("rva_no"));
				rooVieAppVO.setMem_no(rs.getInt("mem_no"));
				rooVieAppVO.setHos_no(rs.getInt("hos_no"));
				rooVieAppVO.setEmp_no(rs.getInt("emp_no"));
				rooVieAppVO.setRva_app_time(rs.getTimestamp("rva_app_time"));
				rooVieAppVO.setRva_order_time(rs.getTimestamp("rva_order_time"));
				rooVieAppVO.setRva_end_time(rs.getTimestamp("rva_end_time"));
				rooVieAppVO.setRva_status(rs.getByte("rva_status"));
//				===================
			}
		} catch (SQLException se) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
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
		return rooVieAppVO;
	}

	@Override
	public List<RooVieAppVO> getAll() {
		List<RooVieAppVO> list = new ArrayList<RooVieAppVO>();
		RooVieAppVO rooVieAppVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				rooVieAppVO = new RooVieAppVO();
				rooVieAppVO.setRva_no(rs.getInt("rva_no"));
				rooVieAppVO.setMem_no(rs.getInt("mem_no"));
				rooVieAppVO.setHos_no(rs.getInt("hos_no"));
				rooVieAppVO.setEmp_no(rs.getInt("emp_no"));
				rooVieAppVO.setRva_app_time(rs.getTimestamp("rva_app_time"));
				rooVieAppVO.setRva_order_time(rs.getTimestamp("rva_order_time"));
				rooVieAppVO.setRva_end_time(rs.getTimestamp("rva_end_time"));
				rooVieAppVO.setRva_status(rs.getByte("rva_status"));
				list.add(rooVieAppVO); // Store the row in the list
			}
			// Handle any driver errors
		} catch (SQLException se) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
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
	public void addpicktime(RooVieAppVO rooVieAppVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(ADDPICKTIME);
//		========VO取值並設給preparedStatement=============
			pstmt.setInt(1,rooVieAppVO.getMem_no());
			pstmt.setInt(2, rooVieAppVO.getHos_no());
			pstmt.setTimestamp(3,rooVieAppVO.getRva_order_time());
			pstmt.setByte(4,rooVieAppVO.getRva_status());
			System.out.println("S");
			System.out.println(rooVieAppVO.getRva_order_time());
//	   =================送出指令========================
			pstmt.executeUpdate();
		} catch (SQLException e) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
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
	public void cancelpicktime(RooVieAppVO rooVieAppVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(CANCELPICKTIME);

			pstmt.setInt(1, rooVieAppVO.getMem_no());
			pstmt.setInt(2, rooVieAppVO.getHos_no());
			pstmt.setTimestamp(3, rooVieAppVO.getRva_order_time());
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
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
	public List<RooVieAppVO> listallpickTime(RooVieAppVO rooVieAppVO) {
		List<RooVieAppVO> list = new LinkedList<RooVieAppVO>();
		RooVieAppVO roovieappVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(LISTALLPICKTIME);
			pstmt.setInt(1, rooVieAppVO.getHos_no());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				roovieappVO = new RooVieAppVO();
				roovieappVO.setRva_no(rs.getInt("rva_no"));
				roovieappVO.setMem_no(rs.getInt("mem_no"));
				roovieappVO.setHos_no(rs.getInt("hos_no"));
				roovieappVO.setEmp_no(rs.getInt("emp_no"));
				roovieappVO.setRva_app_time(rs.getTimestamp("rva_app_time"));
				roovieappVO.setRva_order_time(rs.getTimestamp("rva_order_time"));
				roovieappVO.setRva_end_time(rs.getTimestamp("rva_end_time"));
				roovieappVO.setRva_status(rs.getByte("rva_status"));
				list.add(roovieappVO); // Store the row in the list
			}
			// Handle any driver errors
		} catch (SQLException se) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
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
	public List<RooVieAppVO> listNewPickTime() {
		List<RooVieAppVO> list = new ArrayList<RooVieAppVO>();
		RooVieAppVO roovieappVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(LISTNEWPICKTIME);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				roovieappVO = new RooVieAppVO();
				roovieappVO.setRva_no(rs.getInt("rva_no"));
				roovieappVO.setMem_no(rs.getInt("mem_no"));
				roovieappVO.setHos_no(rs.getInt("hos_no"));
				roovieappVO.setEmp_no(rs.getInt("emp_no"));
				roovieappVO.setRva_app_time(rs.getTimestamp("rva_app_time"));
				roovieappVO.setRva_order_time(rs.getTimestamp("rva_order_time"));
				roovieappVO.setRva_end_time(rs.getTimestamp("rva_end_time"));
				roovieappVO.setRva_status(rs.getByte("rva_status"));
				list.add(roovieappVO); // Store the row in the list
			}
			// Handle any driver errors
		} catch (SQLException se) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
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
	public Map<Integer, Timestamp> listNewRooVieApp() {
		Map<Integer,Timestamp> map = new TreeMap<Integer,Timestamp>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(LISTNEWROOVIEAPP);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				map.put(rs.getInt(1), rs.getTimestamp(2));
			}
			// Handle any driver errors
		} catch (SQLException se) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
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
		return map;
	}

	@Override
	public void changeEmp(Integer emp_no,Byte rva_status, Integer rva_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(CHANGEEMP);

//		========VO取值並設給preparedStatement=============
			pstmt.setInt(1,emp_no);
			pstmt.setByte(2, rva_status);
			pstmt.setInt(3,rva_no);
//	   =================送出指令========================
			pstmt.executeUpdate();
		} catch (SQLException e) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
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
	public List<RooVieAppVO> getEmpApp(Integer emp_no) {
		List<RooVieAppVO> list = new LinkedList<RooVieAppVO>();
		RooVieAppVO roovieappVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GETEMPAPP);
			pstmt.setInt(1, emp_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				roovieappVO = new RooVieAppVO();
				roovieappVO.setRva_no(rs.getInt("rva_no"));
				roovieappVO.setMem_no(rs.getInt("mem_no"));
				roovieappVO.setHos_no(rs.getInt("hos_no"));
				roovieappVO.setEmp_no(rs.getInt("emp_no"));
				roovieappVO.setRva_app_time(rs.getTimestamp("rva_app_time"));
				roovieappVO.setRva_order_time(rs.getTimestamp("rva_order_time"));
				roovieappVO.setRva_end_time(rs.getTimestamp("rva_end_time"));
				roovieappVO.setRva_status(rs.getByte("rva_status"));
				list.add(roovieappVO); // Store the row in the list
			}
			// Handle any driver errors
		} catch (SQLException se) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
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
			if (pstmt!= null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con!= null) {
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
	public List<RooVieAppVO> listallpickTime_noassign(RooVieAppVO rooVieAppVO) {
		List<RooVieAppVO> list = new LinkedList<RooVieAppVO>();
		RooVieAppVO roovieappVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(LISTALLPICKTIME_NOASSIGN);
			pstmt.setInt(1, rooVieAppVO.getHos_no());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				roovieappVO = new RooVieAppVO();
				roovieappVO.setRva_no(rs.getInt("rva_no"));
				roovieappVO.setMem_no(rs.getInt("mem_no"));
				roovieappVO.setHos_no(rs.getInt("hos_no"));
				roovieappVO.setEmp_no(rs.getInt("emp_no"));
				roovieappVO.setRva_app_time(rs.getTimestamp("rva_app_time"));
				roovieappVO.setRva_order_time(rs.getTimestamp("rva_order_time"));
				roovieappVO.setRva_end_time(rs.getTimestamp("rva_end_time"));
				roovieappVO.setRva_status(rs.getByte("rva_status"));
				list.add(roovieappVO); // Store the row in the list
			}
			// Handle any driver errors
		} catch (SQLException se) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
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
	public Map<RooVieAppVO, Integer> listTheEmpApp(Byte rva_status, Integer emp_no) {
		Map<RooVieAppVO,Integer> map = new LinkedHashMap<RooVieAppVO,Integer>();
		RooVieAppVO roovieappVO = null;
		Integer count = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(LISTTHEEMPAPP);
			pstmt.setByte(1, rva_status);
			pstmt.setInt(2, emp_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				roovieappVO = new RooVieAppVO();
				roovieappVO.setHos_no(rs.getInt("hos_no"));
				roovieappVO.setRva_order_time(rs.getTimestamp("MAX(RVA_ORDER_TIME)"));
				count = rs.getInt("COUNT(MEM_NO)");
				map.put(roovieappVO,count); // Store the row in the list
			}
			// Handle any driver errors
		} catch (SQLException se) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
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
			if (pstmt!= null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con!= null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return map;
	}

}

package com.renFurApp.model;

import java.util.*;
import java.sql.*;
import java.text.SimpleDateFormat;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.renFurDet.model.RenFurDetDAO;
import com.renFurDet.model.RenFurDetVO;

import oracle.jdbc.OracleConnection.CommitOption;

public class RenFurAppDAO implements RenFurAppDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/HowTrueProject");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	private static final String TABLE="RENT_FURNITURE_APPLICATION";
	private static final String INSERT_ITEM=" (mem_no,rfa_order_date,rfa_total,rfa_apct_date,rfa_status)";
//	private static final String UPDATE_ITEM="mem_no= ?,emp_no= ?,rfa_order_date= ?,rfa_total= ?,rfa_status= ?";
	private static final String UPDATE_ITEM="emp_no= ?,rfa_order_date= ?, rfa_status=?";
	private static final String PK="rfa_no";
	
	private static final String INSERT_STMT = 
		"INSERT INTO "+TABLE+INSERT_ITEM + 
		" VALUES (?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT rfa_no,mem_no,emp_no,rfa_order_date,rfa_total, rfa_apct_date,rfa_status FROM RENT_FURNITURE_APPLICATION order by rfa_no";
	private static final String GET_ONE_STMT = 
		"SELECT * FROM "+TABLE+"  where "+PK+"= ?";
	private static final String DELETE_LIST = 
		"DELETE FROM "+ TABLE+" where "+PK+"= ?";
	private static final String DELETE_DETAIL = 
			"DELETE FROM RENT_FURNTURE_DETAIL where "+PK+"= ?";
	private static final String UPDATE = 
		"UPDATE "+TABLE+" set "+UPDATE_ITEM+" where "+PK+" = ?";
	private static final String GET_LAST_RFA_NO="SELECT rfa_no FROM RENT_FURNITURE_APPLICATION order by rfa_no desc limit 1";
	//查申請單的租借狀態用
	private static final String GET_RENT_STATUS="SELECT RENT_DATE,RENT_TMT_DATE FROM RENT_FURNITURE_DETAIL WHERE rfa_no=? limit 0,1";
    //找租屋合約編號用
	private static final String GET_RENT_CONT="SELECT RTCT_NO FROM RENT_FURNITURE_DETAIL WHERE rfa_no=? limit 0,1";
	// 蔡佳 查會員的所有申請單
	private static final String GET_ALL_BY_MEM = "SELECT * FROM RENT_FURNITURE_APPLICATION WHERE mem_no=? and rfa_status=? order by rfa_no desc";
	private static final String UPDATE_STATUS_BY_PK = "UPDATE RENT_FURNITURE_APPLICATION SET rfa_status=3 WHERE rfa_no=?";
	
	@Override
	public void insertWithDetail(RenFurAppVO renFurAppVO,List<RenFurDetVO> renFurDetList) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			con = ds.getConnection();
			con.setAutoCommit(false);
			
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, renFurAppVO.getMem_no());
			pstmt.setTimestamp(2, renFurAppVO.getRfa_order_date());
			pstmt.setInt(3, renFurAppVO.getRfa_total());
			pstmt.setTimestamp(4, renFurAppVO.getRfa_apct_date());
			pstmt.setByte(5, renFurAppVO.getRfa_status());

			pstmt.executeUpdate();
			Integer getRfa_no = null;
			
			pstmt=con.prepareStatement(GET_LAST_RFA_NO);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				getRfa_no = rs.getInt(1); 
			}
			
//			rs = pstmt.getGeneratedKeys();	
//			if(rs.next()) {
//				getRfa_no = rs.getInt(1); 
//			}
//			
			
			RenFurDetDAO dao=new RenFurDetDAO();
			for(RenFurDetVO detail : renFurDetList) {
				detail.setRfa_no(getRfa_no);
				dao.insert(detail,con);
			}
			
			con.commit();
			con.setAutoCommit(true);

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
	public void update(RenFurAppVO renFurAppVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
		
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
//			pstmt.setInt(1, renFurAppVO.getMem_no());
			pstmt.setInt(1, renFurAppVO.getEmp_no());
			pstmt.setTimestamp(2, renFurAppVO.getRfa_order_date());
//			pstmt.setInt(4, renFurAppVO.getRfa_total());
			pstmt.setByte(3, renFurAppVO.getRfa_status());
			pstmt.setInt(4, renFurAppVO.getRfa_no());

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
	public void delete(Integer rfa_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			//刪申請單同步刪明細 交易控制 設定於pstmt.executeUpdate()之前
			con.setAutoCommit(false);
			
			//先刪除申請單明細
			pstmt = con.prepareStatement(DELETE_DETAIL);
			pstmt.setInt(1, rfa_no);
			pstmt.executeUpdate();
			//再刪除申請單
			pstmt = con.prepareStatement(DELETE_LIST);
			pstmt.setInt(1, rfa_no);
			pstmt.executeUpdate();
			//送出交易 並結束控制
			con.commit();
			con.setAutoCommit(true);

			// Handle any driver errors
		} catch (SQLException se) {
				try {
					//交易失敗時
					con.rollback();
				} catch(SQLException excep){
					throw new RuntimeException("Rollback error occured. "
							+ excep.getMessage());
				}
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
	public RenFurAppVO findByPrimaryKey(Integer rfa_no) {

		RenFurAppVO renFurAppVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, rfa_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				renFurAppVO = new RenFurAppVO();
				renFurAppVO.setRfa_no(rs.getInt("rfa_no"));
				renFurAppVO.setMem_no(rs.getInt("mem_no"));
				renFurAppVO.setEmp_no(rs.getInt("emp_no"));
				renFurAppVO.setRfa_order_date(rs.getTimestamp("rfa_order_date"));
				renFurAppVO.setRfa_total(rs.getInt("rfa_total"));
				renFurAppVO.setRfa_apct_date(rs.getTimestamp("rfa_apct_date"));
				renFurAppVO.setRfa_status(rs.getByte("rfa_status"));

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
		return renFurAppVO;
	}

	@Override
	public List<RenFurAppVO> getAll() {
		List<RenFurAppVO> list = new ArrayList<RenFurAppVO>();
		RenFurAppVO renFurAppVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			
			while (rs.next()) {
				renFurAppVO = new RenFurAppVO();
				renFurAppVO.setRfa_no(rs.getInt("rfa_no"));
				renFurAppVO.setMem_no(rs.getInt("mem_no"));
				renFurAppVO.setEmp_no(rs.getInt("emp_no"));
				
				renFurAppVO.setRfa_order_date(rs.getTimestamp("rfa_order_date"));
				
				renFurAppVO.setRfa_total(rs.getInt("rfa_total"));
				renFurAppVO.setRfa_apct_date(rs.getTimestamp("rfa_apct_date"));
				renFurAppVO.setRfa_status(rs.getByte("rfa_status"));
				list.add(renFurAppVO); // Store the row in the list
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
	public Byte getRenFurAppStatus(Integer rfa_no) {
		Timestamp rentFurTmtDate=null;
		Timestamp rentFurRentDate=null;
		Byte rentAppStatus=null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_RENT_STATUS);

			pstmt.setInt(1, rfa_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				rentFurTmtDate=rs.getTimestamp("rent_tmt_date");   //解租日期
				 rentFurRentDate=rs.getTimestamp("rent_date");    //出租日期
			}
			if (rentFurTmtDate!=null && rentFurRentDate!=null) {
				rentAppStatus=0; //  解租日期及出租日期都填 0表示已返還
			}else if(rentFurTmtDate==null && rentFurRentDate==null){
				rentAppStatus=1; //  解租日期及出租日期均未填 1表示未租用
			}else {
				rentAppStatus=2; //  出租日期已填 解租日期未填 2表示租用中
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
		return rentAppStatus;
	}

	
//查租屋合約編號用
	@Override
	public Integer getRentCon(Integer rfa_no) {
		Integer rtct_no=null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_RENT_CONT);

			pstmt.setInt(1, rfa_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				rtct_no=rs.getInt("rtct_no");   //租屋合約編號
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
		return rtct_no;
	}

	@Override
	public List<RenFurAppVO> getAllByMem(Integer mem_no, Byte rfa_status) {
		List<RenFurAppVO> list = new ArrayList<RenFurAppVO>();
		RenFurAppVO renFurAppVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_BY_MEM);
			
			pstmt.setInt(1, mem_no);
			pstmt.setByte(2, rfa_status);
			
			rs = pstmt.executeQuery();
			
			
			while (rs.next()) {
				renFurAppVO = new RenFurAppVO();
				renFurAppVO.setRfa_no(rs.getInt("rfa_no"));
				renFurAppVO.setMem_no(rs.getInt("mem_no"));
				renFurAppVO.setEmp_no(rs.getInt("emp_no"));
				
				renFurAppVO.setRfa_order_date(rs.getTimestamp("rfa_order_date"));
				
				renFurAppVO.setRfa_total(rs.getInt("rfa_total"));
				renFurAppVO.setRfa_apct_date(rs.getTimestamp("rfa_apct_date"));
				renFurAppVO.setRfa_status(rs.getByte("rfa_status"));
				list.add(renFurAppVO); // Store the row in the list
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
	public void updateStatusByPK(Integer rfa_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
		
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STATUS_BY_PK);
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
	

}
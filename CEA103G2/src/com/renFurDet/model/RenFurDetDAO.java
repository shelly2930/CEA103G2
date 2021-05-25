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
	private static final String INSERT_ITEM=" (rfa_no,fnt_id,rtct_no,rent_end_date) ";
	private static final String UPDATE_ITEM="rtct_no= ?,rent_date= ?,rent_end_date= ?,rent_tmt_date= ?";
	private static final String PK1="rfa_no";
	private static final String PK2="fnt_id";

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
	 private static final String DELETE_LIST_BY_PK1 = 
		"DELETE FROM " + TABLE + " where " + PK1 + "= ?";
	private static final String UPDATE = 
		"UPDATE "+TABLE+" set "+UPDATE_ITEM+" where "+PK1+"= ? and "+PK2+"=?";
	//找家具品項的未租數量
	private static final String GET_FNT_UNRENT="select fnt_unrent from HOWTRUE.FURNITURE_ITEM where FNT_IT_NO=?"; 
	//更改家具品項的未租數量		
	private static final String UPDATE_FNT_UNRENT="update FURNITURE_ITEM  set  fnt_unrent=? where FNT_IT_NO=?";
	//取未租家具品項編號
	private static final String 	GET_UNRENT_FNT_ID="SELECT fnt_id FROM HOWTRUE.FURNITURE_LIST where fnt_it_no=? and fnt_status=0 and fnt_rent_status=0 limit 1";
	//改家具品項狀態
	private static final String 	UPDATE_FNTID_STATUS ="update HOWTRUE.FURNITURE_LIST set fnt_rent_status=1 where fnt_id=?";

	
	@Override
	public void insert(RenFurDetVO renFurDetVO, Connection con) {
		System.out.println("拿到連線 進到RenForDetDAO");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			   Integer minusFnt_it_no=renFurDetVO.getFnt_id();
			   System.out.println("拿到要查家具清單的家具品項編號"+minusFnt_it_no);
//	           找家具品項編號
				   Integer getUnrentFntId=null;
				   
				   pstmt=con.prepareStatement(GET_UNRENT_FNT_ID);
				   pstmt.setInt(1,minusFnt_it_no);
				   
				   rs=pstmt.executeQuery();
				   
				   while(rs.next()) {
					   getUnrentFntId= rs.getInt(1); 
				   }
				   System.out.println("取未租品項編號"+getUnrentFntId);
	//把拿出的家具品項編號給租家具明細序號			   
				   renFurDetVO.setFnt_id(getUnrentFntId);
//				   把拿出的家具品項編號狀態改變為租借中
				   pstmt=con.prepareStatement(UPDATE_FNTID_STATUS);
				   pstmt.setInt(1,getUnrentFntId);
				   pstmt.executeUpdate();
				   System.out.println("更改清單編號狀態成功");			   
			   
//				  找家具品項的未租數量			   
			   System.out.println("拿到要減的家具品項編號"+minusFnt_it_no);
			   System.out.println("執行select fnt_unrent from HOWTRUE.FURNITURE_ITEM where FNT_IT_NO="+minusFnt_it_no);
			   pstmt=con.prepareStatement(GET_FNT_UNRENT);
			   
			   pstmt.setInt(1, minusFnt_it_no);
			   Integer unrent=null;
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   unrent = rs.getInt(1); 
				}
			   System.out.println("品項編號"+minusFnt_it_no+"目前UNRENT數: "+unrent);
//           家具品項未租數減1 改回品項
			   unrent=unrent-1;
			   System.out.println("update FURNITURE_ITEM  set  fnt_unrent="+unrent+"where FNT_IT_NO="+minusFnt_it_no);
			   pstmt=con.prepareStatement(UPDATE_FNT_UNRENT);
			   
			   pstmt.setInt(1,unrent);
			   pstmt.setInt(2,minusFnt_it_no);
			   
			   pstmt.executeUpdate();
			   System.out.println("更改品項UNRENT-1後: "+unrent);
			   

			//開始新增明細
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, renFurDetVO.getRfa_no());
			pstmt.setInt(2, renFurDetVO.getFnt_id());
			pstmt.setInt(3, renFurDetVO.getRtct_no());
			pstmt.setTimestamp(4, renFurDetVO.getRent_end_date());
			pstmt.executeUpdate();
			System.out.println("新增明細成功");
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
//			if (pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
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

//	@Override
//	public void insert(RenFurDetVO renFurDetVO) {
//		// TODO Auto-generated method stub
//		
//	}
}
package com.furLis.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.sun.org.apache.bcel.internal.generic.NEW;

//import util.CompositeQuery.util_CompositeQuery_Fnt;


public class FurLisDAO implements FurLisDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/HowTrueProject");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	private static final String TABLE="FURNITURE_LIST";
	private static final String INSERT_ITEM=" (fnt_it_no,fnt_acq_date,fnt_status,fnt_rent_status,fnt_unusable_date)";
	private static final String UPDATE_ITEM="fnt_it_no= ?,fnt_acq_date=?,fnt_status= ?,fnt_rent_status= ?,fnt_unusable_date=?";
	private static final String PK="fnt_id";
	
	private static final String INSERT_STMT = 
		"INSERT INTO "+TABLE+INSERT_ITEM + 
		" VALUES (?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT * FROM "+TABLE+ " order by "+PK;
	private static final String GET_ONE_STMT = 
		"SELECT * FROM "+TABLE+"  where "+PK+"= ?";
	private static final String DELETE = 
		"DELETE FROM "+TABLE+" where "+PK+"= ?";
	private static final String UPDATE = 
		"UPDATE "+TABLE+" set "+UPDATE_ITEM+" where "+PK+" = ?";
	//查某家具品項的所有清單
		private static final String GET_ONE_FUR_ITEM_LIST_STMT="SELECT * FROM FURNITURE_LIST where fnt_it_no= ? order by fnt_id";
	//新增狀態正常清單時品項數量變化
		private static final String INSERT_NOMAL_LIST="update FURNITURE_ITEM  set  fnt_unrent=fnt_unrent+1,fnt_total=fnt_total+1 where FNT_IT_NO=?";
	//新增狀態維修清單時品項數量變化
		private static final String INSERT_REPAIR_LIST="update FURNITURE_ITEM  set  fnt_repair=fnt_repair+1,fnt_total=fnt_total+1 where FNT_IT_NO=?";
	//找正常未租
		private static final String GET_UNRENT_NORMAL="SELECT count(*) FROM HOWTRUE.FURNITURE_LIST where FNT_IT_NO=? and FNT_STATUS=0 and FNT_RENT_STATUS=0";
		//從清單編號找品項編號
		private static final String GET_FNTITNO_BY_ID="SELECT fnt_it_no FROM HOWTRUE.FURNITURE_LIST where FNT_ID=?";
	//找各狀態
		private static final String GET_FNT_STATUS_MAP="SELECT FNT_STATUS,count(*) as count FROM HOWTRUE.FURNITURE_LIST where FNT_IT_NO=? group by fnt_status order by FNT_STATUS";
	//更改品項中各狀態數量
		private static final String UPDATE_ONE_FUR_INT_COUNT="update FURNITURE_ITEM  set  fnt_unrent=?,fnt_repair=?,fnt_total=? where FNT_IT_NO=?";
		
	@Override
	public void insert(FurLisVO furLisVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, furLisVO.getFnt_it_no());
			pstmt.setTimestamp(2,furLisVO.getFnt_acq_date());
			pstmt.setByte(3, furLisVO.getFnt_status());
			pstmt.setByte(4, furLisVO.getFnt_rent_status());
			pstmt.setTimestamp(5,furLisVO.getFnt_unusable_date());
			
			pstmt.executeUpdate();
			
			//改品項表單數量
			if(furLisVO.getFnt_status()==0) {
				pstmt = con.prepareStatement(INSERT_NOMAL_LIST);
				pstmt.setInt(1,furLisVO.getFnt_it_no());
				pstmt.executeUpdate();
			}else if(furLisVO.getFnt_status()==1) {
				pstmt = con.prepareStatement(INSERT_REPAIR_LIST);
				pstmt.setInt(1,furLisVO.getFnt_it_no());
				pstmt.executeUpdate();
			}

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
	public void update(FurLisVO furLisVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setInt(1, furLisVO.getFnt_it_no());
			pstmt.setTimestamp(2,furLisVO.getFnt_acq_date());
			pstmt.setByte(3, furLisVO.getFnt_status());
			pstmt.setByte(4, furLisVO.getFnt_rent_status());
			pstmt.setTimestamp(5,furLisVO.getFnt_unusable_date());
			pstmt.setInt(6, furLisVO.getFnt_id());

			pstmt.executeUpdate();
			
			//找狀態正常未租
			 Integer getUnrentNormal=null;
				pstmt=con.prepareStatement(GET_UNRENT_NORMAL);
				pstmt.setInt(1,furLisVO.getFnt_it_no());
					   
				rs=pstmt.executeQuery();
					   
				while(rs.next()) {
					getUnrentNormal= rs.getInt(1); 
				}
			
			//找狀態
			Map<Byte, Integer> fntStatusMap=new LinkedHashMap<>();
				pstmt=con.prepareStatement(GET_FNT_STATUS_MAP);
				pstmt.setInt(1,furLisVO.getFnt_it_no());
				rs=pstmt.executeQuery();
				while(rs.next()) {
					fntStatusMap.put(rs.getByte(1), rs.getInt(2));
				}
				
				Integer fnt_total,fnt_repair,fnt_normal;
				fnt_normal=(fntStatusMap.get(new Byte("0"))==null) ? 0:fntStatusMap.get(new Byte("0"));
				fnt_repair=(fntStatusMap.get(new Byte("1"))==null) ? 0:fntStatusMap.get(new Byte("1"));
				fnt_total=fnt_normal+fnt_repair;
				
				//更改品項數量
				pstmt = con.prepareStatement(UPDATE_ONE_FUR_INT_COUNT);
				pstmt.setInt(1, getUnrentNormal);
				pstmt.setInt(2, fnt_repair);
				pstmt.setInt(3, fnt_total);
				pstmt.setInt(4, furLisVO.getFnt_it_no());

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
	public void delete(Integer fnt_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_FNTITNO_BY_ID);
			pstmt.setInt(1,fnt_id);
			rs=pstmt.executeQuery();
			Integer fnt_it_no=null;
			while(rs.next()) {
				fnt_it_no=rs.getInt(1);
			}
			pstmt = con.prepareStatement(DELETE);
			pstmt.setInt(1, fnt_id);
			pstmt.executeUpdate();
			
			//找狀態正常未租
			 Integer getUnrentNormal=null;
				pstmt=con.prepareStatement(GET_UNRENT_NORMAL);
				pstmt.setInt(1,fnt_it_no);
					   
				rs=pstmt.executeQuery();
					   
				while(rs.next()) {
					getUnrentNormal= rs.getInt(1); 
				}
			
			//找狀態
			Map<Byte, Integer> fntStatusMap=new LinkedHashMap<>();
				pstmt=con.prepareStatement(GET_FNT_STATUS_MAP);
				pstmt.setInt(1,fnt_it_no);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					fntStatusMap.put(rs.getByte(1), rs.getInt(2));
				}
				
				Integer fnt_total,fnt_repair,fnt_normal;
				fnt_normal=(fntStatusMap.get(new Byte("0"))==null) ? 0:fntStatusMap.get(new Byte("0"));
				fnt_repair=(fntStatusMap.get(new Byte("1"))==null) ? 0:fntStatusMap.get(new Byte("1"));
				fnt_total=fnt_normal+fnt_repair;
				
				//更改品項數量
				pstmt = con.prepareStatement(UPDATE_ONE_FUR_INT_COUNT);
				pstmt.setInt(1, getUnrentNormal);
				pstmt.setInt(2, fnt_repair);
				pstmt.setInt(3, fnt_total);
				pstmt.setInt(4, fnt_it_no);

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
	public FurLisVO findByPrimaryKey(Integer fnt_id) {

		FurLisVO furLisVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1,fnt_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				furLisVO = new FurLisVO();
				furLisVO.setFnt_id(rs.getInt("fnt_id"));
				furLisVO.setFnt_it_no(rs.getInt("fnt_it_no"));
				furLisVO.setFnt_acq_date(rs.getTimestamp("fnt_acq_date"));
				furLisVO.setFnt_status(rs.getByte("fnt_status"));
				furLisVO.setFnt_rent_status(rs.getByte("fnt_rent_status"));
				furLisVO.setFnt_unusable_date(rs.getTimestamp("fnt_unusable_date"));
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
		return furLisVO;
	}

	@Override
	public List<FurLisVO> getAll() {
		List<FurLisVO> list = new ArrayList<FurLisVO>();
		FurLisVO furLisVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				furLisVO = new FurLisVO();
				furLisVO.setFnt_id(rs.getInt("fnt_id"));
				furLisVO.setFnt_it_no(rs.getInt("fnt_it_no"));
				furLisVO.setFnt_acq_date(rs.getTimestamp("fnt_acq_date"));
				furLisVO.setFnt_status(rs.getByte("fnt_status"));
				furLisVO.setFnt_rent_status(rs.getByte("fnt_rent_status"));
				furLisVO.setFnt_unusable_date(rs.getTimestamp("fnt_unusable_date"));
				list.add(furLisVO); // Store the row in the list
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
//	複合查詢 待改
	@Override
	public List<FurLisVO> getAll(Map<String, String[]> map) {
		List<FurLisVO> list = new ArrayList<FurLisVO>();
		FurLisVO furLisVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			
			con = ds.getConnection();
//			String finalSQL = "select * from emp2 "
//		          + util_CompositeQuery_Fnt.get_WhereCondition(map)
//		          + "order by empno";
//			pstmt = con.prepareStatement(finalSQL);
//			System.out.println("●●finalSQL(by DAO) = "+finalSQL);
//			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				furLisVO = new FurLisVO();
				furLisVO.setFnt_id(rs.getInt("fnt_id"));
				furLisVO.setFnt_it_no(rs.getInt("fnt_it_no"));
				furLisVO.setFnt_acq_date(rs.getTimestamp("fnt_acq_date"));
				furLisVO.setFnt_status(rs.getByte("fnt_status"));
				furLisVO.setFnt_rent_status(rs.getByte("fnt_rent_status"));
				furLisVO.setFnt_unusable_date(rs.getTimestamp("fnt_unusable_date"));
				list.add(furLisVO); // Store the row in the List
			}
	
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
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

	//取一個品項的每個家具(品項清單)
	@Override
	public List<FurLisVO> getOneFur_Item_Lis(Integer fnt_it_no) {
		List<FurLisVO> list = new ArrayList<FurLisVO>();
		FurLisVO furLisVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_FUR_ITEM_LIST_STMT);
			pstmt.setInt(1,fnt_it_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				furLisVO = new FurLisVO();
				furLisVO.setFnt_id(rs.getInt("fnt_id"));
				furLisVO.setFnt_it_no(rs.getInt("fnt_it_no"));
				furLisVO.setFnt_acq_date(rs.getTimestamp("fnt_acq_date"));
				furLisVO.setFnt_status(rs.getByte("fnt_status"));
				furLisVO.setFnt_rent_status(rs.getByte("fnt_rent_status"));
				furLisVO.setFnt_unusable_date(rs.getTimestamp("fnt_unusable_date"));
				list.add(furLisVO); // Store the row in the list
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
	//多表格查詢
//	@Override
//	public List<FurLisVO> getMultiQuery(Integer furCatSelect,Integer furIteSelect,Integer fntStatusSelect,Integer rentStatusSelect) {
//		List<FurLisVO> multiQueryList=new ArrayList<>();
//		
//		
//			return multiQueryList;
//		}
//		
}
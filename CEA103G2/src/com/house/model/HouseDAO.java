package com.house.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.houPho.model.HouPhoVO;

import jdbcUtil_CompositeQuery_advance.CQ_advance_house;
import jdbcUtil_CompositeQuery_advance.CQ_house_back;

public class HouseDAO implements HouseDAO_interface {
	private static DataSource ds = null;
	private static String qm = "?";
	//填你需要多少個?====================================================================		
//	COUNTQUESTION用在insert需要幾個?(不含PK)
	private static final int COUNTQUESTION = 32;
	//=================================================================================
	static {
		for (int i = 0; i < COUNTQUESTION - 1; i++) {
			qm += ",?";
		}
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/HowTrueProject");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
//填你資料庫內容==========================================================================	
	private static final String TABLE = "HOUSE";
	private static final String PK = "hos_no";
	private static final String QUESTIONMARKS = qm;
	private static final String REDUCE_PK_COL = "lld_no, " + "hos_name, " + "hos_rent, " + "hos_expense, "
			+ "hos_date, " + "hos_views, " + "hos_city, " + "hos_dist, " + "hos_address, " + "hos_lon, " + "hos_lat, "
			+ "hos_type, " + "hos_info, " + "hos_age, " + "hos_floor, " + "hos_ele, " + "hos_parking, " + "hos_pet, "
			+ "hos_cook, " + "hos_squares, " + "hos_gender, " + "hos_water, " + "hos_power, " + "hos_internet, "
			+ "hos_apptime, " + "hos_order_date, " + "emp_no, " + "hos_status, " + "hos_result, " + "hos_loc_pic, "
			+ "hos_state, " + "hos_refuse";
	private static final String TOTAL_COL = "hos_no, " + REDUCE_PK_COL;
//	註記: for Set 要去掉主鍵
	private static final String FOR_SET = "lld_no=?, " + "hos_name=?, " + "hos_rent=?, " + "hos_expense=?, "
			+ "hos_date=?, " + "hos_views=?, " + "hos_city=?, " + "hos_dist=?, " + "hos_address=?, " + "hos_lon=?, "
			+ "hos_lat=?, " + "hos_type=?, " + "hos_info=?, " + "hos_age=?, " + "hos_floor=?, " + "hos_ele=?, "
			+ "hos_parking=?, " + "hos_pet=?, " + "hos_cook=?, " + "hos_squares=?, " + "hos_gender=?, "
			+ "hos_water=?, " + "hos_power=?, " + "hos_internet=?, " + "hos_apptime=?, " + "hos_order_date=?, "
			+ "emp_no=?, " + "hos_status=?, " + "hos_result=?, " + "hos_loc_pic=?, " + "hos_state=?, " + "hos_refuse=?";
//===============================================================================
	private static final String INSERT = "INSERT INTO " + TABLE + "(" + REDUCE_PK_COL + ") VALUES (" + QUESTIONMARKS
			+ ")";
	private static final String GET_ALL = "SELECT " + TOTAL_COL + " FROM " + TABLE + " order by " + PK;
	private static final String GET_ONE = "SELECT " + TOTAL_COL + " FROM " + TABLE + " where " + PK + "= ?";
	private static final String UPDATE = "UPDATE " + TABLE + " set " + FOR_SET + " where " + PK + "=?";
	private static final String DELETE_HOUADDFUR = "DELETE FROM HOUSE_ADDITIONAL_FURNITURE where hos_no = ?";
	private static final String DELETE_HOUPHO = "DELETE FROM HOUSE_PHOTO where hos_no = ?";
	private static final String GET_HOUPHO_By_HOUSE = "SELECT hos_pic_no, hos_no, hos_pic FROM HOUSE_PHOTO where hos_no = ? order by hos_pic_no";
	private static final String GET_ALL_BY_STATE = "SELECT HOS_NO,HOS_NAME,HOS_DATE,HOS_INFO,EMP_NO,HOS_STATE,HOS_STATUS FROM HOUSE where HOS_STATE=? and HOS_STATUS=? order by HOS_STATE" ;
	
	private static final String PULLORPUSH = "UPDATE HOUSE SET HOS_STATE=? WHERE HOS_NO=?";
	private static final String SEARCH = "SELECT * FROM HOUSE WHERE HOS_NAME LIKE ? OR HOS_CITY LIKE ? OR HOS_DIST LIKE ? OR HOS_ADDRESS LIKE ? OR HOS_INFO LIKE ?";
	//新增物件
	@Override
	public void insert(HouseVO houseVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
			pstmt.setInt(1, houseVO.getLld_no());
			pstmt.setString(2, houseVO.getHos_name());
			pstmt.setInt(3, houseVO.getHos_rent());
			pstmt.setInt(4, houseVO.getHos_expense());
			pstmt.setTimestamp(5, houseVO.getHos_date());
			pstmt.setInt(6, houseVO.getHos_views());
			pstmt.setString(7, houseVO.getHos_city());
			pstmt.setString(8, houseVO.getHos_dist());
			pstmt.setString(9, houseVO.getHos_address());
			pstmt.setDouble(10, houseVO.getHos_lon());
			pstmt.setDouble(11, houseVO.getHos_lat());
			pstmt.setByte(12, houseVO.getHos_type());
			pstmt.setString(13, houseVO.getHos_info());
			pstmt.setInt(14, houseVO.getHos_age());
			pstmt.setInt(15, houseVO.getHos_floor());
			pstmt.setByte(16, houseVO.getHos_ele());
			pstmt.setByte(17, houseVO.getHos_parking());
			pstmt.setByte(18, houseVO.getHos_pet());
			pstmt.setByte(19, houseVO.getHos_cook());
			pstmt.setDouble(20, houseVO.getHos_squares());
			pstmt.setByte(21, houseVO.getHos_gender());
			pstmt.setDouble(22, houseVO.getHos_water());
			pstmt.setDouble(23, houseVO.getHos_power());
			pstmt.setInt(24, houseVO.getHos_internet());
			pstmt.setTimestamp(25, houseVO.getHos_apptime());
			pstmt.setTimestamp(26, houseVO.getHos_order_date());
			pstmt.setInt(27, houseVO.getEmp_no());
			pstmt.setByte(28, houseVO.getHos_status());
			pstmt.setByte(29, houseVO.getHos_result());
			pstmt.setBytes(30, houseVO.getHos_loc_pic());
			pstmt.setByte(31, houseVO.getHos_state());
			pstmt.setString(32, houseVO.getHos_refuse());
			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("HouseDAO資料庫錯了!!!!"
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
	//修改物件
	@Override
	public void update(HouseVO houseVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setInt(1, houseVO.getLld_no());
			pstmt.setString(2, houseVO.getHos_name());
			pstmt.setInt(3, houseVO.getHos_rent());
			pstmt.setInt(4, houseVO.getHos_expense());
			pstmt.setTimestamp(5, houseVO.getHos_date());
			pstmt.setInt(6, houseVO.getHos_views());
			pstmt.setString(7, houseVO.getHos_city());
			pstmt.setString(8, houseVO.getHos_dist());
			pstmt.setString(9, houseVO.getHos_address());
			pstmt.setDouble(10, houseVO.getHos_lon());
			pstmt.setDouble(11, houseVO.getHos_lat());
			pstmt.setByte(12, houseVO.getHos_type());
			pstmt.setString(13, houseVO.getHos_info());
			pstmt.setInt(14, houseVO.getHos_age());
			pstmt.setInt(15, houseVO.getHos_floor());
			pstmt.setByte(16, houseVO.getHos_ele());
			pstmt.setByte(17, houseVO.getHos_parking());
			pstmt.setByte(18, houseVO.getHos_pet());
			pstmt.setByte(19, houseVO.getHos_cook());
			pstmt.setDouble(20, houseVO.getHos_squares());
			pstmt.setByte(21, houseVO.getHos_gender());
			pstmt.setDouble(22, houseVO.getHos_water());
			pstmt.setDouble(23, houseVO.getHos_power());
			pstmt.setInt(24, houseVO.getHos_internet());
			pstmt.setTimestamp(25, houseVO.getHos_apptime());
			pstmt.setTimestamp(26, houseVO.getHos_order_date());
			pstmt.setInt(27, houseVO.getEmp_no());
			pstmt.setByte(28, houseVO.getHos_status());
			pstmt.setByte(29, houseVO.getHos_result());
			pstmt.setBytes(30, houseVO.getHos_loc_pic());
			pstmt.setByte(31, houseVO.getHos_state());
			pstmt.setString(32, houseVO.getHos_refuse());
			pstmt.setInt(33, houseVO.getHos_no());
			pstmt.executeUpdate();
			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("HouseDAO資料庫錯了!!!!"
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
	public HouseVO findByPrimaryKey(Integer houseno) {
		HouseVO houseVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE);
			pstmt.setInt(1, houseno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				houseVO = new HouseVO();
				houseVO.setHos_no(rs.getInt("hos_no"));
				houseVO.setLld_no(rs.getInt("lld_no"));
				houseVO.setHos_name(rs.getString("hos_name"));
				houseVO.setHos_rent(rs.getInt("hos_rent"));
				houseVO.setHos_expense(rs.getInt("hos_expense"));
				houseVO.setHos_date(rs.getTimestamp("hos_date"));
				houseVO.setHos_views(rs.getInt("hos_views"));
				houseVO.setHos_city(rs.getString("hos_city"));
				houseVO.setHos_dist(rs.getString("hos_dist"));
				houseVO.setHos_address(rs.getString("hos_address"));
				houseVO.setHos_lon(rs.getDouble("hos_lon"));
				houseVO.setHos_lat(rs.getDouble("hos_lat"));
				houseVO.setHos_type(rs.getByte("hos_type"));
				houseVO.setHos_info(rs.getString("hos_info"));
				houseVO.setHos_age(rs.getInt("hos_age"));
				houseVO.setHos_floor(rs.getInt("hos_floor"));
				houseVO.setHos_ele(rs.getByte("hos_ele"));
				houseVO.setHos_parking(rs.getByte("hos_parking"));
				houseVO.setHos_pet(rs.getByte("hos_pet"));
				houseVO.setHos_cook(rs.getByte("hos_cook"));
				houseVO.setHos_squares(rs.getDouble("hos_squares"));
				houseVO.setHos_gender(rs.getByte("hos_gender"));
				houseVO.setHos_water(rs.getDouble("hos_water"));
				houseVO.setHos_power(rs.getDouble("hos_power"));
				houseVO.setHos_internet(rs.getInt("hos_internet"));
				houseVO.setHos_apptime(rs.getTimestamp("hos_apptime"));
				houseVO.setHos_order_date(rs.getTimestamp("hos_order_date"));
				houseVO.setEmp_no(rs.getInt("emp_no"));
				houseVO.setHos_status(rs.getByte("hos_status"));
				houseVO.setHos_result(rs.getByte("hos_result"));
				houseVO.setHos_loc_pic(rs.getBytes("hos_loc_pic"));
				houseVO.setHos_state(rs.getByte("hos_state"));
				houseVO.setHos_refuse(rs.getString("hos_refuse"));
			}
			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("HouseDAO資料庫錯了!!!!"
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
		return houseVO;
	}
	
	//純粹拉出所有物件
	@Override
	public List<HouseVO> getAll() {
		List<HouseVO> list = new ArrayList<HouseVO>();
		HouseVO houseVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// empVO 也稱為 Domain objects
				houseVO = new HouseVO();
				houseVO.setHos_no(rs.getInt("hos_no"));
				houseVO.setLld_no(rs.getInt("lld_no"));
				houseVO.setHos_name(rs.getString("hos_name"));
				houseVO.setHos_rent(rs.getInt("hos_rent"));
				houseVO.setHos_expense(rs.getInt("hos_expense"));
				houseVO.setHos_date(rs.getTimestamp("hos_date"));
				houseVO.setHos_views(rs.getInt("hos_views"));
				houseVO.setHos_city(rs.getString("hos_city"));
				houseVO.setHos_dist(rs.getString("hos_dist"));
				houseVO.setHos_address(rs.getString("hos_address"));
				houseVO.setHos_lon(rs.getDouble("hos_lon"));
				houseVO.setHos_lat(rs.getDouble("hos_lat"));
				houseVO.setHos_type(rs.getByte("hos_type"));
				houseVO.setHos_info(rs.getString("hos_info"));
				houseVO.setHos_age(rs.getInt("hos_age"));
				houseVO.setHos_floor(rs.getInt("hos_floor"));
				houseVO.setHos_ele(rs.getByte("hos_ele"));
				houseVO.setHos_parking(rs.getByte("hos_parking"));
				houseVO.setHos_pet(rs.getByte("hos_pet"));
				houseVO.setHos_cook(rs.getByte("hos_cook"));
				houseVO.setHos_squares(rs.getDouble("hos_squares"));
				houseVO.setHos_gender(rs.getByte("hos_gender"));
				houseVO.setHos_water(rs.getDouble("hos_water"));
				houseVO.setHos_power(rs.getDouble("hos_power"));
				houseVO.setHos_internet(rs.getInt("hos_internet"));
				houseVO.setHos_apptime(rs.getTimestamp("hos_apptime"));
				houseVO.setHos_order_date(rs.getTimestamp("hos_order_date"));
				houseVO.setEmp_no(rs.getInt("emp_no"));
				houseVO.setHos_status(rs.getByte("hos_status"));
				houseVO.setHos_result(rs.getByte("hos_result"));
				houseVO.setHos_loc_pic(rs.getBytes("hos_loc_pic"));
				houseVO.setHos_state(rs.getByte("hos_state"));
				houseVO.setHos_refuse(rs.getString("hos_refuse"));
				list.add(houseVO); // Store the row in the list
			}
			// Handle any driver errors
		} catch (SQLException se) {
//			RuntimeException老師說，為了丟出例外，
//			當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//			否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
			throw new RuntimeException("HouseDAO資料庫錯了!!!!"
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

	
//複合查詢用(前台用)
	@Override
	public List<HouseVO> getAll(Map<String, String[]> map) {
		List<HouseVO> list = new ArrayList<HouseVO>();
		HouseVO houseVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			con = ds.getConnection();
			String finalSQL = "select * from "+TABLE+" "
		          + CQ_advance_house.get_WhereCondition(map);
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("finalSQL"+finalSQL);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				houseVO = new HouseVO();
				houseVO.setHos_no(rs.getInt("hos_no"));
				houseVO.setLld_no(rs.getInt("lld_no"));
				houseVO.setHos_name(rs.getString("hos_name"));
				houseVO.setHos_rent(rs.getInt("hos_rent"));
				houseVO.setHos_expense(rs.getInt("hos_expense"));
				houseVO.setHos_date(rs.getTimestamp("hos_date"));
				houseVO.setHos_views(rs.getInt("hos_views"));
				houseVO.setHos_city(rs.getString("hos_city"));
				houseVO.setHos_dist(rs.getString("hos_dist"));
				houseVO.setHos_address(rs.getString("hos_address"));
				houseVO.setHos_lon(rs.getDouble("hos_lon"));
				houseVO.setHos_lat(rs.getDouble("hos_lat"));
				houseVO.setHos_type(rs.getByte("hos_type"));
				houseVO.setHos_info(rs.getString("hos_info"));
				houseVO.setHos_age(rs.getInt("hos_age"));
				houseVO.setHos_floor(rs.getInt("hos_floor"));
				houseVO.setHos_ele(rs.getByte("hos_ele"));
				houseVO.setHos_parking(rs.getByte("hos_parking"));
				houseVO.setHos_pet(rs.getByte("hos_pet"));
				houseVO.setHos_cook(rs.getByte("hos_cook"));
				houseVO.setHos_squares(rs.getDouble("hos_squares"));
				houseVO.setHos_gender(rs.getByte("hos_gender"));
				houseVO.setHos_water(rs.getDouble("hos_water"));
				houseVO.setHos_power(rs.getDouble("hos_power"));
				houseVO.setHos_internet(rs.getInt("hos_internet"));
				houseVO.setHos_apptime(rs.getTimestamp("hos_apptime"));
				houseVO.setHos_order_date(rs.getTimestamp("hos_order_date"));
				houseVO.setEmp_no(rs.getInt("emp_no"));
				houseVO.setHos_status(rs.getByte("hos_status"));
				houseVO.setHos_result(rs.getByte("hos_result"));
				houseVO.setHos_loc_pic(rs.getBytes("hos_loc_pic"));
				houseVO.setHos_state(rs.getByte("hos_state"));
				houseVO.setHos_refuse(rs.getString("hos_refuse"));
				list.add(houseVO); // Store the row in the List
			}
		} catch (SQLException se) {
			throw new RuntimeException("HouseDAO資料庫錯了!!!!"
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
//後台用	
	@Override
	public List<HouseVO> getAll_Back(Map<String, String[]> map) {
		List<HouseVO> list = new ArrayList<HouseVO>();
		HouseVO houseVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Set<String> s = map.keySet();
		try {
			con = ds.getConnection();
			String finalSQL = "select * from "+TABLE+" "
		          + CQ_house_back.get_WhereCondition(map);
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("finalSQL"+finalSQL);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				houseVO = new HouseVO();
				houseVO.setHos_no(rs.getInt("hos_no"));
				houseVO.setLld_no(rs.getInt("lld_no"));
				houseVO.setHos_name(rs.getString("hos_name"));
				houseVO.setHos_rent(rs.getInt("hos_rent"));
				houseVO.setHos_expense(rs.getInt("hos_expense"));
				houseVO.setHos_date(rs.getTimestamp("hos_date"));
				houseVO.setHos_views(rs.getInt("hos_views"));
				houseVO.setHos_city(rs.getString("hos_city"));
				houseVO.setHos_dist(rs.getString("hos_dist"));
				houseVO.setHos_address(rs.getString("hos_address"));
				houseVO.setHos_lon(rs.getDouble("hos_lon"));
				houseVO.setHos_lat(rs.getDouble("hos_lat"));
				houseVO.setHos_type(rs.getByte("hos_type"));
				houseVO.setHos_info(rs.getString("hos_info"));
				houseVO.setHos_age(rs.getInt("hos_age"));
				houseVO.setHos_floor(rs.getInt("hos_floor"));
				houseVO.setHos_ele(rs.getByte("hos_ele"));
				houseVO.setHos_parking(rs.getByte("hos_parking"));
				houseVO.setHos_pet(rs.getByte("hos_pet"));
				houseVO.setHos_cook(rs.getByte("hos_cook"));
				houseVO.setHos_squares(rs.getDouble("hos_squares"));
				houseVO.setHos_gender(rs.getByte("hos_gender"));
				houseVO.setHos_water(rs.getDouble("hos_water"));
				houseVO.setHos_power(rs.getDouble("hos_power"));
				houseVO.setHos_internet(rs.getInt("hos_internet"));
				houseVO.setHos_apptime(rs.getTimestamp("hos_apptime"));
				houseVO.setHos_order_date(rs.getTimestamp("hos_order_date"));
				houseVO.setEmp_no(rs.getInt("emp_no"));
				houseVO.setHos_status(rs.getByte("hos_status"));
				houseVO.setHos_result(rs.getByte("hos_result"));
				houseVO.setHos_loc_pic(rs.getBytes("hos_loc_pic"));
				houseVO.setHos_state(rs.getByte("hos_state"));
				houseVO.setHos_refuse(rs.getString("hos_refuse"));
				list.add(houseVO); // Store the row in the List
			}
		} catch (SQLException se) {
			throw new RuntimeException("HouseDAO資料庫錯了!!!!"
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
//	以下: 一(物件)對多(物件照片)===============================================================    
    //物件編號 去拉出所有屬於這物件的照片
		@Override
		public Set<HouPhoVO> getHouPhoByHouse(Integer houseno) {
			Set<HouPhoVO> set = new LinkedHashSet<HouPhoVO>();
			HouPhoVO houPhoVO = null;
		
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
		
			try {
		
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_HOUPHO_By_HOUSE);
				pstmt.setInt(1, houseno);
				rs = pstmt.executeQuery();
		
				while (rs.next()) {
					houPhoVO = new HouPhoVO();
					houPhoVO.setHos_pic_no(rs.getInt("hos_pic_no"));
					houPhoVO.setHos_no(rs.getInt("hos_no"));
					houPhoVO.setHos_pic(rs.getBytes("hos_pic"));
				
					set.add(houPhoVO); // Store the row in the vector
				}
		
				// Handle any SQL errors
			} catch (SQLException se) {
//				RuntimeException老師說，為了丟出例外，
//				當時測試，若沒有這個 當資料庫發生錯誤 必須把錯誤丟給controller
//				否則這裡顯示錯誤就處理掉了，但前台都沒發生報錯
				throw new RuntimeException("HouseDAO資料庫錯了!!!!"
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
			return set;
		}
//平台管理員 負責案件 
		@Override
		public List<HouseVO> getAllByState(Byte state,Byte status) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			List<HouseVO> list = new ArrayList<HouseVO>();
			HouseVO houseVO  = null;
				try {
					con = ds.getConnection();
					pstmt = con.prepareStatement(GET_ALL_BY_STATE);
					pstmt.setInt(1,state);
					pstmt.setInt(2,status);
					rs = pstmt.executeQuery();
					while(rs.next()) {
						houseVO = new HouseVO();
						houseVO.setHos_no(rs.getInt("hos_no"));
						houseVO.setHos_name(rs.getString("HOS_NAME"));
						houseVO.setHos_date(rs.getTimestamp("HOS_DATE"));
						houseVO.setHos_info(rs.getString("HOS_INFO"));
						houseVO.setEmp_no(rs.getInt("EMP_NO"));
						houseVO.setHos_state(rs.getByte("HOS_STATE"));
						houseVO.setHos_status(rs.getByte("HOS_STATUS"));
						list.add(houseVO);
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					throw new RuntimeException(e.getMessage());
				}finally {
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
		public void updateHouseContent(HouseVO houseVO) {
			Connection con= null;
			PreparedStatement ps= null;
			try {
				con = ds.getConnection();
				ps = con.prepareStatement("UPDATE HOUSE SET HOS_NAME=?, HOS_INFO=? WHERE "+ PK+"= ? ");
				ps.setString(1,houseVO.getHos_name());
				ps.setString(2,houseVO.getHos_info());
				ps.setInt(3,houseVO.getHos_no());
				ps.executeUpdate();
			} catch (SQLException e) {
				throw new RuntimeException(e.getMessage());
			}finally {
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
		public void updateHouseState(HouseVO houseVO) {
			Connection con= null;
			PreparedStatement ps= null;
			try {
				con = ds.getConnection();
				ps = con.prepareStatement("UPDATE HOUSE SET HOS_STATE=?, HOS_STATUS=?,HOS_DATE=? WHERE "+ PK+"= ? ");
				ps.setByte(1,houseVO.getHos_state());
				ps.setByte(2,houseVO.getHos_status());
				ps.setTimestamp(3, houseVO.getHos_date());
				ps.setInt(4,houseVO.getHos_no());
				
				ps.executeUpdate();
			} catch (SQLException e) {
				throw new RuntimeException(e.getMessage());
			}finally {
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
		public void pullorpush(Integer houseno,Byte state) {
			Connection con= null;
			PreparedStatement ps= null;
			try {
				con = ds.getConnection();
				ps = con.prepareStatement(PULLORPUSH);
				ps.setByte(1,state);
				ps.setInt(2,houseno);
				ps.executeUpdate();
			} catch (SQLException e) {
				throw new RuntimeException(e.getMessage());
			}finally {
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
		public List<HouseVO> search(String key) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<HouseVO> list = new ArrayList<HouseVO>();
			HouseVO houseVO  = null;
			System.out.println(SEARCH);
			String keyword = "%"+key+"%";
				try {
					con = ds.getConnection();
					pstmt = con.prepareStatement(SEARCH);
					pstmt.setString(1,keyword);
					pstmt.setString(2,keyword);
					pstmt.setString(3,keyword);
					pstmt.setString(4,keyword);
					pstmt.setString(5,keyword);
					rs = pstmt.executeQuery();
					while(rs.next()) {
						houseVO = new HouseVO();
						houseVO.setHos_no(rs.getInt("hos_no"));
						houseVO.setLld_no(rs.getInt("lld_no"));
						houseVO.setHos_name(rs.getString("hos_name"));
						houseVO.setHos_rent(rs.getInt("hos_rent"));
						houseVO.setHos_expense(rs.getInt("hos_expense"));
						houseVO.setHos_date(rs.getTimestamp("hos_date"));
						houseVO.setHos_views(rs.getInt("hos_views"));
						houseVO.setHos_city(rs.getString("hos_city"));
						houseVO.setHos_dist(rs.getString("hos_dist"));
						houseVO.setHos_address(rs.getString("hos_address"));
						houseVO.setHos_lon(rs.getDouble("hos_lon"));
						houseVO.setHos_lat(rs.getDouble("hos_lat"));
						houseVO.setHos_type(rs.getByte("hos_type"));
						houseVO.setHos_info(rs.getString("hos_info"));
						houseVO.setHos_age(rs.getInt("hos_age"));
						houseVO.setHos_floor(rs.getInt("hos_floor"));
						houseVO.setHos_ele(rs.getByte("hos_ele"));
						houseVO.setHos_parking(rs.getByte("hos_parking"));
						houseVO.setHos_pet(rs.getByte("hos_pet"));
						houseVO.setHos_cook(rs.getByte("hos_cook"));
						houseVO.setHos_squares(rs.getDouble("hos_squares"));
						houseVO.setHos_gender(rs.getByte("hos_gender"));
						houseVO.setHos_water(rs.getDouble("hos_water"));
						houseVO.setHos_power(rs.getDouble("hos_power"));
						houseVO.setHos_internet(rs.getInt("hos_internet"));
						houseVO.setHos_apptime(rs.getTimestamp("hos_apptime"));
						houseVO.setHos_order_date(rs.getTimestamp("hos_order_date"));
						houseVO.setEmp_no(rs.getInt("emp_no"));
						houseVO.setHos_status(rs.getByte("hos_status"));
						houseVO.setHos_result(rs.getByte("hos_result"));
						houseVO.setHos_loc_pic(rs.getBytes("hos_loc_pic"));
						houseVO.setHos_state(rs.getByte("hos_state"));
						houseVO.setHos_refuse(rs.getString("hos_refuse"));
						list.add(houseVO); // Store the row in the list
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					throw new RuntimeException(e.getMessage());
				}finally {
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

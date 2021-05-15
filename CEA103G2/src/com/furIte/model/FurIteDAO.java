package com.furIte.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.furPho.model.FurPhoVO;

public class FurIteDAO implements FurIteDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/HowTrueProject");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = 
		"INSERT INTO FURNITURE_ITEM (fnt_ctgr_no,fnt_name,fnt_unrent,fnt_repair,fnt_total,fnt_price,"+
	    "fnt_length,fnt_width,fnt_height,fnt_weight,fnt_standard,fnt_info,fnt_views,fnt_post_status)" + 
		" VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT * FROM FURNITURE_ITEM order by fnt_it_no";
	private static final String GET_ONE_STMT = 
		"SELECT * FROM FURNITURE_ITEM where fnt_it_no = ?";
	private static final String GET_ONE_FurLis = 
			"SELECT * FROM FURNITURE_ITEM where fnt_name = ?";
//	��ȧR���~�� ���t�R�Ӥ�
//	private static final String DELETE = 
//		"DELETE FROM FURNITURE_ITEM where fnt_it_no = ?";
	//�R���~���ΧR���~���Ӥ�
	private static final String DELETE_FNT_PIC = "DELETE FROM FURNITURE_PHOTO where fnt_it_no = ?";
	private static final String DELETE_FNT_ITE = "DELETE FROM FURNITURE_ITEM where fnt_it_no = ?";	
	private static final String DELETE_FNT_LIS= "DELETE FROM FURNITURE_LIST where fnt_it_no = ?";	
	
	private static final String UPDATE = 
		"UPDATE FURNITURE_ITEM set fnt_ctgr_no= ?,fnt_name= ?,fnt_unrent= ?,fnt_repair= ?,fnt_total= ?,fnt_price= ?," + 
		"fnt_length= ?,fnt_width= ?,fnt_height= ?,fnt_weight= ?,fnt_standard= ?,fnt_info= ?,fnt_views= ?, fnt_post_status=? where fnt_it_no = ?";
	//���̫�@���~���s���@�k
	private static final String GET_LAST_ITE_NO = 
			"SELECT fnt_it_no FROM FURNITURE_ITEM order by fnt_it_no desc limit 0,1";
	
	private static final String GET_FurItes_ByFurCat_STMT = "SELECT fnt_it_no,fnt_name FROM FURNITURE_ITEM where fnt_ctgr_no= ? order by fnt_it_no";
	//��ajax�Ϊ��s�ʤU�Ԧ����ﶵ
	private static final String GET_Fnt_Name_STMT = "SELECT fnt_name FROM FURNITURE_ITEM  order by fnt_it_no";
	//�d�Y�a�����O���Ҧ��~��
	private static final String GET_ONE_FUR_CAT_ITEM_STMT="SELECT * FROM FURNITURE_ITEM where fnt_ctgr_no= ? order by fnt_it_no";
//<�e�x��>�d�Ҧ��W�[�~��
	private static final String GET_ALL_GETON_ITEM_STMT = 
			"SELECT * FROM FURNITURE_ITEM where fnt_post_status=1 order by fnt_it_no";
//<�e�x��>�d�Ҧ��U�[�~��
	private static final String GET_ALL_GETOFF_ITEM_STMT = 
			"SELECT * FROM FURNITURE_ITEM where fnt_post_status=0 order by fnt_it_no";
//<�e�x��>�̮a������d�W�[�~��
	private static final String GET_GETON_ITEM_ByCATNO_STMT= 
			"SELECT * FROM FURNITURE_ITEM where fnt_post_status=1 and fnt_ctgr_no=? order by fnt_it_no";
	//����r�d��
//	private static final String GET_FurItes_ByKW_STMT="SELECT * FROM FURNITURE_ITEM where fnt_name=? or fnt_standard=? or fnt_info=? order by fnt_it_no";
	
	@Override
	public void insert(FurIteVO furIteVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	//	Integer last_no=null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, furIteVO.getFnt_ctgr_no());
			pstmt.setString(2, furIteVO.getFnt_name());
			pstmt.setInt(3, furIteVO.getFnt_unrent());
			pstmt.setInt(4, furIteVO.getFnt_repair());
			pstmt.setInt(5, furIteVO.getFnt_total());
			pstmt.setInt(6, furIteVO.getFnt_price());
			pstmt.setDouble(7, furIteVO.getFnt_length());
			pstmt.setDouble(8, furIteVO.getFnt_width());
			pstmt.setDouble(9, furIteVO.getFnt_height());
			pstmt.setDouble(10, furIteVO.getFnt_weight());
			pstmt.setString(11, furIteVO.getFnt_standard());
			pstmt.setString(12, furIteVO.getFnt_info());
			pstmt.setInt(13, furIteVO.getFnt_views());
			pstmt.setByte(14, furIteVO.getFnt_post_status());

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
	public Integer GetLastFnt_it_no() {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Integer last_fnt_it_no=null;
		try {

			con = ds.getConnection();			
			//���շs�W�~�����\�� ���X�̷s�@���~���s�� �̫�NŪ�쪺�Ϥ��e��Ϥ����
			pstmt = con.prepareStatement(GET_LAST_ITE_NO);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				last_fnt_it_no=rs.getInt("fnt_it_no");
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
		return last_fnt_it_no;

	}
	

	@Override
	public void update(FurIteVO furIteVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, furIteVO.getFnt_ctgr_no());
			pstmt.setString(2, furIteVO.getFnt_name());
			pstmt.setInt(3, furIteVO.getFnt_unrent());
			pstmt.setInt(4, furIteVO.getFnt_repair());
			pstmt.setInt(5, furIteVO.getFnt_total());
			pstmt.setInt(6, furIteVO.getFnt_price());
			pstmt.setDouble(7, furIteVO.getFnt_length());
			pstmt.setDouble(8, furIteVO.getFnt_width());
			pstmt.setDouble(9, furIteVO.getFnt_height());
			pstmt.setDouble(10, furIteVO.getFnt_weight());
			pstmt.setString(11, furIteVO.getFnt_standard());
			pstmt.setString(12, furIteVO.getFnt_info());
			pstmt.setInt(13, furIteVO.getFnt_views());
			pstmt.setByte(14, furIteVO.getFnt_post_status());
			pstmt.setInt(15, furIteVO.getFnt_it_no());

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
	public void delete(Integer fnt_it_no) {

		Connection con = null;
		PreparedStatement pstmt = null;
	
			try {
	
				con = ds.getConnection();
				
			// 1���]�w�� pstm.executeUpdate()���e
			con.setAutoCommit(false);

			// ���R���Ӥ�
			pstmt = con.prepareStatement(DELETE_FNT_PIC );
			pstmt.setInt(1, fnt_it_no);
			pstmt.executeUpdate();
			// �R���a��M��
			pstmt = con.prepareStatement(DELETE_FNT_LIS);
			pstmt.setInt(1, fnt_it_no);
			pstmt.executeUpdate();
			// �A�R���~��
			pstmt = con.prepareStatement(DELETE_FNT_ITE);
			pstmt.setInt(1, fnt_it_no);
			pstmt.executeUpdate();

			// 2���]�w�� pstm.executeUpdate()����
			con.commit();
			con.setAutoCommit(true);
			
			// Handle any driver errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3���]�w���exception�o�ͮɤ�catch�϶���
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
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
//	public void delete(Integer fnt_it_no) {
//
//		Connection con = null;
//		PreparedStatement pstmt = null;
//
//		try {
//
//			con = ds.getConnection();
//			pstmt = con.prepareStatement(DELETE);
//
//			pstmt.setInt(1, fnt_it_no);
//
//			pstmt.executeUpdate();
//
//			// Handle any driver errors
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//			// Clean up JDBC resources
//		} finally {
//			if (pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}
//
//	}

	@Override
	public FurIteVO findByPrimaryKey(Integer fnt_it_no) {

		FurIteVO furIteVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, fnt_it_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				furIteVO = new FurIteVO();
				furIteVO.setFnt_it_no(rs.getInt("fnt_it_no"));
				furIteVO.setFnt_ctgr_no(rs.getInt("fnt_ctgr_no"));
				furIteVO.setFnt_name(rs.getString("fnt_name"));
				furIteVO.setFnt_unrent(rs.getInt("fnt_unrent"));
				furIteVO.setFnt_repair(rs.getInt("fnt_repair"));
				furIteVO.setFnt_total(rs.getInt("fnt_total"));
				furIteVO.setFnt_price(rs.getInt("fnt_price"));
				furIteVO.setFnt_length(rs.getDouble("fnt_length"));
				furIteVO.setFnt_width(rs.getDouble("fnt_width"));
				furIteVO.setFnt_height(rs.getDouble("fnt_height"));
				furIteVO.setFnt_weight(rs.getDouble("fnt_weight"));
				furIteVO.setFnt_standard(rs.getString("fnt_standard"));
				furIteVO.setFnt_info(rs.getString("fnt_info"));
				furIteVO.setFnt_views(rs.getInt("fnt_views"));
				furIteVO.setFnt_post_status(rs.getByte("fnt_post_status"));
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
		return furIteVO;
	}

	@Override
	public FurIteVO showOneFurIteToFE(Integer fnt_it_no) {

		FurIteVO furIteVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, fnt_it_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				furIteVO = new FurIteVO();
				furIteVO.setFnt_it_no(rs.getInt("fnt_it_no"));
				furIteVO.setFnt_ctgr_no(rs.getInt("fnt_ctgr_no"));
				furIteVO.setFnt_name(rs.getString("fnt_name"));
				furIteVO.setFnt_unrent(rs.getInt("fnt_unrent"));
				furIteVO.setFnt_repair(rs.getInt("fnt_repair"));
				furIteVO.setFnt_total(rs.getInt("fnt_total"));
				furIteVO.setFnt_price(rs.getInt("fnt_price"));
				furIteVO.setFnt_length(rs.getDouble("fnt_length"));
				furIteVO.setFnt_width(rs.getDouble("fnt_width"));
				furIteVO.setFnt_height(rs.getDouble("fnt_height"));
				furIteVO.setFnt_weight(rs.getDouble("fnt_weight"));
				furIteVO.setFnt_standard(rs.getString("fnt_standard"));
//				furIteVO.setFnt_info(rs.getString("fnt_info"));
				String fnt_info = rs.getString("fnt_info").replaceAll("\n", "<br>").replaceAll("\\s", "&nbsp");
				furIteVO.setFnt_info(fnt_info);
				furIteVO.setFnt_views(rs.getInt("fnt_views"));
				furIteVO.setFnt_post_status(rs.getByte("fnt_post_status"));
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
		return furIteVO;
	}
	
	@Override
	public FurIteVO findByFurName(String fnt_name) {

		FurIteVO furIteVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_FurLis);

			pstmt.setString(1, fnt_name);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				furIteVO = new FurIteVO();
				furIteVO.setFnt_it_no(rs.getInt("fnt_it_no"));
				furIteVO.setFnt_ctgr_no(rs.getInt("fnt_ctgr_no"));
				furIteVO.setFnt_name(rs.getString("fnt_name"));
				furIteVO.setFnt_unrent(rs.getInt("fnt_unrent"));
				furIteVO.setFnt_repair(rs.getInt("fnt_repair"));
				furIteVO.setFnt_total(rs.getInt("fnt_total"));
				furIteVO.setFnt_price(rs.getInt("fnt_price"));
				furIteVO.setFnt_length(rs.getDouble("fnt_length"));
				furIteVO.setFnt_width(rs.getDouble("fnt_width"));
				furIteVO.setFnt_height(rs.getDouble("fnt_height"));
				furIteVO.setFnt_weight(rs.getDouble("fnt_weight"));
				furIteVO.setFnt_standard(rs.getString("fnt_standard"));
				furIteVO.setFnt_info(rs.getString("fnt_info"));
				furIteVO.setFnt_views(rs.getInt("fnt_views"));
				furIteVO.setFnt_post_status(rs.getByte("fnt_post_status"));
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
		return furIteVO;
	}
	
	
	@Override
	public List<FurIteVO> getAll() {
		List<FurIteVO> list = new ArrayList<FurIteVO>();
		FurIteVO furIteVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				furIteVO = new FurIteVO();
				furIteVO.setFnt_it_no(rs.getInt("fnt_it_no"));
				furIteVO.setFnt_ctgr_no(rs.getInt("fnt_ctgr_no"));
				furIteVO.setFnt_name(rs.getString("fnt_name"));
				furIteVO.setFnt_unrent(rs.getInt("fnt_unrent"));
				furIteVO.setFnt_repair(rs.getInt("fnt_repair"));
				furIteVO.setFnt_total(rs.getInt("fnt_total"));
				furIteVO.setFnt_price(rs.getInt("fnt_price"));
				furIteVO.setFnt_length(rs.getDouble("fnt_length"));
				furIteVO.setFnt_width(rs.getDouble("fnt_width"));
				furIteVO.setFnt_height(rs.getDouble("fnt_height"));
				furIteVO.setFnt_weight(rs.getDouble("fnt_weight"));
				furIteVO.setFnt_standard(rs.getString("fnt_standard"));
				furIteVO.setFnt_info(rs.getString("fnt_info"));
				furIteVO.setFnt_views(rs.getInt("fnt_views"));
				furIteVO.setFnt_post_status(rs.getByte("fnt_post_status"));
				list.add(furIteVO); // Store the row in the list
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
	public List<FurIteVO> getFurItesByFurCat(Integer fnt_ctgr_no) {
		List<FurIteVO> list = new ArrayList<FurIteVO>();
		FurIteVO furIteVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_FurItes_ByFurCat_STMT);
			pstmt.setInt(1, fnt_ctgr_no);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				furIteVO = new FurIteVO();
				furIteVO.setFnt_it_no(rs.getInt("fnt_it_no"));
				furIteVO.setFnt_ctgr_no(rs.getInt("fnt_ctgr_no"));
				furIteVO.setFnt_name(rs.getString("fnt_name"));
				list.add(furIteVO); 
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
//Ajax�s�ʤU�Ԧ����ﶵ��
	@Override
	public String selectByPrimaryKey(Integer fnt_ctgr_no) {
		String sameFnt_Ctgr_name="";
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_FurItes_ByFurCat_STMT);
			pstmt.setInt(1, fnt_ctgr_no);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				sameFnt_Ctgr_name+=(sameFnt_Ctgr_name=="") ? (rs.getInt("fnt_it_no")+"-"+ rs.getString("fnt_name")) :(","+rs.getInt("fnt_it_no")+"-"+rs.getString("fnt_name"));
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
		return sameFnt_Ctgr_name;
	}
	
	//�s�ʤU�Ԧ���檺�~�����k
	@Override
	public String getAllFntName() {
		String allFnt_name="";
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_Fnt_Name_STMT);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				allFnt_name+=(allFnt_name=="") ? rs.getString("fnt_name") :","+rs.getString("fnt_name");
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
		return allFnt_name;
	}

	//���Y���O���Ҧ��~��
	@Override
	public List<FurIteVO> getOneFurCat_Item(Integer fnt_ctgr_no) {
		List<FurIteVO> list = new ArrayList<FurIteVO>();
		FurIteVO furIteVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_FUR_CAT_ITEM_STMT);
			pstmt.setInt(1, fnt_ctgr_no);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				furIteVO = new FurIteVO();
				furIteVO.setFnt_it_no(rs.getInt("fnt_it_no"));
				furIteVO.setFnt_ctgr_no(rs.getInt("fnt_ctgr_no"));
				furIteVO.setFnt_name(rs.getString("fnt_name"));
				furIteVO.setFnt_unrent(rs.getInt("fnt_unrent"));
				furIteVO.setFnt_repair(rs.getInt("fnt_repair"));
				furIteVO.setFnt_total(rs.getInt("fnt_total"));
				furIteVO.setFnt_price(rs.getInt("fnt_price"));
				furIteVO.setFnt_length(rs.getDouble("fnt_length"));
				furIteVO.setFnt_width(rs.getDouble("fnt_width"));
				furIteVO.setFnt_height(rs.getDouble("fnt_height"));
				furIteVO.setFnt_weight(rs.getDouble("fnt_weight"));
				furIteVO.setFnt_standard(rs.getString("fnt_standard"));
				furIteVO.setFnt_info(rs.getString("fnt_info"));
				furIteVO.setFnt_views(rs.getInt("fnt_views"));
				furIteVO.setFnt_post_status(rs.getByte("fnt_post_status"));
				list.add(furIteVO); // Store the row in the list
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
//<�e�x��> �d�Ҧ��W�[�a��
	 public List<FurIteVO> getAllGetOnFurIte(){
			List<FurIteVO> list = new ArrayList<FurIteVO>();
			FurIteVO furIteVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ALL_GETON_ITEM_STMT);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					furIteVO = new FurIteVO();
					furIteVO.setFnt_it_no(rs.getInt("fnt_it_no"));
					furIteVO.setFnt_ctgr_no(rs.getInt("fnt_ctgr_no"));
					furIteVO.setFnt_name(rs.getString("fnt_name"));
					furIteVO.setFnt_unrent(rs.getInt("fnt_unrent"));
					furIteVO.setFnt_repair(rs.getInt("fnt_repair"));
					furIteVO.setFnt_total(rs.getInt("fnt_total"));
					furIteVO.setFnt_price(rs.getInt("fnt_price"));
					furIteVO.setFnt_length(rs.getDouble("fnt_length"));
					furIteVO.setFnt_width(rs.getDouble("fnt_width"));
					furIteVO.setFnt_height(rs.getDouble("fnt_height"));
					furIteVO.setFnt_weight(rs.getDouble("fnt_weight"));
					furIteVO.setFnt_standard(rs.getString("fnt_standard"));
					furIteVO.setFnt_info(rs.getString("fnt_info"));
					furIteVO.setFnt_views(rs.getInt("fnt_views"));
					furIteVO.setFnt_post_status(rs.getByte("fnt_post_status"));
					list.add(furIteVO); // Store the row in the list
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
	
	//<�e�x��> �d�Ҧ��W�[�a��
		 public List<FurIteVO>  getAllGetOffFurIte(){
				List<FurIteVO> list = new ArrayList<FurIteVO>();
				FurIteVO furIteVO = null;
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;

				try {

					con = ds.getConnection();
					pstmt = con.prepareStatement(GET_ALL_GETOFF_ITEM_STMT);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						furIteVO = new FurIteVO();
						furIteVO.setFnt_it_no(rs.getInt("fnt_it_no"));
						furIteVO.setFnt_ctgr_no(rs.getInt("fnt_ctgr_no"));
						furIteVO.setFnt_name(rs.getString("fnt_name"));
						furIteVO.setFnt_unrent(rs.getInt("fnt_unrent"));
						furIteVO.setFnt_repair(rs.getInt("fnt_repair"));
						furIteVO.setFnt_total(rs.getInt("fnt_total"));
						furIteVO.setFnt_price(rs.getInt("fnt_price"));
						furIteVO.setFnt_length(rs.getDouble("fnt_length"));
						furIteVO.setFnt_width(rs.getDouble("fnt_width"));
						furIteVO.setFnt_height(rs.getDouble("fnt_height"));
						furIteVO.setFnt_weight(rs.getDouble("fnt_weight"));
						furIteVO.setFnt_standard(rs.getString("fnt_standard"));
						furIteVO.setFnt_info(rs.getString("fnt_info"));
						furIteVO.setFnt_views(rs.getInt("fnt_views"));
						furIteVO.setFnt_post_status(rs.getByte("fnt_post_status"));
						list.add(furIteVO); // Store the row in the list
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
	 
//<�e�x��x��>�̮a������d�W�[�~���æC�X
	 public List<FurIteVO> getGetOnFurIteByCat(Integer fnt_ctgr_no) {
			List<FurIteVO> list = new ArrayList<FurIteVO>();
			FurIteVO furIteVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_GETON_ITEM_ByCATNO_STMT);
				pstmt.setInt(1, fnt_ctgr_no);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					furIteVO = new FurIteVO();
					furIteVO.setFnt_it_no(rs.getInt("fnt_it_no"));
					furIteVO.setFnt_ctgr_no(rs.getInt("fnt_ctgr_no"));
					furIteVO.setFnt_name(rs.getString("fnt_name"));
					furIteVO.setFnt_unrent(rs.getInt("fnt_unrent"));
					furIteVO.setFnt_repair(rs.getInt("fnt_repair"));
					furIteVO.setFnt_total(rs.getInt("fnt_total"));
					furIteVO.setFnt_price(rs.getInt("fnt_price"));
					furIteVO.setFnt_length(rs.getDouble("fnt_length"));
					furIteVO.setFnt_width(rs.getDouble("fnt_width"));
					furIteVO.setFnt_height(rs.getDouble("fnt_height"));
					furIteVO.setFnt_weight(rs.getDouble("fnt_weight"));
					furIteVO.setFnt_standard(rs.getString("fnt_standard"));
					furIteVO.setFnt_info(rs.getString("fnt_info"));
					furIteVO.setFnt_views(rs.getInt("fnt_views"));
					furIteVO.setFnt_post_status(rs.getByte("fnt_post_status"));
					list.add(furIteVO); // Store the row in the list
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
		
	 //�e�x�ҽk�d��
	 @Override
	 public List<FurIteVO> getOneFurIteByKWtoFE(String keyword){
			List<FurIteVO> list = new ArrayList<FurIteVO>();
			FurIteVO furIteVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
//				pstmt = con.prepareStatement(GET_FurItes_ByKW_STMT);
				String GET_FurItes_ByKWtoFE_STMT="SELECT * FROM FURNITURE_ITEM where fnt_post_status=1 and (fnt_name like '%"+keyword+
						"%' or fnt_standard like '%"+keyword+"%' or fnt_info like '%"+keyword+"%') order by fnt_it_no";

				pstmt = con.prepareStatement(GET_FurItes_ByKWtoFE_STMT);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					furIteVO = new FurIteVO();
					furIteVO.setFnt_it_no(rs.getInt("fnt_it_no"));
					furIteVO.setFnt_ctgr_no(rs.getInt("fnt_ctgr_no"));
					furIteVO.setFnt_name(rs.getString("fnt_name"));
					furIteVO.setFnt_unrent(rs.getInt("fnt_unrent"));
					furIteVO.setFnt_repair(rs.getInt("fnt_repair"));
					furIteVO.setFnt_total(rs.getInt("fnt_total"));
					furIteVO.setFnt_price(rs.getInt("fnt_price"));
					furIteVO.setFnt_length(rs.getDouble("fnt_length"));
					furIteVO.setFnt_width(rs.getDouble("fnt_width"));
					furIteVO.setFnt_height(rs.getDouble("fnt_height"));
					furIteVO.setFnt_weight(rs.getDouble("fnt_weight"));
					furIteVO.setFnt_standard(rs.getString("fnt_standard"));
					furIteVO.setFnt_info(rs.getString("fnt_info"));
					furIteVO.setFnt_views(rs.getInt("fnt_views"));
					furIteVO.setFnt_post_status(rs.getByte("fnt_post_status"));
					list.add(furIteVO); // Store the row in the list
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
	 
	 
	
	//����r�d��
	@Override
	public List<FurIteVO> getOneFurIteByKW(String keyword) {
		List<FurIteVO> list = new ArrayList<FurIteVO>();
		FurIteVO furIteVO = null;
		System.out.println("�iDAO, keyword�Ȭ�"+keyword);
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
//			pstmt = con.prepareStatement(GET_FurItes_ByKW_STMT);
			String GET_FurItes_ByKW_STMT="SELECT * FROM FURNITURE_ITEM where fnt_name like '%"+keyword+
					"%' or fnt_standard like '%"+keyword+"%' or fnt_info like '%"+keyword+"%' order by fnt_it_no";
			pstmt = con.prepareStatement(GET_FurItes_ByKW_STMT);
//			pstmt.setString(1,"like '%"+keyword+"%'");
//			pstmt.setString(2,"like '%"+keyword+"%'");
//			pstmt.setString(3,"like '%"+keyword+"%'");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				furIteVO = new FurIteVO();
				furIteVO.setFnt_it_no(rs.getInt("fnt_it_no"));
				furIteVO.setFnt_ctgr_no(rs.getInt("fnt_ctgr_no"));
				furIteVO.setFnt_name(rs.getString("fnt_name"));
				furIteVO.setFnt_unrent(rs.getInt("fnt_unrent"));
				furIteVO.setFnt_repair(rs.getInt("fnt_repair"));
				furIteVO.setFnt_total(rs.getInt("fnt_total"));
				furIteVO.setFnt_price(rs.getInt("fnt_price"));
				furIteVO.setFnt_length(rs.getDouble("fnt_length"));
				furIteVO.setFnt_width(rs.getDouble("fnt_width"));
				furIteVO.setFnt_height(rs.getDouble("fnt_height"));
				furIteVO.setFnt_weight(rs.getDouble("fnt_weight"));
				furIteVO.setFnt_standard(rs.getString("fnt_standard"));
				furIteVO.setFnt_info(rs.getString("fnt_info"));
				furIteVO.setFnt_views(rs.getInt("fnt_views"));
				furIteVO.setFnt_post_status(rs.getByte("fnt_post_status"));
				list.add(furIteVO); // Store the row in the list
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
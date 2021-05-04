package com.employee.model;

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

import com.employee.model.EmployeeVO;
import com.staRig.model.StaRigService;
import com.staRig.model.StaRigVO;

public class EmployeeDAO implements EmployeeDAO_interface {

	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/HowTrueProject");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT = 
		"INSERT INTO EMPLOYEE (EMP_JOB, EMP_USERNAME, EMP_PASSWORD, EMP_HIREDATE, EMP_EMAIL, EMP_SAL) VALUES (?, ?, ?, ?, ?, ?)";
	private static final String UPDATE_BY_SUP = 
		"UPDATE EMPLOYEE SET EMP_JOB = ?, EMP_HIREDATE = ?, EMP_QUITDATE = ?, EMP_EMAIL = ?, EMP_SAL = ?, EMP_BONUS = ? WHERE EMP_NO = ?";
	private static final String UPDATE_BY_EMP = 
		"UPDATE EMPLOYEE SET EMP_NAME = ?, EMP_PASSWORD = ?, EMP_GENDER = ?, EMP_ID = ?, EMP_BIRTHDAY = ?, EMP_PHONE = ?, EMP_MOBILE = ?, EMP_ADDR = ?, EMP_EMAIL = ?, EMP_BANK = ?, EMP_ACCOUNT = ?, EMP_PIC = ? WHERE EMP_NO = ?";
	private static final String DELETE = 
		"DELETE FROM EMPLOYEE WHERE EMP_NO = ?";
	private static final String GET_BY_PK = 
		"SELECT * FROM EMPLOYEE WHERE EMP_NO = ?";
	private static final String GET_ALL = 
		"SELECT * FROM EMPLOYEE ORDER BY EMP_NO";
	private static final String DOES_IT_EXIST = 
		"SELECT * FROM EMPLOYEE WHERE EMP_USERNAME = ?";

	@Override
	public void insert(EmployeeVO employeeVO, List<Integer> list_Fun_no) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			String[] cols = {"EMP_NO"};
			pstmt = con.prepareStatement(INSERT, cols);
			
			con.setAutoCommit(false);
			
			pstmt.setString(1, employeeVO.getEmp_job());
			pstmt.setString(2, employeeVO.getEmp_username());
			pstmt.setString(3, employeeVO.getEmp_password());
			pstmt.setDate(4, employeeVO.getEmp_hiredate());
			pstmt.setString(5, employeeVO.getEmp_email());
			pstmt.setInt(6, employeeVO.getEmp_sal());
			pstmt.executeUpdate();
			
			rs = pstmt.getGeneratedKeys();
			
			Integer emp_no = null;
			if(rs.next())
				emp_no = rs.getInt(1);
			else
				System.out.println("未取得自增主鍵值");
			
			StaRigService staRigService = new StaRigService();
			for(Integer fun_no : list_Fun_no)
				staRigService.addStaRig(emp_no, fun_no, con);
			
			con.commit();
			con.setAutoCommit(true);
			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					System.err.println("rolled back(EmployeeDAO)");
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

	@Override
	public void updateBySup(EmployeeVO employeeVO, List<Integer> list_Fun_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_BY_SUP);

			con.setAutoCommit(false);
			
			pstmt.setString(1, employeeVO.getEmp_job());
			pstmt.setDate(2, employeeVO.getEmp_hiredate());
			pstmt.setDate(3, employeeVO.getEmp_quitdate());
			pstmt.setString(4, employeeVO.getEmp_email());
			pstmt.setInt(5, employeeVO.getEmp_sal());
			pstmt.setInt(6, employeeVO.getEmp_bonus());
			
			Integer emp_no = employeeVO.getEmp_no();
			pstmt.setInt(7, emp_no);
			pstmt.executeUpdate();
			
			StaRigService staRigService = new StaRigService();
			// 找出原本的權限
			List<StaRigVO> list_StaRigVO =  staRigService.getOneEmpStaRig(emp_no);
			List<Integer> list_Fun_no_init = new ArrayList<Integer>();
			for(StaRigVO staRigVO : list_StaRigVO) {
				Integer fun_no = staRigVO.getFun_no();
				list_Fun_no_init.add(fun_no);
			}
			
			// 找出原權限與新權限的交集
			List<Integer> list_Intersection = new ArrayList<Integer>(list_Fun_no);
			list_Intersection.retainAll(list_Fun_no_init);
			
			// 找出新權限與原權限的差集,新增原本沒有的權限
			list_Fun_no.removeAll(list_Intersection);
			System.out.println("員工編號:" + emp_no + ", 新增權限:"+ list_Fun_no);
			for(Integer fun_no : list_Fun_no)
				staRigService.addStaRig(emp_no, fun_no, con);
			
			// 找出原權限與新權限的差集,刪除原本有的權限
			list_Fun_no_init.removeAll(list_Intersection);
			System.out.println("員工編號:" + emp_no + ", 刪除權限:"+ list_Fun_no_init);
			for(Integer fun_no : list_Fun_no_init)
				staRigService.deleteStaRig(emp_no, fun_no, con);

			// Handle any driver errors
			con.commit();
			con.setAutoCommit(true);
			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					System.err.println("rolled back(EmployeeDAO)");
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
	public void updateByEmp(EmployeeVO employeeVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_BY_EMP);

			pstmt.setString(1, employeeVO.getEmp_name());
			pstmt.setString(2, employeeVO.getEmp_password());
			pstmt.setByte(3, employeeVO.getEmp_gender());
			pstmt.setString(4, employeeVO.getEmp_id());
			pstmt.setDate(5, employeeVO.getEmp_birthday());
			pstmt.setString(6, employeeVO.getEmp_phone());
			pstmt.setString(7, employeeVO.getEmp_mobile());
			pstmt.setString(8, employeeVO.getEmp_addr());
			pstmt.setString(9, employeeVO.getEmp_email());
			pstmt.setString(10, employeeVO.getEmp_bank());
			pstmt.setString(11, employeeVO.getEmp_account());
			pstmt.setBytes(12, employeeVO.getEmp_pic());
			pstmt.setInt(13, employeeVO.getEmp_no());
			pstmt.executeUpdate();
			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
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
	public void delete(Integer emp_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, emp_no);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
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
	public EmployeeVO getByPK(Integer emp_no) {

		EmployeeVO employeeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_BY_PK);

			pstmt.setInt(1, emp_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// employeeVO 也稱為 Domain objects
				employeeVO = new EmployeeVO();
				employeeVO.setEmp_no(rs.getInt("EMP_NO"));
				employeeVO.setEmp_name(rs.getString("EMP_NAME"));
				employeeVO.setEmp_job(rs.getString("EMP_JOB"));
				employeeVO.setEmp_username(rs.getString("EMP_USERNAME"));
				employeeVO.setEmp_password(rs.getString("EMP_PASSWORD"));
				employeeVO.setEmp_gender(rs.getByte("EMP_GENDER"));
				employeeVO.setEmp_id(rs.getString("EMP_ID"));
				employeeVO.setEmp_birthday(rs.getDate("EMP_BIRTHDAY"));
				employeeVO.setEmp_phone(rs.getString("EMP_PHONE"));
				employeeVO.setEmp_mobile(rs.getString("EMP_MOBILE"));
				employeeVO.setEmp_addr(rs.getString("EMP_ADDR"));
				employeeVO.setEmp_hiredate(rs.getDate("EMP_HIREDATE"));
				employeeVO.setEmp_quitdate(rs.getDate("EMP_QUITDATE"));
				employeeVO.setEmp_email(rs.getString("EMP_EMAIL"));
				employeeVO.setEmp_bank(rs.getString("EMP_BANK"));
				employeeVO.setEmp_account(rs.getString("EMP_ACCOUNT"));
				employeeVO.setEmp_sal(rs.getInt("EMP_SAL"));
				employeeVO.setEmp_bonus(rs.getInt("EMP_BONUS"));
				employeeVO.setEmp_pic(rs.getBytes("EMP_PIC"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
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
		return employeeVO;
	}

	@Override
	public List<EmployeeVO> getAll() {
		List<EmployeeVO> list = new ArrayList<EmployeeVO>();
		EmployeeVO employeeVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// employeeVO 也稱為 Domain objects
				employeeVO = new EmployeeVO();
				employeeVO.setEmp_no(rs.getInt("EMP_NO"));
				employeeVO.setEmp_name(rs.getString("EMP_NAME"));
				employeeVO.setEmp_job(rs.getString("EMP_JOB"));
				employeeVO.setEmp_username(rs.getString("EMP_USERNAME"));
				employeeVO.setEmp_password(rs.getString("EMP_PASSWORD"));
				employeeVO.setEmp_gender(rs.getByte("EMP_GENDER"));
				employeeVO.setEmp_id(rs.getString("EMP_ID"));
				employeeVO.setEmp_birthday(rs.getDate("EMP_BIRTHDAY"));
				employeeVO.setEmp_phone(rs.getString("EMP_PHONE"));
				employeeVO.setEmp_mobile(rs.getString("EMP_MOBILE"));
				employeeVO.setEmp_addr(rs.getString("EMP_ADDR"));
				employeeVO.setEmp_hiredate(rs.getDate("EMP_HIREDATE"));
				employeeVO.setEmp_quitdate(rs.getDate("EMP_QUITDATE"));
				employeeVO.setEmp_email(rs.getString("EMP_EMAIL"));
				employeeVO.setEmp_bank(rs.getString("EMP_BANK"));
				employeeVO.setEmp_account(rs.getString("EMP_ACCOUNT"));
				employeeVO.setEmp_sal(rs.getInt("EMP_SAL"));
				employeeVO.setEmp_bonus(rs.getInt("EMP_BONUS"));
				employeeVO.setEmp_pic(rs.getBytes("EMP_PIC"));
				list.add(employeeVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
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
	public boolean doesItExist(String emp_username) {
		EmployeeVO employeeVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DOES_IT_EXIST);

			pstmt.setString(1, emp_username);

			rs = pstmt.executeQuery();

			if (rs.next())
				return true;
			else
				return false;
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
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
	}
	
}

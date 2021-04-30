package com.post.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class PostJDBCDAO implements PostDAO_interface{
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/HOWTRUE?serverTimezone=Asia/Taipei";
	String userid = "David";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
			"INSERT INTO post (post_title, post_content, post_status) VALUES (?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT post_no,post_time, post_title, post_content, post_status FROM post order by post_time desc";
	private static final String GET_ALL_STMTASC = 
			"SELECT post_no,post_time, post_title, post_content, post_status FROM post order by post_time asc";
	private static final String GET_ALLFRONT_STMT = 
			"SELECT post_no,post_time, post_title, post_content, post_status FROM post where post_status =1 order by post_time desc";
	private static final String GET_ALLFRONTASC_STMT = 
			"SELECT post_no,post_time, post_title, post_content, post_status FROM post where post_status =1 order by post_time asc";
	
	private static final String GET_ONE_STMT = 
			"SELECT post_no,post_time, post_title, post_content, post_status FROM post where post_no = ?";
	private static final String DELETE = 
			"DELETE FROM post where post_no = ?";
	private static final String UPDATE = 
			"UPDATE post set post_no=?, post_title=?, post_content=?, post_status=? where post_no = ?";

	@Override
	public void insert(PostVO postVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			
			pstmt.setString(1, postVO.getPost_title());
			pstmt.setString(2, postVO.getPost_content());
			pstmt.setByte(3, postVO.getPost_status());

			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	public void update(PostVO postVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setInt(1, postVO.getPost_no());
//			pstmt.setTimestamp(2, postVO.getPost_time());
			pstmt.setString(2, postVO.getPost_title());
			pstmt.setString(3, postVO.getPost_content());
			pstmt.setByte(4, postVO.getPost_status());
			pstmt.setInt(5, postVO.getPost_no());
			
			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	public void delete(Integer post_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, post_no);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	public PostVO findByPrimaryKey(Integer post_no) {
		// TODO Auto-generated method stub
		PostVO postVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, post_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo 也稱為 Domain objects
				postVO = new PostVO();
				postVO.setPost_no(rs.getInt("post_no"));
				postVO.setPost_time(rs.getTimestamp("post_time"));
				postVO.setPost_title(rs.getString("post_title"));
				postVO.setPost_content(rs.getString("post_content"));
				postVO.setPost_status(rs.getByte("post_status"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		return postVO;
	}

	@Override
	public PostVO findByPrimaryKeyShow(Integer post_no) {
		// TODO Auto-generated method stub
		PostVO postVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, post_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				postVO = new PostVO();
				postVO.setPost_no(rs.getInt("post_no"));
				postVO.setPost_time(rs.getTimestamp("post_time"));
				postVO.setPost_title(rs.getString("post_title"));
				String postCon=rs.getString("post_content");
				String y = postCon.replaceAll("\n", "<br>").replaceAll("\\s", "&nbsp");
				
				postVO.setPost_content(y);
//				postVO.setPost_content(rs.getString("post_content"));
				System.out.println(y);
				postVO.setPost_status(rs.getByte("post_status"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		return postVO;
	}

	

	@Override
	public List<PostVO> getAllDesc() {
		// TODO Auto-generated method stub
		List<PostVO> list = new ArrayList<PostVO>();
		PostVO postVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				postVO = new PostVO();
				postVO.setPost_no(rs.getInt("post_no"));
				postVO.setPost_time(rs.getTimestamp("post_time"));
				postVO.setPost_title(rs.getString("post_title"));
				postVO.setPost_content(rs.getString("post_content"));
				postVO.setPost_status(rs.getByte("post_status"));
				list.add(postVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	public List<PostVO> getAllAsc() {
		// TODO Auto-generated method stub
		List<PostVO> list = new ArrayList<PostVO>();
		PostVO postVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMTASC);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				postVO = new PostVO();
				postVO.setPost_no(rs.getInt("post_no"));
				postVO.setPost_time(rs.getTimestamp("post_time"));
				postVO.setPost_title(rs.getString("post_title"));
				postVO.setPost_content(rs.getString("post_content"));
				postVO.setPost_status(rs.getByte("post_status"));
				list.add(postVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	public List<PostVO> getAllFront() {
		// TODO Auto-generated method stub
		List<PostVO> list = new ArrayList<PostVO>();
		PostVO postVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALLFRONT_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				postVO = new PostVO();
				postVO.setPost_no(rs.getInt("post_no"));
				postVO.setPost_time(rs.getTimestamp("post_time"));
				postVO.setPost_title(rs.getString("post_title"));
				postVO.setPost_content(rs.getString("post_content"));
				postVO.setPost_status(rs.getByte("post_status"));
				list.add(postVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
	public List<PostVO> getAllFrontAsc() {
		// TODO Auto-generated method stub
		List<PostVO> list = new ArrayList<PostVO>();
		PostVO postVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALLFRONTASC_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				postVO = new PostVO();
				postVO.setPost_no(rs.getInt("post_no"));
				postVO.setPost_time(rs.getTimestamp("post_time"));
				postVO.setPost_title(rs.getString("post_title"));
				postVO.setPost_content(rs.getString("post_content"));
				postVO.setPost_status(rs.getByte("post_status"));
				list.add(postVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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

	public static void main(String[] args) {

		PostJDBCDAO dao = new PostJDBCDAO();

		

		

		// 查詢
		List<PostVO> list = dao.getAllFrontAsc();
		for (PostVO bEmp : list) {
			System.out.print(bEmp.getPost_no() + ",");
			System.out.print(bEmp.getPost_time() + ",");
			System.out.println();
		}
	}

}
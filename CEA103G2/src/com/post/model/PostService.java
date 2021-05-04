package com.post.model;

import java.util.List;


public class PostService {
	private PostDAO_interface dao;

	public PostService() {
		dao = new PostDAO();
	}

	public PostVO addPost(String post_title, String post_content, Byte post_status) {

		PostVO postVO = new PostVO();

		postVO.setPost_title(post_title);
		postVO.setPost_content(post_content);
		postVO.setPost_status(post_status);
		dao.insert(postVO);

		return postVO;
	}

	public PostVO updatePost(Integer post_no, java.sql.Timestamp post_time, String post_title, String post_content,
			Byte post_status) {

		PostVO postVO = new PostVO();

		postVO.setPost_no(post_no);
		postVO.setPost_time(post_time);
		postVO.setPost_title(post_title);
		postVO.setPost_content(post_content);
		postVO.setPost_status(post_status);
		dao.update(postVO);

		return postVO;
	}
	
	public void deletePost(Integer post_no) {
		dao.delete(post_no);
	}
	public PostVO getOnePost(Integer post_no) {
		return dao.findByPrimaryKey(post_no);
	}
	public PostVO getOnePostShow(Integer post_no) {
		return dao.findByPrimaryKeyShow(post_no);
	}

	public List<PostVO> getAllDesc() {
		return dao.getAllDesc();
	}
	public List<PostVO> getAllAsc() {
		return dao.getAllAsc();
	}

	public List<PostVO> getAllFront() {
		return dao.getAllFront();
	}
	public List<PostVO> getAllFrontAsc() {
		return dao.getAllFrontAsc();
	}
}

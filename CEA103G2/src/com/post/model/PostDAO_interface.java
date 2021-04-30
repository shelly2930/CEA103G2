package com.post.model;

import java.util.*;


public interface PostDAO_interface {
	public void insert(PostVO postVO);
    public void update(PostVO postVO);
    public void delete(Integer post_no);
    public PostVO findByPrimaryKey(Integer post_no);
    public List<PostVO> getAllDesc();
    public List<PostVO> getAllAsc();
    public List<PostVO> getAllFront();
    public List<PostVO> getAllFrontAsc();
	public PostVO findByPrimaryKeyShow(Integer post_no);
	
}

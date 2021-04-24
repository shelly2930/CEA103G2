package com.post.model;

import java.sql.Timestamp;

public class PostVO implements java.io.Serializable{
		private Integer post_no;
		private Timestamp post_time;
		private String post_title;
		private String post_content;
		private Byte post_status;
		public Integer getPost_no() {
			return post_no;
		}
		public void setPost_no(Integer post_no) {
			this.post_no = post_no;
		}
		public Timestamp getPost_time() {
			return post_time;
		}
		public void setPost_time(Timestamp post_time) {
			this.post_time = post_time;
		}
		public String getPost_title() {
			return post_title;
		}
		public void setPost_title(String post_title) {
			this.post_title = post_title;
		}
		public String getPost_content() {
			return post_content;
		}
		public void setPost_content(String post_content) {
			this.post_content = post_content;
		}
		public Byte getPost_status() {
			return post_status;
		}
		public void setPost_status(Byte post_status) {
			this.post_status = post_status;
		}
		
}

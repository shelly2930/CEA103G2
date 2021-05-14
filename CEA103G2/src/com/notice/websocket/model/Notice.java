package com.notice.websocket.model;

public class Notice {
	private String type;
	private String identity;
	private String username;
	private String currentTime;//判別前後台
	public Notice(String type, String identity, String username, String currentTime, String message) {
		super();
		this.type = type;
		this.identity = identity;
		this.username = username;
		this.currentTime = currentTime;
		this.message = message;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getIdentity() {
		return identity;
	}
	public void setIdentity(String identity) {
		this.identity = identity;
	}
	public String getCurrentTime() {
		return currentTime;
	}
	public void setCurrentTime(String currentTime) {
		this.currentTime = currentTime;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	private String message;

}

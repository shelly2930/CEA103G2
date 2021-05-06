package com.rooVieApp.websocket.model;

public class PickTime {
	private String type;
	private String sender;
	private String identity;//判別前後台
	private String message;
	
	public PickTime(String type, String sender,  String identity, String message) {
		super();
		this.type = type;
		this.sender = sender;
		this.identity = identity;
		this.setMessage(message);
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getIdentity() {
		return identity;
	}
	public void setIdentity(String identity) {
		this.identity = identity;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

}
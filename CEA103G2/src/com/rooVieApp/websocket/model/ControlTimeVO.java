package com.rooVieApp.websocket.model;

import java.util.Set;

public class ControlTimeVO {
	private String type;
	private String sender;
	private String identity;//判別前後台
	private String freeTimeToSee;
	private String gotowork;
	private String gooffwork;
	private Set<String> freedate;
	
	
	public ControlTimeVO(String type, String sender, String identity, String freeTimeToSee, String gotowork,
			String gooffwork, Set<String> freedate) {
		super();
		this.type = type;
		this.sender = sender;
		this.identity = identity;
		this.freeTimeToSee = freeTimeToSee;
		this.gotowork = gotowork;
		this.gooffwork = gooffwork;
		this.freedate = freedate;
	
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
	public String getFreeTimeToSee() {
		return freeTimeToSee;
	}
	public void setFreeTimeToSee(String freeTimeToSee) {
		this.freeTimeToSee = freeTimeToSee;
	}
	public String getGotowork() {
		return gotowork;
	}
	public void setGotowork(String gotowork) {
		this.gotowork = gotowork;
	}
	public String getGooffwork() {
		return gooffwork;
	}
	public void setGooffwork(String gooffwork) {
		this.gooffwork = gooffwork;
	}

	public Set<String> getFreedate() {
		return freedate;
	}

	public void setFreedate(Set<String> freedate) {
		this.freedate = freedate;
	}
}

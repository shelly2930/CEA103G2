package com.cusSer.websocket.model;

public class ChatVO {
	//type: history  chat 
	private String type;
	private String sender;//�|�� ���u(E)
	private String friend;//�e�x�o�T�� �o�̬O�Ū�   ��x�o�T�� �L�|�h�I�n�ͦC��  �o�̥i�H���L�n��ܪ��H
	private String key;//����Ʈw�� (key=�|���s�� �C���� ���X�o�|�������v����)
	private String message;//��ѰT��
	private String date;//��U�ɶ�
	private String judge;//�P�_�wŪ��Ū

	public ChatVO(String type, String sender, String friend, String key, String message, String date,
			String judge) {
		super();
		this.type = type;
		this.sender = sender;
		this.friend = friend;
		this.key = key;
		this.message = message;
		this.date = date;
		this.judge = judge;
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

	public String getFriend() {
		return friend;
	}

	public void setFriend(String friend) {
		this.friend = friend;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getJudge() {
		return judge;
	}

	public void setJudge(String judge) {
		this.judge = judge;
	}

}

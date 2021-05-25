package com.cusSer.websocket.model;

public class ChatVO {
	//type: history  chat 
	private String type;
	private String sender;//會員 員工(E)
	private String friend;//前台發訊息 這裡是空的   後台發訊息 他會去點好友列表  這裡可以選到他要對話的人
	private String key;//撈資料庫用 (key=會員編號 每次撈 撈出這會員的歷史紀錄)
	private String message;//聊天訊息
	private String date;//當下時間
	private String judge;//判斷已讀未讀

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

package com.cusSer.websocket.controller;

import java.io.IOException;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import com.cusSer.websocket.jedis.JedisHandleMessage;
import com.cusSer.websocket.model.ChatVO;
import com.cusSer.websocket.model.State;
import com.google.gson.Gson;


@ServerEndpoint("/chat/{userName}")
public class ChatWS {

	private static Map<String, Session> sessionsMap = new ConcurrentHashMap<>();
	Gson gson = new Gson();
	// 共有 1. 狀態VO
	@OnOpen
	public void onOpen(@PathParam("userName") String userName, Session userSession) throws IOException {
		//收集連線 辨別用
		sessionsMap.put(userName, userSession);
		Set<String> userNames = sessionsMap.keySet();
		System.out.println("UESR"+userName);
		//創一個stateVO 回傳前台 跟他說open而且要更新好友列表，後台//要更新會員 ，後台判別不用有E的
		State stateMessage = new State("open", userName, userNames);
		String stateMessageJson = gson.toJson(stateMessage);
		
		//發送
		Collection<Session> sessions = sessionsMap.values();
		for (Session session : sessions) {
		if (session.isOpen()) {
				session.getAsyncRemote().sendText(stateMessageJson);
			}
		}
	}
	
	@OnMessage
	public void onMessage(Session userSession, String message) {
		//接歷史訊息空包 拿出歷史訊息裝好 回傳
		//如果是正常聊天情況 直接轉交
		
		
		ChatVO chatvo = gson.fromJson(message, ChatVO.class);
		String sender = chatvo.getSender();
		String key = chatvo.getKey();
		//not null 進去
		if ("history".equals(chatvo.getType())) {
			//從資料庫撈出歷史訊息
			List<String> historyData = JedisHandleMessage.getHistoryMsg(key);
			String historyMsg = gson.toJson(historyData);
			//創一個新包裹 裝有歷史訊息塞進去
			ChatVO history = new ChatVO("history", sender, "", key, historyMsg, "", "");
			if (userSession != null && userSession.isOpen()) {
				userSession.getAsyncRemote().sendText(gson.toJson(history));
				System.out.println("history = " + gson.toJson(history));
				return;
			}
		}else if("getallkey".equals(chatvo.getType())) {
			Set<String> allkey = JedisHandleMessage.getAllkey();
			String allkeyMsg = gson.toJson(allkey);
			ChatVO  allkeyvo = new ChatVO("getallkey", sender, "", "", allkeyMsg, "", "");
			if (userSession != null && userSession.isOpen()) {
				userSession.getAsyncRemote().sendText(gson.toJson(allkeyvo));
				System.out.println("allkeyvo = " + gson.toJson(allkeyvo));
				return;
			}
		}
		//必為chat
		if(sender.indexOf("E")!=-1) {//員工送出訊息
			//case2 :type:chat sender:E6 
			Session memberSession = sessionsMap.get(key);
			if (memberSession != null && memberSession.isOpen()) {
				System.out.println("GET"+message);
				memberSession.getAsyncRemote().sendText(message);
			}
		}else {
			//case1: type:chat sender:5 
			//拿出所有連線者 (裡面存放連線中的sender)
			Set<String> userNames = sessionsMap.keySet();
			for(String user : userNames) {//從一堆有E和沒有E全撈出來了  這裡找名字而已
				if(user.indexOf("E")!=-1) {//我是員工
					Session empSession = sessionsMap.get(user);//找出員工sessionon
					if (empSession != null && empSession.isOpen()) {
						empSession.getAsyncRemote().sendText(message);
						//還完要存到redis
					}
				}
			}
		}
		JedisHandleMessage.saveChatMessage(key, message);
		userSession.getAsyncRemote().sendText(message);
		
		
	}
	
	@OnError
	public void onError(Session userSession, Throwable e) {
		System.out.println("Error: " + e.toString());
	}
	
	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		//userNameClose是好友離線用
		String userNameClose = null;
		Set<String> userNames = sessionsMap.keySet();
		for (String userName : userNames) {
			//迴圈中尋找自己的名字連線,找到符合的,把map裡面存放的連線移除
			//因為自己已經要離線了，所以要移除，那為什麼要userNameClose? 因為你要跟其他使用者說你離線了，所以好友列表要刪除
			if (sessionsMap.get(userName).equals(userSession)) {
				userNameClose = userName;
				sessionsMap.remove(userName);
				break;//找到就可以離開迴圈不要再繼續找
			}
		}

		if (userNameClose != null) {
			State stateMessage = new State("close", userNameClose, userNames);
			String stateMessageJson = gson.toJson(stateMessage);
			Collection<Session> sessions = sessionsMap.values();
			for (Session session : sessions) {
				session.getAsyncRemote().sendText(stateMessageJson);
			}
		}

		String text = String.format("session ID = %s, disconnected; close code = %d%nusers: %s", userSession.getId(),
				reason.getCloseCode().getCode(), userNames);
		System.out.println(text);
	}
}

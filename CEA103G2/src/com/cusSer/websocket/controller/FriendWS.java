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

import com.google.gson.Gson;

import com.cusSer.websocket.jedis.JedisHandleMessage;
import com.cusSer.websocket.model.ChatMessage;
import com.cusSer.websocket.model.State;

@ServerEndpoint("/FriendWS/{userName}")
public class FriendWS {
	//創一個map 裡面裝有所有這個連線者、其他連線者 包含自己
	private static Map<String, Session> sessionsMap = new ConcurrentHashMap<>();
	Gson gson = new Gson();

	@OnOpen
	public void onOpen(@PathParam("userName") String userName, Session userSession) throws IOException {
		/* save the new user in the map */
		//{(使用者名稱1,使用者連線ID1)、(使用者名稱2,使用者連線ID2)、(使用者名稱3,使用者連線ID3)}
		sessionsMap.put(userName, userSession);
		/* Sends all the connected users to the new user */
		Set<String> userNames = sessionsMap.keySet();
		
		//創一個新包裹1 open  自己  其他使用者，包含自己
		State stateMessage = new State("open", userName, userNames);
		
		String stateMessageJson = gson.toJson(stateMessage);
		
		Collection<Session> sessions = sessionsMap.values();
		
		
		for (Session session : sessions) {
			if (session.isOpen()) {
				session.getAsyncRemote().sendText(stateMessageJson);
				
			}
		}

		String text = String.format("Session ID = %s, connected; userName = %s%nusers: %s", userSession.getId(),
				userName, userNames);
		System.out.println(text);
		System.out.println("dd"+userNames);
	}

	@OnMessage
	public void onMessage(Session userSession, String message) {
		//message是前面送來的包裹
		ChatMessage chatMessage = gson.fromJson(message, ChatMessage.class);
		String sender = chatMessage.getSender();
		String receiver = chatMessage.getReceiver();
		
		if ("history".equals(chatMessage.getType())) {
			//存到歷史訊息
			List<String> historyData = JedisHandleMessage.getHistoryMsg(sender, receiver);
			
			String historyMsg = gson.toJson(historyData);
			
			//創一個新包裹 裝有歷史訊息塞進去
			ChatMessage cmHistory = new ChatMessage("history", sender, receiver, historyMsg);
			
			if (userSession != null && userSession.isOpen()) {
				userSession.getAsyncRemote().sendText(gson.toJson(cmHistory));
				System.out.println("history = " + gson.toJson(cmHistory));
				return;
			}
		}
		
		
		Session receiverSession = sessionsMap.get(receiver);//找出這個連線者的朋友
		if (receiverSession != null && receiverSession.isOpen()) {
			//把59行收到的包裹  送給連線者
			receiverSession.getAsyncRemote().sendText(message);
			userSession.getAsyncRemote().sendText(message);
			//還完要存到redis
			JedisHandleMessage.saveChatMessage(sender, receiver, message);
		}
		System.out.println("Message received: " + message);
	}

	@OnError
	public void onError(Session userSession, Throwable e) {
		System.out.println("Error: " + e.toString());
	}

	
	
	
	
	
	
	
	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		String userNameClose = null;
		Set<String> userNames = sessionsMap.keySet();
		for (String userName : userNames) {
			if (sessionsMap.get(userName).equals(userSession)) {
				userNameClose = userName;
				sessionsMap.remove(userName);
				break;
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

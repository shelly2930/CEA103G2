package com.notice.websocket.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
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
import com.notice.websocket.jedis.HandleNotice;
import com.notice.websocket.model.Notice;

@ServerEndpoint("/test/{username}/{identity}")
public class NoticeWS {
	private static Map<String, Session> sessionsMap = new ConcurrentHashMap<>();
	private static Map<String, String> judge = new LinkedHashMap<String, String>();
	Gson gson = new Gson();
	@OnOpen
	public void onOpen( @PathParam("username") String username,@PathParam("identity") String identity,Session userSession) throws IOException {
		/* save the new user in the map */
		sessionsMap.put(username,userSession);//放入這條連線的使用者名稱
		judge.put(username, identity);
		Notice sendOpen = new Notice("open",username,identity,"","");
		userSession.getAsyncRemote().sendText(new Gson().toJson(sendOpen));
	}

	@OnMessage
	public void onMessage(Session userSession, String message) {
		System.out.println("S");
		System.out.println(message);
		Notice notice = new Gson().fromJson(message, Notice.class);
		String username = notice.getUsername();
		String identity = notice.getIdentity();
		String curTime = notice.getCurrentTime();
		String mes = notice.getMessage();
		Notice sendNotice = null;
		if(notice.getType().equals("send")&&notice.getIdentity().equals("0")) {
			sendNotice = new Notice("receive",username,identity,curTime,mes);
			String sendNoticeJson = new Gson().toJson(sendNotice);
			Set<String> total = sessionsMap.keySet();
			for(String temp : total) {
				if("1".equals(judge.get(temp))&&sessionsMap.get(temp).isOpen()) {
					System.out.println("SAAA");
					HandleNotice.saveHistory(identity, sendNoticeJson);
					sessionsMap.get(temp).getAsyncRemote().sendText(sendNoticeJson);//前台
				}
			}
		}else if(notice.getType().equals("send")&&notice.getIdentity().equals("1")) {//來自後台
			sendNotice = new Notice("receive",identity,username,curTime,mes);
			String sendNoticeJson = new Gson().toJson(sendNotice);
			Set<String> total = sessionsMap.keySet();
			for(String temp : total) {
				if("0".equals(judge.get(temp))&&sessionsMap.get(temp).isOpen()) {
					HandleNotice.saveHistory(identity, sendNoticeJson);
					sessionsMap.get(temp).getAsyncRemote().sendText(sendNoticeJson);//後台
					System.out.println(sendNoticeJson+"TEST");
				}
			}
		}
	}


	@OnError
	public void onError(Session userSession, Throwable e) {
		System.out.println("Error: " + e.toString());
	}

	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
//		String userNameClose = null;
//		Set<String> others = sessionsMap.keySet();
//		for (String userName : others) {
//		//1.先從maps移除 沒有連線的該使用者
//		//把map裡面所有連線者，比對其session，找到相同session移除掉[因為map裡面存放的就是正在連線]
//			if (sessionsMap.get(userName).equals(userSession)) {
//				userNameClose = userName;
//				sessionsMap.remove(userName);
//				break;
//			}
//		}
//		//關掉要跟前台說你關閉了
//		if (userNameClose != null) {
//			State stateMessage = new State("close", userNameClose, others);
//			String stateMessageJson = gson.toJson(stateMessage);
//			Collection<Session> sessions = sessionsMap.values();
//			for (Session session : sessions) {
//				session.getAsyncRemote().sendText(stateMessageJson);
//			}
//		}
//
//		String text = String.format("session ID = %s, disconnected; close code = %d%nusers: %s", userSession.getId(),
//				reason.getCloseCode().getCode(), others);
//		System.out.println(text);
	}

}

package com.rooVieApp.websocket.controller;

import java.io.IOException;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
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

import com.rooVieApp.websocket.jedis.HandlePickTime;
import com.rooVieApp.websocket.model.PickTime;
import com.rooVieApp.websocket.model.State;

@ServerEndpoint("/pickTime/{member}")
public class RooVieAppWS {
	//類似多執行緒，每條連線近來，你都裝進去maps  
	//所以該maps裡面裝有，包含自己的所有連線名稱
	//maps在這裡，要放正在連線的所有連線
	private static Map<String, Session> sessionsMap = new ConcurrentHashMap<>();
	Gson gson = new Gson();

	@OnOpen
	public void onOpen(@PathParam("member") String member, Session userSession) throws IOException {
		/* save the new user in the map */
		sessionsMap.put(member, userSession);//放入這條連線的使用者名稱
		//包含該條連線 的所有使用者名稱
		Set<String> others = sessionsMap.keySet();
		
		//包裹一類(包裹一類任務是丟出去，目前只丟一種包裹) 名稱:stateMessage  訊息 State(狀態、自己使用者、其他所有使用者)(String、String、Set<String>)
		State stateMessage = new State("open", member, others);
		
		//送出包裹一號
		String stateMessageJson = gson.toJson(stateMessage);//送到前台去
		
		Collection<Session> sessions = sessionsMap.values();
		for (Session session : sessions) {
			if (session.isOpen()) {//所有連線，我只有針對open的連線 才傳送
				session.getAsyncRemote().sendText(stateMessageJson);
			}
		}
		//test用
		String text = String.format("Session ID = %s, connected; userName = %s%nusers: %s", userSession.getId(),
				member, others);
		System.out.println(text);
	}

	@OnMessage
	public void onMessage(Session userSession, String message) {
		
		//包裹二類(在這要接收包裹二類 目前包裹二類有兩種 A:[identity,message] B:[type,sender,identity,message]) 
		//接收前端的包裹 裝在picktime	
		PickTime picktime = gson.fromJson(message, PickTime.class);
//		拿到的JOSN，取出我要的
		String sender = picktime.getSender();
		String identity = picktime.getIdentity();
//		包裹type為歷史 表示這包裹，我要處理!!![這裡表示想要取得舊資料]
		if ("history".equals(picktime.getType())) {
//			取出歷史訊息
			//查詢資料庫資料 所有為identity的資料
			List<String> historyData = HandlePickTime.getHistoryMsg(identity);
//			歷史訊息轉JSON
			String getmessage = gson.toJson(historyData);//字串陣列
			PickTime ptime = new PickTime("history", sender, identity, getmessage);
			if (userSession != null && userSession.isOpen()) {
				//只要針對還在連線的open就好
				//包裹三類，這是查詢完資料庫內容並且包裝完成的包裹，送出
				userSession.getAsyncRemote().sendText(gson.toJson(ptime));
				return;
			}
		}
		Set<String> others = sessionsMap.keySet();//map 放著 使用者名稱與session連線
		for(String other : others) {
			Session receiverSession = sessionsMap.get(other);//找出接受者
			if (receiverSession != null && receiverSession.isOpen()) {//連線的這些人
				//message是前面送來的包裹，再送回去
				receiverSession.getAsyncRemote().sendText(message);
//				存進資料庫
				HandlePickTime.saveChatMessage(identity, message);
				System.out.println("Message received: " + message);
			}
		}
		
	}

	@OnError
	public void onError(Session userSession, Throwable e) {
		System.out.println("Error: " + e.toString());
	}

	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		String userNameClose = null;
		Set<String> others = sessionsMap.keySet();
		for (String userName : others) {
		//1.先從maps移除 沒有連線的該使用者
		//把map裡面所有連線者，比對其session，找到相同session移除掉[因為map裡面存放的就是正在連線]
			if (sessionsMap.get(userName).equals(userSession)) {
				userNameClose = userName;
				sessionsMap.remove(userName);
				break;
			}
		}
		//關掉要跟前台說你關閉了
		if (userNameClose != null) {
			State stateMessage = new State("close", userNameClose, others);
			String stateMessageJson = gson.toJson(stateMessage);
			Collection<Session> sessions = sessionsMap.values();
			for (Session session : sessions) {
				session.getAsyncRemote().sendText(stateMessageJson);
			}
		}

		String text = String.format("session ID = %s, disconnected; close code = %d%nusers: %s", userSession.getId(),
				reason.getCloseCode().getCode(), others);
		System.out.println(text);
	}
}

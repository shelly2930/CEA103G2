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
	// �@�� 1. ���AVO
	@OnOpen
	public void onOpen(@PathParam("userName") String userName, Session userSession) throws IOException {
		//�����s�u ��O��
		sessionsMap.put(userName, userSession);
		Set<String> userNames = sessionsMap.keySet();
		System.out.println("UESR"+userName);
		//�Ф@��stateVO �^�ǫe�x ��L��open�ӥB�n��s�n�ͦC��A��x//�n��s�|�� �A��x�P�O���Φ�E��
		State stateMessage = new State("open", userName, userNames);
		String stateMessageJson = gson.toJson(stateMessage);
		
		//�o�e
		Collection<Session> sessions = sessionsMap.values();
		for (Session session : sessions) {
		if (session.isOpen()) {
				session.getAsyncRemote().sendText(stateMessageJson);
			}
		}
	}
	
	@OnMessage
	public void onMessage(Session userSession, String message) {
		//�����v�T���ť] ���X���v�T���˦n �^��
		//�p�G�O���`��ѱ��p �������
		
		
		ChatVO chatvo = gson.fromJson(message, ChatVO.class);
		String sender = chatvo.getSender();
		String key = chatvo.getKey();
		//not null �i�h
		if ("history".equals(chatvo.getType())) {
			//�q��Ʈw���X���v�T��
			List<String> historyData = JedisHandleMessage.getHistoryMsg(key);
			String historyMsg = gson.toJson(historyData);
			//�Ф@�ӷs�]�q �˦����v�T����i�h
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
		//����chat
		if(sender.indexOf("E")!=-1) {//���u�e�X�T��
			//case2 :type:chat sender:E6 
			Session memberSession = sessionsMap.get(key);
			if (memberSession != null && memberSession.isOpen()) {
				System.out.println("GET"+message);
				memberSession.getAsyncRemote().sendText(message);
			}
		}else {
			//case1: type:chat sender:5 
			//���X�Ҧ��s�u�� (�̭��s��s�u����sender)
			Set<String> userNames = sessionsMap.keySet();
			for(String user : userNames) {//�q�@�靈E�M�S��E�����X�ӤF  �o�̧�W�r�Ӥw
				if(user.indexOf("E")!=-1) {//�ڬO���u
					Session empSession = sessionsMap.get(user);//��X���usessionon
					if (empSession != null && empSession.isOpen()) {
						empSession.getAsyncRemote().sendText(message);
						//�٧��n�s��redis
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
		//userNameClose�O�n�����u��
		String userNameClose = null;
		Set<String> userNames = sessionsMap.keySet();
		for (String userName : userNames) {
			//�j�餤�M��ۤv���W�r�s�u,���ŦX��,��map�̭��s�񪺳s�u����
			//�]���ۤv�w�g�n���u�F�A�ҥH�n�����A��������nuserNameClose? �]���A�n���L�ϥΪ̻��A���u�F�A�ҥH�n�ͦC��n�R��
			if (sessionsMap.get(userName).equals(userSession)) {
				userNameClose = userName;
				sessionsMap.remove(userName);
				break;//���N�i�H���}�j�餣�n�A�~���
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

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
	//�����h������A�C���s�u��ӡA�A���˶i�hmaps  
	//�ҥH��maps�̭��˦��A�]�t�ۤv���Ҧ��s�u�W��
	//maps�b�o�̡A�n�񥿦b�s�u���Ҧ��s�u
	private static Map<String, Session> sessionsMap = new ConcurrentHashMap<>();
	Gson gson = new Gson();

	@OnOpen
	public void onOpen(@PathParam("member") String member, Session userSession) throws IOException {
		/* save the new user in the map */
		sessionsMap.put(member, userSession);//��J�o���s�u���ϥΪ̦W��
		//�]�t�ӱ��s�u ���Ҧ��ϥΪ̦W��
		Set<String> others = sessionsMap.keySet();
		
		//�]�q�@��(�]�q�@�����ȬO��X�h�A�ثe�u��@�إ]�q) �W��:stateMessage  �T�� State(���A�B�ۤv�ϥΪ̡B��L�Ҧ��ϥΪ�)(String�BString�BSet<String>)
		State stateMessage = new State("open", member, others);
		
		//�e�X�]�q�@��
		String stateMessageJson = gson.toJson(stateMessage);//�e��e�x�h
		
		Collection<Session> sessions = sessionsMap.values();
		for (Session session : sessions) {
			if (session.isOpen()) {//�Ҧ��s�u�A�ڥu���w��open���s�u �~�ǰe
				session.getAsyncRemote().sendText(stateMessageJson);
			}
		}
		//test��
		String text = String.format("Session ID = %s, connected; userName = %s%nusers: %s", userSession.getId(),
				member, others);
		System.out.println(text);
	}

	@OnMessage
	public void onMessage(Session userSession, String message) {
		
		//�]�q�G��(�b�o�n�����]�q�G�� �ثe�]�q�G������� A:[identity,message] B:[type,sender,identity,message]) 
		//�����e�ݪ��]�q �˦bpicktime	
		PickTime picktime = gson.fromJson(message, PickTime.class);
//		���쪺JOSN�A���X�ڭn��
		String sender = picktime.getSender();
		String identity = picktime.getIdentity();
//		�]�qtype�����v ��ܳo�]�q�A�ڭn�B�z!!![�o�̪�ܷQ�n���o�¸��]
		if ("history".equals(picktime.getType())) {
//			���X���v�T��
			//�d�߸�Ʈw��� �Ҧ���identity�����
			List<String> historyData = HandlePickTime.getHistoryMsg(identity);
//			���v�T����JSON
			String getmessage = gson.toJson(historyData);//�r��}�C
			PickTime ptime = new PickTime("history", sender, identity, getmessage);
			if (userSession != null && userSession.isOpen()) {
				//�u�n�w���٦b�s�u��open�N�n
				//�]�q�T���A�o�O�d�ߧ���Ʈw���e�åB�]�˧������]�q�A�e�X
				userSession.getAsyncRemote().sendText(gson.toJson(ptime));
				return;
			}
		}
		Set<String> others = sessionsMap.keySet();//map ��� �ϥΪ̦W�ٻPsession�s�u
		for(String other : others) {
			Session receiverSession = sessionsMap.get(other);//��X������
			if (receiverSession != null && receiverSession.isOpen()) {//�s�u���o�ǤH
				//message�O�e���e�Ӫ��]�q�A�A�e�^�h
				receiverSession.getAsyncRemote().sendText(message);
//				�s�i��Ʈw
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
		//1.���qmaps���� �S���s�u���ӨϥΪ�
		//��map�̭��Ҧ��s�u�̡A����session�A���ۦPsession������[�]��map�̭��s�񪺴N�O���b�s�u]
			if (sessionsMap.get(userName).equals(userSession)) {
				userNameClose = userName;
				sessionsMap.remove(userName);
				break;
			}
		}
		//�����n��e�x���A�����F
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

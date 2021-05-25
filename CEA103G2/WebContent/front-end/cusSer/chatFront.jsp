<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.post.model.*"%>
<%@ page import="com.memTen.model.*"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>

<style>
* {
	box-sizing: border-box;
}

#chat {
	position: absolute;
	font: 15px verdana, Times New Roman, arial, helvetica, sans-serif,
		Microsoft JhengHei;
	width: 478px;
	height: 500px;
	top: 73px;
}

.panel {
	background: white;
	/* 	border: 2px solid #0078ae; */
	border-radius: 5px;
	width: 100%;
}

#messagesArea {
	float: right;
}

.message-area {
	height: 85%;
	resize: none;
	box-sizing: border-box;
	overflow: auto;
}

.input-area {
	background: #0078ae;
	box-shadow: inset 0 0 10px #00568c;
	float: right;
}

.input-area input {
	margin: 0.5em 0em 0.5em 0.5em;
}

.text-field {
	border: 1px solid grey;
	padding: 0.5em;
	box-shadow: 0 0 5px #000000;
}

h1 {
	font-size: 1.5em;
	padding: 5px;
	margin: 5px;
}

#userName {
	width: 20%;
}

#message {
	width: 80%;
}

#sendMessage {
	padding: 5px;
	background-color: white;
	text-align: justify;
	color: black;
}

.footer_part {
	position: relative;
	top: 500px;
}

#hide, #show {
	position: relative;
	top: 100px;
	left: 50px;
}

ul {
	list-style: none;
	margin: 0;
	padding: 0;
}

ul li {
	display: inline-block;
	clear: both;
	border-radius: 30px;
	margin-bottom: 2px;
	font-family: Helvetica, Arial, sans-serif;
}

ul li#time {
	display: table;
	margin: 0 auto;
	float: none;
	font-size: 0.5em;
	color: #D3D3D3;
}

.friend {
	background: #eee;
	float: left;
	padding: 20px;
}

.me {
	float: right;
	background: #0084ff;
	color: #fff;
	padding: 20px;
}

.friend+.me {
	border-bottom-right-radius: 5px;
}

.me+.me {
	border-top-right-radius: 5px;
	border-bottom-right-radius: 5px;
}

.me:last-of-type {
	border-bottom-right-radius: 30px;
}

#time {
	background: none;
	color: black;
	/*     padding: inherit; */
}

.panel message-area #time {
	margin: auto;
}
</style>
</head>
<body onload="connect();" onunload="disconnect();">
	<div id="chat" class="flex">
		<div id="row"></div>
		<div id="messagesArea" class="panel message-area"></div>
		<div class="panel input-area">
			<input id="message" class="text-field" type="text-area"
				placeholder="Message"
				onkeydown="if (event.keyCode == 13) sendMessage();" /> <input
				type="submit" id="sendMessage" class="button" value="Send"
				onclick="sendMessage();" />
		</div>
	</div>
</body>

<script>
	var MyPoint = "/chat/${MemTenVO.mem_no}";
	var self = '${MemTenVO.mem_no}';

	var host = window.location.host;
	var path = window.location.pathname;
	var webCtx = path.substring(0, path.indexOf('/', 1));
	var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
	var statusOutput = document.getElementById("statusOutput");
	var messagesArea = document.getElementById("messagesArea");
	var webSocket;
	function connect() {
		// create a websocket
		webSocket = new WebSocket(endPointURL);

		webSocket.onopen = function(event) {
			console.log("Connect Success!");
		};

		webSocket.onmessage = function(event) {
			//�]�q
			var jsonObj = JSON.parse(event.data);
			if ("open" === jsonObj.type) {
				addListener();
			} else if ("history" === jsonObj.type) {
				messagesArea.innerHTML = '';
				var ul = document.createElement('ul');
				ul.id = "area";
				messagesArea.appendChild(ul);
				// �o�檺jsonObj.message�O�qredis���X��n�ͪ����v�T���A�Aparse��JSON�榡�B�z
				//�s�bredies�����v�T�� �]�q
				var messages = JSON.parse(jsonObj.message);
				for (var i = 0; i < messages.length; i++) {
					var historyData = JSON.parse(messages[i]);
					var showMsg = historyData.message;
					var showDt = historyData.date;
					var li = document.createElement('li');
					var liTime = document.createElement('li');
					liTime.id = 'time';
					// �ھڵo�e�̬O�ۤv�٬O���ӵ������P��class�W, �H�F��T�����k�Ϥ�
					//CSS�ɮפ��Ϥ�

					historyData.sender === self ? li.className += 'me'
							: li.className += 'friend';
					historyData.sender === self ? liTime.className += 'me'
							: liTime.className += 'friend';
					liTime.innerHTML = showDt;
					li.innerHTML = showMsg;
					ul.appendChild(liTime);
					ul.appendChild(li)

				}
				messagesArea.scrollTop = messagesArea.scrollHeight;
				//�����ۤv�o�X�h��chat�]�q
			} else if ("chat" === jsonObj.type) {
				var ul = document.createElement('ul');
				ul.id = "area";
				messagesArea.appendChild(ul);
				var li = document.createElement('li');
				var liTime = document.createElement('li');
				liTime.id = 'time';
				// 				jsonObj.sender === self ? li.innerHTML = "�|��" + jsonObj.sender
				// 						+ ":" + jsonObj.message + "<br>" +jsonObj.date : li.innerHTML = "���u" + ":"
				// 						+ jsonObj.message + "<br>" +jsonObj.date;

				// 						self ? li.className += 'me' : li.className += 'friend'
				// 						li.innerHTML = jsonObj.message;
				jsonObj.sender === self ? li.className += 'me'
						: li.className += 'friend';
				jsonObj.sender === self ? liTime.className += 'me'
						: liTime.className += 'friend';
				liTime.innerHTML = jsonObj.date;
				li.innerHTML = jsonObj.message;

				console.log(li);
				console.log(liTime);
				//��li�[��"area"��
				document.getElementById("area").appendChild(liTime);
				document.getElementById("area").appendChild(li);
				messagesArea.scrollTop = messagesArea.scrollHeight;
				//����server�ݵo�X�������]�q
			} else if ("close" === jsonObj.type) {
				refreshFriendList(jsonObj);//�����|���C��
			}

		};

		webSocket.onclose = function(event) {
			console.log("Disconnected!");
		};
	}

	function sendMessage() {
		var inputMessage = document.getElementById("message");
		var now = new Date();
		var message = inputMessage.value.trim();//�����J����r
		//�s�i�h�o1100519
		var nowTime = timeFormat(now);

		if (message === "") {
			alert("Input a message");
			inputMessage.focus();
		} else {
			//��server�� �e�X��ѥ]�q
			var jsonObj = {
				"type" : "chat",
				"sender" : self,
				"friend" : "",
				"key" : self,
				"message" : message,
				"date" : nowTime,
				"judge" : "0",
			};

			//�o�e!!!!
			webSocket.send(JSON.stringify(jsonObj));
			inputMessage.value = "";
			inputMessage.focus();
		}
	}

	function timeFormat(now) {
		return now.getFullYear() + '/' + (now.getMonth() + 1) + '/'
				+ now.getDate() + ' ' + now.getHours() + ':' + now.getMinutes();
	}

	// ���n�ͤW�u�����u�N��s�C��
	function refreshFriendList(jsonObj) {
		//51��A ��open�]�q����  ��ѥ]�q�A��̭����B��  ��s�쭶���W
		var friends = jsonObj.users;
		var row = document.getElementById("row");
		row.innerHTML = '';
		for (var i = 0; i < friends.length; i++) {
			if (friends[i] === self) {
				continue;
			}
			row.innerHTML += '<div id=' + i + ' class="column" name="friendName" value=' + friends[i] + ' ><h2>'
					+ friends[i] + '</h2></div>';
		}
	}

	//$(���U�Y��click�ƥ�) �ڥh�I�� ��쨺�ӷ|��  ��U�I�saddListener();

	// ���U�C���I���ƥ�ç���n�ͦW�r�H���o���v�T��
	function addListener() {

		var jsonObj = {
			"type" : "history",
			"sender" : self,
			"friend" : "click",
			"key" : self,
			"message" : "",
			"date" : "",
			"judge" : "",
		};
		webSocket.send(JSON.stringify(jsonObj));

	}

	function disconnect() {
		webSocket.close();
	}
</script>

</html>
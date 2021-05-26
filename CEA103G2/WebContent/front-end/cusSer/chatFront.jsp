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
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">



<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.nicescroll/3.6.8-fix/jquery.nicescroll.min.js"></script>
   <link rel="stylesheet" href="<%=request.getContextPath()%>/template_front-end/chat/chat.css">
<script src="<%=request.getContextPath()%>/template_front-end/chat/chat.js"></script>
<style>

</style>
</head>
<body onload="connect();" onunload="disconnect();">

			<div id='chatleft' class="answer left">
			    <div class="avatar">
			        <div class="status offline"></div>
			    </div>
			    <div class="name"></div>
			    <div class="text">
			        
			    </div>
			    <div class="time"></div>
			</div>
			 <div id='chatright' class="answer right">
			     <div class="avatar">
			         <div class="status offline"></div>
			     </div>
			     <div class="name"></div>
			     <div class="text">
			     </div>
			     <div class="time"></div>
			 </div>

			<div class=" rounded-top border border-info chat-body panel chat message-area" style='overflow:auto;border:2px solid blue' id="messagesArea" >
			
			
			</div>
                
              <div class="answer-add2 ">
              <div class="row">
	              <div class="col-sm-12 panel input-group mb-3">
	               		<input id="message" class="input form-control text-field" type="text"
						placeholder="Message"
						onkeydown="if (event.keyCode == 13) sendMessage();" />
					  <div class="input-group-append">
					    <input
						type="submit" id="sendMessage" class="btn btn-outline-primary"  value="Send"
						onclick="sendMessage();" />
					  </div>
					</div>
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
				$("#messagesArea").empty();
				addListener();
			} else if ("history" === jsonObj.type) {
				// �o�檺jsonObj.message�O�qredis���X��n�ͪ����v�T���A�Aparse��JSON�榡�B�z
				//�s�bredies�����v�T�� �]�q
				var messages = JSON.parse(jsonObj.message);
				for (var i = 0; i < messages.length; i++) {
					var historyData = JSON.parse(messages[i]);
					var showMsg = historyData.message;
					var showDt = historyData.date;
					// �ھڵo�e�̬O�ۤv�٬O���ӵ������P��class�W, �H�F��T�����k�Ϥ�
					//CSS�ɮפ��Ϥ�
					if(jsonObj.sender === self){
						var a = $("#chatright").clone(true);
						$("#messagesArea").append($(a));
						$(a).children(".name").text("�|���s��:"+jsonObj.sender);
						$(a).children(".text").text(showMsg);
						$(a).children(".time").text(showDt);
					}else{
						var a = $("#chatleft").clone(true);
						$("#messagesArea").append($(a));
						$(a).children(".name").text("�ȪA");
						$(a).children(".text").text(showMsg);
						$(a).children(".time").text(showDt);
					}
				}
				let height = $("#messagesArea").prop('scrollHeight');
				$("#messagesArea").scrollTop(height);

				//�����ۤv�o�X�h��chat�]�q
			} else if ("chat" === jsonObj.type) {
				if(jsonObj.sender === self){
					var a = $("#chatright").clone(true);
					$("#messagesArea").append($(a));
					$(a).children(".name").text("�|���s��:"+jsonObj.sender);
					$(a).children(".text").text(jsonObj.message);
					$(a).children(".time").text(jsonObj.date);
				}else{
					var a = $("#chatleft").clone(true);
					$("#messagesArea").append($(a));
					$(a).children(".name").text("�ȪA");
					$(a).children(".text").text(jsonObj.message);
					$(a).children(".time").text(jsonObj.date);
				}
				let height = $("#messagesArea").prop('scrollHeight');
				$("#messagesArea").scrollTop(height);
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
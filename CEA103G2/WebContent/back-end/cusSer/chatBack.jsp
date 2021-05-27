<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ page import="javax.servlet.http.Cookie"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>��x�ŭ�</title>

<!-- Custom fonts for this template-->
<link
	href="<%=request.getContextPath()%>/template_back-end/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link
	href="<%=request.getContextPath()%>/template_back-end/css/sb-admin-2.min.css"
	rel="stylesheet">


<style>
#chat {
	margin: auto;
	padding: 0px;
}

#chat {
	position: absolute;
	left: 30% !important;
    top: 40% !important;
	font: 15px verdana, Times New Roman, arial, helvetica, sans-serif,
		Microsoft JhengHei;
	width: 400px;
	height: 500px;
}

.panel {
	border: 2px solid #ced4da;
	border-radius: 5px;
	width: 100%;
}

.message-area {
	height: 70%;
	resize: none;
	box-sizing: border-box;
	overflow: auto;
	background-color: rgb(222, 255, 255);
}

.input-area {
	background: #fff;
}

.input-area input {
	margin: 0.5em 0em 0.5em 0.5em;
}

.text-field {
	border: 1px solid grey;
	padding: 0.2em;
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
    position: relative;
    flex: 1 1 auto;
    width: 80%;
}

.statusOutput {
	background: #0078ae;
	text-align: center;
	color: #ffffff;
	border: 1px solid grey;
	padding: 0.2em;
	box-shadow: 0 0 5px #000000;
	width: 30%;
}
ul{
  list-style: none;
  margin: 0;
  padding: 0;
}

ul li{
  display:inline-block;
  clear: both;
  border-radius: 30px;
  margin-bottom: 2px;
  font-family: Helvetica, Arial, sans-serif;
}
ul li#time {
	display: table;
	margin: 0 auto;
	float: none;
	font-size: 0.7em;
    font-weight: bolder;
    color: #8b8383;
}

.friend{
  background: #ebebeb;
  float: left;
  padding: 20px;
}

.me{
  float: right;
  background: #7266ba;
  color: #fff;
  padding: 20px;
}
.friend + .me{
  border-bottom-right-radius: 5px;
}

/* .me + .me{ */
/*   border-top-right-radius: 5px; */
/*   border-bottom-right-radius: 5px; */
/* } */

.me:last-of-type {
  border-bottom-right-radius: 30px;
}
#time{
	background: none;
    color: black;
     padding: inherit; 
}
</style>
</head>

<body id="page-top" onload="connect();" onunload="disconnect();">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<%@ include file="/back-end/includeFile/sidebarBack.file"%>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<%@ include file="/back-end/includeFile/topbarBack.file"%>

				<!--�@�@�@�����������������������e���������������������@�@�@-->


				<!--                 �ǰT�����|�� -->
				<div id = 'description'>�ݦ^�_�T�����|��</div>
				<div id='point'></div>
				<!--                 �ǰT�����|�� -->


<%-- 				catch${employeeVO.emp_no}�����u --%>
				<div class="container-fluid">
					<div id="chat">
						<div id="row"></div>
						<div id="messagesArea" class="panel message-area"></div>
						<div class="panel input-area">
							<input id="message" class="text-field" type="text"
								placeholder="Message"
								onkeydown="if (event.keyCode == 13) sendMessage(test);" /> <input
								type="submit" id="sendMessage" class="button" value="Send" />
						</div>
					</div>
				</div>
				<!--�@�@�@�����������������������e���������������������@�@�@-->

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<%@ include file="/back-end/includeFile/footerBack.file"%>

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<%@ include file="/back-end/includeFile/otherBack.file"%>

	<!-- Bootstrap core JavaScript-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/jquery/jquery.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script
		src="<%=request.getContextPath()%>/template_back-end/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script
		src="<%=request.getContextPath()%>/template_back-end/vendor/chart.js/Chart.min.js"></script>

	<!-- Page level custom scripts -->
	<script
		src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-area-demo.js"></script>
	<script
		src="<%=request.getContextPath()%>/template_back-end/js/demo/chart-pie-demo.js"></script>

</body>
<script>
	var MyPoint = "/chat/"+"E"+"${employeeVO.emp_no}";
	var self = "E"+'${employeeVO.emp_no}';
	var host = window.location.host;
	var path = window.location.pathname;
	var webCtx = path.substring(0, path.indexOf('/', 1));
	var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
	var statusOutput = document.getElementById("statusOutput");
	var messagesArea = document.getElementById("messagesArea");
	let test = "";
	let conunt = 0;
	

		$("input[type='submit']").click(function(){
			sendMessage(test);
		});
	
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
				if(conunt++<1){
					getAllMember();
				}
				

// 				refreshFriendList(jsonObj);//��sShow�X�Ҧ��|���A��Ū�T��
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
					historyData.sender.indexOf("E")!== -1 ? li.className += 'me' : li.className += 'friend';
					historyData.sender.indexOf("E")!== -1 ? liTime.className += 'me' : liTime.className += 'friend';
					liTime.innerHTML = showDt;
					li.innerHTML = showMsg;
					ul.appendChild(liTime);
					ul.appendChild(li);
// 					jsonObj.sender === self ? li.innerHTML = "�|��"+historyData.sender+":"+historyData.message : li.innerHTML = "���u"+":"+historyData.message;
					ul.appendChild(li);
				}
				messagesArea.scrollTop = messagesArea.scrollHeight;
				//�����ۤv�o�X�h��chat�]�q
			} else if ("chat" === jsonObj.type && jsonObj.key ===test) {
				var ul = document.createElement('ul');
				ul.id = "area";
				messagesArea.appendChild(ul);
				var li = document.createElement('li');
				var liTime = document.createElement('li');
				liTime.id = 'time';
// 				jsonObj.sender === self ? li.innerHTML = "���u"+self+":"+jsonObj.message : li.innerHTML = "�|��"+jsonObj.key+":"+jsonObj.message;
				
				jsonObj.sender === self ? li.className += 'me' : li.className += 'friend';
				jsonObj.sender === self ? liTime.className += 'me' : liTime.className += 'friend';
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
			} else if("getallkey" === jsonObj.type){
				console.log(jsonObj.message);
				let mem = JSON.parse(jsonObj.message);
				for(let temp of mem){
					if(temp.trim()=="" || temp.indexOf("E")!=-1) continue;  
					let button = "<button class='member btn btn-outline-info btn-sm' id='"+temp+"'>�|��"+temp+"</button>&nbsp;";
					$("#point").append(button);
					//���w����ӷ|����� �I���ӫ��s
				}
				$(".member").click(function(){
					test = $(this).attr('id');
					addListener(test);
					$(".member").each(function(){
						$(".member").prop('disabled',false);
						console.log("H!");
					})
					$(this).prop('disabled',true);
					console.log("H2");
				})
				addListener(test);
			}
			
		};

		webSocket.onclose = function(event) {
			console.log("Disconnected!");
		};
	}
	
	function sendMessage(test) {
		var inputMessage = document.getElementById("message");
// 		var friend = statusOutput.textContent;
		var message = inputMessage.value.trim();//�����J����r
		var now = new Date();
		var nowTime = timeFormat(now);
		//���� �T���Ū��Ϊ̨S��B�� �����A�e�T��
		if (message === "") {
			alert("Input a message");
			inputMessage.focus();
		}  else {
			//��server�� �e�X��ѥ]�q
			var jsonObj = {
				"type" : "chat",
				"sender" : self,
				"friend" : test,
				"key" :test,
				"message" : message,
				"date": nowTime,
				"judge":0,
			};
			
			//�o�e!!!!
			webSocket.send(JSON.stringify(jsonObj));
			inputMessage.value = "";
			inputMessage.focus();
		}
	}
	
	function timeFormat(now) {
        return now.getFullYear() + '/' + (now.getMonth() + 1) + '/' + now.getDate() + ' ' + now.getHours() + ':' + now.getMinutes();
    }
	
	
	// ���n�ͤW�u�����u�N��s�C��
// 	function refreshFriendList(jsonObj) {
// 		//��Ҧ��ϥΪ̧�X�� append�bdiv�̭�
// 		var friends = jsonObj.users;
// 		var row = document.getElementById("row");
// 		row.innerHTML = '';
// 		for (var i = 0; i < friends.length; i++) {
// 			if (friends[i] === self) { continue; }
// 			row.innerHTML +='<div id=' + i + ' class="column" name="friendName" value=' + friends[i] + ' ><h2>' + friends[i] + '</h2></div>';
// 		}
// 	}
	
	//$(���U�Y��click�ƥ�) �ڥh�I�� ��쨺�ӷ|��  ��U�I�saddListener();
	
	// ���U�C���I���ƥ�ç���n�ͦW�r�H���o���v�T��
	function addListener(test) {
			var jsonObj = {
					"type" : "history",
					"sender" : self,
					"friend" : test,
					"key" :test,
					"message" : "",
					"date":"",
					"judge":"",
				};
			webSocket.send(JSON.stringify(jsonObj));
	}
	//���o�Ҧ��|��
	function getAllMember(){
		let jsonObj = {
				"type" : "getallkey",
				"sender" : self,
				"friend" : "",
				"key" :"",
				"message" : "",
				"date":"",
				"judge":"",
		}
		webSocket.send(JSON.stringify(jsonObj));
	}
	
	
	function disconnect() {
		webSocket.close();
	}
	
// 	$(window).load(function(){
		
		
// 	})
	$("#chat").hide();
	$("#point").click(function(){
		$("#chat").show();
	});
	

	
</script>
</html>
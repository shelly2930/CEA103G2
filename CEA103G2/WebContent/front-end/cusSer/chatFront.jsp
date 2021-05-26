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



</html>
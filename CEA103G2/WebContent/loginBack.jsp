<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ page import="javax.servlet.http.Cookie"%>

<%
// 	String emp_username = null;
// 	Cookie[] cookieList = request.getCookies();
// 	if(cookieList != null){
// 		for(int i = 0; i < cookieList.length; i++) {
// 			Cookie cookie = cookieList[i];
// 			if(cookie.getName().equals("emp_username")){
// 				emp_username = cookie.getValue();
// 			}
// 		}
// 	}
// 	pageContext.setAttribute("emp_username",emp_username);
	
	Cookie[] cookieList = request.getCookies();
	for(Cookie cookie : cookieList){
		pageContext.setAttribute(cookie.getName(),cookie.getValue());
	}
	
%>

<!DOCTYPE html>
<html lang="zh-tw">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>HowTrue BackEndLogin</title>
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Josefin+Sans:wght@300;400;500;700&family=Noto+Sans+TC:wght@300;400;500;700&family=Noto+Serif+TC:wght@400;700&display=swap');

		.form {
			margin: auto;
			width: 400px;
			padding: 20px 30px;
			background: #fff;
			border: 1px solid #dfdfdf;
			transform-style: preserve-3d;
			perspective-origin: 50px center;
			perspective: 2000px;
			transition: transform 1s ease;
		}
		.form::before, .form::after {
			content: "";
			position: absolute;
			width: 100%;
			left: 0;
		}
		.form::before {
			height: 100%;
			top: 0;
			transform: translateZ(-100px);
			background: #333;
			opacity: 0.3;
		}
		.form::after {
			content: "SUCCESS!";
			transform: translateY(-50%) translateZ(-101px) scaleX(-1);
			top: 50%;
			color: #fff;
			text-align: center;
			font-weight: bold;
		}

		.field {
			position: relative;
			background: #cfcfcf;
			transform-style: preserve-3d;
		}
		.field + .field {
			margin-top: 10px;
		}

		.icon {
			width: 24px;
			height: 24px;
			position: absolute;
			top: calc(50% - 12px);
			left: 12px;
			transform: translateZ(50px);
			transform-style: preserve-3d;
		}
		.icon::before, .icon::after {
			content: "";
			display: block;
			width: 100%;
			height: 100%;
			position: absolute;
			top: 0;
			left: 0;
		}
		.icon::after {
			transform: translateZ(-23px);
			opacity: 0.5;
		}

		.input {
			border: 1px solid #dfdfdf;
			background: #fff;
			height: 48px;
			line-height: 48px;
			padding: 0 10px 0 48px;
			width: 100%;
			transform: translateZ(26px);
		}

		.button {
			display: block;
			width: 100%;
			border: 0;
			text-align: center;
			font-weight: bold;
			color: #fff;
			background: linear-gradient(45deg, #ccb78f, #CCAC70);
			margin-top: 20px;
			padding: 14px;
			position: relative;
			transform-style: preserve-3d;
			transform: translateZ(26px);
			transition: transform 0.3s ease;
			cursor: pointer;
		}
		.button:hover {
			transform: translateZ(13px);
		}

		.side-top-bottom {
			width: 100%;
		}
		.side-top-bottom::before, .side-top-bottom::after {
			content: "";
			width: 100%;
			height: 26px;
			background: linear-gradient(45deg, #B69964, #AE9260);
			position: absolute;
			left: 0;
		}
		.side-top-bottom::before {
			transform-origin: center top;
			transform: translateZ(-26px) rotateX(90deg);
			top: 0;
		}
		.side-top-bottom::after {
			transform-origin: center bottom;
			transform: translateZ(-26px) rotateX(-90deg);
			bottom: 0;
		}

		.side-left-right {
			height: 100%;
		}
		.side-left-right::before, .side-left-right::after {
			content: "";
			height: 100%;
			width: 26px;
			position: absolute;
			top: 0;
		}
		.side-left-right::before {
			background: #AD9260;
			transform-origin: left center;
			transform: rotateY(90deg);
			left: 0;
		}
		.side-left-right::after {
			background: #A3895A;
			transform-origin: right center;
			transform: rotateY(-90deg);
			right: 0;
		}

		.email .icon::before, .email .icon::after {
			background: url(https://image.flaticon.com/icons/svg/131/131040.svg) center/contain no-repeat;
		}

		.password .icon::before, .password .icon::after {
			background: url(https://image.flaticon.com/icons/svg/130/130996.svg) center/contain no-repeat;
		}

		.face-up-left {
			transform: rotateY(-30deg) rotateX(30deg);
		}

		.face-up-right {
			transform: rotateY(30deg) rotateX(30deg);
		}

		.face-down-left {
			transform: rotateY(-30deg) rotateX(-30deg);
		}

		.face-down-right {
			transform: rotateY(30deg) rotateX(-30deg);
		}

		.form-complete {
			-webkit-animation: formComplete 2s ease;
			animation: formComplete 2s ease;
		}

		.form-error {
			-webkit-animation: formError 2s ease;
			animation: formError 2s ease;
		}

		input:active, input:focus, button:active, button:focus {
			outline: none;
			border: 1px solid #e77371;
		}

		@-webkit-keyframes formComplete {
			50%, 55% {
				transform: rotateX(30deg) rotateY(180deg);
			}
			100% {
				transform: rotateX(0deg) rotateY(1turn);
			}
		}

		@keyframes formComplete {
			50%, 55% {
				transform: rotateX(30deg) rotateY(180deg);
			}
			100% {
				transform: rotateX(0deg) rotateY(1turn);
			}
		}
		@-webkit-keyframes formError {
			0%, 100% {
				transform: rotateX(0deg) rotateY(0deg);
			}
			25% {
				transform: rotateX(-25deg);
			}
			33% {
				transform: rotateX(-25deg) rotateY(45deg);
			}
			66% {
				transform: rotateX(-25deg) rotateY(-30deg);
			}
		}
		@keyframes formError {
			0%, 100% {
				transform: rotateX(0deg) rotateY(0deg);
			}
			25% {
				transform: rotateX(-25deg);
			}
			33% {
				transform: rotateX(-25deg) rotateY(45deg);
			}
			66% {
				transform: rotateX(-25deg) rotateY(-30deg);
			}
		}
		.small {
			color: #999;
			text-align: center;
			display: block;
			margin-top: 20px;
			-webkit-backface-visibility: hidden;
			backface-visibility: hidden;
		}

		html, body {
			width: 100%;
			height: 100%;
			display: flex;
			background: linear-gradient(45deg, #dddddd, #B3B3B3);
			background-image: url('<%=request.getContextPath()%>/images/LoginBack.jpg');
			background-size: cover;
			background-position:center;
		}

		*, *::before, *::after {
			box-sizing: border-box;
		}

		.howtrue{
			text-align: center;
			margin: 0 0 10px 0;
			font-family: 'Josefin Sans', 'Noto Sans TC';
			font-size: 2rem;
			font-weight: 400;
			color: #3f4948;
			
		}
		.failure{
			text-align: center;
			margin: 0 0 10px 0;
			font-size: 1rem;
			color: orange;
		}
	</style>
</head>
<body>
	<form class="form" id="form" method="post" action="<%=request.getContextPath()%>/employee/employee.do">
		<div class="howtrue">HowTure 好厝</div>
		<div class="failure">${messages.failure}</div>
		<div class="field email">
			<div class="icon"></div>
			<input class="input" type="text" id="email" placeholder="員工代號" autocomplete="off"
				   name="emp_username" value="${messages.emp_username}" required/>
		</div>
		<div class="field password">
			<div class="icon"></div>
			<input class="input" id="password" type="password" placeholder="密碼"
				   name="emp_password" required/>
		</div>
		<button class="button" id="submit">LOGIN
			<div class="side-top-bottom"></div>
			<div class="side-left-right"></div>
		</button>
		<div class="small">
			<label> <input type="checkbox" name="rememberMe" value="rememberMe" ${(messages.rememberMe eq null)? "" : "checked"}>
				Remember me
			</label>
		</div>
		<input type="hidden" name="action" value="login">
	</form>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script>
		var formAnim = {
			$form: $("#form"),
			animClasses: [
			"face-up-left",
			"face-up-right",
			"face-down-left",
			"face-down-right",
			"form-complete",
			"form-error"
			],
			resetClasses: function () {
				var $form = this.$form;

				$.each(this.animClasses, function (k, c) {
					$form.removeClass(c);
				});
			},
			faceDirection: function (d) {
				this.resetClasses();

				d = parseInt(d) < this.animClasses.length ? d : -1;

				if (d >= 0) {
					this.$form.addClass(this.animClasses[d]);
				}
			}
		};

		var $input = $("#email, #password"),
		$submit = $("#submit"),
		focused = false,
		completed = false;

		$input.focus(function () {
			focused = true;

			if (completed) {
				formAnim.faceDirection(1);
			} else {
				formAnim.faceDirection(0);
			}
		});

		$input.blur(function () {
			formAnim.resetClasses();
		});

		$input.on("input paste keyup", function () {
			completed = true;

			$input.each(function () {
				if (this.value == "") {
					completed = false;
				}
			});

			if (completed) {
				formAnim.faceDirection(1);
			} else {
				formAnim.faceDirection(0);
			}
		});

		$submit.click(function () {
			focused = true;
			formAnim.resetClasses();

			if (completed) {
				$submit.css("pointer-events", "none");
				setTimeout(function () {
					formAnim.faceDirection(4);
					$input.val("");
					completed = false;

					setTimeout(function () {
						$submit.css("pointer-events", "");
						formAnim.resetClasses();
					}, 2000);
				}, 1000);
			} else {
				setTimeout(function () {
					formAnim.faceDirection(5);

					setTimeout(function () {
						formAnim.resetClasses();
					}, 2000);
				}, 1000);
			}
		});

		$(function () {
			setTimeout(function () {
				if (!focused) {
					$input.eq(0).focus();
				}
			}, 2000);
		});

		if(${empty messages.emp_username && emp_username != null}) {
			$("#email").val("${emp_username}");
			$("[name='rememberMe']").prop("checked", true);
		}
// 		<c:if test="${empty messages.emp_username && emp_username != null}">
// 			$("#email").val("${emp_username}");
// 			$("[name='rememberMe']").prop("checked", true);
// 		</c:if>
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<!doctype html>
<html lang="zh-tw">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v3.8.5">
<title>HowTrue BackEndLogin</title>

<!-- Bootstrap core CSS -->
<link
	href="https://bootstrap.hexschool.com/docs/4.2/dist/css/bootstrap.css"
	rel="stylesheet">


<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}
</style>
<!-- Custom styles for this template -->
<link href="https://bootstrap.hexschool.com/docs/4.2/examples/floating-labels/floating-labels.css" rel="stylesheet">
</head>
<body>
	<form class="form-signin" method="post" action="<%=request.getContextPath()%>/employee/employee.do">
		<div class="text-center mb-4">
			<img class="mb-4" src="https://live.staticflickr.com/4057/4708032722_e22d6e4e92_c.jpg"
				alt="" width="200" height="200">
			<h1 class="h3 mb-3 font-weight-normal">HowTrue ¦n­í</h1>
		</div>

		<div class="text-center mb-3"><h1 class="h6 font-weight-normal text-warning">${messages.failure}</h4></div>
		
		<div class="form-label-group">
			<input type="text" id="inputEmail" class="form-control" name="emp_username" value="${messages.emp_username}"
				placeholder="Email address" required autofocus> <label
				for="inputEmail">Username</label>
		</div>

		<div class="form-label-group">
			<input type="password" id="inputPassword" class="form-control" name="emp_password"
				placeholder="Password" required> <label for="inputPassword">Password</label>
		</div>

		<div class="checkbox mb-3">
			<label> <input type="checkbox" value="remember-me">
				Remember me
			</label>
		</div>
		
		<button class="btn btn-lg btn-primary btn-block" type="submit">Sign
			in</button>
		<p class="mt-5 mb-3 text-muted text-center">&copy; 2017-2018</p>
		<input type="hidden" name="action" value="login">
	</form>
</body>
</html>
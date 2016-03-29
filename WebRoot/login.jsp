<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@ page import="java.util.*"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title></title>

<link type="text/css" rel="stylesheet" href="css/login.css" />
</head>

<body>
	<div id="wrapper">
		<form name="login-form" class="login-form" action="login"
			method="post"  onsubmit="return checkUserNull(this)">
			<div class="header">
				<h1>Concentric Ring</h1>
				<div id = "demo" class="error"></div>
				<%
					if (request.getAttribute("currId") == null) {
					} else {
						String currId = (String) request.getAttribute("currId");
						if (currId.equals("error")) {
							out.println("<script type =\"text/javascript\">document.getElementById(\"demo\").innerHTML = \"The username or password is incorrect.Please try again\"</script>"
								
							);
						}
					}
				%>
				
<script> 
		function checkUserNull(f){
		if (f.uid.value == "" || f.password.value == ""){
			alert("Please fill out username and password");
			return false;
		} else {
			return true;
		}
	}
		function removal(f) {
			document.getElementById("demo").innerHTML = "";
		}
	
	</script>
  
			</div>

			<div class="content">
				<input type="text"  name="uid" class="input username"
					placeholder="username" onfocus="removal()"> <span id="msg"></span>
					
					<input type="password"
					name="password" class="input password" placeholder="Password" onfocus="removal()"><span id="msgPsw"></span>
			</div>
			<div class="footer">
				<input type="submit" name="submit" value="login" class="button">
			</div>
		</form>
	<div class="gradient"></div>

</body>
</html>

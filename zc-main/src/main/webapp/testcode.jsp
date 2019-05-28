<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE HTML >
<html>
	<head>
		<title>验证码</title>
		<script language="javascript">
function myReload() {
	document.getElementById("CreateCheckCode").src = document
			.getElementById("CreateCheckCode").src
			+ "?nocache=" + new Date().getTime();
}
</script>
	</head>
 
	<body>
		
			
			<img src="${APP_PATH }/getcode.do" id="CreateCheckCode" align="middle">
			<a href="" onclick="myReload()"> 看不清,换一个</a>
			
	</body>
</html>
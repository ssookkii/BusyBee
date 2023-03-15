<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String addUser_Msg = (String) request.getAttribute("addUser_Msg");
	if(addUser_Msg!=null && addUser_Msg!="") {
		if(addUser_Msg=="addUser_SUCCESS") {
			%>
			<script>
			alert('BusyBee의 가족이 되신 것을 환영합니다 :)');
			location.href="loginMain.do";
			</script>
			<%
		} else {
			%>
			<script>
			alert('회원가입을 다시 진행해주세요.');
			location.href="regi2.do";
			</script>
			<%
		}
	}
	
	String loginCheck_Msg = (String) request.getAttribute("loginCheck_Msg");
	if(loginCheck_Msg!=null && loginCheck_Msg!="") {
		if(loginCheck_Msg=="loginCheck_SUCCESS") {
			String name = (String) request.getAttribute("name");
			%>
			<script>
			alert('오늘도 파이팅입니다, ' + '<%=name %>' + '님 :)');
			location.href="login.do";
			</script>
			<%
		} else {
			%>
			<script>
			alert('로그인 정보를 다시 확인해주세요.');
			location.href="loginMain.do";
			</script>
			<%
		}
	}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메시지</title>
</head>
<body>
    <h1>${message}</h1>
</body>
</html>
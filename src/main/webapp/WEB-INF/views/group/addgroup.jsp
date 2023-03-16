<%@page import="mul.cam.a.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	UserDto login = (UserDto) session.getAttribute("login");
	String id = login.getId();
	String name = login.getName();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- jQuery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- jQuery UI CSS -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- Bootstrap -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>

<link rel="stylesheet"
	href="https://bootswatch.com/5/minty/bootstrap.min.css">

</head>
<body>

<h3>그룹 생성화면</h3>
<form action="addGroup.do" id="frm" method="get">
그룹 이름 : <input type="text" name="group_name">
그룹 정보 : <textarea rows="5" cols="50" name="group_info"></textarea>
그룹 리더 : <input type="text" readonly="readonly" style="width:200px" value="<%=name%>(<%=id%>)">

<input type="hidden" name="leader_id" value='<%=id %>'>
<input type="hidden" name="leader_name" value='<%=name %>'>
<button type="button" onclick="go_addGroup()">그룹 만들기</button>
</form>

<script type="text/javascript">
function go_addGroup() {
	
	$("#frm").submit();
}
</script>
</body>
</html>
<%@page import="mul.cam.a.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
UserDto login = (UserDto)session.getAttribute("login");
%>
   
<a style="float: right; margin: 20px; color: #bca880; font-size:12px; text-decoration: none;" href="customer.do" >고객센터</a>
<%if(login.getAuth()==3){
	
	%>
<a style="float: right; margin: 20px; color: #bca880; font-size:12px; text-decoration: none;" href="javascript:void(0)" onclick="admin()">Admin</a>
	<% 
}
	%>
<br/>
<div style="text-align: center;">
   <img src="images/favicon.ico">busy beeeeeeee </br>
   Developer : 양상숙 박상준 신준 임영언 정은성
</div>

<script type="text/javascript">
function admin() {
	let f = document.createElement('form');
	f.setAttribute('method','post');
	f.setAttribute('action','admin.do');
	document.body.appendChild(f);
	f.submit();
	
}

</script>
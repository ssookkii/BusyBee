<%@page import="mul.cam.a.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
UserDto login = (UserDto)session.getAttribute("login");
%>
   
<a style="float: right; margin: 20px; font-size: 20px; font-weight: bold;" href="customer.do" >고객센터</a>
<%if(login.getAuth()==3){
	
	%>
<a style="float: right; margin: 20px; font-size: 20px; font-weight: bold;" href="javascript:void(0)" onclick="admin()">어드민</a>
	<% 
}
	%>
<br/>
<div style="text-align: center;">
  <p>busy beeeeeeee</p>
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
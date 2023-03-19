<%@page import="mul.cam.a.dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<%
String group_code = (String)session.getAttribute("group_code");
String org = (String)session.getAttribute("org");
%>

<input type="hidden" id="org" value="<%=org %>">
<input type="hidden" id="group_code" value="<%=group_code %>">


<%
String bbswrite = (String)request.getAttribute("bbswrite");
if(bbswrite != null && !bbswrite.equals("")){
	if(bbswrite.equals("bbswrite_YES")){
		%>
		<script type="text/javascript">
		let group_code = document.getElementById("group_code").value;
		let org = document.getElementById("org").value;
		alert("성공적으로 작성되었습니다");
		location.href="bbslist.do?group_code=" + group_code + "&org=" + org;
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		let group_code = document.getElementById("group_code").value;
		let org = document.getElementById("org").value;
		alert("다시 작성해 주십시오");
		location.href = "bbswrite.do?group_code=" + group_code + "&org=" + org;
		</script>
		<%
	}
}

String bbsupdate = (String)request.getAttribute("bbsupdate");
if(bbsupdate != null && !bbsupdate.equals("")){
	if(bbsupdate.equals("bbsupdate_YES")){
		%>
		<script type="text/javascript">
		let group_code = document.getElementById("group_code").value;
		let org = document.getElementById("org").value;
		alert("성공적으로 수정되었습니다");
		location.href="bbslist.do?group_code=" + group_code + "&org=" + org;
		</script>
		<%
	}
	else{
		int seq = (Integer)request.getAttribute("seq");
		%>
		<script type="text/javascript">
		alert("다시 작성해 주십시오");
		let seq = "<%=seq %>";		
		location.href = "bbsupdate.do?seq=" + seq;
		</script>
		<%
	}	
}

String bbsdelete = (String)request.getAttribute("bbsdelete");
if(bbsdelete != null && !bbsdelete.equals("")){
	if(bbsdelete.equals("bbsdelete_YES")){
	%>
		<script type="text/javascript">
		let group_code = document.getElementById("group_code").value;
		let org = document.getElementById("org").value;
		alert("삭제되었습니다");
		location.href="bbslist.do?group_code=" + group_code + "&org=" + org;
		</script>
	<% 
} else{	
	int seq = Integer.parseInt(request.getParameter("seq"));
	%>
		<script type="text/javascript">
		
		alert("삭제에 실패했습니다");
		let seq = "<%=seq %>";
		location.href = "bbsdetail.do?seq=" + seq;
		</script>
	<%
	}
}

String bbscomment = (String) request.getAttribute("bbscomment");
if(bbscomment != null && bbscomment != "") {
	if(bbscomment == "bbscomment_YES") {
		int seq = Integer.parseInt(request.getParameter("seq"));
		%>
		<script type="text/javascript">
		alert("댓글이 작성되었습니다");
		let seq = "<%=seq %>";
		location.href = "bbsdetail.do?seq=" + seq;
		</script>
	<% 
} else{	
	int seq = Integer.parseInt(request.getParameter("seq"));
	%>
		<script type="text/javascript">
		
		alert("댓글작성에 실패했습니다");
		let seq = "<%=seq %>";
		location.href = "bbsdetail.do?seq=" + seq;
		</script>
	<%
	}
}

String deleteBbscomment = (String) request.getAttribute("deleteBbscomment");
if(deleteBbscomment != null && deleteBbscomment != "") {
	if(deleteBbscomment == "deleteBbscomment_YES") {
		int seq = Integer.parseInt(request.getParameter("seq"));
		%>
		<script type="text/javascript">
		alert("댓글이 삭제되었습니다");
		let seq = "<%=seq %>";
		location.href = "bbsdetail.do?seq=" + seq;
		</script>
	<% 
} else{	
	int seq = Integer.parseInt(request.getParameter("seq"));
	%>
		<script type="text/javascript">
		
		alert("댓글삭제에 실패했습니다");
		let seq = "<%=seq %>";
		location.href = "bbsdetail.do?seq=" + seq;
		</script>
	<%
	}
}
%>

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

</body>
</html>
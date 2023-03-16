<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

String customerWrite = (String)request.getAttribute("customerWrite");
if(customerWrite != null && !customerWrite.equals("")){
	if(customerWrite.equals("CUS_ADD_OK")){
		%>
		<script type="text/javascript">
		alert("성공적으로 작성되었습니다");
		location.href = "customer.do";
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		alert("다시 작성해 주십시오");
		location.href = "customerWrite.do";
		</script>
		<%
	}
}

String customerDelete = (String)request.getAttribute("customerDelete");
if(customerDelete != null && !customerDelete.equals("")){
	if(customerDelete.equals("CUS_DEL_OK")){
		%>
		<script type="text/javascript">
		alert("성공적으로 삭제되었습니다");
		location.href = "customer.do";
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		alert("삭제에 실패했습니다.");
		location.href = "customer.do";
		</script>
		<%
	}
}

String customerUpdate = (String)request.getAttribute("customerUpdate");
if(customerUpdate != null && !customerUpdate.equals("")){
	if(customerUpdate.equals("CUS_UPDATE_OK")){
		%>
		<script type="text/javascript">
		alert("성공적으로 수정되었습니다");
		location.href = "customer.do";
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		alert("수정하기에 실패했습니다");
		location.href = "customerDetail.do?seq="+seq;
		</script>
		<%
	}
}

String customerAnswer = (String)request.getAttribute("customerAnswer");
if(customerAnswer != null && !customerAnswer.equals("")){
	if(customerAnswer.equals("CUS_ANSWER_OK")){
		%>
		<script type="text/javascript">
		alert("성공적으로 작성되었습니다");
		location.href = "customer.do";
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		alert("작성에 실패했습니다");
		location.href = "customerAnswer.do?seq="+seq;
		</script>
		<%
	}
}

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

String banId = (String)request.getAttribute("banId");
String userBan = (String)request.getAttribute("userBan");
if(userBan != null && !userBan.equals("")){
	if(userBan.equals("USER_BAN_OK")){
		%>
		<script type="text/javascript">
		if(!confirm("<%=banId%> 회원을 정지하시겠습니까? ")){
		    alert("취소되었습니다.");
		}else{
		    alert("정지되었습니다.");
		}
		location.href = "userList.do";
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		alert("error");
		location.href = "userList.do";
		</script>
		<%
	}
}

String inId = (String)request.getAttribute("inId");
String userIn = (String)request.getAttribute("userIn");
if(userIn != null && !userIn.equals("")){
	if(userIn.equals("USER_IN_OK")){
		%>
		<script type="text/javascript">
		if(!confirm("<%=inId %> 회원의 정지를 해제하시겠습니까? ")){
		    alert("취소되었습니다.");
		}else{
		    alert("해제되었습니다.");
		}
		location.href = "userList.do";
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		alert("error");
		location.href = "userList.do";
		</script>
		<%
	}
}

%>

</body>
</html>
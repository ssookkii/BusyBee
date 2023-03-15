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
		location.href = "customerDetail.do?seq="+seq;
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

%>

</body>
</html>
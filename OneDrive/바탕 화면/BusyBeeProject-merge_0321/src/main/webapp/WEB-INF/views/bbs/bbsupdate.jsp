
<%@page import="mul.cam.a.dto.UserDto"%>
<%@page import="mul.cam.a.dto.BbsDto"%>
<%@page import="mul.cam.a.dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int seq = Integer.parseInt(request.getParameter("seq"));
UserDto login = (UserDto)session.getAttribute("login");
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
<%
//	BbsDao dao = BbsDao.getInstance();
//	BbsDto dto = dao.getBbs(seq);
BbsDto dto = (BbsDto)request.getAttribute("bbsdto");
String cate = dto.getCategory();
%>

<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold">&nbsp;&nbsp;&nbsp;글 수정하기</h1>
<small class="text-muted" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;자유롭게 작성하세요.</small>
<br><br>

<div id="app" class="container">

<!-- <form action="bbswriteAf.do" id="frm" method="post"> -->

<!-- 나중에 파일 추가할때 필요함 -->
<form id="frm" action="bbsupdateAf.do" method="post" enctype="multipart/form-data">
<input type="hidden" name="seq" value="<%=dto.getSeq() %>">
<input type="hidden" name="group_code" value="<%=dto.getGroup_code() %>">

<table class="table table-sm">
<col width="100px"><col width="500px">
<tr>
	<th>모임명</th>
	<td>
		<input value="<%=dto.getOrg()%>" type="text" id="org" name="org" class="form-control form-control-lg" readonly="readonly">
	</td>
</tr>
<tr>
	<th>아이디</th>
	<td>
		<input value="<%=dto.getId() %>" type="text" id="id" name="id" class="form-control form-control-lg" readonly="readonly">
	</td>
</tr>
<tr>
	<th class="align-middle">제목</th>
	<td>
		<input value="<%=dto.getTitle() %>" type="text" id="title" name="title" size="50px" class="form-control form-control-lg" placeholder="제목기입">
	</td>
</tr>
<tr>
	<th>파일</th>
	<td>
		<input value="<%=dto.getFilename() %>" id="fileload" type="file" name="fileload">
		<!-- 파일이 변경되지 않았을 경우를 위해서 보낸다 -->
		<input type="hidden" name="filename" value="<%=dto.getFilename() %>">
		<input type="hidden" name="newfilename" value="<%=dto.getNewfilename() %>">
	</td>
</tr>
<tr>
	<th>카테고리</th>
	<td>
		<select id="category" name="category" class="form-control form-control-lg">
			<option>아래에서 선택</option>
			<option value="공지사항">공지사항</option>
			<option value="일반게시글">일반게시글</option>
			<option value="자료게시글">자료게시글</option>
			<option value="회의록">회의록</option>
		</select>
	</td>
</tr>
<tr>	
	<td colspan="2">
		<textarea id="content" rows="18" name="content" class="form-control" placeholder="내용기입"><%=dto.getContent() %></textarea>
	</td>
</tr>
<tr>
	<td colspan="2" align="right" style="padding-top: 20px">
		<!-- <input class="btn btn-warning" type="submit" value="글작성완료"> -->
		<button class="btn btn-warning" onclick="bbsdetail()" type="button">이전으로</button>
		<button class="btn btn-warning" onclick="bbsupdate()" >수정하기</button>
	</td>
</tr>

</table>
</form>
</div>

<script type="text/javascript">


$(document).ready(function() {
	
	$("#category").val("<%=dto.getCategory() %>").prop("selected", true);

});

function bbsdetail() {
	location.href = "bbsdetail.do?seq=" + <%=seq%>;
}

function bbsupdate() {
	
//	alert("작동합니다");

	if($("#title").val().trim() == "" ){
		alert("제목을 기입해 주십시오");
		return;
	}else if($("#content").val().trim() == "" ){
		alert("내용을 기입해 주십시오");
		return;
	}else if($("#category").val() == "아래에서 선택" ){
		alert("카테고리를 선택해주세요");
		return;
	}else{
		$("#frm").submit();
	}
	
}
</script>

</body>
</html>
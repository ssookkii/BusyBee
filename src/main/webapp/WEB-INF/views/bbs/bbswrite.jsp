<%@page import="mul.cam.a.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
        
<%
	UserDto login = (UserDto)session.getAttribute("login");
String group_code = (String)session.getAttribute("group_code");
String org = (String)session.getAttribute("org");
%>      
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
      th{
      font-size: 13px; 
       } 
      </style>
<body>

<br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold">&nbsp;&nbsp;&nbsp;글쓰기</h1>
<small class="text-muted" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;자유롭게 작성하세요.</small>
<br><br>

<div id="app" class="container">

<!-- <form action="bbswriteAf.do" id="frm" method="post"> -->

<!-- 나중에 파일 추가할때 필요함 -->
<form id="frm" action="bbswriteAf.do" method="post" enctype="multipart/form-data">

<input type="hidden" id="group_code" name="group_code" class="form-control form-control-lg" value="<%=group_code%>" readonly="readonly">

<table class="table table-sm">
<col width="100px"><col width="500px">
<tr>
	<th >모임명</th>
	<td>
		<input type="text" id="org" name="org" class="form-control form-control-lg" value="<%=org%>" readonly="readonly">
	</td>
</tr>
<tr>
	<th>아이디</th>
	<td>
		<input type="text" id="id" name="id" class="form-control form-control-lg" value="<%=login.getId() %>" readonly="readonly">
	</td>
</tr>
<tr>
	<th class="align-middle">제목</th>
	<td>
		<input type="text" id="title" name="title" size="50px" class="form-control form-control-lg" placeholder="제목을 입력하세요">
	</td>
</tr>
<tr>
	<th>파일</th>
	<td>
		<input id="fileload" type="file" name="fileload" onchange="readURL(this);">
		
	</td>
</tr>
<tr>
	<th>미리보기</th>
	<td>
		<img id="preview" />
	</td>
</tr>
<tr>
	<th>카테고리</th>
	<td>
		<select id="category" name="category" class="form-control form-control-lg" >
			<option>여기를 눌러 선택하세요</option>
			<option value="공지사항">공지사항</option>
			<option value="일반게시글">일반게시글</option>
			<option value="자료게시글">자료게시글</option>
			<option value="회의록">회의록</option>
		</select>
	</td>
</tr>
<tr>	
	<td colspan="2">
		<textarea id="content" rows="18" name="content" class="form-control" placeholder="그룹원들과 공유하고 싶은 내용을 작성해주세요" style="font-size:14px;"></textarea>
	</td>
</tr>
<tr>
	<td colspan="2" align="right" style="padding-top: 20px">
		<!-- <input class="btn btn-warning" type="submit" value="글작성완료"> -->
		<button class="btn btn-warning" onclick="bbslist()" type="button" style="font-size:13px;">게시판으로</button>
		<button class="btn btn-warning" onclick="bbswrite()" type="button" style="font-size:13px;" >글쓰기</button>
	</td>
</tr>

</table>
</form>
</div>

<script type="text/javascript">
let group_code = document.getElementById("group_code").value;
let org = document.getElementById("org").value;
function bbswrite(){
	
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
function bbslist(){
	location.href= "bbslist.do?group_code=" + group_code + "&org=" + org;
}
function readURL(input) {
	  if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    reader.onload = function(e) {
	      document.getElementById('preview').src = e.target.result;
	    };
	    reader.readAsDataURL(input.files[0]);
	  } else {
	    document.getElementById('preview').src = "";
	 }
}
</script>

</body>
</html>

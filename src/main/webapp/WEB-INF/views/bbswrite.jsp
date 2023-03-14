<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>글쓰기</h1>

<div id="app" class="container">

<!-- <form action="bbswriteAf.do" id="frm" method="post"> -->

<!-- 나중에 파일 추가할때 필요함 -->
<form id="frm" action="bbswriteAf.do" method="post" enctype="multipart/form-data">

<table class="table table-sm">
<col width="100px"><col width="500px">
<tr>
	<th>모임명</th>
	<td>
		<input type="text" id="org" name="org" class="form-control form-control-lg">
	</td>
</tr>
<tr>
	<th>아이디</th>
	<td>
		<input type="text" id="id" name="id" class="form-control form-control-lg">
	</td>
</tr>
<tr>
	<th class="align-middle">제목</th>
	<td>
		<input type="text" id="title" name="title" size="50px" class="form-control form-control-lg" placeholder="제목기입">
	</td>
</tr>
<tr>
	<th>파일</th>
	<td>
		<input id="fileload" type="file" name="fileload">
	</td>
</tr>
<tr>
	<th>카테고리</th>
	<td>
		<select id="category" name="category" class="form-control form-control-lg" name="category">
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
		<textarea id="content" rows="18" name="content" class="form-control" placeholder="내용기입"></textarea>
	</td>
</tr>
<tr>
	<td colspan="2" align="right" style="padding-top: 20px">
		<!-- <input class="btn btn-primary" type="submit" value="글작성완료"> -->
		<button type="button">글쓰기</button>
	</td>
</tr>

</table>
</form>
</div>

<script type="text/javascript">
$(document).ready(function() {
	
	$("button").click(function() {
//		alert("작동합니다");
		
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
	});	

});


</script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!-- 부트스트랩 JavaScript 및 의존성 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.3/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.min.js"></script>

<!-- 원하는 글꼴 추가 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Dongle:wght@300;400;700&family=Jua&display=swap" rel="stylesheet">


<!-- Font Awesome 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">


<style>

body{
font-family: 'Black Han Sans', sans-serif;
font-family: 'Dongle', sans-serif;
font-family: 'Jua', sans-serif;
}

.flex-container {
  display: flex;
  justify-content: center;
  
}

.flex-item {
  margin: 15px;
  width: 400px;
  margin: 15px;
  text-align: center;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);

}

.card-body {
  height: 500px;
  font-size: 14px;
}

#notice{
  display: flex;
  justify-content: center;
  text-align: center;
  font-size: 15px;
  margin-top:40px;
  margin-left: auto;
  margin-right: auto;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);

}

.card-header{
font-size: 15px;

}
</style>

<!-- 부트스트랩 CSS -->
<link rel="stylesheet" href="https://bootswatch.com/5/minty/bootstrap.min.css">

</head>
<body>

<h3>문의하기</h3>

<hr>

<div id="app" class="container">

<form action="customerWriteAf.do" id="frm" method="post" enctype="multipart/form-data">

<table class="table table-sm">
<col width="100px"><col width="500px">

<tr>
	<th>아이디</th>
	<td>		
		<input type="hidden" name="id" value="">
	</td>
</tr>
<tr>
	<th class="align-middle">제목</th>
	<td>
		<input type="text" id="title" name="title" size="50px" class="form-control form-control-lg" placeholder="제목기입">
	</td>
</tr>
<tr>	
	<td colspan="2">
		<textarea rows="18" id="content" name="content" class="form-control" placeholder="내용기입"></textarea>
	</td>
</tr>
<tr>
	<th>첨부파일</th>
	<td>
		<input type="file" name="fileload" onchange="readURL(this);" multiple />
	</td>
</tr>
<tr>
	<th>미리보기</th>
	<td>
		<img id="preview" />
	</td>
</tr>
<tr>
<th>비밀글</th>
<td class="form-inline">
    <input type="checkbox" name="secret" id="secret" >
</td>

</tr>
<tr>
	<td colspan="2" align="right" style="padding-top: 20px">
		<button type="button" class="btn btn-primary">문의하기</button>
	</td>
</tr>

</table>
</form>
</div>

<script type="text/javascript">
$(document).ready(function() {
	
	$("button").click(function() {
		
		if($("#title").val().trim() == "" ){
			alert("제목을 기입해 주십시오");
			return;
		}else if($("#content").val().trim() == "" ){
			alert("내용을 기입해 주십시오");
			return;
		}else{
			$("#frm").submit();
		}		
	});	
});

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
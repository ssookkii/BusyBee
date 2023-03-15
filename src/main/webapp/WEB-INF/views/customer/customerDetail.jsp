<%@page import="mul.cam.a.dto.CustomerDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
CustomerDto dto = (CustomerDto) request.getAttribute("dto");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<!-- 부트스트랩 JavaScript 및 의존성 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.3/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.min.js"></script>

<!-- 원하는 글꼴 추가 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Dongle:wght@300;400;700&family=Jua&display=swap"
	rel="stylesheet">


<!-- Font Awesome 아이콘 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">


<style>
body {
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

#notice {
	display: flex;
	justify-content: center;
	text-align: center;
	font-size: 15px;
	margin-top: 40px;
	margin-left: auto;
	margin-right: auto;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.card-header {
	font-size: 15px;
}
</style>

<!-- 부트스트랩 CSS -->
<link rel="stylesheet"
	href="https://bootswatch.com/5/minty/bootstrap.min.css">

</head>
<body>

	<h1>문의글</h1>

	<hr>

	<div id="app" class="container">

		<table class="table table-striped table-sm">
			<colgroup>
				<col style="width: 150px" />
				<col style="width: 500px" />
			</colgroup>

			<tr>
				<th>작성자</th>
				<td><%=dto.getId()%></td>
			</tr>

			<tr>
				<th>작성일</th>
				<td><%=dto.getWdate()%></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<%
				if (!dto.getFilename().equals("") && dto.getFilename() != null) {
				%>
				<td><input type="button" value="다운로드"
					onclick="filedown(<%=dto.getSeq()%>, '<%=dto.getNewfilename()%>', '<%=dto.getFilename()%>')">
				</td>

				<%
				}
				%>
			</tr>

			<tr>
				<td colspan="2" style="font-size: 22px; font-weight: bold;"><%=dto.getTitle()%></td>
			</tr>
			<tr>
				<td colspan="2" style="background-color: white;"><pre
						style="font-size: 20px; font-family: 고딕, arial; background-color: white"><%=dto.getContent()%></pre>
				</td>
			</tr>
		</table>


		<br>

		<button type="button" class="btn btn-primary"
			onclick="location.href='customer.do'">글목록</button>


		<button type="button" class="btn btn-primary"
			onclick="customerUpdate(<%=dto.getSeq()%>)">수정</button>

		<button type="button" class="btn btn-primary"
			onclick="customerDelete(<%=dto.getSeq()%>)">삭제</button>

		<button type="button" class="btn btn-primary"
			onclick="customerAnswer(<%=dto.getSeq()%>)">답변</button>

	</div>

	<form name="file_down" action="filedownLoad.do" method="post">
		<input type="hidden" name="newfilename"> <input type="hidden"
			name="filename"> <input type="hidden" name="seq">
	</form>

	<script type="text/javascript">
function customerUpdate(seq) {
	location.href="customerUpdate.do?seq="+seq;
}

function customerDelete(seq) {
	location.href="customerDelete.do?seq="+seq;
}

function customerAnswer(seq) {
	location.href="customerAnswer.do?seq="+seq;
}

function filedown(seq, newfilename, filename) {
	document.file_down.newfilename.value = newfilename;
	document.file_down.filename.value = filename;
	document.file_down.seq.value = seq;
	document.file_down.submit();
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
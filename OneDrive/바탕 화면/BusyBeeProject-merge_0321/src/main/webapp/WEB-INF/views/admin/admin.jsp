<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main View</title>

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
 justify-content: center;
}

.btn {
  height: 700px;
	width: 400px;

}

</style>

<!-- 부트스트랩 CSS -->
<link rel="stylesheet" href="https://bootswatch.com/5/minty/bootstrap.min.css">

</head>
<body>

<div class="flex-container" >


    <button style="font-size: 50px; margin-left: 340px;" class="btn btn-warning" onclick="userList()">회원 관리</button>




    <button style="font-size: 50px;" class="btn btn-danger" onclick="boardList()">게시글 관리</button>


    <button style="font-size: 50px;" class="btn btn-warning" onclick="reportList()">신고 관리</button>
</div>

<script type="text/javascript">
function userList() {
	location.href="userList.do";
}
function boardList() {
	location.href="allbbslist.do";
}
function reportList() {
	location.href="reportList.do";
}
</script>


</body>
</html>
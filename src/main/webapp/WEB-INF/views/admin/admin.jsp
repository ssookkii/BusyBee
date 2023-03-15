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

.card-button{
padding: 200px 100px;
}

</style>

<!-- 부트스트랩 CSS -->
<link rel="stylesheet" href="https://bootswatch.com/5/minty/bootstrap.min.css">

</head>
<body>

<div class="flex-container" >

<div class="flex-item card border-light mb-3" >
  <div class="card-header" ></div>
    <div class="card-body">
    <button class="card-button" onclick="memberList()">회원 관리</button>
  </div>
</div>

<div class="flex-item card border-light mb-3">
  <div class="card-header"></div>
  <div class="card-body">
    <button class="card-button" onclick="boardList()">게시글 관리</button>
  </div>
</div>

<div class="flex-item card border-light mb-3">
  <div class="card-header"></div>
  <div class="card-body">
    <button class="card-button" onclick="reportList()">신고 관리</button>
  </div>
</div>

</div>

<script type="text/javascript">

function memberList() {
	location.href="memberList.do";
}

function boardList() {
	location.href="boardList.do";
}

function reportList() {
	location.href="reportList.do";
}


</script>


</body>
</html>
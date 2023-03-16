<%@page import="mul.cam.a.dto.EventDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main View</title>



<style>

body{
font-family: 'Black Han Sans', sans-serif;
font-family: 'Dongle', sans-serif;
font-family: 'Jua', sans-serif;
font-family: 'Noto Sans KR', sans-serif;
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


<div id="notice" class="card border-light mb-3" style="max-width: 125rem;">
  <div class="card-header">공지사항</div>
  <div class="notice-card-body">
notice
  </div>
</div>

<div class="flex-container" >

<div class="flex-item card border-light mb-3" >
  <div class="card-header" >게시판 영역</div>
  <div class="card-body">
    <p class="card-text">임시</p>
  </div>
</div>

<div class="flex-item card border-light mb-3">
  <div class="card-header">일정관리 영역</div>
  <div class="card-body">
    <p class="card-text"></p>
  </div>
</div>

<div class="flex-item card border-light mb-3">
  <div class="card-header">친구 영역</div>
  <div class="card-body">
    <p class="card-text">임시</p>
  </div>
</div>

</div>

</body>
</html>
<%@page import="mul.cam.a.dto.UserDto"%>
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
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Dongle:wght@300;400;700&family=Jua&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<!-- Font Awesome 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<script type="text/javascript" src="./jquery/jquery.twbsPagination.min.js"></script>

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
<%
UserDto login = (UserDto)session.getAttribute("login");
String id = login.getId();

%>
<div id="notice" class="card border-light mb-3" style="max-width: 125rem;">
  <div class="card-header">공지사항</div>
  <div class="notice-card-body">
notice
  </div>
</div>

<input type="hidden" id="id" value='<%=id %>'>

<div class="flex-container" >

<div class="flex-item card border-light mb-3" >
  <div class="card-header" >게시판 영역</div>
  <div class="card-body">
     
    <a href="bbslist.do">게시판</a>
    <table border="1">
	<thead>
	<tr>
		<th>번호</th>
		<th>그룹코드</th>
		<th>그룹명</th>
		<th>그룹소개</th>
		<th>게시판</th>
	</tr>
	</thead>
	<tbody id="tableBody">
	<tr>
	<td>
	<h3 id="nogroup"></h3>
	</td>
	</tr>
	</tbody>
</table>
    
  <!-- <button type="button" onclick="bbsBtn()">게시판임시버튼</button> -->
  </div>
</div>

<div class="flex-item card border-light mb-3">
  <div class="card-header">일정관리 영역</div>
  <div class="card-body">
    <p class="card-text">임시</p>
  </div>
</div>

<div class="flex-item card border-light mb-3">
  <div class="card-header">친구 영역</div>
  <div class="card-body">
    <p class="card-text">임시</p>
  </div>
</div>

</div>




<script type="text/javascript">

$(document).ready(function(){

	
	var group1;
	var group2;
	var count = 1;
	
	// Leader
	$.ajax({
		url:"http://localhost:8090/busyBee/selectGroup1.do",
		type:"get",
		data:{"id":$("#id").val()},
		async:false,
		success:function(data) {
			if(data!=null && data!="") {
				var tableTd = '';
				$.each(data, function(i){
					tableTd += '<tr>'
								+ '<td>' + count + '</td>'
								+ '<td>' + data[i].group_code + '</td>'
								+ '<td>' + data[i].group_name + '</td>'
								+ '<td>' + data[i].group_info + '</td>'
								+ "<td><button type='button' onclick="+ "location.href='bbssession.do?group_code="
									+ data[i].group_code + "&org=" + data[i].group_name + "'>"
									+ "게시판으로</button>"
								+ "</td>"
							 + '</tr>';
					count++;
				});
				$("#tableBody").append(tableTd);
				group1 = true;
				groupCheck();
			} else if (data==null || data=="") {
				group1 = false;
				groupCheck();
			}
		},	
		error:function(){
			alert('error');
		}
	});
	// Member
	$.ajax({
		url:"http://localhost:8090/busyBee/selectGroup2.do",
		type:"get",
		data:{"id":$("#id").val()},
		success:function(data) {
			if(data!=null && data!="") {
				var tableTd = '';
				$.each(data, function(i){
					var group_code = data[i].group_code;
					tableTd += '<tr>'
								+ '<td>' + count + '</td>'
								+ '<td>' + data[i].group_code + '</td>'
								+ '<td>' + data[i].group_name + '</td>'
								+ '<td>' + data[i].group_info + '</td>'
								+ "<td><button type='button' onclick="+ "location.href='bbssession.do?group_code="
								+ 	data[i].group_code + "&org=" + data[i].group_name + "'>"
								+ "게시판으로</button>"
								+ "</td>"
							 + '</tr>';
					count++;
				});
				$("#tableBody").append(tableTd);
				group2 = true;
				groupCheck();
			} else if (data==null || data=="") {
				group2 = false;
				groupCheck();
			}
		},
		error:function(){
			alert('error');
		}
	});
	
	function groupCheck(){
		
/* 		alert("group1 =" + group1);
		alert("group2 =" + group2);
		 */
		if(group1=="undefined" || group2=="undefined") {
			return;
		}
		
		if(group1==false && group2==false) {
/* 			alert("group1* =" + group1);
			alert("group2* =" + group2); */
			$("#nogroup").text('가입한 그룹이 없습니다.');	
		}
	}
	
});

</script>
</body>
</html>
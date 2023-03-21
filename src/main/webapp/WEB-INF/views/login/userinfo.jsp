<%@page import="mul.cam.a.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	UserDto login = (UserDto) session.getAttribute("login");
	String id = login.getId();
%>

<!-- 
[참고] 프로필 사진이 로딩이 안되는 경우
(1) 'Servers' 폴더 > server.xml
(2) (*) Web에서 local의 이미지를 볼 수 있게 하는 설정 확인
(3) << 다음과 같이 수정 >> docBase="프로필 사진이 업로드되는 서버의 경로" (\는 \\로 써야 인식됨)
-->


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- AJAX -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<!-- 파일유효성 검사를 위한 JQuery 버전 -->
<script src="http://code.jquery.com/jquery-migrate-1.2.1.js"></script>

<style type="text/css">
.table-warning{
	margin-left: 100px;
}
.table-warning th{
	font-size : 11pt;
	color : black;
	text-align: center;
	font-family: 'Black Han Sans', sans-serif;
	font-family: 'Dongle', sans-serif;
	font-family: 'Jua', sans-serif;
	font-family: 'Noto Sans KR', sans-serif;
	vertical-align: middle;
}
.table-warning td{
	background-color : white;
	color : black;
	font-size : 11pt;
	text-align: center;
	font-family: 'Black Han Sans', sans-serif;
	font-family: 'Dongle', sans-serif;
	font-family: 'Jua', sans-serif;
	font-family: 'Noto Sans KR', sans-serif;
	vertical-align: middle;
	padding-top: 10px;
	padding-bottom : 15px;
	padding-right: 10px;
	padding-left: 10px;
	border-bottom: 1px solid rgba(0, 0, 0, 0.3);
}
input[type=text] {
	margin-left:30px;
	padding-left:10px;
	width: 150px;
}
</style>
</head>
<body>
<div>
<form id="frm" method="post" enctype="multipart/form-data">
<br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold">&nbsp;&nbsp;&nbsp;나의 정보 수정</h1>
<small class="text-muted" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;회원정보를 확인, 수정할 수 있어요.</small>
<br><br><br>
<table class="table-warning" style="margin-left : 170px">
<col width="210px"><col width="210px"><col width="200px">
	<thead>
	<tr class="table-warning">
		<th style="height: 30px">ID</th>
		<th>이메일</th>
		<th>회원가입일</th>
	</thead>
	<tbody id="tBody">
	</tbody>
</table>
<br><br><br>
<table class="table-warning" style="margin-left : 170px">
<col width="220px"><col width="100px"><col width="90px">
	<thead>
	<tr class="table-warning">
		<th style="height: 30px">이름</th>
		<th>핸드폰 (공개 <input type="checkbox" id="p_Check" onchange="public_Change()"> )</th>
		<th>프로필메세지</th>
	</thead>
	<tbody id="tBody2">
	</tbody>
</table>
<br>
<input type="hidden" id="id" name='id' value='<%=id%>'>
</form>
<br><br>
<input type="hidden" id="fChange">
<input type="hidden" id="bChange">
<button type="button" class="btn btn-warning" style='font-size:12pt; padding: 10px 20px; margin-left: 350px;' onclick="location.href='idandpwd.do'">비밀번호 재설정</button>
<button type="button" class="btn btn-warning" style='font-size:12pt; padding: 10px 20px; ' id="updUser" onclick="go_updUser()">정보 수정하기</button>
<br><br><br>
<hr>
<br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold">&nbsp;&nbsp;&nbsp;계정 삭제</h1>
<small class="text-muted" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;계정을 삭제하면 되돌릴 수 없어요.</small>
<br><br><br>
<input type="button" class="btn btn-danger" style="font-size:14pt; padding: 10px 20px; margin-left: 440px;
margin-top: 10px" value="계정삭제" onclick="go_delUser()"/>
<br><br><br>
</div>


<script type="text/javascript">
var imgsrc = "";
$(document).ready(function(){
	
	$.ajax({
		url:"selectUser.do",
		type:"get",
		data:{"id":'<%=id %>'},
		
		success:function(data){
			if(data!=null && data!="") {
				var tableTd = "";
				$("#tBody").html('');
				tableTd += '<tr>'
							+ '<td>' + data.id + '</td>'
							+ "<td>" + data.email + "</td>"
							+ "<td>" + data.regidate.substr(0,10) + "</td>"
							+ "</tr>";
							
				var tableTd2 = '<tr>';
				tableTd2 += "<td><input type='text' class='form-control form-control-lg' id='name' name='name' maxlength='15' value='" + data.name + "'></td>"
							+ "<td><input type='text' class='form-control form-control-lg' id='phone' name='phone' maxlength='15' value='" + data.phone + "'></td>"
							+ "<td><input type='text' id='profMsg' class='form-control form-control-lg'"
							+ "style='width:150px' name='profMsg' maxlength='20' value='" + data.profMsg + "'></td>"
							+ '</tr>';
							+ "</tr>";
							
				$("#tBody").append(tableTd);
				$("#tBody2").append(tableTd2);
						
				if(data.phone_public==null) {
					$("#p_Check").prop('checked', false);
				} else {
					$("#p_Check").prop('checked', true);
				}
			}
			
		},
		error:function(){
			alert('error');
		}
	});
});

function public_Change(){
	
	if($("#p_Check").is(':checked')) {
		$("#phone_public").val('on');
	} else {
		$("#phone_public").val(null);
	}
}

function go_updUser() {
	
	var nameValid = /\s/g;
	if(nameValid.test($("#name").val())) {
		alert('이름에는 공백이 들어갈 수 없습니다.');
		$("#name").val('');
		return;
	} else {
		var phoneValid = /^[0-9]*$/;
		
		if(!phoneValid.test($("#phone").val())) {
			alert('연락처는 -를 제외한 숫자만 입력해주세요.');
			$("#phone").val('');
			return;
		}
	}
	
	$("#frm").attr("action", "updUser_n.do");
	$("#frm").submit();
	
}

function go_delUser() {
	location.href="delUser.do?id=" + '<%=id%>';
}
</script>
</body>
</html>
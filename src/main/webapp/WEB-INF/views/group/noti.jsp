<%@page import="mul.cam.a.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	UserDto login = (UserDto) session.getAttribute("login");
	String id = login.getId();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- AJAX -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<style type="text/css">
.table-warning{
	margin-left: 100px;
}
.table-warning th{
	font-size : 10pt;
	height : 30px;
	color : black;
	font-family: 'Black Han Sans', sans-serif;
	font-family: 'Dongle', sans-serif;
	font-family: 'Jua', sans-serif;
	font-family: 'Noto Sans KR', sans-serif;
	text-align: center;
	vertical-align: middle;
}
.table-warning td{
	background-color : white;
	font-size : 10pt;
	color : black;
	text-align: center;
	font-family: 'Black Han Sans', sans-serif;
	font-family: 'Dongle', sans-serif;
	font-family: 'Jua', sans-serif;
	font-family: 'Noto Sans KR', sans-serif;
	vertical-align: middle;
	padding-top: 10px;
	padding-bottom : 10px;
	padding-right: 10px;
	padding-left: 10px;
	border-bottom: 1px solid rgba(0, 0, 0, 0.3);
}
</style>
</head>
<body>

<div>
<br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold">&nbsp;&nbsp;&nbsp;요청 받은 그룹 승인</h1>
<small class="text-muted" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;리더님의 그룹에 가입하고 싶어하는 사람들입니다.</small>
<br><br><br>
<table class="table-warning">
<col width="50px"><col width="130px"><col width="130px"><col width="200px"><col width="130px"><col width="130px"><col width="60px">
	<thead>
	<tr class="table-warning">
		<th>번호</th>
		<th>요청자 이름(ID)</th>
		<th>가입 요청 그룹</th>
		<th>가입/요청 메세지</th>
		<th>신청일자</th>
		<th colspan='2'>비고</th>
	</tr>
	</thead>
	<tbody id="tableBody1">
	</tbody>
</table>
<br><br><br>
<hr>
<br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold">&nbsp;&nbsp;&nbsp;내가 요청한 그룹 승인</h1>
<small class="text-muted" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;그룹 리더님의 가입 수락을 기다리고 있어요.</small>
<br><br><br>
<table class="table-warning" style="margin-left:130px">
<col width="50px"><col width="130px"><col width="130px"><col width="200px"><col width="130px"><col width="130px">
	<thead>
	<tr class="table-warning">
		<th>번호</th>
		<th>그룹 리더(ID)</th>
		<th>가입 예정 그룹</th>
		<th>가입/요청 메세지</th>
		<th>요청일자</th>
		<th>비고</th>
	</tr>
	</thead>
	<tbody id="tableBody2">
	</tbody>
</table>
<input type="hidden" id="id" value='<%=id %>'>
</div>
<script type="text/javascript">
$(document).ready(function(){
	
	// 요청 받은 승인(내가 리더인 그룹)
	$.ajax({
		url:"selectNoti_from.do",
		type:"get",
		data:{"id":$("#id").val()},
		success:function(data) {
			if(data!=null && data!="") {
				var tableTd = '';
				var count = 1;
				$.each(data, function(i){
					tableTd += '<tr>'
								+ '<td>' + count + '</td>'
								+ '<td>' + data[i].name + '(' + data[i].from_id + ')' + '</td>'
								+ '<td>' + data[i].group_name + '(' + data[i].group_code + ')' + '</td>'
								+ '<td>' + data[i].regimsg + '</td>'
								+ '<td>' + data[i].regidate.substr(0,10) + '</td>'
								+ "<td><button type='button' class='btn btn-warning' style='font-size:10pt;'onclick="+ "location.href='addGroupMem.do?id="
									+ data[i].from_id + "&group_code=" + data[i].group_code + "'>"
									+ "수락</button>"
								+ "</td>"
								+ "<td><button type='button' class='btn btn-danger' style='font-size:10pt; margin-left:-50px' onclick="+ "location.href='lead_deleteNoti.do?from_id="
									+ data[i].from_id + "&group_code=" + data[i].group_code + "'>"
									+ "거절</button>"
								+ "</td>"
							 + '</tr>';
					count++;
				});
				$("#tableBody1").append(tableTd);
			} else if (data==null || data=="") {
				tableTd += "<tr><td colspan='7'>요청 받은 그룹 승인이 없습니다.</td></tr>"
				$("#tableBody1").append(tableTd);
			}
		},	
		error:function(){
			alert('error');
		}
	});
	
	// 요청한 승인(상대방이 리더인 그룹)
	$.ajax({
		url:"selectNoti_to.do",
		type:"get",
		data:{"id":$("#id").val()},
		success:function(data) {
			if(data!=null && data!="") {
				var tableTd = '';
				var count = 1;
				$.each(data, function(i){
					tableTd += '<tr>'
								+ '<td>' + count + '</td>'
								+ '<td>' + data[i].name + '(' + data[i].to_id + ')' + '</td>'
								+ '<td>' + data[i].group_name + '(' + data[i].group_code + ')' + '</td>'
								+ '<td>' + data[i].regimsg + '</td>'
								+ '<td>' + data[i].regidate.substr(0,10) + '</td>'
								+ "<td><button type='button' class='btn btn-danger' style='font-size:10pt; margin-left:0px 'onclick="+ "location.href='deleteNoti.do?from_id="
								+ '<%=id %>' + "&group_code=" + data[i].group_code + "'>"
									+ "요청 취소</button>"
								+ "</td>"
							 + '</tr>';
					count++;
				});
				$("#tableBody2").append(tableTd);
			} else if (data==null || data=="") {
				tableTd += "<tr><td colspan='6'>요청한 그룹 승인이 없습니다.</td></tr>"
				$("#tableBody2").append(tableTd);
			}
		},	
		error:function(){
			alert('error');
		}
	});
});
</script>
</body>
</html>
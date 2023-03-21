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
input[type=text] {
	margin-left:30px;
	padding-left:10px;
	width: 300px;
}
</style>

<meta charset="UTF-8">
<title>Insert title here</title>

<!-- AJAX -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
</head>
<body>
<div>
<br><br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold">&nbsp;&nbsp;&nbsp;나의 그룹 확인하기</h1>
<small class="text-muted" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;그룹 관리/탈퇴를 통해 나의 그룹을 관리할 수 있어요.</small>
<br><br><br>
<table class="table-warning">
<col width="50px"><col width="80px"><col width="130px"><col width="200px"><col width="130px"><col width="130px"><col width="90px">
	<tr class="table-warning">
		<th>번호</th>
		<th>그룹코드</th>
		<th>그룹명</th>
		<th>그룹소개</th>
		<th>그룹리더</th>
		<th>그룹생성일</th>
		<th colspan="2">비고</th>
	</tr>
	<tbody id="tableBody">
	</tbody>
</table>
<br>
<input type="hidden" id="id" value='<%=id %>'>
</div>
<script type="text/javascript">
$(document).ready(function(){
	
	var group1;
	var group2;
	var count = 1;
	
	// Leader
	$.ajax({
		url:"selectGroup1.do",
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
								+ '<td>' + data[i].leader_name + '(' + data[i].leader_id + ')' + '</td>'
								+ '<td>' + data[i].regidate.substr(0,10) + '</td>'
								+ "<td>" + "<img src='./images/mark.png' width='26.4px' height='22.8px' >" + '&nbsp;리더' + '</td>'
								+ "<td><button type='button' class='btn btn-warning' style='font-size:10pt;' onclick="+ "location.href='goManagegroup.do?group_code="
									+ data[i].group_code + "'>"
									+ "그룹 관리</button>"
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
		url:"selectGroup2.do",
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
								+ '<td>' + data[i].leader_name + '(' + data[i].leader_id + ')' + '</td>'
								+ '<td>' + data[i].regidate.substr(0,10) + '</td>'
								+ "<td>" + "<img src='./images/GroupMem3.png' width='26.4px' height='22.8px' >" + '&nbsp;그룹원' + '</td>'
								+ "<td colspan='2'><button type='button' class='btn btn-danger' style='font-size:10pt;' onclick="+ "location.href='delGroupMem.do?id="
										+ '<%=id %>' +"&group_code=" + data[i].group_code + "'>"
										+ "그룹탈퇴</button>"
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
			var tableTd = '<tr>'
				+ "<td colspan='8'> 가입한 그룹이 없습니다. </td>"
			 + '</tr>';
			$("#tableBody").append(tableTd);
		}
	}
	
});
</script>
</body>
</html>
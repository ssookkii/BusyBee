
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
</head>
<body>

<div>
<h3>요청 받은 그룹 승인</h3>
<table border="1">
	<thead>
	<tr>
		<th>번호</th>
		<th>그룹 리더(ID)</th>
		<th>가입 예정 그룹</th>
		<th>가입 메세지</th>
		<th>신청일자</th>
		<th></th>
	</tr>
	</thead>
	<tbody id="tableBody1">
	</tbody>
</table>
<br><br><br>
<hr>
<h3>내가 요청한 그룹 승인</h3>
<table border="1">
	<thead>
	<tr>
		<th>번호</th>
		<th>그룹 리더(ID)</th>
		<th>가입 예정 그룹</th>
		<th>가입/요청 메세지</th>
		<th>요청일자</th>
		<th></th>
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
		url:"http://localhost:8090/busyBee/selectNoti_from.do",
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
								+ "<td><button type='button' onclick="+ "location.href='addGroupMem.do?id="
									+ data[i].from_id +"&group_code=" + data[i].group_code + "'>"
									+ "수락</button>"
								+ "</td>"
								+ "<td><button type='button' onclick="+ "location.href='lead_deleteNoti.do?from_id="
									+ data[i].from_id +"&group_code=" + data[i].group_code + "'>"
									+ "거절</button>"
								+ "</td>"
							 + '</tr>';
					count++;
				});
				$("#tableBody1").append(tableTd);
			} else if (data==null || data=="") {
				tableTd += '<tr><td>요청 받은 그룹 승인이 없습니다.</td></tr>'
				$("#tableBody1").append(tableTd);
			}
		},	
		error:function(){
			alert('error');
		}
	});
	
	// 요청한 승인(상대방이 리더인 그룹)
	$.ajax({
		url:"http://localhost:8090/BusyBee/selectNoti_to.do",
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
								+ "<td><button type='button' onclick="+ "location.href='deleteNoti.do?from_id="
									+ '<%=id %>' +"&group_code=" + data[i].group_code + "'>"
									+ "요청 취소</button>"
								+ "</td>"
							 + '</tr>';
					count++;
				});
				$("#tableBody2").append(tableTd);
			} else if (data==null || data=="") {
				tableTd += '<tr><td>요청한 그룹 승인이 없습니다.</td></tr>'
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
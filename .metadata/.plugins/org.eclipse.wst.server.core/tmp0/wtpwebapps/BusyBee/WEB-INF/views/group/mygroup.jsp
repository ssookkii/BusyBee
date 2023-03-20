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
<h3>나의 그룹 확인</h3>

<table border="1">
	<thead>
	<tr>
		<th>번호</th>
		<th>그룹코드</th>
		<th>그룹명</th>
		<th>그룹소개</th>
		<th>그룹리더</th>
		<th>그룹생성일</th>
		<th>비고</th>
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

<br>
[참고] 지금 내 로그인 정보 : <input type="text" value='<%=id %>' readonly="readonly">
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
								+ '<td>' + "<img src='./images/mark.png' width='15px' height='15px' >" + ' 리더' + '</td>'
								+ "<td><button type='button' onclick="+ "location.href='goManagegroup.do?group_code="
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
								+ "<td><button type='button' onclick="+ "location.href='delGroupMem.do?id="
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
			$("#nogroup").text('가입한 그룹이 없습니다.');	
		}
	}
	
});

</script>
</body>
</html>
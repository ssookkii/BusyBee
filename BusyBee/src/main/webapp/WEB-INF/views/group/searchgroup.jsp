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
<h3>그룹검색</h3>
<select id="choice" onChange="searchGroup()">
	<option value="">검색</option>
	<option value="group_code">그룹코드</option>
	<option value="group_name">그룹명</option>
	<option value="leader_name">리더 이름</option>
	<option value="leader_id">리더 ID</option>
</select>
<input type="text" id="search">
[참고] 지금 내 로그인 정보 : <input type="text" value='<%=id %>' readonly="readonly">
<table border="1">
	<thead>
	<tr>
		<th>번호</th>
		<th>그룹코드</th>
		<th>그룹명</th>
		<th>그룹소개</th>
		<th>그룹리더</th>
		<th>그룹생성일</th>
	</tr>
	</thead>
	<tbody id="tableBody">
	</tbody>
</table>

<input type="hidden" id="id" value='<%=id %>'>

<br><br><br>
<hr>
<h3>가입 신청</h3>
그룹 코드 : <input type="text" id="wantTo">
<h6>그룹 코드는 공백 없이, 영문 소문자 및 숫자를 포함한 8자입니다.</h6>
가입 메세지 : <input type="text" id="wantTo_Msg">
<input type="button" value="가입신청" onclick="go_checkDupl()">
<table border="1">
	<thead>
	<tr>
		<th>그룹코드</th>
		<th>그룹명</th>
		<th>그룹소개</th>
		<th>그룹리더</th>
		<th>그룹생성일</th>
	</tr>
	</thead>
	<tbody id="tableBody2">
	</tbody>
</table>

</div>

<script type="text/javascript">


$("#search").keyup(function(){
	searchGroup();
});

$("#wantTo").keyup(function(e){
	
	let key = e.key || e.keyCode;
	
	if(key==" " || key==32) {
		$("#wantTo").val('');
		$("#tableBody2").html('');
		var tableTdNone = '<tr><td>아이디에는 공백이 들어갈 수 없습니다.</td></tr>';
		$("#tableBody2").append(tableTdNone);
		return;
	}
	
	// 그룹코드 유효성 검사
	var gcValid = /^[a-z0-9]{0,8}$/;
	
	if(!gcValid.test($("#wantTo").val())) {
		$("#wantTo").val('');
		$("#tableBody2").html('');
		var tableTdNone = '<tr><td>그룹코드에는 영문 소문자, 숫자만 들어갈 수 있습니다.</td></tr>';
		$("#tableBody2").append(tableTdNone);
		return;
	}
	
	$.ajax({
		url:"singleGroup.do",
		type:"get",
		data:{"group_code":$("#wantTo").val()},
		success:function(data){
			if(data!=null && data!="") {
				var tableTd = "";
				$("#tableBody2").html('');
				tableTd += '<tr>'
							+ '<td>' + data.group_code + '</td>'
							+ '<td>' + data.group_name + '</td>'
							+ '<td>' + data.group_info + '</td>'
							+ '<td>' + data.leader_name + '(' + data.leader_id + ')' + '</td>'
							+ '<td>' + data.regidate.substr(0,10) + '</td>'
							+ "<td><input type='hidden' id='group_code' value='" + data.group_code + "'</td>"
							+ "<td><input type='hidden' id='leader_id' value='" + data.leader_id + "'</td>"
							+ '</tr>';
				$("#tableBody2").append(tableTd);
			} else if(data==null || data=="") {
				$("#tableBody2").html('');
				var tableTdNone = '<tr><td>정확한 그룹코드를 입력해주세요.</td></tr>';
				$("#tableBody2").append(tableTdNone);
			}
		},
		error:function(){
			alert('Aj2 error');
		}
	});
});




function go_checkDupl(){
	
	if($.trim($("#wantTo").val())=="") {
		alert('그룹 코드를 입력해주세요.');
		return;
	}
	
	$.ajax({
		url:"checkDupl.do",
		type:"get",
		data:{"id":'<%=id%>', "group_code":$("#group_code").val()},
		success:function(msg){
			if(msg!=null && msg!="") {
				if(msg=="Already"){
					alert('이미 가입된 그룹입니다.');
					$("#wantTo").val('');
					$("#wantTo_Msg").val('');
					$("#tableBody2").html('');
				} else if(msg=="WAIT") {
					alert('승인 대기중인 그룹입니다.');
					$("#wantTo").val('');
					$("#wantTo_Msg").val('');
					$("#tableBody2").html('');
				} else {
					location.href="addNoti.do?to_id="+$("#leader_id").val()+"&from_id="+'<%=id%>'
							+"&group_code="+$("#group_code").val()+"&regimsg=" + $("#wantTo_Msg").val();
				}
			} else {
				alert('그룹코드를 다시 확인해주세요.');
				$("#wantTo_Msg").val('');
				$("#wantTo_Msg").val('');
			}
		},
		error:function(){
			alert('error');
		}
	});
}

function searchGroup() {
	
	if($.trim($("#choice").val())=="" || $.trim($("#search").val())==""  ) {
		$("#tableBody").html('');
		return;
	}
	
	$.ajax({
		url:"allGroup.do",
		type:"get",
		data:{"choice":$("#choice").val(), "search":$("#search").val()},
		success:function(data){
			if(data!=null && data!="") {
				var tableTd = "";
				var count = 1;
				for(var i=0; i<data.length; i++){
					$("#tableBody").html('');
					tableTd += '<tr>'
								+ '<td>' + count + '</td>'
								+ '<td>' + data[i].group_code + '</td>'
								+ '<td>' + data[i].group_name + '</td>'
								+ '<td>' + data[i].group_info + '</td>'
								+ '<td>' + data[i].leader_name + '(' + data[i].leader_id + ')' + '</td>'
								+ '<td>' + data[i].regidate.substr(0,10) + '</td>'
							+ '</tr>';
					count++;
				}
				$("#tableBody").append(tableTd);
			} else if(data==null || data=="") {
				$("#tableBody").html('');
				var tableTdNone = '<tr><td>조건에 해당하는 그룹이 없습니다.</td></tr>';
				$("#tableBody").append(tableTdNone);
			}
		},
		error:function(){
			alert('Aj1 error');
		}
	});
}

</script>

</body>
</html>
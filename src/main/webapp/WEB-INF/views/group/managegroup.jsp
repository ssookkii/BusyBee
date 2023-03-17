<%@page import="mul.cam.a.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	UserDto login = (UserDto) session.getAttribute("login");
	String id = login.getId();
	
	String group_code = (String) request.getAttribute("group_code");
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
<h3>그룹 정보 관리</h3>
<table>
	<thead>
	<tr>
		<th>그룹코드</th>
		<th>그룹생성일</th>
		<th>그룹이름</th>
		<th>그룹정보</th>
	</tr>
	</thead>
	<tbody id="tBody1">
	</tbody>
</table>
<br><br>
<hr>

<h3>그룹 구성원 관리</h3>
<h5>기존 구성원 관리</h5>
<table>
	<thead>
	<tr>
		<th>번호</th>
		<th>이름(ID)</th>
		<th>email</th>
		<th>핸드폰번호</th>
		<th>가입일</th>
	</tr>
	</thead>
	<tbody id="tBody2">
	</tbody>
</table>
<br><br>

<h5>새 구성원 추가</h5>
초대 ID : <input type="text" id="wantId" maxlength="12">
<h6>아이디는 공백 없이, 영문 대소문자 및 숫자를 포함하여 12자 이내입니다.</h6>
초대 메세지 : <input type="text" id="wantTo_Msg">
<input type="button" value="그룹초대" onclick="go_checkDupl()">
<table border="1">
	<thead>
	<tr>
		<th>이름(ID)</th>
		<th>email</th>
		<th>핸드폰번호</th>
		<th>BusyBee 가입일</th>
	</tr>
	</thead>
	<tbody id="tBody3">
	</tbody>
</table>

</div>

<script type="text/javascript">
$(document).ready(function(){
	
	// 그룹 정보
 	$.ajax({
		url:"http://localhost:8090/busyBee/singleGroup.do",
		type:"get",
		data:{"group_code":'<%=group_code%>'},
		success:function(data){
			if(data!=null && data!="") {
				var tableTd = "";
				$("#tBody1").html('');
				tableTd += '<tr>'
							+ "<td><input type='text' readonly='readonly' value=" + data.group_code + "></td>"
							+ "<td><input type='text' readonly='readonly' value=" + data.regidate.substr(0,10) + "></td>"
							+ "<td><input type='text' id='group_name' value='" + data.group_name + "'></td>"
							+ "<td><input type='text' id='group_info' value='" + data.group_info + "'></td>"
							+ "<td><button type='button' onclick='go_groupUpd()'>수정</button>"
						+ '</tr>';
				$("#tBody1").append(tableTd);
			}
		},
		error:function(){
			alert('Aj1 error');
		}
	});
 	
	// 기존 그룹원
 	$.ajax({
		url:"http://localhost:8090/busyBee/allGroupMem.do",
		type:"get",
		data:{"group_code":'<%=group_code%>'},
		success:function(data){
			if(data!=null && data!="") {
				var tableTd = "";
				var count = 1;
				for(var i=0; i<data.length; i++){
					$("#tBody2").html('');
					tableTd += '<tr>'
								+ '<td>' + count + '</td>'
								+ '<td>' + data[i].name +'(' + data[i].id + ')' + '</td>'
								+ '<td>' + data[i].email + '</td>';
					if(data[i].phone_public==null) {
						tableTd += '<td>비공개</td>';
					} else {
						tableTd += '<td>' + data[i].phone + '</td>';
					}
						tableTd += '<td>' + data[i].regidate.substr(0,10) + '</td>'
								+ "<td><button type='button' onclick="+ "location.href='outGroupMem.do?group_code="
									+ data[i].group_code + "&id=" + data[i].id + "'>"
									+ "추방</button>"
								+ "</td>"
								+ "<td><button type='button' onclick="+ "location.href='changeleader.do?group_code="
									+ data[i].group_code + "&id=" + data[i].id + "&name=" + data[i].name + 
									"&leader_id=" +'<%=id%>' + "'>"
									+ "리더 위임</button>"
							+ "</td>"
							+ '</tr>';
					count++;
				}
				$("#tBody2").append(tableTd);
			} else if(data==null || data=="") {
				$("#tBody2").html('');
				var tableTdNone = '<tr><td>그룹원이 없습니다.</td></tr>';
				$("#tBody2").append(tableTdNone);
			}
		},
		error:function(){
			alert('Aj2 error');
		}
	});
	
});

$("#wantId").keyup(function(e){
	
	let key = e.key || e.keyCode;
	
	// ID 유효성 검사
	var idValid = /^[a-zA-z0-9]{0,12}$/;
	
	if($("#wantId").val()=="") {
		$("#tBody3").html('');
		return;
	}
	
	if(key==" " || key==32) {
		$("#wantId").val('');
		$("#tBody3").html('');
		var tableTdNone = '<tr><td>아이디에는 공백이 들어갈 수 없습니다.</td></tr>';
		$("#tBody3").append(tableTdNone);
		return;
	}
	
	if(!idValid.test($("#wantId").val())) {
		$("#wantId").val('');
		$("#tBody3").html('');
		var tableTdNone = '<tr><td>아이디에는 영문 대소문자, 숫자만 들어갈 수 있습니다.</td></tr>';
		$("#tBody3").append(tableTdNone);
		return;
	}
		
	$.ajax({
		url:"http://localhost:8090/busyBee/selectUser.do",
		type:"get",
		data:{"id":$("#wantId").val()},
		
		success:function(data){
			if(data!=null && data!="") {
				var tableTd = "";
				$("#tBody3").html('');
				tableTd += '<tr>'
							+ '<td>' + data.name +'(' + data.id + ')' + '</td>'
							+ '<td>' + data.email + '</td>';
				if(data.phone_public==null) {
						tableTd += '<td>비공개</td>';
				} else {
						tableTd += '<td>' + data.phone + '</td>';
							}							
				tableTd +=	'<td>' + data.regidate.substr(0,10) + '</td>'
							+ '</tr>';
				$("#tBody3").append(tableTd);
			} else if(data==null || data=="") {
				$("#tBody3").html('');
				var tableTdNone = '<tr><td>정확한 ID를 입력해주세요.</td></tr>';
				$("#tBody3").append(tableTdNone);
			}
		},
		error:function(){
			alert('error');
		}
		
	});
	
});

function go_groupUpd() {
	location.href="updGroup.do?group_code=" + '<%=group_code%>' + "&group_name=" + $("#group_name").val()
			+ "&group_info=" + $("#group_info").val();
}

function go_checkDupl(){
	
	if($.trim($("#wantId").val())=="") {
		alert('초대 ID를 입력해주세요.');
		return;
	}
	
	$.ajax({
		url:"http://localhost:8090/busyBee/inv_checkDupl.do",
		type:"get",
		data:{"id":$("#wantId").val(), "group_code":'<%=group_code%>'},
		success:function(msg){
			if(msg!=null && msg!="") {
				if(msg=="Already"){
					alert('이미 가입된 멤버입니다.');
					$("#wantId").val('');
					$("#wantTo_Msg").val('');
					$("#tBody3").html('');
				} else if(msg=="WAIT") {
					alert('승인 대기중인 멤버입니다.');
					$("#wantId").val('');
					$("#wantTo_Msg").val('');
					$("#tBody3").html('');
				} else {
					location.href="inv_addNoti.do?to_id="+$("#wantId").val()+"&from_id="+'<%=id%>'
							+"&group_code="+'<%=group_code%>'+"&regimsg=" + $("#wantTo_Msg").val();
				}
			} else {
				alert('초대ID를 다시 확인해주세요.');
				$("#wantId").val('');
			}
		},
		error:function(){
			alert('error');
		}
	});
}

</script>
</body>
</html>
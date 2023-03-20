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
	padding-left:20px;
	width: 300px;
}

</style>
</head>
<body>
<div>
<br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold">&nbsp;&nbsp;&nbsp;그룹 정보 관리</h1>
<small class="text-muted" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;그룹 이름, 정보를 수정할 수 있어요.</small>
<br><br><br>
<table class="table-warning" style="margin-left: 100px">
<col width="80px"><col width="130px"><col width="130px"><col width="200px">
	<thead>
	<tr class="table-warning">
		<th>그룹코드</th>
		<th>그룹생성일</th>
		<th>그룹이름</th>
		<th>그룹정보</th>
	</tr>
	</thead>
	<tbody id="tBody1">
	</tbody>
</table>
<br>
<input type="button" class="btn btn-warning" style="font-size:11pt; padding: 10px 20px; margin-left: 500px;
margin-top: 10px" value="정보 수정" onclick='go_groupUpd()'/>
<br><br>
<hr>
<br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold">&nbsp;&nbsp;&nbsp;기존 그룹원 관리</h1>
<small class="text-muted" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;우리 그룹의 멤버를 관리할 수 있어요.</small>
<br><br><br>
<table class="table-warning" style="margin-left:130px">
<col width="50px"><col width="130px"><col width="160px"><col width="130px"><col width="200px"><col width="150px">
	<thead>
	<tr class="table-warning">
		<th>번호</th>
		<th>이름(ID)</th>
		<th>email</th>
		<th>핸드폰번호</th>
		<th>가입일</th>
		<th colspan='2'>비고</th>
	</tr>
	</thead>
	<tbody id="tBody2">
	</tbody>
</table>
<br><br>
<hr>
<br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold">&nbsp;&nbsp;&nbsp;새 그룹원 초대</h1>
<small class="text-muted" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;ID를 검색해서 새로운 멤버를 초대할 수 있어요.</small>
<br><br><br>
<input class="form-control form-control-lg" style="width:100px; background-color:rgba(255,238,186, 0.3);
						float:left; margin-right : 20px; margin-left : 330px; text-align: center"
						type="text" readonly="readonly" value="ID">
<input class="form-control form-control-lg" type="text" id="wantId" maxlength="12" placeholder="초대하고 싶은 ID를 입력해주세요.">
<br>
<input class="form-control form-control-lg" style="width:100px; background-color:rgba(255,238,186, 0.3);
						float:left; margin-right : 20px; margin-left : 330px"
						type="text" readonly="readonly" value="초대메세지" maxlength="25">
<input class="form-control form-control-lg" type="text" id="wantTo_Msg" placeholder="해당 멤버에게 전달될 메세지입니다.">
<br>
<table class="table-warning" style="margin-left:200px">
<col width="130px"><col width="160px"><col width="130px"><col width="130px"><col width="130px">
	<thead>
	<tr class="table-warning">
		<th>프로필</th>
		<th>이름(ID)</th>
		<th>email</th>
		<th>핸드폰번호</th>
		<th>BusyBee 가입일</th>
	</tr>
	</thead>
	<tbody id="tBody3">
	<tr><td colspan='5'>초대하고 싶은 ID를 입력해주세요.</td></tr>
	</tbody>
</table>
</div>
<br>
<input type="button" class="btn btn-warning" style="font-size:11pt; padding: 10px 20px; margin-left: 500px;
margin-top: 10px" value="그룹초대" onclick="go_checkDupl()">
<br><br>
<hr>
<br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold">&nbsp;&nbsp;&nbsp;그룹 해체</h1>
<small class="text-muted" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;해체한 그룹은 되돌릴 수 없어요. 신중하게 선택해주세요.</small>
<br><br><br>
<input type="button" class="btn btn-danger" style="font-size:14pt; padding: 10px 20px; margin-left: 490px;
margin-top: 10px" value="그룹 해체" onclick="go_delGroup()">
<br><br><br><br>
<script type="text/javascript">
$(document).ready(function(){
	
	// 그룹 정보
 	$.ajax({
		url:"singleGroup.do",
		type:"get",
		data:{"group_code":'<%=group_code%>'},
		success:function(data){
			if(data!=null && data!="") {
				var tableTd = "";
				$("#tBody1").html('');
				tableTd += '<tr>'
							+ "<td>" + data.group_code + "</td>"
							+ "<td>" + data.regidate.substr(0,10) + "</td>"
							+ "<td><input type='text' id='group_name' value='" + data.group_name + "'></td>"
							+ "<td><input type='text' id='group_info' value='" + data.group_info + "'></td>"
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
		url:"allGroupMem.do",
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
								+ "<td><button type='button' class='btn btn-danger' style='font-size:10pt;' onclick="+ "location.href='outGroupMem.do?group_code="
									+ data[i].group_code + "&id=" + data[i].id + "'>"
									+ "추방</button>"
								+ "</td>"
								+ "<td><button type='button' class='btn btn-warning' style='font-size:10pt;' onclick="+ "location.href='changeleader.do?group_code="
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
				var tableTdNone = "<tr><td colspan='6'>그룹원이 없습니다.</td></tr>";
				$("#tBody2").append(tableTdNone);
			}
		},
		error:function(){
			alert('Aj2 error');
		}
	});
	
});

var selMem_OK = false;

$("#wantId").keyup(function(e){
	
	let key = e.key || e.keyCode;
	
	// ID 유효성 검사
	var idValid = /^[a-zA-z0-9]{0,12}$/;
	
	if($("#wantId").val()=="") {
		$("#tBody3").html('');
		var inputMemId = "<tr><td colspan='5'>초대하고 싶은 ID를 입력해주세요.</td></tr>";
		$("#tBody3").append(inputMemId);
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
	
	// 초대 멤버 검색
	$.ajax({
		url:"selectUser.do",
		type:"get",
		data:{"id":$("#wantId").val()},
		
		success:function(data){
			if(data!=null && data!="") {
				var tableTd = "";
				$("#tBody3").html('');
				tableTd += '<tr>'
							+ "<td><img src ='/busyBeeImg/" + data.profPic_Server + "'width='100px' height='100px' alt=''/>"
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
				var selMem_OK = true;
			} else if(data==null || data=="") {
				$("#tBody3").html('');
				var tableTdNone = "<tr><td colspan='5'>정확한 ID를 입력해주세요.</td></tr>";
				$("#tBody3").append(tableTdNone);
				var selMem_OK = false;
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
		var selMem_OK = false;
		return;
	}
	
	$.ajax({
		url:"inv_checkDupl.do",
		type:"get",
		data:{"id":$("#wantId").val(), "group_code":'<%=group_code%>'},
		success:function(msg){
			if(msg!=null && msg!="") {
				if(msg=="Already"){
					alert('이미 가입된 멤버입니다.');
					$("#wantId").val('');
					$("#wantTo_Msg").val('');
					$("#tBody3").html('');
					var selMem_OK = false;
					return;
				} else if(msg=="WAIT") {
					alert('승인 대기중인 멤버입니다.');
					$("#wantId").val('');
					$("#wantTo_Msg").val('');
					$("#tBody3").html('');
					var selMem_OK = false;
					return;
				} else {
					var selMem_OK = true;
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
	
	if(!selMem_OK) {
		alert('초대 불가능한 ID입니다.');
		$("#wantId").val('');
		return;
	} else {
		location.href="inv_addNoti.do?to_id="+$("#wantId").val()+"&from_id="+'<%=id%>'
		+"&group_code="+'<%=group_code%>'+"&regimsg=" + $("#wantTo_Msg").val();
	}
}

function go_delGroup(){
	
	location.href="delGroup.do?group_code=" + '<%=group_code%>';
	
}
</script>
</body>
</html>
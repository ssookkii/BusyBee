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
	margin-left: 180px;
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

.btn btn-warning {
	padding: 10px 30px;

}

.form-select {
	background-color: rgba(255,238,186, 0.3);
	margin-left : 330px;
	width : 100px;
	float : left;
	margin-right : 20px;
	font-size : 11pt;
}

.btn btn-warning {
	padding: 10px 30px;
}
</style>
</head>
<body>
<div>
<br><br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold">&nbsp;&nbsp;&nbsp;다른 그룹 검색하기</h1>
<small class="text-muted" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;다양한 조건으로 다른 그룹들을 검색할 수 있어요.</small>
<br><br><br>
<select class="form-select" id="choice" onChange="searchGroup()">
	<option value="">검색</option>
	<option value="group_code">그룹코드</option>
	<option value="group_name">그룹명</option>
	<option value="leader_name">리더 이름</option>
	<option value="leader_id">리더 ID</option>
</select><input class="form-control form-control-lg" type="text" id="search" placeholder="검색어를 입력해주세요.">
<br>
<table class="table-warning">
<col width="50px"><col width="80px"><col width="130px"><col width="200px"><col width="130px"><col width="130px">
	<thead>
	<tr class="table-warning">
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
<br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold">&nbsp;&nbsp;&nbsp;그룹 가입 신청하기</h1>
<small class="text-muted" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;검색한 그룹코드로 가입신청이 가능해요.</small>
<br><br><br>
<input class="form-control form-control-lg" style="width:100px; background-color:rgba(255,238,186, 0.3);
						float:left; margin-right : 20px; margin-left : 330px"
						type="text" readonly="readonly" value="그룹코드">
<input class="form-control form-control-lg" type="text" id="wantTo" placeholder="영문 소문자, 숫자 포함 8자">
<br>
<input class="form-control form-control-lg" style="width:100px; background-color:rgba(255,238,186, 0.3);
						float:left; margin-right : 20px; margin-left : 330px"
						type="text" readonly="readonly" value="가입메세지" maxlength="25">
<input class="form-control form-control-lg" type="text" id="wantTo_Msg" placeholder="그룹 리더에게 전달될 메세지입니다.">
<br>
<table class="table-warning">
<col width="80px"><col width="130px"><col width="200px"><col width="130px"><col width="130px">
	<thead>
	<tr class="table-warning">
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
<br><br>
<input type="button" class="btn btn-warning" style="font-size:11pt; padding: 10px 20px; margin-left: 450px;
margin-top: 10px" value="가입신청" onclick="go_checkDupl()">


<script type="text/javascript">
$("#search").keyup(function(){
	searchGroup();
});
$("#wantTo").keyup(function(e){
	
	let key = e.key || e.keyCode;
	
	if($.trim($("#wantTo").val())=="") {
		$("#tableBody2").html('');
		return;
	}
	
	if(key==" " || key==32) {
		$("#wantTo").val('');
		$("#tableBody2").html('');
		var tableTdNone = "<tr><td colspan='5'>그룹코드에는 공백이 들어갈 수 없습니다.</td></tr>";
		$("#tableBody2").append(tableTdNone);
		return;
	}
	
	// 그룹코드 유효성 검사
	var gcValid = /^[a-z0-9]{0,8}$/;
	
	if(!gcValid.test($("#wantTo").val())) {
		$("#wantTo").val('');
		$("#tableBody2").html('');
		var tableTdNone = "<tr><td colspan='5'>그룹코드에는 영문 소문자, 숫자만 들어갈 수 있습니다.</td></tr>";
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
				var tableTdNone = "<tr><td colspan='5'>정확한 그룹코드를 입력해주세요.</td></tr>";
				$("#tableBody2").append(tableTdNone);
			}
		},
		error:function(){
			alert('Aj2 error');
		}
	});
});

var group_code_OK = false;
function go_checkDupl(){
	
	if($.trim($("#wantTo").val())=="") {
		alert('그룹 코드를 입력해주세요.');
		$("#wantTo").val('');
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
					group_code_OK = false;
				} else if(msg=="WAIT") {
					alert('승인 대기중인 그룹입니다.');
					$("#wantTo").val('');
					$("#wantTo_Msg").val('');
					$("#tableBody2").html('');
					group_code_OK = false;
				} else {
					group_code_OK = true;
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
	
	if(!group_code_OK) {
		$("#wantTo").val('');
		alert('유효한 그룹코드를 작성해주세요.');
		return;
	} else {
		location.href="addNoti.do?to_id="+$("#leader_id").val()+"&from_id="+'<%=id%>'
		+"&group_code="+$("#group_code").val()+"&regimsg=" + $("#wantTo_Msg").val();
	}
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
				var tableTdNone = "<tr><td colspan='7'>조건에 해당하는 그룹이 없습니다.</td></tr>";
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
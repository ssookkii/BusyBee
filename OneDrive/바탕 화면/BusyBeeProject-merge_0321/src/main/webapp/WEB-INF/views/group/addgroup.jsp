<%@page import="mul.cam.a.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	UserDto login = (UserDto) session.getAttribute("login");
	String id = login.getId();
	String name = login.getName();
%>
<!DOCTYPE html>
<html>
<head>

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
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- AJAX -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

</head>
<body>
<br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold">&nbsp;&nbsp;&nbsp;그룹 생성하기</h1>
<small class="text-muted" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;원하는 그룹을 자유롭게 생성해보세요!</small>
<br><br><br>
<form action="addGroup.do" id="frm" method="get">
<table class="table-warning" style="margin-left:280px">
<colgroup>
<col width="200px"><col width="400px">
</colgroup>
<tr class="table-warning">
	<th>그룹이름</th>
	<td><input type="text" name="group_name" class="form-control form-control-lg" maxlength="15" placeholder="그룹이름을 입력해주세요." id="group_name">
  </td>
</tr>
<tr class="table-warning">
	<th>그룹정보</th>
	<td>
	<input type="text" name="group_info" class="form-control form-control-lg" maxlength="20" placeholder="그룹정보를 입력해주세요." id="group_info">
	</td>
</tr>
<tr class="table-warning">
	<th>그룹리더</th>
	<td>
	<input type="text" readonly="readonly" class="form-control form-control-lg" value="<%=name%>(<%=id%>)">
	</td>
</tr>
<tr>
<td colspan="2">
<button type="button" class="btn btn-warning" onclick="go_addGroup()" style="font-size:11pt; padding: 10px 20px; margin-left: -50px; margin-top: 10px">그룹 만들기</button>
</td>
</tr>
</table>
<input type="hidden" name="leader_id" value='<%=id %>'>
<input type="hidden" name="leader_name" value='<%=name %>'>
<br>
<br>
<hr>
<br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold">&nbsp;&nbsp;&nbsp;비슷한 성격의 그룹</h1>
<small class="text-muted" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;'그룹 검색'에서 가입신청이 가능해요.</small>
</form>

<br><br>
<input class="form-control form-control-lg" style="width:100px; background-color:rgba(255,238,186, 0.3);
						float:left; margin-right : 20px; margin-left : 330px"
						type="text" readonly="readonly" value="검색어">
<input class="form-control form-control-lg" type="text" id="similar" placeholder="그룹이름, 정보를 바탕으로 조회돼요.">
<br>
<table class="table-warning" style="margin-left:160px">
<col width="50px"><col width="90px"><col width="150px"><col width="200px"><col width="150px"><col width="130px">
	<thead>
	<tr class="table-warning">
		<th style="font-size: 10pt; height:30px">번호</th>
		<th style="font-size: 10pt;">그룹코드</th>
		<th style="font-size: 10pt">그룹명</th>
		<th style="font-size: 10pt">그룹소개</th>
		<th style="font-size: 10pt">그룹리더</th>
		<th style="font-size: 10pt">그룹생성일</th>
	</tr>
	</thead>
	<tbody id="tableBody2">
	<tr>
	</tr>
	</tbody>
</table>

<script type="text/javascript">
function go_addGroup() {
	if($.trim($("#group_name").val())=="") {
		alert('그룹 이름은 반드시 입력해야 합니다.');
		$("#group_name").val('');
		return;
	} else {
		var groupValid = /\s/g;
		
		if(groupValid.test($("#group_name").val())) {
			alert('그룹 이름에는 공백이 들어갈 수 없습니다.');
			$("#group_name").val('');
			$("#group_name").focus();
			return;
		}
	}
	
	$("#frm").submit();
}
$("#similar").keyup(function(){
	if($.trim($("#similar").val())=="") {
		$("#tableBody2").html('');
		var noData = "<tr><td colspan='6'>검색어를 입력해주세요.</td></tr>";
		$("#tableBody2").append(noData);
		return;
	}
	
	$.ajax({
		url:"similarGroup.do",
		type:"get",
		data:{"search" : $("#similar").val()},
		success:function(data){
			if(data!=null && data!="") {
				var tableTd = "";
				var count = 1;
				for(var i=0; i<data.length; i++){
					$("#tableBody2").html('');
					tableTd += "<tr style='border-bottom:1px solid rgba(0, 0, 0, 0.3)'>"
								+ '<td>' + count + '</td>'
								+ '<td>' + data[i].group_code + '</td>'
								+ '<td>' + data[i].group_name + '</td>'
								+ '<td>' + data[i].group_info + '</td>'
								+ '<td>' + data[i].leader_name + '(' + data[i].leader_id + ')' + '</td>'
								+ '<td>' + data[i].regidate.substr(0,10) + '</td>'
							+ '</tr>';
					count++;
				}
				$("#tableBody2").append(tableTd);
			} else if(data==null || data=="") {
				$("#tableBody2").html('');
				var tableTdNone = "<tr><td colspan='7'>조건에 해당하는 그룹이 없습니다.</td></tr>";
				$("#tableBody2").append(tableTdNone);
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
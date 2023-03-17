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
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- AJAX -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
</head>
<body>
<div>
<h3>그룹검색</h3>
<select id="choice">
	<option value="">검색</option>
	<option value="group_code">그룹코드</option>
	<option value="group_name">그룹명</option>
	<option value="leader_name">리더 이름</option>
	<option value="leader_id">리더 ID</option>
</select>

<table border="1">
	<tbody id="tableBody">
	</tbody>
</table>

<input type="text" id="search">
<br>
[참고] 지금 내 로그인 정보 : <input type="text" value='<%=id %>' readonly="readonly">
</div>

<script type="text/javascript">
$("#search").keyup(function(){
	
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
				for(var i=0; i<data.length; i++){
					$("#tableBody").html('');
					tableTd += '<tr>'
								+ '<td>' + data[i].group_code + '</td>'
								+ '<td>' + data[i].group_name + '</td>'
								+ '<td>' + data[i].group_info + '</td>'
								+ '<td>' + data[i].leader_name + '(' + data[i].leader_id + ')' + '</td>';
					if ('<%=id%>' !== data[i].leader_id) {
						tableTd +="<td><input type='button' id='addGroupMem' value='가입'></td>"
								/* +="<td><input type='button' id='addNoti' value='가입하기'></td>" */
								+ "<td><input type='hidden' id='group_code' value='" + data[i].group_code + "'</td>"
								+ "<td><input type='hidden' id='leader_id' value='" + data[i].leader_id + "'</td>"
								+ "</tr>";
						} else {
							tableTd += '</tr>';
						}
						$("#tableBody").append(tableTd);
				}
			} else if(data==null || data=="") {
				$("#tableBody").html('');
				var tableTdNone = '<tr><td>조건에 해당하는 그룹이 없습니다.</td></tr>';
				$("#tableBody").append(tableTdNone);
			}
		},
		error:function(){
			alert('error');
		}
	});
});

$(document).on("click", "#addGroupMem", function(){
	location.href="addGroupMem.do?id=" + '<%=id%>' + "&group_code=" + $("#group_code").val();
});

<%-- $(document).on("click", "#addNoti", function(){
	location.href="addNoti.do?id=" + '<%=id%>' + "&group_code=" + $("#group_code").val()
				+ "&leader_id=" + $("#leader_id").val();
	$(this).val('대기중');
	$(this).attr("disabled", true);
}); --%>
</script>

</body>
</html>
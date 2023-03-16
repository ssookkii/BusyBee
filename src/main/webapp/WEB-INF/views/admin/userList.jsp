<%@page import="mul.cam.a.dto.UserDto"%>
<%@page import="mul.cam.a.dto.ReportDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%

List<UserDto> list = (List<UserDto>)request.getAttribute("userList");
UserDto dto = (UserDto)request.getAttribute("dto");
int pageBbs = (Integer)request.getAttribute("pageBbs");
int pageNumber = (Integer)request.getAttribute("pageNumber");
String choice = (String)request.getAttribute("choice");
String search = (String)request.getAttribute("search");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>회원 관리</h1>

<hr>

<div align="center">


<br>
<table class="table table-hover table-sm" style="width: 1000px">
<col width="50">
<col width="100"><col width="100"><col width="100"><col width="300">
<col width="300"><col width="100">

<thead>
<tr class="bg-primary" style="color: white;">
	<th>번호</th><th>회원ID</th><th>회원상태</th><th>신고누적</th>
	<th>가입일</th><th>이메일</th><th>회원관리</th>
</tr>
</thead>
<tbody style="text-align: left;">
<%
if(list == null || list.size() == 0){
	%>
	<tr>
		<td colspan="4">회원이 없습니다.</td>
	</tr>
	<%
}else{
	
	for(int i = 0;i < list.size(); i++)
	{
		dto = list.get(i);
		%>
		<tr>
			<th><%= i + 1 + (pageNumber * 10) %></th>
			
			<td><%=dto.getId() %></td>
			<td>
			
			<%if(dto.getAuth()==3){
				%>
				<p>관리자</p>
				<% 
			}else if(dto.getAuth()==1){
				%>
				<p>일반회원</p>
				<% 
			}else if(dto.getAuth()==2){
				%>
				<p>정지회원</p>
				<% 
			}
			%>
			
			</td>
						<td>
			<%=dto.getReported_count()%>
			</td>
			<td>
			<%=dto.getRegidate() %>
			</td>
						<td>
			<%=dto.getEmail() %>
			</td>
			<td>
			<%if(dto.getAuth()==1){
				%>
			<button type="button" class="btn btn-primary"
			onclick="userBan('<%=dto.getId()%>')">이용정지</button>				
				<% 
			}else if(dto.getAuth()==2){
				%>
			<button type="button" class="btn btn-primary"
			onclick="userIn('<%=dto.getId()%>')">정지해제</button>		
				<% 	
			}
				%>
			

	</td>
		</tr>
		<%
	}
}
%>

</tbody>
</table>


<br><br>



<table style="margin-left: auto; margin-right: auto; margin-top: 3px; margin-bottom: 3px">
	<tr>
		<td style="padding-left: 5px">
			<select class="custom-select" id="choice" name="choice">
				<option selected value="id">ID</option>
				<option value="report_count">신고대상</option>
				<option value="auth">회원상태</option>
			</select>
		</td>
		<td style="padding-left: 5px" class="align-middle">
			<input type="text" class="form-control" id="search" name="search" onkeyup="enterKeyEvent()" placeholder="검색어" value="<%=search %>">
		<td style="padding-left: 5px">
			<span>
				<button type="button" class="btn btn-primary" onclick="searchBtn()">검색</button>
			</span>
		</td>
	</tr>
</table>
</div>

<script type="text/javascript">

function userBan(id) {
	location.href="userBan.do?id="+id;
}

function userIn(id) {
	location.href="userIn.do?id="+id;
}

let search = "<%=search %>";
console.log("search = " + search);
if(search != ""){
	let obj = document.getElementById("choice");
	obj.value = "<%=choice %>";
	obj.setAttribute("selected", "selected");
}

function enterKeyEvent() {
	if(window.event.keyCode==13){
		searchBtn();
	}
}

function searchBtn() {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	

	
	location.href = "userList.do?choice=" + choice + "&search=" + search;
}


$('#pagination').twbsPagination({
	startPage: <%=pageNumber+1 %>, 
    totalPages: <%=pageBbs %>,
    visiblePages: 10,
    first:'<span srid-hidden="true">«</span>',
    prev:"이전",
    next:"다음",
    last:'<span srid-hidden="true">»</span>',
    initiateStartPageClick:false,   // onPageClick 자동실행되지 않도록
    onPageClick: function (event, page) {
        // alert(page);
        let choice = document.getElementById('choice').value;
		let search = document.getElementById('search').value;
    	location.href = "reportList.do?choice=" + choice + "&search=" + search + "&pageNumber=" + (page-1);
    }
});





</script>

</body>
</html>
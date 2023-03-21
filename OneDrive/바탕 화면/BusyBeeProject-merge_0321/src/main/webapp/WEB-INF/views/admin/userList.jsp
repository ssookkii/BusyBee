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

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<script type="text/javascript" src="./jquery/jquery.twbsPagination.min.js"></script>


<style type="text/css">
.d-flex{
font-size: 14px;
float: right;
}
body{
font-size: 14px;
}
.table{
margin-left:auto; 
margin-right:auto;
}
table, td, th {
    border-collapse : collapse;
}

.pagination{
margin-left: 300px;
}
.pagination .page-link {
  color: #333;
  background-color: #fff;
  border-color: #ddd;
}
.pagination .page-item.active .page-link {
  background-color: #FFCE67;
  border-color: #FFCE67;
}
.pagination .page-link:focus,
.pagination .page-link:hover {
  color: #FFCE67;
  background-color: #e9ecef;
  border-color: #dee2e6;
}
.pagination .page-item:first-child .page-link {
  border-top-left-radius: 0.25rem;
  border-bottom-left-radius: 0.25rem;
}
.pagination .page-item:last-child .page-link {
  border-top-right-radius: 0.25rem;
  border-bottom-right-radius: 0.25rem;
}
</style>
</head>
<body>

<br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold; font-size: 48px;">&nbsp;&nbsp;&nbsp;회원관리</h1>
<br><br>
<hr>

<div align="right">
<nav style="width: 1000px; text-align: right;">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarColor01">
      <div class="d-flex" >
	      	<select id="choice" style="color:black;">
				<option value="id" selected="selected">ID</option>
				<option value="report_type">신고유형</option>
			</select>
  <input style="width: 100px; height: 30px;" class="form-control form-control-sm" type="text" id="search" name="search" onkeyup="enterKeyEvent()" placeholder="검색어" value="<%=search %>">
				<button type="button" class="btn btn-secondary my-2 my-sm-0" onclick="searchBtn()">검색</button>
      </div>
    </div>
  </div>
</nav>
</div>


<div align="center">


<br>
<table class="table table-hover" style="width: 1000px;, font-size: 20px;margin-left: 500px;"><col width="50">
<col width="100"><col width="100"><col width="250"><col width="300">
<col width="300"><col width="100">

<thead>
<tr class="table-warning" style="color: black;">
	<th>번호</th><th>회원ID</th><th>회원상태</th>
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
			<%=dto.getRegidate() %>
			</td>
						<td>
			<%=dto.getEmail() %>
			</td>
			<td>
			<%if(dto.getAuth()==1){
				%>
			<button style="font-size: 20px;" type="button" class="btn btn-warning"
			onclick="userBan('<%=dto.getId()%>')">이용정지</button>				
				<% 
			}else if(dto.getAuth()==2){
				%>
			<button style="font-size: 20px;" type="button" class="btn btn-warning"
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
<div class="container">
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination" style="justify-content:center"></ul>
    </nav>
</div>

<br><br>


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
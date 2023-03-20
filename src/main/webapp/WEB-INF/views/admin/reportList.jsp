<%@page import="mul.cam.a.dto.ReportDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%

List<ReportDto> list = (List<ReportDto>)request.getAttribute("reportList");
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
<!-- 페이징 -->

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
padding-right: 100px;
}

.btn{
	height : 30px;
	width: 50px;
	
}

body{
font-size: 14px;
}

.pagination {
  display: inline-block;
}

.pagination li {
  display: inline-block;
  margin-right: 5px;
  border: 1px solid #FFCE67;
  padding: 5px 10px;
  background-color: #FFCE67;
  border-radius: 3px;
}

.pagination li.active {
  background-color: #FFCE67;
  border-color: #FFCE67;
  color: #FFCE67;
}

.pagination li:hover {
  background-color: #FFCE67;
  cursor: pointer;
}

</style>

</head>
<body>

<br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold; font-size: 48px;">&nbsp;&nbsp;&nbsp;신고관리</h1>
<br><br>
<hr>



<div align="right">
<nav style="width: 1000px; text-align: right; padding-left: 300px;">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarColor01">
      <div class="d-flex" >
	      	<select id="choice" style="color:black;">
				<option value="reported_id" selected="selected">ID</option>
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
<table class="table table-hover" style="width: 1700px;, font-size: 20px;">
<col width="50">
<col width="100"><col width="100"><col width="150"><col width="100">
<col width="100"><col width="200"><col width="600"><col width="200">
<col width="100">

<thead>
<tr class="table-warning" style="color: black;">
	<th scope="row">번호</th><th scope="row">신고자</th><th scope="row">피신고자</th>
	<th scope="row">신고누적횟수</th><th scope="row">신고글 번호</th><th scope="row">신고글 유형</th><th>신고사유</th>
	<th scope="row">신고일시</th><th scope="row">신고글 관리</th>
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
		ReportDto dto = list.get(i);
		%>
		<tr>
			<th><%=i + 1 + (pageNumber * 10) %></th>
			
			<td><%=dto.getReporter_id() %></td>
			<td>
			<%=dto.getReported_id() %>
			</td>
			<td>
			<%=dto.getReport_count() %>
			</td>
						<td>
			<%=dto.getReport_seq() %>
			</td>
			
						<td>
			<%=dto.getReport_type() %>
			</td>
									<td>
			<%=dto.getReport_content() %>
			</td>
		
						<td>
			<%=dto.getReport_date() %>
			</td>
			
			<td>
			<input style="font-size: 14px; width: 100px; height: 50px;" type="button" class="btn btn-warning" onclick="goBbs(<%=dto.getReport_seq() %>)" value="신고글 이동">
			</td>


		</tr>
		<%
	}
}
%>

</tbody>
</table>
<br><br>

<div>
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination" style="justify-content:center"></ul>
    </nav>
</div>


<br><br>



</div>

<script type="text/javascript">

function goBbs(seq) {
	location.href="goReportPage.do?seq="+seq;
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
	

	
	location.href = "reportList.do?choice=" + choice + "&search=" + search;
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
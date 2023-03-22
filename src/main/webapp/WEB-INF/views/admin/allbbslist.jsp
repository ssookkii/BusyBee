<%@page import="mul.cam.a.dto.starDto"%>
<%@page import="mul.cam.a.dto.UserDto"%>
<%@page import="mul.cam.a.util.Utility"%>
<%@page import="mul.cam.a.dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩 JavaScript 및 의존성 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.min.js"></script>


<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Dongle:wght@300;400;700&family=Jua&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<script type="text/javascript" src="./jquery/jquery.twbsPagination.min.js"></script>

<!-- 팝업  -->
<style type="text/css">
*{margin:0; padding:0;}
	a{text-decoration:none;}
	.wrap{padding:10px;}
	
	.btn_open{font-weight:bold; margin:5px; padding:4px 6px; }
	.pop_wrap{position:fixed; top:0; left:0; right:0; bottom:0; background:rgba(0,0,0,.5); font-size:0; text-align:center;}
	.pop_wrap:after{display:inline-block; height:100%; vertical-align:middle; content:'';}
	.pop_wrap .pop_inner{display:inline-block; padding:20px 30px; background:#fff; width:200px; vertical-align:middle; font-size:15px;}
</style>

<style type="text/css">
#bbs{
	text-align: center;	
}

.nav{
text-align: center;
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

<!-- 드롭다운 -->


</head>
<body>

</head>
<body>

<%
UserDto login = (UserDto)session.getAttribute("login");
List<BbsDto> list = (List<BbsDto>)request.getAttribute("bbslist");
int pageBbs = (Integer)request.getAttribute("pageBbs");
int pageNumber = (Integer)request.getAttribute("pageNumber");
String choice = (String)request.getAttribute("choice");
String search = (String)request.getAttribute("search");
String category = (String)request.getAttribute("category");
%>

<br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold; font-size: 48px;">&nbsp;&nbsp;&nbsp;전체글</h1>
<br><br>


<div align="center">
<nav class="navbar navbar-expand-lg navbar-dark bg-warning" style="width: 1000px">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarColor01">
      <ul class="navbar-nav me-auto">
      </ul>
           <div class="d-flex" style="font-size: 13px" >
	      	<select id="choice" style="color:black">
				<option value="" selected="selected">검색</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="writer">작성자</option>
			</select>
	        <input class="form-control me-sm-2" type="text" placeholder="Search" id="search" class="form-control"  value="<%=search %>" style="font-size: 13px">
	        <button type="button" onclick="searchBtn()" class="btn btn-danger" style="width: 55px; height: 30px; font-size: 13px; ">검색</button>
      </div>
    </div>
  </div>
</nav>
</div>




<div align="center">


<input type="hidden" id="id" value='<%=login.getId()%>'>

<table id="bbs" class="table table-hover" style="width: 1000px; font-size: 12px " >
<col width="100"><col width="800"><col width="100"><col width="180"><col width="100">
<thead class="table-warning">
<tr>
	<th>번호</th><th>제목</th><th>조회수</th><th>작성자</th><th>첨부파일</th>
</tr>
</thead>
<tbody>

<%
if(list == null || list.size() == 0){
	%>
	<tr>
		<td colspan="7">작성된 글이 없습니다</td>
	</tr>
	<%
}else{
	
	for(int i = 0;i < list.size(); i++)
	{
		BbsDto dto = list.get(i);
		%>
		<tr>
					<th style="vertical-align: middle"><%=i + 1 + (pageNumber * 10) %></th>
	
				<td style="text-align: left;">
					<%=Utility.arrow(dto.getDepth()) %>
					<a href="bbsdetail.do?&seq=<%=dto.getSeq() %>" style="text-decoration: none; color:#978c88;">
						<%=dto.getTitle() %>
					</a>
				</td>
			
			<td style="vertical-align: middle"><%=dto.getReadcount() %></td>
			<td style="vertical-align: middle"><%=dto.getId() %></td>
			
			<%
			if(dto.getFilename() != null){
			 %>
				<td><i class="fa fa-file"></i></td>
			<%
			} else{
				%>
				<td></td>
				<%
			}
			%>
		</tr>
		<%
	}
}
%>

</tbody>
</table>


<div class="container">
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination" style="justify-content:center"></ul>
    </nav>
</div>

</div>

  
<script type="text/javascript">
let search = "<%=search %>";
console.log("search = " + search);
if(search != ""){
	let obj = document.getElementById("choice");
	obj.value = "<%=choice %>";
	obj.setAttribute("selected", "selected");
}
function goPage( pageNumber ) {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	location.href = "allbbslist.do?choice=" + choice + "&search=" + search + "&pageNumber=" + pageNumber;	
}
function searchBtn() {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	let category = document.getElementById('category').value;
	let group_code = document.getElementById("group_code").value;
	let org = document.getElementById("org").value;
	
//	alert(category);
	
	/* if(choice == ""){
		alert("카테고리를 선택해 주십시오");
		return;
	} */
	/* 
	if(search.trim() == ""){
		alert("검색어를 선택해 주십시오");
		return;
	} */
	
	location.href = "allbbslist.do?choice=" + choice + "&search=" + search;
}
$('#pagination').twbsPagination({
	startPage:<%=pageNumber+1 %>,
    totalPages: <%=pageBbs %>,
    visiblePages: 10,
    first:'<span srid-hidden="true">«</span>',
    prev:"이전",
    next:"다음",
    last:'<span srid-hidden="true">»</span>',
    initiateStartPageClick:false,		// onPageClick 자동실행되지 않도록
    onPageClick: function (event, page) {
    	let choice = document.getElementById('choice').value;
    	let search = document.getElementById('search').value;
    	
    	location.href = "allbbslist.do?choice=" + choice + "&search=" + search + "&pageNumber=" + (page-1);
    }
})
</script>


</body>
</html>
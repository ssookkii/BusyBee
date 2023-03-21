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

<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>


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

<style type="text/css">
#bbs{
	text-align: center;
	vertical-align: bo;
}
.body{
	font-family: 'Black Han Sans', sans-serif;
	font-family: 'Dongle', sans-serif;
	font-family: 'Jua', sans-serif;
	font-family: 'Noto Sans KR', sans-serif;
} 
</style>

<style type="text/css">
</style>

</head>
<body>

<%
List<starDto> starlist = (List<starDto>)request.getAttribute("starlist");
UserDto login = (UserDto)session.getAttribute("login");
List<BbsDto> list = (List<BbsDto>)request.getAttribute("bbslist");
int pageBbs = (Integer)request.getAttribute("pageBbs");
int pageNumber = (Integer)request.getAttribute("pageNumber");
String choice = (String)request.getAttribute("choice");
String search = (String)request.getAttribute("search");
String category = (String)request.getAttribute("category");
String group_code = (String)session.getAttribute("group_code");
String org = (String)session.getAttribute("org");
%>

<input type="hidden" id="org" value="<%=org %>">
<input type="hidden" id="group_code" value="<%=group_code %>">

<br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold">&nbsp;&nbsp;&nbsp;즐겨찾기</h1>
<small class="text-muted" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;즐겨찾기 한 글입니다.</small>
<br><br>

<div align="center">
<nav id="navbar" class="navbar navbar-expand-lg navbar-dark bg-warning" style="width: 1000px">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarColor01">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link" onclick="beforelist()" style="font-size: 15px">게시판으로</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" onclick="mybbslist()" style="font-size: 15px">내가 작성한 글</a>
        </li>
     <!--   <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" style="font-size: 15px" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">그룹 선택</a>
          <div id="groupdrop" class="dropdown-menu">
            <h3 id="nogroup"></h3>
          </div>
        </li> -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" style="font-size: 15px" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">게시판 선택</a>
          <div class="dropdown-menu">
            <a class="dropdown-item" onclick="categorybtn()">전체글</a>
            <a class="dropdown-item" onclick="categorybtn1()">공지사항</a>
            <a class="dropdown-item" onclick="categorybtn2()">일반게시글</a>
            <a class="dropdown-item" onclick="categorybtn3()">자료게시글</a>
            <a class="dropdown-item" onclick="categorybtn4()">회의록</a>
          </div>
        </li>
      </ul>
      <div class="d-flex" >
	      	<select id="choice" style="color:black">
				<option value="" selected="selected">검색</option>
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="writer">작성자</option>
			</select>
	        <input class="form-control me-sm-2" type="text" placeholder="Search" id="search" class="form-control"  value="<%=search %>">
	        <button type="button" onclick="searchBtn()" class="btn btn-light">검색</button>
      </div>
    </div>
  </div>
</nav>
</div>

<div align="center">

<input type="hidden" id="id" value='<%=login.getId()%>'>
<input type="hidden" id="category" value="<%=category %>">
<input type="hidden" id="login" value="<%=login.getId() %>">

<table id="bbs" class="table table-hover" style="width: 1000px">
<col width="70"><col width="150"><col width="70"><col width="150"><col width="400"><col width="100"><col width="150"><col width="70">
<thead class="table-warning">
<tr>
	<th>즐겨찾기</th><th>분류</th><th>번호</th><th>그룹명</th><th>제목</th><th>조회수</th><th>작성자</th><th>첨부파일</th>
</tr>
</thead>
<tbody>

<%
if(list == null || list.size() == 0){
	%>
	<tr>
		<td colspan="8">작성한 글이 없습니다</td>
	</tr>
	<%
}else{
	
	for(int i = 0;i < list.size(); i++)
	{
		BbsDto dto = list.get(i);
		boolean starcheck = false;
		%>
		<tr>
		<%
			if(dto.getDel() == 0){
				if(starlist != null){
					for(int j = 0; j < starlist.size(); j++)
					{
						starDto stardto = starlist.get(j);
						
						if(dto.getSeq() == stardto.getSeq()){
							starcheck = true;
						}
						
						if(starcheck){	
							%>
							<th>
							<a href="#pop_info_2" class="btn_open">
								<button onclick="star2(<%=dto.getSeq() %>)" class="btn btn-danger">
									<i class="fa fa-star"></i>
								</button>
							</a>
							</th>
							<%
							break;
						}
					}
					if(starcheck == false){	
					%>
					<th>
					<a href="#pop_info_1" class="btn_open">
						<button onclick="star(<%=dto.getSeq() %>)" class="btn btn-warning">
							<i class="fa fa-star-o"></i>
						</button>
					</a>
					</th>
					<%
					}
				} else{
					%>
					<th>
					<a href="#pop_info_1" class="btn_open">
						<button onclick="star(<%=dto.getSeq() %>)" class="btn btn-warning">
							<i class="fa fa-star-o"></i>
						</button>
					</a>
					</th>
					<%
				}
			}else if(dto.getDel() == 1){
				%>
				<th></th>
				<%
			}
			starcheck = false;
			%>
			
			<th><%=dto.getCategory()%></th>
			<th><%=i + 1 + (pageNumber * 10) %></th>
			<td><%=dto.getOrg() %></td>
			<%
			
				%>			
				<td style="text-align: left">
					<%=Utility.arrow(dto.getDepth()) %>
					<a href="bbsdetail.do?&seq=<%=dto.getSeq() %>">
						<%=dto.getTitle() %>
					</a>
				</td>			
			<td><%=dto.getReadcount() %></td>
			<td><%=dto.getId() %></td>
			
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

<br>


<div class="container">
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination" style="justify-content:center"></ul>
    </nav>
</div>

<button class="btn btn-warning" onclick="bbswrite()">글쓰기</button>

</div>

<div id="pop_info_1" class="pop_wrap" style="display:none;">
  <div class="pop_inner">
    <p class="dsc">즐겨찾기에 추가하시겠습니까?</p>
    <button id="staradd" type="button" class="btn btn-warning btn_close">예</button>
    <button type="button" class="btn btn-warning btn_close">아니오</button>
  </div>
</div>

<div id="pop_info_2" class="pop_wrap" style="display:none;">
  <div class="pop_inner">
    <p class="dsc">즐겨찾기를 삭제하시겠습니까?</p>
    <button id="stardelete" type="button" class="btn btn-warning btn_close">예</button>
    <button type="button" class="btn btn-warning btn_close">아니오</button>
  </div>
</div>
  
  
<script type="text/javascript">
let group_code = document.getElementById("group_code").value;
let org = document.getElementById("org").value;
function beforelist() {
	location.href="bbslist.do?group_code=" + group_code + "&org=" + org;
}
function categorybtn() {
	location.href="mystarlist.do";
}
function categorybtn1() {
	location.href="mystarlist.do?category=공지사항";
}
function categorybtn2() {
	location.href="mystarlist.do?category=일반게시글";
}
function categorybtn3() {
	location.href="mystarlist.do?category=자료게시글";
}
function categorybtn4() {
	location.href="mystarlist.do?category=회의록";
}
function bbslist(){
//	alert("bbslist작동합니다");
	location.href="login.do";
}
function mybbslist(){
//	alert("mybbslist작동합니다");
	location.href="mybbslist.do";
}
function bbswrite() {
//	alert("작동합니다")
	location.href = "bbswrite.do";
}
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
	let category = document.getElementById('category').value;
	
	location.href = "mybbslist.do?choice=" + choice + "&search=" + search + "&pageNumber=" + pageNumber + "&category=" + category;	
}
function searchBtn() {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	let category = document.getElementById('category').value;
	
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
	
	location.href = "mybbslist.do?choice=" + choice + "&search=" + search + "&category=" + category;
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
    	let category = document.getElementById('category').value;
    	
    	location.href = "mybbslist.do?choice=" + choice + "&search=" + search  + "&category=" + category + "&pageNumber=" + (page-1);
    //	location.href = "bbslist.do?choice=null&search=null" + "&category=" + category + "&pageNumber=" + (page-1);
    }
})
function star(seq) {
	let star = seq
	$('#staradd').val(star);
//	alert("add작동합니다");
}
function star2(seq) {
	let star2 = seq
	$('#stardelete').val(star2);
//	alert("delete작동합니다");
}
// 즐겨찾기 추가
$('#staradd').click(function() {
	let seq = document.getElementById('staradd').value;
//	alert(staradd);
	
	let group_code = document.getElementById("group_code").value;
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	let category = document.getElementById('category').value;
	let id = document.getElementById('login').value;
	let pageNumber = <%=pageNumber%>;
	
	$.ajax({
		url:"http://localhost:8090/BusyBee/staradd.do",
		type:"get",
		async:false,
		data:{ "seq": seq, "id":id },
		success:function(msg){
//			alert("ajax 작동");
			location.href = "mystarlist.do?choice=" + choice + "&search=" + search  + "&category=" + category + "&pageNumber=" + pageNumber;
		},
		error:function(){
			alert('error');	
		}		
	});	
});
	
// 즐겨찾기 삭제
$('#stardelete').click(function() {
	let seq = document.getElementById('stardelete').value;
//	alert(stardelete);
	
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	let category = document.getElementById('category').value;
	let id = document.getElementById('login').value;
	let pageNumber = <%=pageNumber%>;
	$.ajax({
		url:"http://localhost:8090/BusyBee/stardelete.do",
		type:"get",
		async:false,
		data:{ "seq": seq, "id":id },
		success:function(msg){
//			alert("ajax 작동");
			location.href = "mystarlist.do?choice=" + choice + "&search=" + search  + "&category=" + category + "&pageNumber=" + pageNumber;
		},
		error:function(){
			alert('error');	
		}		
	});	
});
//	location.href = "staradd.do?seq=" + seq + "&id=" + id;
	
</script>

<!-- 팝업 -->
<script type="text/javascript">
var target = document.querySelectorAll('.btn_open');
var btnPopClose = document.querySelectorAll('.pop_wrap .btn_close');
var targetID;
for(var i = 0; i < target.length; i++){
  target[i].addEventListener('click', function(){
    targetID = this.getAttribute('href');
    document.querySelector(targetID).style.display = 'block';
  });
}
for(var j = 0; j < target.length; j++){
  btnPopClose[j].addEventListener('click', function(){
    this.parentNode.parentNode.style.display = 'none';
  });
}
</script>

<script type="text/javascript">
$(document).ready(function(){
	var group1;
	var group2;
	var count = 1;
	
	// Leader
	$.ajax({
		url:"selectGroup1.do",
		type:"get",
		data:{"id":$("#id").val()},
		async:false,
		success:function(data) {
			if(data!=null && data!="") {
				var groupdrop = '';
				$.each(data, function(i){
					groupdrop += "<a class='dropdown-item' onclick=\"golist('"+ data[i].group_code + "', '" + data[i].group_name + "')\">" + data[i].group_name + "</a>"
					count++;
				});
				$("#groupdrop").append(groupdrop);
				group1 = true;
				groupCheck();
			} else if (data==null || data=="") {
				group1 = false;
				groupCheck();
			}
		},	
		error:function(){
			alert('error');
		}
	});
	// Member
	$.ajax({
		url:"selectGroup2.do",
		type:"get",
		data:{"id":$("#id").val()},
		success:function(data) {
			if(data!=null && data!="") {
				var groupdrop = '';
				$.each(data, function(i){
					groupdrop += "<a class='dropdown-item' onclick=\"golist('"+ data[i].group_code + "', '" + data[i].group_name + "')\">" + data[i].group_name + "</a>"
					count++;
				});
				$("#groupdrop").append(groupdrop);
				group2 = true;
				groupCheck();
			} else if (data==null || data=="") {
				group2 = false;
				groupCheck();
			}
		},
		error:function(){
			alert('error');
		}
	});
	
	function groupCheck(){
		
/* 		alert("group1 =" + group1);
		alert("group2 =" + group2);
		 */
		if(group1=="undefined" || group2=="undefined") {
			return;
		}
		
		if(group1==false && group2==false) {
/* 			alert("group1* =" + group1);
			alert("group2* =" + group2); */
			$("#nogroup").text('가입한 그룹이 없습니다.');	
		}
	}
	
	
});
function golist(group_code, group_name) {
//	alert('golist');
	location.href='bbssession.do?group_code=' + group_code + '&org=' + group_name;
}
</script>


</body>
</html>
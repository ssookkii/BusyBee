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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

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
	vertical-align: bo;
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

<h1>즐겨찾기</h1>
<br><br>

<div align="center">

<div class="panel-body">
  	<div class="form-inline" >
	    <input type="button" id="bbslist"  onclick="bbslist()" value="그룹선택" class="btn btn-primary"/>
  	</div>
  	<br>
  	
    <div class="form-inline" >
  		<input type="button" id="categorybtn"  onclick="categorybtn()" value="전체글" class="btn btn-primary"/>
        <input type="button" id="categorybtn1"  onclick="categorybtn1()" value="공지사항" class="btn btn-primary"/>
        <input type="button" id="categorybtn2"  onclick="categorybtn2()" value="일반게시글" class="btn btn-primary"/>
        <input type="button" id="categorybtn3"  onclick="categorybtn3()" value="자료게시글" class="btn btn-primary"/>
        <input type="button" id="categorybtn4"  onclick="categorybtn4()" value="회의록" class="btn btn-primary"/>
    </div>
    <br>
    
    <div class="form-inline">
         <input type="button" id="bbslist"  onclick="beforelist()" value="게시판으로" class="btn btn-primary"/>
         <input type="button" id="mybbslist"  onclick="mybbslist()" value="내가작성한글" class="btn btn-primary"/>
    </div>
    <br><br>
</div>

<input type="hidden" id="category" value="<%=category %>">
<input type="hidden" id="login" value="<%=login.getId() %>">
<table id="bbs" class="table table-hover table-sm" style="width: 1200px">
<col width="70"><col width="150"><col width="70"><col width="150"><col width="600"><col width="100"><col width="150"><col width="70">
<thead class="thead-dark">
<tr>
	<th>즐겨찾기</th><th>분류</th><th>번호</th><th>그룹명</th><th>제목</th><th>조회수</th><th>작성자</th><th>첨부파일</th>
</tr>
</thead>
<tbody>

<%
if(list == null || list.size() == 0){
	%>
	<tr>
		<td colspan="4">작성한 글이 없습니다</td>
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
								<button onclick="star2(<%=dto.getSeq() %>)" class="btn btn-primary">
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
						<button onclick="star(<%=dto.getSeq() %>)" class="btn btn-primary">
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
						<button onclick="star(<%=dto.getSeq() %>)" class="btn btn-primary">
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
			}else{
			%>
				<td><i class="fa fa-file-o"></i></td>
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


<br><br>
<div class="form-row align-items-center d-flex justify-content-center align-items-center container">
<select id="choice">
	<option value="">검색</option>
	<option value="title">제목</option>
	<option value="content">내용</option>
	<option value="org">그룹</option>
</select>

<div class="col-sm-2 my-1">
	<input type="text" id="search" class="form-control"  value="<%=search %>">
</div>

<button type="button" onclick="searchBtn()" class="btn btn-primary">검색</button>
</div>


<button onclick="bbswrite()">글쓰기</button>

</div>

<div id="pop_info_1" class="pop_wrap" style="display:none;">
  <div class="pop_inner">
    <p class="dsc">즐겨찾기에 추가하시겠습니까?</p>
    <button id="staradd" type="button" class="btn btn-primary btn_close">예</button>
    <button type="button" class="btn btn-primary btn_close">아니오</button>
  </div>
</div>

<div id="pop_info_2" class="pop_wrap" style="display:none;">
  <div class="pop_inner">
    <p class="dsc">즐겨찾기를 삭제하시겠습니까?</p>
    <button id="stardelete" type="button" class="btn btn-primary btn_close">예</button>
    <button type="button" class="btn btn-primary btn_close">아니오</button>
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
	let category = document.getElementById("categorybtn1").value;
	location.href="mystarlist.do?category=" + category;
}

function categorybtn2() {
	let category = document.getElementById("categorybtn2").value;
	location.href="mystarlist.do?category=" + category;
}

function categorybtn3() {
	let category = document.getElementById("categorybtn3").value;
	location.href="mystarlist.do?category=" + category;
}

function categorybtn4() {
	let category = document.getElementById("categorybtn4").value;
	location.href="mystarlist.do?category=" + category;
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
		url:"http://localhost:8090/busyBee/staradd.do",
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
		url:"http://localhost:8090/busyBee/stardelete.do",
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




</body>
</html>
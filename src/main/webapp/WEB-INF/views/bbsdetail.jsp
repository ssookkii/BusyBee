
<%@page import="mul.cam.a.dto.BbsComment"%>
<%@page import="mul.cam.a.dto.UserDto"%>
<%@page import="mul.cam.a.dto.MemberDto"%>
<%@page import="mul.cam.a.dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>




</head>
<body>

<%	
	BbsDto dto = (BbsDto)request.getAttribute("bbsdto");
%> 

<h1>상세 글보기</h1>

<hr>

<div id="app" class="container">


<table class="table table-sm">
<col width="100px"><col width="500px">
<tr>
	<th>모임명</th>
	<td>
		<input value="<%=dto.getOrg() %>" type="text" class="form-control form-control-lg" readonly="readonly">
	</td>
</tr>
<tr>
	<th>아이디</th>
	<td>
		<input value="<%=dto.getId() %>" type="text" class="form-control form-control-lg" readonly="readonly">
	</td>
</tr>
<tr>
	<th class="align-middle">제목</th>
	<td>
		<input value="<%=dto.getTitle() %>" type="text" class="form-control form-control-lg" readonly="readonly">
	</td>
</tr>
<tr>
	<th>파일</th>
	<td>
		<input value="<%=dto.getFilename() %>" type="text" class="form-control form-control-lg" readonly="readonly">
		<br>
		<input type="button" value="파일 다운로드" class="btn btn-primary"
		onclick="filedown(<%=dto.getSeq() %>, '<%=dto.getNewfilename() %>', '<%=dto.getFilename() %>')">
	</td>
</tr>
<tr>
	<th>카테고리</th>
	<td>
		<input value="<%=dto.getCategory() %>" type="text" class="form-control form-control-lg" readonly="readonly">
	</td>
</tr>
<tr>	
	<td colspan="2">
		<textarea rows="18" class="form-control" readonly="readonly"><%=dto.getContent() %></textarea>
	</td>
</tr>


</table>

<br>

<button type="button" class="btn btn-primary" onclick="bbslist()">글목록</button>

<input type="hidden" id="org" value="<%=dto.getOrg() %>">
<input type="hidden" id="group_code" value="<%=dto.getGroup_code() %>">
<input type="hidden" id="category" value="<%=dto.getCategory() %>">

<%
UserDto login = (UserDto)session.getAttribute("login");
if(dto.getId().equals(login.getId())){
	%>
	<button type="button" class="btn btn-primary" onclick="updateBbs(<%=dto.getSeq() %>)">수정</button>
	
	<button type="button" class="btn btn-primary" onclick="deleteBbs(<%=dto.getSeq() %>)">삭제</button>
	
	<br>
	
	<button type="button" class="btn btn-primary" onclick="reportBbs(<%=dto.getSeq() %>)">신고하기</button>
	<%
}
%>

</div>

<form name="file_down" action="filedownload.do" method="post">
	<input type="hidden" name="seq">
	<input type="hidden" name="newfilename">
	<input type="hidden" name="filename">
</form>

<script type="text/javascript">
let category = document.getElementById('category').value;
let group_code = document.getElementById("group_code").value;
let org = document.getElementById("org").value;

function bbslist(){
	location.href= "bbslist.do?group_code=" + group_code + "&org=" + org;
}

function updateBbs( seq ) {
	location.href = "bbsupdate.do?seq=" + seq;
}

function deleteBbs( seq ) {
	location.href = "bbsdelete.do?seq=" + seq;  // update del=1
}

function reportBbs( seq ) {
	location.href = "reportBbs.do?seq=" + seq;
}

function filedown(seq, newfilename, filename){
	document.file_down.seq.value = seq;
	document.file_down.newfilename.value = newfilename;
	document.file_down.filename.value = filename;
	document.file_down.submit();
}
</script>

<br><br>
<!-- 댓글 -->


<div id="app" class="container">

<form action="commentwriteAf.do" method="post">
<input type="hidden" name="seq" value="<%=dto.getSeq() %>">
<input type="hidden" name="id" value="<%=login.getId() %>">




<table>
<col width="1500"><col width="150">
<tr>
	<td>comment</td>
	<td style="paddng-left: 30px">올리기<td>
</tr>
<tr>
	<td>
		<textarea rows="3" class="form-control" name="content"></textarea>
	</td>
	<td style="paddng-left: 30px">
		<button type="submit" class="btn btn-primary btn-block p-4">완료</button>
	</td>
</tr>
</table>
</form>

<br><br>

<table class="table">
<col width="500"><col width="500"><col width="100">
<tbody id="tbody">

</tbody>
</table>


</div>

<!-- 댓글 -->
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		url:"./commentList.do",
		type:"get",
		data:{ "seq":<%=dto.getSeq() %> },
		success:function(list){
		//	alert('success');
		//	alert(JSON.stringify(list[0].id));

			$("#tbody").html("");
			
			$.each(list, function(index, item){
				let str = "<tr class='table-info'>" 
					+ "<td>작성자:" + item.id + "</td>"
					+ "<td>작성일:" + item.wdate + "</td>";
				if(item.id == "<%=login.getId()%>") {
					str += "<td>"
						+ "<button type='button' class='btn btn-primary' onclick='deleteBbscomment(" + item.seq + "," + item.anseq + ")'>삭제</button>"
						+"</td>";
				}
				str += '</tr>'
					+ '<tr>'
					+ '<tr>'
					+ 	"<td colspan='2'>" + item.content + "</td>"
					+ '</tr>';
				$("#tbody").append(str);
			});
		},
		error:function(){
			alert('error');	
		}		
	});	
});
function deleteBbscomment( seq, anseq ) {
	location.href = "deleteBbscomment.do?seq=" + seq + "&anseq=" + anseq;
}

</script>

</body>
</html>





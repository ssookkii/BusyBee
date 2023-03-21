
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

<link rel="stylesheet" href="https://bootswatch.com/5/minty/bootstrap.min.css"> 

<style type="text/css">


/* 신고 모달창 */
    .modal {
        position: absolute;
        top: 0;
        left: 0;

        width: 100%;
        height: 100%;

        display: none;

        background-color: rgba(0, 0, 0, 0.8);
        

      }

      .modal.show {
        display: block;
      }

      .modal_body {
        position: absolute;
        top: 50%;
        left: 50%;

        width: 800px;
        height: 600px;

        /* padding: 40px; */

        /* text-align: center; */

        background-color: rgb(255, 255, 255);
        border-radius: 10px;
        box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);

        transform: translateX(-50%) translateY(-50%);
      }
      .m_head{
        height: 10%;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        background-color:#FFCE67;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        color: white;
      }
      .m_body{
        height: 80%;
        padding: 20px;
      }
      .m_footer{
        height: 10%;
        padding: 15px;
        background-color:#FFCE67;
        border-bottom-left-radius: 10px;
        border-bottom-right-radius: 10px;
        display: flex;
        justify-content: end;
      }
      .modal_title{
        font-size: 24px;
        color: gray;
        font-weight: 900;
        
      }
      .close_btn{
        font-size: 20px;
        color: rgb(139, 139, 139);
        font-weight: 900;
        cursor: pointer;
      }
      .modal_label{
        padding-top: 20px;
        font-size: 20px;
        font-weight: 900;
      }
      .input_box{
        width: 500px;
        border: 1px solid rgb(189, 189, 189);
        height: 30px;
      }
      .modal_btn{
        width: 80px;
        height: 30px;
        border-radius: 5px;
        text-align: center;
        font-size: 14px;
        font-weight: bolder;
        padding-top: 5px;
        margin-left: 5px;
        font-family: sans-serif;
      }
      .cancle{
        background-color: #FFCE67;
        color: black;
        cursor: pointer;
        
      }
      .save{
        background-color: #FF7851;
        color: white;
        cursor: pointer;
        
      }
</style>


</head>
<body>

<%	
	BbsDto dto = (BbsDto)request.getAttribute("bbsdto");
%> 

<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold">&nbsp;&nbsp;&nbsp;상세글 보기</h1>
<br><br>

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
		<% 	if(dto.getFilename() != null){ %>
				<input value="<%=dto.getFilename() %>" type="text" class="form-control form-control-lg" readonly="readonly">
		<%	}else{ %>
				<input value="" type="text" class="form-control form-control-lg" readonly="readonly">
		<%	} %>
		<br>
		<% 	if(dto.getFilename() != null){ %>
				<input type="button" value="파일 다운로드" class="btn btn-warning"
				onclick="filedown(<%=dto.getSeq() %>, '<%=dto.getNewfilename() %>', '<%=dto.getFilename() %>')">
		<%	}else{ %>
				
		<%	} %>
		
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



<input type="hidden" id="org" value="<%=dto.getOrg() %>">
<input type="hidden" id="group_code" value="<%=dto.getGroup_code() %>">
<input type="hidden" id="category" value="<%=dto.getCategory() %>">

	<button type="button" class="btn btn-outline-warning" onclick="bbslist()">글목록</button>
	<button type="button" id="reportBtn" class="btn btn-danger">신고</button>
<%
UserDto login = (UserDto)session.getAttribute("login");
if(dto.getId().equals(login.getId())){
	%>
	<div>
	<button type="button" class="btn btn-warning" onclick="updateBbs(<%=dto.getSeq() %>)">수정</button>
	<button type="button" class="btn btn-danger" onclick="deleteBbs(<%=dto.getSeq() %>)">삭제</button>
	</div>
	
	<br>
	
	<%
}
%>



</div>

<!-- 모달창 -->
<div class="modal" id="modal">
  <div class="modal_body">
    <div class="m_head">
      <div class="modal_title">신고</div>
      <div class="close_btn" id="close_btn">X</div>
    </div>
    <form id="reportForm">
    <div class="m_body">
    <input type="hidden" id="reporter_id" value="<%=login.getId()%>">
    <input type="hidden" id="report_seq" value="<%=dto.getSeq()%>">
    
      <div class="modal_label">신고 대상 ID</div>
      <input type="text" class="input_box" id="reported_id" value="<%=dto.getId()%>" readonly="readonly">
      <div class="modal_label">신고 유형</div>
     
     <fieldset class="form-group">
      <div class="form-check">
        <input style="font-size: 18px;" class="form-check-input" type="radio" name="optionsRadios" id="report_type" value="불법/유해 정보" checked>
        <label style="font-size: 20px;" class="form-check-label" for="optionsRadios1">
불법/유해 정보        
</label>
      </div>
      <div class="form-check">
        <input style="font-size: 18px;" class="form-check-input" type="radio" name="optionsRadios" id="report_type" value="욕설/불쾌한 표현">
        <label style="font-size: 20px;" class="form-check-label" for="optionsRadios2">
		욕설/불쾌한 표현       
		</label>
      </div>
      <div class="form-check disabled">
        <input style="font-size: 18px;" class="form-check-input" type="radio" name="optionsRadios" id="report_type" value="스팸/홍보">
        <label style="font-size: 20px;" class="form-check-label" for="optionsRadios3">
          스팸/홍보
        </label>
      </div>
    </fieldset>
    
      
      <br>
   
   	<div class="modal_label">사유</div>  
	<textarea style="font-size: 16px;" maxlength="200" rows="7" id="report_content" class="form-control" placeholder="내용기입"></textarea>
    </div>
    <div class="m_footer">
      <div class="modal_btn cancle" id="close_btn">취소</div>
      <div class="modal_btn save" id="saveBtn">신고</div>
    </div>
    </form>
  </div>
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
		<button type="submit" class="btn btn-warning btn-block p-4">완료</button>
	</td>
</tr>
</table>
</form>

<br><br>

<table class="table table-hover">
<col width="500"><col width="500"><col width="100">
<tbody id="tbody">

</tbody>
</table>


</div>

<!-- 댓글 -->
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		url:"commentList.do",
		type:"get",
		data:{ "seq":<%=dto.getSeq() %> },
		success:function(list){
		//	alert('success');
		//	alert(JSON.stringify(list[0].id));

			$("#tbody").html("");
			
			$.each(list, function(index, item){
				let str = "<tr class='table-warning'>" 
					+ "<td>작성자:" + item.id + "</td>"
					+ "<td>작성일:" + item.wdate + "</td>";
				if(item.id == "<%=login.getId()%>") {
					str += "<td>"
						+ "<button type='button' class='btn btn-danger' onclick='deleteBbscomment(" + item.seq + "," + item.anseq + ")'>삭제</button>"
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

//모달

//click on 라벨 추가 모달 열기
$(document).on('click', '#reportBtn', function (e) {
  console.log("click event");
  $('#modal').fadeIn();

});

// 모달 닫기
$(document).on('click', '#close_btn', function (e) {
  console.log("click event");
  $('#modal').fadeOut();

});





// 모달 신고 제출
	$(document).on('click', '#saveBtn', function (e) {
	
	var reporter_id = $("#reporter_id").val();
	var reported_id = $("#reported_id").val();
	var report_content = $("#report_content").val();
	var report_seq = $("#report_seq").val();
	var report_type = $("#report_type:checked").val();

	
	// 리포트 모달 값
    var reportData = {
		     "reporter_id" : reporter_id,
			  "reported_id": reported_id,
			  "report_seq": report_seq,
			 "report_content": report_content,
			  "report_type": report_type
		    };
	
	var params = $("#reportForm").serialize();
	console.log(report_content);
	$.ajax({
	type : "post",
	url : "reportSubmit.do",
	dataType : "json",
	data : reportData,
	success : function(data) {
		
	

	console.log(JSON.stringify(data));
	alert('신고를 완료했습니다.');
	$('#modal').fadeOut();

	},
	error: function(){
	console.log(error);

	}

	});
});

</script>

</body>
</html>





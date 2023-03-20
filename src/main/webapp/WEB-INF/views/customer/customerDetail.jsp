<%@page import="mul.cam.a.dto.UserDto"%>
<%@page import="mul.cam.a.dto.MemberDto"%>
<%@page import="mul.cam.a.dto.CustomerDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
UserDto login = (UserDto)session.getAttribute("login");
CustomerDto dto = (CustomerDto) request.getAttribute("dto");

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>



<style>

button{
font-size: 14px;
}


/* 신고 모달창 */


table{
font-size: 14px;

}

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



	<div id="app" class="container">

		<table class="table table-hover">
			<colgroup>
				<col style="width: 150px" />
				<col style="width: 500px" />
			</colgroup>
			

			<%if(dto.isSecret()){
			
			if(dto.getId().equals(login.getId()) || login.getAuth()==3){
				%>

			<tr class="table-light">
				<th scope="col">작성자</th>
				<td><%=dto.getId()%></td>
			</tr>

			<tr class="table-light">
				<th scope="col">작성일</th>
				<td><%=dto.getWdate()%></td>
			</tr>
			<tr class="table-light">
				<th scope="col">첨부파일</th>
				<%
				if (!dto.getFilename().equals("") && dto.getFilename() != null) {
				%>
				<td><input class="btn btn-warning" type="button" value="다운로드"
					onclick="filedown(<%=dto.getSeq()%>, '<%=dto.getNewfilename()%>', '<%=dto.getFilename()%>')">
				</td>

				<%
				}
				%>
			</tr>

			<tr class="table-light">
				<td colspan="2" style="font-size: 22px; font-weight: bold;"><%=dto.getTitle()%></td>
			</tr>
			<tr class="table-light">
				<td colspan="2" style="background-color: white;"><pre
						style="font-size: 20px; font-family: 고딕, arial; background-color: white"><%=dto.getContent()%></pre>
				</td>
			</tr>
		</table>


		<br>

		<button type="button" class="btn btn-warning"
			onclick="location.href='customer.do'">글목록</button>


		<%if(dto.getId().equals(login.getId()) || login.getAuth() == 3 ){
			
			%>		
		<button type="button" class="btn btn-warning"
		onclick="customerUpdate(<%=dto.getSeq()%>)">수정</button>

		<button type="button" class="btn btn-warning"
			onclick="customerDelete(<%=dto.getRef()%>)">삭제</button>
			<%
		}
		
		%>

		<%if(login.getAuth()==3){
			
		%>
		<button type="button" class="btn btn-warning"
			onclick="customerAnswer(<%=dto.getSeq()%>)">답변</button>
		<%
		}
		%>

	</div>

	<form name="file_down" action="filedownLoad.do" method="post">
		<input type="hidden" name="newfilename"> <input type="hidden"
			name="filename"> <input type="hidden" name="seq">
	</form>
	
					<% 
			}else{
				%>
				<p style="font-size: 30px; align-content: center;">권한이 없습니다.</p>
				<% 
			}
			
		}else{
		%>
<br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold">&nbsp;&nbsp;&nbsp;문의글</h1>
<small class="text-muted" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;무엇이든 물어보세요</small>
<br><br>
	<hr>

	<div id="app" class="container">

		<table class="table table-hover">
			<colgroup>
				<col style="width: 150px" />
				<col style="width: 500px" />
			</colgroup>
				<tr class="table-light">
				<th>제목</th>
				<td><%=dto.getTitle()%></td>
			</tr>
			
		<tr class="table-light">
				<th>작성자</th>
				<td><%=dto.getId()%></td>
			</tr>

			<tr class="table-light">
				<th>작성일</th>
				<td><%=dto.getWdate()%></td>
			</tr>
			<tr class="table-light">
				<th>첨부파일</th>
				<%
				if (!dto.getFilename().equals("") && dto.getFilename() != null) {
				%>
				<td><input type="button" value="다운로드"
					onclick="filedown(<%=dto.getSeq()%>, '<%=dto.getNewfilename()%>', '<%=dto.getFilename()%>')">
				</td>

				<%
				}
				%>
			</tr>

			<tr class="table-light">
				<td colspan="2" style="font-size: 22px; font-weight: bold;"><%=dto.getTitle()%></td>
			</tr>
			<tr class="table-light">
				<td colspan="2" style="background-color: white;"><pre
						style="font-size: 20px; font-family: 고딕, arial; background-color: white"><%=dto.getContent()%></pre>
				</td>
			</tr>
		</table>


		<br>

		<button type="button" class="btn btn-danger"
			onclick="location.href='customer.do'">글목록</button>
			

		<%if(dto.getId().equals(login.getId()) || login.getAuth() == 3 ){
			
			%>		
		<button type="button" class="btn btn-warning"
		onclick="customerUpdate(<%=dto.getSeq()%>)">수정</button>

		<button type="button" class="btn btn-warning"
			onclick="customerDelete(<%=dto.getRef()%>)">삭제</button>
			<%
		}
		
		%>


		<%if(login.getAuth()==3){
			
		%>
		<button type="button" class="btn btn-warning"
			onclick="customerAnswer(<%=dto.getSeq()%>)">답변</button>
		<%
		}
		%>
	<button type="button" id="reportBtn" class="btn btn-danger">신고</button>
	</div>

	<form name="file_down" action="filedownLoad.do" method="post">
		<input type="hidden" name="newfilename"> <input type="hidden"
			name="filename"> <input type="hidden" name="seq">
	</form>	
		<% 
		}
		

		%>


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
    

			

	<script type="text/javascript">
	
	// click on 라벨 추가 모달 열기
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

function customerUpdate(seq) {
	location.href="customerUpdate.do?seq="+seq;
}

function customerDelete(ref) {
	location.href="customerDelete.do?ref="+ref;
}

function customerAnswer(seq) {
	location.href="customerAnswer.do?seq="+seq;
}

function filedown(seq, newfilename, filename) {
	document.file_down.newfilename.value = newfilename;
	document.file_down.filename.value = filename;
	document.file_down.seq.value = seq;
	document.file_down.submit();
}

function readURL(input) {
	  if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    reader.onload = function(e) {
	      document.getElementById('preview').src = e.target.result;
	    };
	    reader.readAsDataURL(input.files[0]);
	  } else {
	    document.getElementById('preview').src = "";
	  }
	}



</script>

</body>
</html>
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




table{
font-size: 14px;

}

  
    </style>

</head>
<body>


<br></br><br></br>
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
				<th scope="col"  >작성자</th>
				<td > <%=dto.getId()%></td>
			</tr>

			<tr class="table-light" >
				<th scope="col" >작성일</th>
				<td ><%=dto.getWdate()%></td>
			</tr>
			<tr class="table-light">
				<th scope="col">첨부파일</th>
				<%
				if (!dto.getFilename().equals("") && dto.getFilename() != null) {
				%>
				<td ><input class="btn btn-warning" type="button" value="다운로드" style="font-size:12px;"
					onclick="filedown(<%=dto.getSeq()%>, '<%=dto.getNewfilename()%>', '<%=dto.getFilename()%>')">
				</td>

				<%
				}
				%>
			</tr>

			<tr class="table-light"  >
				<td  colspan="2" style="font-size: 22px; font-weight: bold; "><%=dto.getTitle()%></td>
			</tr>
			<tr class="table-light">
				<td colspan="2" style="background-color: white; height: 300px;"><pre
						style="font-size: 15px; background-color: rgb(255,250,234); height: 300px;"><%=dto.getContent()%></pre>
				</td>
			</tr>
		</table>


		<br>

		<button type="button" class="btn btn-warning"
			onclick="location.href='customer.do'" style="font-size: 13px;">글목록</button>


		<%if(dto.getId().equals(login.getId()) || login.getAuth() == 3 ){
			
			%>		
		<button type="button" class="btn btn-warning"
		onclick="customerUpdate(<%=dto.getSeq()%>)"  style="font-size: 13px;">수정</button>

		<button type="button" class="btn btn-warning"
			onclick="customerDelete(<%=dto.getRef()%>)"  style="font-size: 13px;" >삭제</button>
			<%
		}
		
		%>

		<%if(login.getAuth()==3){
			
		%>
		<button type="button" class="btn btn-warning"
			onclick="customerAnswer(<%=dto.getSeq()%>)"  style="font-size: 13px;" >답변</button>
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
	</div>

	<form name="file_down" action="filedownLoad.do" method="post">
		<input type="hidden" name="newfilename"> <input type="hidden"
			name="filename"> <input type="hidden" name="seq">
	</form>	
		<% 
		}
		

		%>


    

			

	<script type="text/javascript">
	
	

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
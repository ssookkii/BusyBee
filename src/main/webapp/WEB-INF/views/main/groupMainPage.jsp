<%@page import="mul.cam.a.dto.GroupDto"%>
<%@page import="mul.cam.a.util.Utility"%>
<%@page import="mul.cam.a.dto.UserDto"%>
<%@page import="mul.cam.a.dto.CustomerDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    
    UserDto login = (UserDto)session.getAttribute("login");
	GroupDto dto = (GroupDto)request.getAttribute("dto");
	String group_code = (String) request.getAttribute("group_code");
	String group_name = (String) request.getAttribute("group_name");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main View</title>

<!-- 부트스트랩 JavaScript 및 의존성 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.3/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.min.js"></script>

<!-- 원하는 글꼴 추가 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Dongle:wght@300;400;700&family=Jua&display=swap" rel="stylesheet">


<!-- Font Awesome 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">


<style>
body{
font-family: 'Black Han Sans', sans-serif;
font-family: 'Dongle', sans-serif;
font-family: 'Jua', sans-serif;
}
.flex-container {
  display: flex;
  justify-content: center;
  
}
.flex-item {
  margin: 15px;
  width: 500px;
  margin: 15px;
  text-align: center;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}
.card-body {
	width : 500px;
  height: 500px;
  font-size: 14px;
}
#notice{
  display: flex;
  justify-content: center;
  text-align: center;
  font-size: 15px;
  margin-top:40px;
  margin-left: auto;
  margin-right: auto;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}
.card-header{
font-size: 15px;
}
</style>

<!-- 부트스트랩 CSS -->
<link rel="stylesheet" href="https://bootswatch.com/5/minty/bootstrap.min.css">

</head>
<body>

<div id="notice" class="card border-light mb-3" style="max-width: 125rem;">
  <div class="card-header">공지사항</div>
  <div class="notice-card-body">
notice
  </div>
</div>

<div class="flex-container" >

<div class="flex-item card border-light mb-3" >
  <div class="card-header" ><a href="goBbslist.do?group_code=<%=group_code %>&group_name=<%=group_name %>">그룹 게시판</a></div>
  <div class="card-body">
<table>
    <thead>
    <tr>
        <th>제목</th>
        <th>작성자</th>
    </tr>
    </thead>
    <tbody id="bbsBody">
    </tbody>
</table>
  </div>
</div>

<div class="flex-item card border-light mb-3">
  <div class="card-header"><a href="goCalendar.do?group_code=<%=group_code %>&group_name=<%=group_name %>">일정관리</a></div>
  <div class="card-body">
<table>
    <thead>
    <tr>
        <th>제목</th>
        <th>시작일</th>
        <th>종료일</th>
    </tr>
    </thead>
    <tbody id="calBody">
    </tbody>
</table>
    
  </div>
</div>


</div>


<script type="text/javascript">
console.log("?"+<%=group_name%>);
//게시판 미리보기
$.ajax({
       url: 'preBbsList.do',
       type: 'get',
       data:{"groupCode" : '<%=group_code %>'},
       success: function(data) {
           var tableTd = "";
         if (data != null && data.length > 0) {
                $("#bbsBody").html('');
           for (var i = 0; i < data.length; i++) {
                tableTd = '<tr>';
               if(data[i].title.length > 10){
               	
               tableTd += '<td>' + data[i].title.substr(0, 10)+'...' + '</td>';
               }else{
               	tableTd += '<td>' + data[i].title + '</td>';
               }
               tableTd += '<td>' + data[i].id + '</td>'
                          + '</tr>';
                  $("#bbsBody").append(tableTd);
           }
         }
       },
       error: function(){
           alert('error');
       }
});
// 일정 미리보기
	 $.ajax({
            url: 'preScheduleList.do',
            type: 'get',
            data:{"id": '<%=login.getId() %>', "groupCode" : '<%=group_code %>'},
            success: function(data) {
                var tableTd = "";
              if (data != null && data.length > 0) {
                     $("#calBody").html('');
                for (var i = 0; i < data.length; i++) {
                     tableTd = '<tr>';
                    if(data[i].title.length > 7){
                    	
                    tableTd += '<td>' + data[i].title.substr(0, 6)+'...' + '</td>';
                    }else{
                    	tableTd += '<td>' + data[i].title + '</td>';
                    }
                    tableTd += '<td>' + data[i].startDate + '</td>'
                            + '<td>' + data[i].endDate + '</td>'
                               + '</tr>';
                       $("#calBody").append(tableTd);
                }
              }
            },
            error: function(){
                alert('error');
            }
});
</script>
</body>
</html>

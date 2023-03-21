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
	String group_code = (String)request.getAttribute("group_code");
	String group_name = (String)request.getAttribute("group_name");

    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main View</title>


<style type="text/css">



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
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);

}

#notice{
  display: flex;
  justify-content: center;
  text-align: center;
  font-size: 15px;
  margin-top:40px;
  margin-left: auto;
  margin-right: auto;
  box-shadow: 0 4px 5px rgba(0, 0, 0, 0.1);

}

.card-header{
font-size: 15px;

}
th {
  text-align: center;
}
.nav-link.active {
  text-shadow: 2px 2px 5px #f8ebcc;
}
.nav-link.active1 {
  text-shadow: 2px 2px 5px #ffdab6;
}
</style>


</head>
<body>

<br>
<img src = "./images/mark.png" width="70px" height="60px" style="float: left; margin-left: 30px"/>
<h1 style="font-weight: bold; color:#aa9a89">&nbsp;&nbsp;&nbsp;현재 나의 그룹: <%=group_name %></h1>
<small class="text-muted" style="font-size: 11pt">&nbsp;&nbsp;&nbsp;&nbsp;내 그룹 게시판 글과 일정을 확인하세요!</small>

<br><br>
<hr>

<div class="flex-container" >

<div class="card border-warning mb-3 rounded" style="text-align: center; ">
  <div class="card-header" >
  
  <a class="nav-link active" style="font-size: 35px; color:#aa9a89; font-weight: bold;"
  href="goBbslist.do?group_code=<%=group_code %>&group_name=<%=group_name %>">그룹 게시판</a>
  </div>

  <div class="card-body">
<table class="table table-hover">
    <thead>
    <tr>
        <th style="font-size: 20px;">제목</th>
        <th style="font-size: 20px; ">작성자</th>
    </tr>
    </thead>
    <tbody id="bbsBody">
    </tbody>
</table>
  </div>
</div>
&nbsp;&nbsp;
<div class="card border-warning mb-3 rounded" style="text-align: center;">
  <div class="card-header">
  <a class="nav-link active1" style="font-size: 35px; color:#aa9a89; font-weight: bold;"
  href="goCalendar.do?group_code=<%=group_code %>&group_name=<%=group_name %>">일정 관리</a></div>
  <div class="card-body">
<table class="table table-hover">
    <thead>
    <tr>
        <th style="font-size: 20px;  ">제목</th>
        <th style="font-size: 20px; ">시작일</th>
        <th style="font-size: 20px; ">종료일</th>
    </tr>
    </thead>
    <tbody id="calBody">
    </tbody>
</table>
    
  </div>
</div>


</div>


<script type="text/javascript">

//게시판 미리보기
$.ajax({
       url: 'preBbsList.do',
       type: 'get',
       data:{"group_code" : '<%=group_code %>'},
       success: function(data) {
           var tableTd = "";

         if (data != null && data.length > 0) {
                $("#bbsBody").html('');
           for (var i = 0; i < 10; i++) {
                tableTd = '<tr>';

                	
               if(data[i].title.length > 10){
               	
               tableTd += '<td style="font-size: 15px; font-weight: 300; color:black;"><a href=bbsdetail.do?seq='+ data[i].seq+'>' + data[i].title.substr(0, 10)+'...' + '</a></td>';
               }else{
               	tableTd += '<td style="font-size: 15px; font-weight: 300; color:black;"><a href=bbsdetail.do?seq='+ data[i].seq+'>' + data[i].title + '</td>';
               }
               tableTd += '<td style="font-size: 15px; font-weight: 300; color:black;">' + data[i].id + '</td>'
                          + '</tr>';
                  $("#bbsBody").append(tableTd);
                  
                 
           }
         }else{
       	  tableTd += '<tr>' 
        	  + '<td colspan="2" style="font-size: 15px; font-weight: 300; color:black; ">&nbsp&nbsp&nbsp&nbsp&nbsp게시글이 없습니다</td><td></td>'
        	  +'</tr>';
              $("#bbsBody").append(tableTd);

          }
                
       },
       error: function(){
           alert('error');
       }

});


//일정 미리보기
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
               	
               tableTd += '<td style="font-size: 15px; font-weight: 300; color:black;">' + data[i].title.substr(0, 6)+'...' + '</td>';
               }else{
               	tableTd += '<td style="font-size: 15px; font-weight: 300;   color:black;">' + data[i].title + '</td>';
               }
               tableTd += '<td style="font-size: 15px; font-weight: 300;  color:black;">' + data[i].startDate + '</td>'
                       + '<td style="font-size: 15px; font-weight: 300;  color:black;">' + data[i].endDate + '</td>'
                          + '</tr>';
                  $("#calBody").append(tableTd);
           }
         }else{
          	  tableTd += '<tr>' 
          		+ '<td colspan="3" style="font-size: 15px; font-weight: 300; color:black; ">&nbsp&nbsp&nbsp&nbsp일정이 없습니다</td><td></td>'
            	  +'</tr>';
                  $("#calBody").append(tableTd);

              }
       },
       error: function(){
    	   console.log(group_code);
           alert('error');
       }
});



</script>
</body>
</html>
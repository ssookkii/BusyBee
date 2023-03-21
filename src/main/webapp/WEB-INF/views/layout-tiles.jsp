<%@page import="mul.cam.a.dto.UserDto"%>
<%@page import="mul.cam.a.dto.EventDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<%
	UserDto login = (UserDto)session.getAttribute("login");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BUSY BEE</title>
<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">

<!-- 부트스트랩 JavaScript 및 의존성 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.8.3/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.min.js"></script>
<!-- jQuery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>	
	<!-- jQuery UI CSS -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- Moment.js -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script
	src='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.4.0/fullcalendar.min.js'></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
	

<!-- 원하는 글꼴 추가 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Dongle:wght@300;400;700&family=Jua&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">

<!-- Font Awesome 아이콘 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">



<!-- FullCalendar CSS -->
<link rel='stylesheet'
	href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.4.0/fullcalendar.min.css' />


<!-- Bootstrap Datepicker -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap-responsive.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>


<!-- timepicker -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>


<!-- Bootstrap -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>

<link rel="stylesheet"
	href="https://bootswatch.com/5/minty/bootstrap.min.css">

<style>
span {
	float: right;
	margin-right: 3px;
}
body {
	margin: 0px;
}
.tilestable {
	width: 100%;
	height: 100%;
	border-collapse: collapse;
}
td {
	vertical-align: top;
	padding: 0;
}
 
    
</style>
</head>
<body>

	<div align="center">

		<table class="tilestable">

		<!-- header -->
            <tr align="center" style="background-color: #fff7e1; color: gray;">
                <td><header>
                <a href="login.do">
                     <img src="images/logo.png" width="280px" height="40px"
                            style="float: left; margin-left: 10px; margin-top : 20px">
                            </a>
                    </header></td>

                <td style="height: 5%">
                    <div style="float: right; margin-right: 30px; margin-top: 15px">

                        <!-- user Name 받아오기
                         <span>${user.name}</span> -->
                        <!--  user 상태 메시지
                        <span style="color: gray;">${user.status}</span> -->

                        <!-- 임시 -->
                        <span style="font-size: 15px;"><%=login.getName()%>(<%=login.getId() %>)</span> <br /> 
                        <span style="color: #938046; font-size: 13px;"><%=login.getProfMsg() %></span>

                        <!-- 로그아웃 , 회원정보 수정-->
                        <br /> 
                        <a style="float: right; margin-right: 5px;" href="#" onclick="logout()">로그아웃</a>

										<script>
										function logout() {
										  if(confirm("로그아웃 하시겠습니까?")) {
										    location.href = "loginMain.do";
										  }
										}
										</script>
                        <a style="float: right; margin-right: 5px;" href="goUserinfo.do">정보 수정</a>
                    </div>
                         <!-- user image -->
                    <div style="float: right; margin: 5px; margin-right: 30px;">
                     <img src="./images/BusyB.png" width="70px" height="70px"
                            style="border-radius: 50%;">
                    </div>
                </td>

        </tr>
		
		<!-- 메뉴 이동 네비게이션 -->
		<tr>
		<td colspan="2">
			<nav class="navbar navbar-expand-lg navbar-light bg-light" style="margin-bottom: 0px;">
		<div class="container-fluid">
		<div class="collapse navbar-collapse" id="navbarColor03">
				<ul class="navbar-nav me-auto" style="font-size: 14px">
					<li class="nav-item"><a class="nav-link active" href="#">
							<span class="visually-hidden">(current)</span>
					</a></li>
					<li class="nav-item"><a class="nav-link" href="goAddgroup.do">그룹 생성</a></li>
					<li class="nav-item"><a class="nav-link" href="goMygroup.do">내 그룹</a></li>
					<li class="nav-item"><a class="nav-link" href="goSearchgroup.do">그룹 검색</a></li>
					<li class="nav-item"><a class="nav-link" href="goNoti.do">그룹 알림</a></li>
					<li>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</li>
					<li class="nav-item"><a class="nav-link" href="chatHome.do">채팅방</a></li>
				</ul>
			</div>
		</div>
	</nav>
	</td>
	</tr>
		


			<!-- menu 영역 -->
			<tr>
				<td align="left" valign="top"
					style="background-color: #fffaea; padding: 15px;" height="765px"
					width="10%">
					<tiles:insertAttribute name="menu" /></td>

				<!-- content 영역 -->
				<td valign="top" style="padding: 10px;">
				<tiles:insertAttribute
						name="content" /></td>

			</tr>

			<!-- footer 영역 -->
			<tr align="right" style="background-color: #fff7e1; color: #938046;">
				<td colspan="5" height="25px">
				<tiles:insertAttribute
						name="footer" /></td>

			</tr>


		</table>


	</div>
	<script>
	</script>

</body>
</html>
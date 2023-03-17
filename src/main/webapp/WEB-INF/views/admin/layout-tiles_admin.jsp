<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Busy bee</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
	
<!-- 부트스트랩 JavaScript 및 의존성 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.3/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.min.js"></script>

<!-- 원하는 글꼴 추가 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Dongle:wght@300;400;700&family=Jua&display=swap"
	rel="stylesheet">


<!-- Font Awesome 아이콘 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">


<style>
span {
	float: right;
	margin-right: 3px;
}

body {

	margin: 0px;
}

table {
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

		<table>

			<!-- header -->
			<tr align="center" style="background-color: #fff7e1; color: gray;">
				<td><header>
						<img src="images/logo.png" width="250px" height="40px"
							style="float: left; margin: 20px;">
					</header></td>

				<td style="height: 5%">
					<div style="float: right; margin-right: 30px; margin-top: 15px">
					
						<!-- user Name 받아오기     
    					 <span>${user.name}</span> -->
						<!--  user 상태 메시지
						<span style="color: gray;">${user.status}</span> -->

						<!-- 임시 -->
						<span style="font-size: 15px;">양상숙</span> <br /> 
						<span style="color: #938046; font-size: 13px;">개발중입니다. 건들지마세요</span>

						<!-- 로그아웃 , 회원정보 수정-->
						<br /> 
						<a style="float: right; margin-right: 5px;"	href="${logoutUrl}">로그아웃</a> 
						<a style="float: right; margin-right: 5px;" href="${mem_info}">정보 수정</a>
					</div>
					 	<!-- user image -->
					<div style="float: right; margin: 5px; margin-right: 30px;">
						<img src="images/user.jpg" width="70px" height="70px"
							style="border-radius: 50%;">
					</div>
				</td>
				
			<tr>

				<!-- content 영역 -->
				<td valign="top" style="padding: 10px;"><tiles:insertAttribute
						name="content" /></td>

			</tr>
		
		

			<!-- footer 영역 -->
			<tr align="right" style="background-color: #fff7e1; color: #938046;">
				<td colspan="5" height="25px"><tiles:insertAttribute
						name="footer" /></td>

			</tr>


		</table>


	</div>
	

</body>
</html>







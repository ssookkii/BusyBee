<%@page import="mul.cam.a.dto.ChatRoomDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	ChatRoomDto chatRoomInfo = (ChatRoomDto)request.getAttribute("chatRoomInfo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<style>

#chatContainer{ 
	display: flex;
	justify-content: center;
	align-items: center;
	height: 1100px;
}

#chatContent {
	width: 600px;
	height: 800px;
	margin-top: 10px;
	margin-bottom: 10px;
	border: 2px solid black;
	border-radius: 5px;
	box-shadow: 5px 5px 2px 1px gray;
	overflow: scroll;
}

#messageContainer {
	display: inline-flex;
	justify-content: center;
	align-items: center;
	height: 50px;
	width: 600px;
}

#writer {
	width: 40px;
	height: 30px;
}

#message {
	display: inline-block;
	width: 300px;
	height: 30px;
}

.invisiable {
	display: none;
}
</style>
</head>
<body>
	<div id="chatContainer">
		<div>
			<div id="chatHeader">
				<p>채팅방 >> <%=chatRoomInfo.getTitle() %></p>
				<p>채팅방 소개 >> <%=chatRoomInfo.getDescriptions() %></p>
				<p>참여자 >> <%=chatRoomInfo.getMembers() %></p>
			</div>
			<div id="chatContent">
				
			</div>
			<div id="messageContainer">
				<form method="POST" action="<%=chatRoomInfo.getRoomId()%>.do">
					<input type="text" name="writer" id="writer" value="abc" />
					<input type='text' name="message" id="message" />
					<button id="sendBtn" type="submit">Send Message</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
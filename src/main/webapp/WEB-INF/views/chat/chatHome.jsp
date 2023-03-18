
<%@page import="mul.cam.a.dto.ChatRoomDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String User = (String)session.getAttribute("User");
List<ChatRoomDto> allChatRoom = (List<ChatRoomDto>)request.getAttribute("allChatRoom");
System.out.println(User);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chat!</title>
<style>
input {
	width: 250px;
	height: 30px;
	padding-left: 15px;
	padding-right: 15px;
	border-radius: 5px;
}


ul{
	list-style: none;
	padding: 0px;
	margin: 0px;
}

li {
	margin-top: 5px;
	margin-bottom: 5px;
	padding: 10px;
}
#createChatBtn {
	width: 300px;
	height: 100px;
	font-size: 40px;
	background-color: gray;
	color: white;
	margin-bottom: 50px;
}

#createChatBtn:hover{
	background-color:black;
	transition: 2s;
}

#modal {
	display: none;
	position: absolute;
	width: 300px;
	height: 250px;
	background-color: rgba(200,230,255,0.8);
	border: 0px solid gray;
	border-radius: 15px;
	box-shadow: 10px 5px 2px gray;
	top: 300px;
	left: 37%;
	padding: 20px, 10px;
	animation: fadein 2s;
}

#modalBtn {
	align-text:right;
}
#closeModal {
	posotion: absolute;
	right: 0;
	top:0;
}

#chatList {
	display: flex;
	height: 400px;
	justify-content: center;
	align-items: center;
}

#chatForAll {
	width: 200px;
	height: 60px;
	border-radius: 15px;
	margin: 50px;
}
.show {
	display: inline-flex !important;
}
.none {
	display: none !important;
}

.chat {
	display: inline-block;
	text-align: left;
	text-decoration: none;
	width: 300px;
	height: 200px;
	border: 5px solid yellow;
	border-radius: 15px;
	margin: 10px;
	
	list-style: none;
}

.chat:hover {
	text-decoration: none;
	cursor: pointer;
	transform: scale(1.1);
	transition: transform 1s;
}
.cjat:action {
	transform: scale(0.9);
	transition: transform 1s;
}

.center {
	text-align:middle;
}
.flexible {
	display: inline-flex;
	justify-content: center;
	align-items: center;
	width: 100%;
}

@keyframes fadein {
	from{
		opacity: 0;
	}
	to {
		opacity: 1;
	}
}
</style>
</head>
<body>
	<div id="ChatContainer">
		<div class="flexible">
			<div>
				<button id="createChatBtn">Create Chat!</button>
			</div>
		</div>
		<div id="modal">
			<div id="modalBtn">
				<button id="closeModal">X</button>
			</div>
			<div>
				<h3>Create Your Chat!</h3>
				<form method="POST" id="ChatForm">
					<input id="roomId" name="roomId" type="text" placeholder="Chat ID(identifier)" required /><br/>
					<input id="title" name="title" type="text" placeholder="Chat Name" required/><br/>
					<input id="description" name="description" type="text" placeholder="description" required/><br/>
					<input id="member" name="member" type="text" placeholder="member" /><br/>
					<input type="submit" value="Create Chat!"/> 
				</form>
			</div>
		</div>
		<div id="chatList">
		<%
		// 참여하고 있는 방이없으면 
		if (allChatRoom == null) {
			%>
			<h1>참여하고있는 채팅방이 없습니다.</h1>
			<% 
		}else{
		// 침여하고 있는 방 표시
			for (ChatRoomDto chatRoom: allChatRoom){
				%>
				<div class="chat">
					<a href="chatRoom/<%=chatRoom.getRoomId()%>.do" target="_blank">
						<ul>
							<li>chat name || <%=chatRoom.getRoomId()%></li>
							<li>host || <%=chatRoom.getCreatedBy()%></li>
							<li>member || <%=chatRoom.getMembers()%></li>
							<li>description || <%=chatRoom.getDescriptions() %></li>
						</ul>
					</a>
				</div>
				<% 
			}
		}
		%>
		</div>
		<hr>
		<div class="flexible">
			<div>
				<h1 style="text-align:center;">전체 채팅방</h1>
				<Button id="chatForAll">입장</Button>
			</div>
		</div>
	</div>
<script>

const createChatBtn = document.getElementById("createChatBtn");
const modalWindow = document.getElementById("modal");
const closeModal = document.getElementById("closeModal");
const chatForm = document.getElementById("ChatForm");
const chatForAllBtn = document.getElementById("chatForAll");

const clickCreateChatBtn = () => {
	document.getElementById("roomId").value = "";
	document.getElementById("title").value = "";
	document.getElementById("description").value = "";
	document.getElementById("member").value = "";
	if (!modalWindow.classList.contains("show")) modalWindow.classList.add("show");
}

const clickCloseModal = () => {
	if (modalWindow.classList.contains("show")) modalWindow.classList.remove("show");
}
createChatBtn.addEventListener("click",clickCreateChatBtn);
closeModal.addEventListener("click", clickCloseModal);

const chatForAll = () =>{
	location.href="chating.do";
}

chatForAllBtn.addEventListener("click", chatForAll);

</script>
</body>
</html>
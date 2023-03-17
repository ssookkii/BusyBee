
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String User = (String)session.getAttribute("User");
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
	background-color: gray;
	color: white;
	margin-bottom: 50px;
}

#createChatBtn:hover{
	background-color:black;
	opacity: 0.2 1s;
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
	height: 300px;
	justify-content: center;
	align-items: center;
}

#chatForAll {
	width: 200px;
	height: 60px;
	border-radius: 15px;
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
	width: 300px;
	height: 200px;
	border: 5px solid yellow;
	border-radius: 15px;
	margin: 10px;
}

.center {
	text-align:middle;
}
.flexible {
	display: inline-flex;
	justify-content: center;
	align-items: center
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
		<button id="createChatBtn">Create Chat!</button>
		<div id="modal">
			<div id="modalBtn">
				<button id="closeModal">X</button>
			</div>
			<div>
				<h3>Create Your Chat!</h3>
				<form method="POST" id="ChatForm">
					<input id="roomName" name="roomName" type="text" placeholder="Chat Name" required/><br/>
					<input id="description" name="descriptions" type="text" placeholder="description" required/><br/>
					<input id="member" name="members" type="text" placeholder="member" /><br/>
					<input type="submit" value="Create Chat!"/> 
				</form>
			
			</div>
		</div>
		<div id="chatList">
		</div>
		<hr>
		<div class="center">
			<h3>전체채팅방입장!</h3>
			<Button id="chatForAll">입장</Button>
		</div>
	</div>
<script>

const createChatBtn = document.getElementById("createChatBtn");
const modalWindow = document.getElementById("modal");
const closeModal = document.getElementById("closeModal");
const chatForm = document.getElementById("ChatForm");
const chatForAllBtn = document.getElementById("chatForAll");

const clickCreateChatBtn = () => {
	document.getElementById("roomName").value = "";
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

<%@page import="mul.cam.a.dto.UserDto"%>
<%@page import="mul.cam.a.dto.ChatRoomDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
UserDto userInfo = (UserDto)session.getAttribute("login");
String User = userInfo.getId();
session.setAttribute("User", User);
List<ChatRoomDto> allChatRoom = (List<ChatRoomDto>)request.getAttribute("allChatRoom");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Chat!</title>
<link rel="stylesheet" href="https://bootswatch.com/5/minty/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Dongle:wght@300;400;700&family=Jua&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">

<style>
*{
	font-family: 'Black Han Sans', sans-serif;
	font-family: 'Dongle', sans-serif;
	font-family: 'Jua', sans-serif;
	font-family: 'Noto Sans KR', sans-serif;
}
#modal {
	display: none;
	top: 100px;
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
#allChatContainer {
	text-align: middle;
	margin: 20px;
}
.exitChatBtn {
	border-style: none;
	border-radius: 15px;
	color: black;
	width: 100%;
	height: 100%;
}
}
.show {
	display: inline-flex !important;
}
.none {
	display: none !important;
}
.card:hover {
	text-decoration: none;
	cursor: pointer;
	transform: scale(1.1);
	transition: transform 1s;
}
.flexible {
	display: inline-flex;
	justify-content: center;
	align-items: center;
	width: 100%;
}
</style>
<script>
function showChatInfo(element) {
	const chatRoomId = element.id; // 태그 구분을 개행으로 하면 첫 자식이 빈 text 가 잡힌다..
	$.ajax({
		method: "post",
		data: { "chatRoomId": chatRoomId },
		url: "showChatInfo.do",
		dataType: "text",
		success: function(data){
			data = JSON.parse(data);
			
			let sendTime = new Date();
			sendTime = sendTime.toLocaleString('ko-kr');
			
			const chatTitle = data.title;
			const chatDescription = data.descriptions;
			const chatMembers = data.members;
			const chatHost = data.createdBy;
			const chatCreatedAt = data.createdAt;
			document.getElementById("showChatId").innerText = chatRoomId;
			document.getElementById("showChatTitle").innerText = chatTitle;
			document.getElementById("showChatDescription").innerText = chatDescription;
			document.getElementById("showChatMember").innerText = chatMembers;
			document.getElementById("showChatHost").innerText = chatHost;
			document.getElementById("showChatCreatedAt").innerText = sendTime;
			document.getElementById("chatExit").innerHTML = "<button class='exitChatBtn' onclick='exitChat(this)'>Chat Exit</button>";
		},
		error: function(){
			alert("실패");
		}
	});
}
function enterChat(element) {
	const chatRoomId = element.id;
	
	if (chatRoomId == null || chatRoomId == "") {
		alert("해당 채팅방을 찾을 수 없습니다.");
		return;
	}
	
	const teamChatWindow = window.open("teamChating/"+ chatRoomId + ".do", "chatteam", "resizable");
	teamChatWindow.resizeTo(600,900);
	
}
function exitChat(element) { // 자신을 제거
	const toExitChatRoomId = document.getElementById("showChatId").innerText;
	const chatRoomInfo = document.getElementById(toExitChatRoomId);
	
	// 노드를 제거하기 위해서는 해당 노드의 부모에 접근해야함.
	chatRoomInfo.parentElement.removeChild(chatRoomInfo);
	
	// 채팅정보 초기화
	document.getElementById("showChatId").innerText = "-";
	document.getElementById("showChatTitle").innerText = "-";
	document.getElementById("showChatDescription").innerText = "-";
	document.getElementById("showChatMember").innerText = "-";
	document.getElementById("showChatHost").innerText = "-";
	document.getElementById("showChatCreatedAt").innerText = "-";
	document.getElementById("chatExit").innerHTML = "-";
	
	// DB 에서도 참여자에서 제거
	$.ajax({
		url: "exitChatRoom.do",
		method: "post",
		data: { "chatRoomId" : toExitChatRoomId },
		dataType: "text",
		success: function() {
			alert("채팅방에서 나갔습니다");
		},
		error: function() {
			alert("예기지치 못한 오류가 발생했습니다.");
		}
	});
}
</script>
</head>
<body>
	<div id="ChatContainer">
		<div class="flexible">
			<div>
				<button onclick="clickOpenModal()" class="btn btn-danger" style="width: 200px; height: 80px; font-size: 15px;">새 채팅방 만들기</button>
			</div>
		</div>
		
		<div class="modal" id="modal">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h3>채팅방 생성</h3>
		        <button type="button" id="closeModal" class="btn-close" onclick="clickCloseModal()" data-bs-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true" ></span>
		        </button>
		      </div>
		      <div class="modal-body">
				<input class="form-control" id="roomId" name="roomId" type="text" placeholder="채팅방 ID" maxLength="20" required /><br/>
				<input class="form-control" id="title" name="title" type="text" placeholder="채팅방 이름(20자)" maxLength="20" required/><br/>
				<textarea class="form-control" id="description" name="description" placeholder="채팅방 소개 (200자)" maxLength="200" rows="10" required/></textarea><br/>
				<input class="form-control" id="member" name="member" type="text" placeholder="채팅 멤버(콤마로 구분해주세요)" maxLength="200"/><br/>
		      </div>
		      <div class="modal-footer">
		        <button type="button"  class="btn btn-primary" onclick="createChat()">생성</button>
		        <button type="button" class="btn btn-secondary" onclick="clickCloseModal()" data-bs-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>
		<div id="chatList">
		<%
		// 참여하고 있는 방이없으면 
		if (allChatRoom == null) {
			%>
			<h1>참여하고 있는 채팅방이 없습니다.</h1>
			<% 
		}else{
		// 침여하고 있는 방 표시
			for (ChatRoomDto chatRoom: allChatRoom){
				%>
				<div>
					<div class="card text-white bg-warning mb-3" id="<%=chatRoom.getRoomId() %>" onclick="showChatInfo(this)" ondblclick="enterChat(this)" style="width: 150px; height: 150px; margin:15px;">
					  <div class="card-header" style="background-color: yellow; color: black;">[ 채팅이름 ] <%=chatRoom.getTitle() %></div>
					  <div class="card-body">
					    <p class="card-text"><%=chatRoom.getDescriptions() %></p>
					  </div>
					</div>
				</div>
				<% 
			}
		}
		%>
		</div>
		<div id="chatInfo" class="flexible">
			<div>
				<table class="table table-hover">
					<colgroup>
						<col />
						<col width="100" />
						<col width="400" />
						<col width="100"/>
						<col width="100" />
						<col width="100" />
						<col width="100" />
					</colgroup>
					<thead>
						<tr class="table-warning" style="color: black;">
							<th>채팅방 ID</th>
							<th>채팅방 이름</th>
							<th>채팅방 소개</th>
							<th>채팅 멤버</th>
							<th>호스트</th>
							<th>생성시기</th>
							<th>나가기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td id="showChatId">-</td>
							<td id="showChatTitle"> - </td>
							<td id="showChatDescription">- </td>
							<td id="showChatMember">-</td>
							<td id="showChatHost">-</td>
							<td id="showChatCreatedAt">-</td>
							<td id="chatExit">-</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<hr>
		<div class="flexible">
			<div>
				<div id="allChatContainer">
					<h1>전체 채팅방</h1>
				</div>
				<Button onclick="chatForAll()" class="btn btn-outline-primary" style="width: 100%; height: 100px; font-size: 15px;">입장</Button>
			</div>
		</div>
	</div>
<script>
const modalWindow = document.getElementById("modal");
const chatForAllBtn = document.getElementById("chatForAll");
const clickOpenModal = () => {
	document.getElementById("roomId").value = "";
	document.getElementById("title").value = "";
	document.getElementById("description").value = "";
	document.getElementById("member").value = "";
	if (!modalWindow.classList.contains("show")) modalWindow.classList.add("show");
}
const clickCloseModal = () => {
	if (modalWindow.classList.contains("show")) modalWindow.classList.remove("show");
}
const createChat = () => {
	
	const roomId = document.getElementById("roomId").value;
	const title = document.getElementById("title").value;
	const description = document.getElementById("description").value;
	const member = document.getElementById("member").value;
	
	$.ajax({
		url: "createChat.do",
		method: "post",
		data: {
			"roomId": roomId,
			"title": title,
			"description": description,
			"member": member
			},
		dataType: "text",
		success: function(data){
			if (data == null || data == "" || data == undefined) {
				alert("이미 존재하는 Chat ID 입니다.");
				document.getElementById("roomId").value = "";
				document.getElementById("roomId").focus();
				return;
			}
			const json = JSON.parse(data);
			
			const chatDiv = document.createElement("div");
			const chatDivChild = "<div class='card text-white bg-warning mb-3' id=" + json.roomId + " onclick='showChatInfo(this)' ondblclick='enterChat(this)' style='width: 150px; height: 150px; margin:15px;'>";
									+ "<div class='card-header' style='background-color: yellow; color: black;'>[ 채팅이름 ] " + json.title + " </div>"
									+ "<div class='card-body'>" 
										+ "<p class='card-text'>" + json.descriptions + "</p>" 
									+ "</div>" 
							   + "</div>";
			chatDiv.innerHTML = chatDivChild;
			window.location.reload();
		},
		error: function(error) {
			alert("예기치 못한 에러가 발생하였습니다");
		},
	});
}
const chatForAll = () =>{
	const allChatWindow = window.open("allChating.do", "chatAll", "resizable");
	allChatWindow.resizeTo(600,900);
}
</script>
</body>
</html>
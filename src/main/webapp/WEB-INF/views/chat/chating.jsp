<%@page import="mul.cam.a.dto.ChatRoomDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
String User = (String)session.getAttribute("login");
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<style>

.item-center {
	display:flex;
	justify-content: center;
	align-items: center;
	margin: 30px;
}
.chat-contents-container {
	border: 2px solid black;
	border-radius: 5px;
	box-shadow: 5px 5px 2px 1px gray;
	padding: 10px;
	width: 500px;
	height: 700px;
	overflow: scroll;
}

.chat-me {
	display: inline-flex;
	justify-content: flex-start;
	border: 2px solid black;
	border-radius: 5px;
	box-shadow: 0px 5px 2px 1px gray;
	padding: 5px 10px;
	margin: 5px 5px;
}

.chat-other {
	display: inline-flex;
	position: relative;
	right: 5px;
	border: 2px solid black;
	border-radius: 5px;
	box-shadow: 5px 5px 2px 1px gray;
	padding: 5px 10px;
	margin: 5px 5px;
	background-color: gray;
}
.whisper {
	background-color: purple;
	color: white;
	font-weight: bold;
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
	width: 500px;
	height: 400px;
	background-color: rgba(0,0,0,0.8);
	top: 100px;
	left: 37%;
	animation: fadein 2s;
}

#closeModal {
	posotion: absolute;
	right: 0;
	top:0;
}

#chatList {
	display: flex;
	justify-content: center;
	align-items: center;
}
#chatHeader {
	text-align: center;
}

#message {
	font-size: 20px;
	margin-left: 15px;
	border: 3px solid black;
	border-radius: 5px;
	height: 40px;
	width: 350px;
}

#sendBtn {
	text-align: center;
	border: 3px solid black;
	border-radius: 5px;
	font-weight: bold;
	height: 40px;
	width: 80px;
}

#sendBtn:hover {
	background-color: orange;
	transition: 3s;
}

#sendBtn:active {
	background-color: black;
	color: white;
}

</style>


<div id="chatHeader">
	<h1>전체채팅방</h1>
	<p></p>
</div>
<div class="item-center">
	<div class="chat-contents-container">
		<div class="chat-contents">
		</div>
	</div>
</div>
<div class="item-center margin">
	<div>
		<select id="chatOption" onchange="toChatWho()">
			<option value="toAll">--전체--</option>
			<option value="toOne">--귓속말--</option>
		</select>
		<input type="text" id="recipient" disabled placeholder="send to" value="to All"/>
	</div>
	<input type="text" id="message" size="50" required />
	<input type="button" id="sendBtn" value="전송" onclick="send()" />
</div>
<input type="button" id="enterBtn" value="입장" onclick="connect()" />
<input type="button" id="exitBtn" value="나가기" onclick="disconnect()" />
<script>

var wsocket;

// 접속
function connect() {
	
	if(wsocket != undefined && wsocket.readyState != WebSocket.CLOSED){
		alert("이미 입장하셨습니다");
		return;
	}
	
	// Web Socket 생성
	
	if( $("#name").val() == "abc" ){
		wsocket = new WebSocket("ws://localhost:8080/busyBee/echo.do");
	}
	else{
		wsocket = new WebSocket("ws://localhost:8080/busyBee/echo.do");		
	}
	
	wsocket.onopen = onOpen;
	wsocket.onmessage = onMessage;
	wsocket.close = onClose;
}

// 접속을 중단
function disconnect() {
	wsocket.close();
	location.href = "chating.do";
}

// 연결이 되었을 때
function onOpen(evt) {
	appendMessage("연결되었습니다");
}

// 메시지 수신이 되었을 때
function onMessage(evt) {
	console.log(evt); // 서버에서 온 데이터 확인
	console.log("server message send");
	let data = evt.data;
	appendMessage( data );
}

// 끊겼을 때
function onClose(evt) {
	appendMessage("연결이 끊겼습니다");
}

// 메시지 송신
function send() {

	const writer = "임의 유저"; //"<%=User%>"
	const message = document.getElementById("message").value;
	const recipient = document.getElementById("recipient").value; // 모두에게 보낼때 "to All" 귓속말일때 "user name"
	let sendTime = new Date();
	sendTime = sendTime.toLocaleString('ko-kr');
	// 유효성 검사
	if (message == "" || message == null || message == "" || message == null) {
		alert("유효하지 않은 요청입니다.");
		return;
	};
	if (recipient == "" || recipient == null) {
		alert("보낼 상대를 입력해주세요");
		return;
	}
	
	const sendMessage = writer + "[@:`]" + message + "[@:`]" + recipient + "[@:`]" + sendTime;
	
	// 웹소켓으로 전달
	wsocket.send(sendMessage);	// msg:aaa:안녕하세요
	document.getElementById("message").value = "";
	
	// DB 저장
	$.ajax ({
		type: "post",
		url: "allChatSave.do",
		data: { 
			"writer" : writer,
			"message" : message,
			"recipient" : recipient,
		},
		dataType: "text",
		success: function(){

		},
		error: function(){
			alert("실패");
		}
	});
}

// 추가 문자열을 기입
function appendMessage( msg ) { // msg >> "user이름:message내용"
	
	const messageList = msg.split("[@:`]");
	const writer = messageList[0]; 
	const message = messageList[1];
	const recipient = messageList[2];
	const sendTime = messageList[3];
	
	const chatBox = document.querySelector(".chat-contents");
	const chatContent = document.createElement("div");

	if (message === undefined || message == "") return; // 만약에라도 메세지가 비어있으면 아무동작 안함.
	
	// 자신이 보낸 메세지일경우
	if (writer == "<%=User%>" && recipient == "to All") { 
		const plusElementMyChat = "<p class='chat-me'>" +
										 "나 | " + message +
							      "</p><span>" + sendTime + "</span>";
		
		chatContent.innerHTML = plusElementMyChat;
		chatBox.appendChild(chatContent);
	
	}
	// 다른사람이 보낸 전체메세지 일경우
	else if (writer != "<%=User%>" && recipient == "to All") {
		const plusElementOtherChat = "<p class='chat-other'>" +
										 + message + " | " + writer +
									  "</p>";
		chatContent.innerHTML = plusElementOtherChat;
		chatBox.appendChild(chatContent);
	}
	
	// 다른사람이 보낸 귓속말 일경우
	else if(writer != "<%=User%>" && recipient == "<%=User%>"){ 
		const plusElementOtherChat = "<p class='chat-other whisper'>" +
										 + message + " |  <귓속말>" + writer +
								     "</p>";
		chatContent.innerHTML = plusElemenOtherChat;
		chatBox.appendChild(chatContent);
	}
		// 스크롤을 위로 이동 시킨다
	chatBox.scrollTop = chatBox.scrollHeight;
}


function toChatWho() {
	//select option 의 value 추출
	const chatOption = document.getElementById("chatOption");
	const optionValue = chatOption.options[chatOption.selectedIndex].value;
	const recipient = document.getElementById("recipient");
	// 전체채팅으로 보내면 input 비활성화
	if (optionValue === "toAll") {
		recipient.setAttribute("disabled", true);
		recipient.value = "to All"
	}
	
	// 귓속말일 경우 input 활성화
	else if (optionValue === "toOne"){
		recipient.removeAttribute("disabled"); // setAttribute("disable", false) 불가 => 바뀌긴하지만 비활성화가 안풀림
		recipient.value = "";
	}
}

</script>
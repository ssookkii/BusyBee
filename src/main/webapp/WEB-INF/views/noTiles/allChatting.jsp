<%@page import="mul.cam.a.dto.ChatRoomDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
String User = (String)request.getAttribute("User");
%>
<link rel="stylesheet" href="https://bootswatch.com/5/minty/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Dongle:wght@300;400;700&family=Jua&family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<style>
*{
	font-family: 'Black Han Sans', sans-serif;
	font-family: 'Dongle', sans-serif;
	font-family: 'Jua', sans-serif;
	font-family: 'Noto Sans KR', sans-serif;
}
body {
	height: 850px;
}
#sendOption{
	margin-top: 10px;
	text-align: middle;
	height: 50px;
}
#allChatContainer {
	height: 100%;
	background-color: #fff7e1;
	margin: 0;
	padding-top: 20px;
}
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
	height: 650px;
	overflow: scroll;
	background-color: white;
}
.chat-me {
	display: flex;
	justify-content: flex-start;
	
}
.chat-me p {
	border: 2px solid black;
	border-radius: 5px;
	box-shadow: 0px 5px 2px 1px gray;
	padding: 5px 10px;
	margin: 5px 5px;
}
.chat-other {
	display: flex;
	justify-content: flex-end;
	
}
.chat-other p {
 	margin-left: auto;
	border: 2px solid black;
	border-radius: 5px;
	box-shadow: 5px 5px 2px 1px gray;
	padding: 5px 10px;
	margin: 5px 5px;
	background-color: #ffecd2;
}
.whisper {
	display: flex;
	justify-content: flex-end;
	margin-left: auto;
}
.whisper p {
	margin-left: auto;
	border: 2px solid black;
	border-radius: 5px;
	box-shadow: 5px 5px 2px 1px gray;
	padding: 5px 10px;
	margin: 5px 5px;
	background-color: #ffd2e8;
}
</style>

<div id="allChatContainer">	
	<h2 style="text-align: center;">전체채팅방</h2>
	<div class="item-center">
		<div class="chat-contents-container">
			<div class="chat-contents">
			</div>
		</div>
	</div>
	<div class="item-center" id="sendOption">
		<div>
			<select id="chatOption" class="form-select" onchange="toChatWho()">
				<option value="toAll">--전체--</option>
				<option value="toOne">--귓속말--</option>
			</select>
			<input type="text" id="recipient" class="form-control-sm" disabled placeholder="send to" value="to All"/>
		</div>
		<input type="text" id="message" class="form-control" size="50" required style="width: 300px; height:45px; font-size:15px;"/>
		<input type="button" class="btn btn-warning" value="전송" onclick="send()" style="width:80px; height: 45px;" />
	</div>
</div>
<script>
var wsocket;
function loginCheck() {
	if ( "<%=User%>" == "" || "<%=User%>" == "null"){
		location.href= "/BusyBee/loginMain.do";
		alert("로그인 후 이용해주세요");
		return false;
	}
	return true;
}
// 접속
function connect() {
	
	if(wsocket != undefined && wsocket.readyState != WebSocket.CLOSED){
		alert("이미 입장하셨습니다");
		return;
	}
	
	// Web Socket 생성
	wsocket = new WebSocket("ws://localhost:8080/BusyBee/echo.do");
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
	let data = evt.data;
	appendMessage( data );
}
// 끊겼을 때
function onClose(evt) {
	appendMessage("연결이 끊겼습니다");
}
// 메시지 송신
function send() {
	const writer = "<%=User%>";
	const message = document.getElementById("message").value;
	const recipient = document.getElementById("recipient").value; // 모두에게 보낼때 "to All" 귓속말일때 "user name"
	let sendTime = new Date();
	sendTime = sendTime.toLocaleString('ko-kr');
	// 유효성 검사
	if (message == "" || message == null || message == "" || message == null) {
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
		success: function(msg){
			if (msg === "Success") console.log("채팅내용 저장성공");
			else console.log("채팅내용 저장실패");
		},
		error: function(){
			alert("메세지 전달에 실패하였습니다.");
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
		chatContent.className = "chat-me";
		const plusElementMyChat = "<p>" + "나 | " + message + "</p><br/>" +
								"<span>" + sendTime + "</span>";
		
		chatContent.innerHTML = plusElementMyChat;
		chatBox.appendChild(chatContent);
	}
	// 자신이 보낸 귓속말 메세지인경우
	else if (writer == "<%=User %>" && recipient != "to All"){
		chatContent.className = "chat-me";
		const plusElementMyChat = "<p>[" + recipient + "]에게 귓속말 | " + message + "</p><br/>" +
								"<span>" + sendTime + "</span>";
		
		chatContent.innerHTML = plusElementMyChat;
		chatBox.appendChild(chatContent);
	}
	// 다른사람이 보낸 전체메세지 일경우
	else if (writer != "<%=User%>" && recipient == "to All") {
		chatContent.className = "chat-other";
		const plusElementOtherChat = "<span>" + sendTime + "</span><br/>"+ 
									"<p>"+ message + " [" + writer + "]</p>";
;
		chatContent.innerHTML = plusElementOtherChat;
		chatBox.appendChild(chatContent);
	}
	
	// 다른사람이 보낸 귓속말 일경우
	else if(writer != "<%=User%>" && recipient == "<%=User%>"){ 
		chatContent.className = "whisper";
		const plusElementOtherChat = "<span>" + sendTime + "</span><br/>"+
									"<p>" + message + " [" + writer + "]</p>";
		chatContent.innerHTML = plusElementOtherChat;
		chatBox.appendChild(chatContent);
	}
	
	const chatScrollBar = document.querySelector(".chat-contents-container")
	console.log(chatScrollBar.offsetHeight);
	chatScrollBar.scrollTop = chatScrollBar.offsetHeight;
	
	//chatBox.lastChild.focus();
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
function resizeWindowSize() {
	window.resizeTo(600,900);
}
window.addEventListener("resize", resizeWindowSize);
if (loginCheck()) connect();
</script>
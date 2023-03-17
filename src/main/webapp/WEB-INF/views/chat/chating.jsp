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
	height: 30px;
	padding: 5px 10px;
	margin: 5px 5px;
}

.chat-other {
	display: inline-flex;
	justify-content: flex-end;
	border: 2px solid black;
	border-radius: 5px;
	box-shadow: 5px 5px 2px 1px gray;
	height: 30px;
	padding: 5px 10px;
	margin: 5px 5px;
	background-color: rgba(255,255,255, 0.5);
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
	
	// wsocket = new WebSocket("ws://192.168.0.210:8090/sample10/echo.do");
	
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
	if(data.substring(0, 4) == "msg:"){		// msg:안녕하세요
		appendMessage( data.substring(4) );	// 안녕하세요
	}
}

// 끊겼을 때
function onClose(evt) {
	appendMessage("연결이 끊겼습니다");
}

// 메시지 송신
function send() {
	let id = "<%=User%>";
	let msg = document.getElementById("message");
	console.log(msg);
	if (msg.value == "" || msg.value==null) {
		msg.focus()
	} 
	wsocket.send("msg:" + id + ":" + msg.value);	// msg:aaa:안녕하세요
	$("#message").val("");
}

// 추가 문자열을 기입
function appendMessage( msg ) { // msg >> "user이름:message내용"
	
	
	// 메시지를 추가 하고 개행
	const messageList = msg.split(":");
	const userId = messageList[0]; 
	const message = messageList[1];
	const plusElementMyChat = "<div>" +
								"<p class='chat-me'>" +
								 "나 | " + message +
							    "</p>" +
							  "</div";
						
	const plusElementOtherChat ="<div>" +
								   "<p class='chat-me'>" +
									 + userId + " | " + message +
								   "</p>" +
								"</div";
	
	if (message === undefined || message == "") return; // 연결메세지이거나 메세지가 비어있으면 아무동작 안함.
	
	// 보낸사람이 자신과 같으면 왼쪽 정렬
	// 그렇지 않으면 오른쪽 정렬
	if (userId == "<%=User%>") $(".chat-contents").append(plusElementMyChat);
	else $(".chat-contents").append(plusElementOtherChat);
	// 스크롤을 위로 이동 시킨다
	const chatBox = document.querySelector(".chat-contents")
	chatBox.scrollTop = chatBox.scrollHeight;
}
</script>








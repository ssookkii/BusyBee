package mul.cam.a.websocket;

import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import mul.cam.a.dto.ChatMessageDto;
import mul.cam.a.service.ChatMessageService;

public class WebSocket extends TextWebSocketHandler {
	
	// 프론트로부터 소켓에 접속 받으면 클라이언트 정보를 userNap
	// userMap 은 클라이언트 정보를 저장하기 위함. (session id 가 key값, session 전체가 value 값이다)
	// ConcurrentHashMap 은 HashMap 에서 thread-safe 한 자료형.
	private Map<String, WebSocketSession> userMap = new ConcurrentHashMap<String, WebSocketSession>();
	
	public WebSocket() {
		System.out.println("EchoHandler 생성됨 " + new Date());
	}

	// 클라이언트와 접속이 성공했을 때 호출
	// session.getId 는 세션ID
	// 클라이언트로부터 socket.connection() 되면 자동으로 서버가 session 을 받아 userMap 에 현재 유저저장
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("연결됨 " + session.getId() + " " + new Date());
		userMap.put(session.getId(), session);
		
	}

	// 클라이언트와 접속이 끊겼을 때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("연결 종료 " + session.getId() + " " + new Date());
		userMap.remove(session.getId());
	}

	// 메시지 수신(recv)&송신(send)
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 수신(recv)
		System.out.println("message: " + message.getPayload());
				
		// 송신(send) - 모든 client(session)에 전송	
		for(WebSocketSession s : userMap.values()) {
			s.sendMessage(message);			
		}
	}

	// 예외 발생
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		System.out.println(session.getId() + " 예외발생 " + new Date());
	}
	
	
}









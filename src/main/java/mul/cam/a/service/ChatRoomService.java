package mul.cam.a.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mul.cam.a.dao.ChatRoomDao;
import mul.cam.a.dto.ChatRoomDto;
import mul.cam.a.service.ChatRoomService;

@Service
public class ChatRoomService {
	
	@Autowired
	ChatRoomDao dao;	
	
	public List<ChatRoomDto> printAllChatRoom(String userId) {
		return dao.printAllChatRoom(userId);
	}
	
	public boolean createChatRoom(ChatRoomDto dto) {
		return dao.createChatRoom(dto)>0 ? true : false;
	}

	public ChatRoomDto chatRoomInfo(String roomId) {
		return dao.chatRoomInfo(roomId);
	}
	
	public boolean exitChatRoom(String roomId, String user) {
		return dao.exitChatRoom(roomId, user)>0 ? true : false;
	}
}

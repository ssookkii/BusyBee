package mul.cam.a.service;

import java.util.List;

import mul.cam.a.dto.ChatRoomDto;

public interface ChatRoomService {
	public List<ChatRoomDto> printAllChatRoom(String userId);
	public boolean createChatRoom(ChatRoomDto dto);
	public ChatRoomDto chatRoomInfo(String roomId);
	public boolean exitChatRoom(String roomId, String user);
}

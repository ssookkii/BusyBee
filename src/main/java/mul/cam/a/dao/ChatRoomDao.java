package mul.cam.a.dao;

import java.util.List;

import mul.cam.a.dto.ChatRoomDto;

public interface ChatRoomDao {
	public List<ChatRoomDto> printAllChatRoom(String userId);
	public int createChatRoom(ChatRoomDto dto);
	public ChatRoomDto chatRoomInfo(String roomId);
	public int exitChatRoom(String roomId, String user);
}
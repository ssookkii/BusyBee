package mul.cam.a.dao;

import mul.cam.a.dto.ChatMessageDto;

public interface ChatMessageDao {
	public int saveChatMessage(ChatMessageDto chatMessage);
}
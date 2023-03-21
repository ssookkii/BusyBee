package mul.cam.a.service;

import mul.cam.a.dto.ChatMessageDto;

public interface ChatMessageService {
	public boolean saveChatMessage(ChatMessageDto chatMessage);
}
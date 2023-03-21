package mul.cam.a.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mul.cam.a.dao.ChatMessageDao;
import mul.cam.a.dto.ChatMessageDto;
import mul.cam.a.service.ChatMessageService;

@Service
public class ChatMessageServiceImpl implements ChatMessageService {
	
	@Autowired
	ChatMessageDao dao;
	
	public boolean saveChatMessage(ChatMessageDto chatMessage) {
		boolean isSuccess = dao.saveChatMessage(chatMessage) > 0 ? true : false;
		return isSuccess;
	}
}

package mul.cam.a.dao.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mul.cam.a.dao.ChatMessageDao;
import mul.cam.a.dto.ChatMessageDto;

@Repository
public class ChatMessageDaoImpl implements ChatMessageDao{
	
	@Autowired
	SqlSession session;
	
	public int saveChatMessage(ChatMessageDto chatMessage) {
		return session.insert("ChatMessage.saveChatMessage",chatMessage);
	}
}

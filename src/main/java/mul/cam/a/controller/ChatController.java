package mul.cam.a.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import mul.cam.a.dto.ChatMessageDto;
import mul.cam.a.dto.ChatRoomDto;
import mul.cam.a.service.ChatMessageService;
import mul.cam.a.service.ChatRoomService;

@Controller
public class ChatController {
	
	@Autowired
	ChatMessageService chatMessageService;

	// 전체 채팅방 
	@GetMapping("chating.do")
	public String chating(Model model, HttpSession session) {
		return "chating";
	}
	
	// 채팅내용 저장
	@RequestMapping(value="AllChatSave.do", method=RequestMethod.POST) //절대경로
	public String chatingDB(@RequestParam(value="writer")String writer,
			@RequestParam(value="message")String message,
			@RequestParam(value="recipient")String recipient) {

		String roomId = "AllChatRoom";
		ChatMessageDto chatMessage = new ChatMessageDto(roomId, writer, recipient, message);
		chatMessageService.saveChatMessage(chatMessage);
		return "chating";
	}
}

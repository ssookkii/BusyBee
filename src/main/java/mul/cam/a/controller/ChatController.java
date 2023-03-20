package mul.cam.a.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import mul.cam.a.dto.ChatMessageDto;
import mul.cam.a.service.ChatMessageService;


@Controller
public class ChatController {
	
	@Autowired
	ChatMessageService chatMessageService;

	// 전체 채팅방 
	@GetMapping("allChatting.do")
	public String chating(Model model, HttpSession session) {
		model.addAttribute("User", session.getAttribute("User"));
		return "allChatting";
	}

	// 채팅내용 저장
	@ResponseBody
	@RequestMapping(value="allChatSave.do", method=RequestMethod.POST) //절대경로
	public String chatingDB(@RequestParam(value="writer")String writer,
			@RequestParam(value="message")String message,
			@RequestParam(value="recipient")String recipient) {

		String roomId = "AllChatRoom";
		ChatMessageDto chatMessage = new ChatMessageDto(roomId, writer, recipient, message);
		boolean saveSuccess = chatMessageService.saveChatMessage(chatMessage);
		
		String resultMessage = "Fail";
		if (saveSuccess) resultMessage = "Success";
		return resultMessage;
	};
	
	
}
package mul.cam.a.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import mul.cam.a.dto.ChatRoomDto;
import mul.cam.a.service.ChatRoomService;

@Controller
public class ChatRoomController {
	@Autowired
	ChatRoomService chatRoomService;

	// 유저가 참여해있는 채팅방 표시
	@GetMapping("chatHome.do")
	public String chatHome(Model model, HttpSession session) {
		String user = (String)session.getAttribute("User"); // ㄹ그인 정보
		List<ChatRoomDto> allChatRoom = chatRoomService.printAllChatRoom(user);
		model.addAttribute("allChatRoom", allChatRoom);
		return "chatHome";
	}
	// 채팅방 생성
	@PostMapping(value = "chatHome.do")
	public String createChat (
			@RequestParam(value="roomId", required=true)String roomId,
			@RequestParam(value="title", required=true)String title,
			@RequestParam(value="description", required=true)String descriptions,
			@RequestParam(value="member", required=true)String members,
			HttpSession session,
			Model model
			) {
		String createdBy = (String)session.getAttribute("User"); // ㄹ그인 정보
		
		ChatRoomDto dto = new ChatRoomDto(roomId, title, descriptions, members, createdBy);
		Boolean isSuccess = chatRoomService.createChatRoom(dto);
		if (!isSuccess) { 
			model.addAttribute("fail create chat", "fail create Chat!");
			return "message";
		}
		return "redirect:/chatHome.do";
	}
	
	@GetMapping(value="chatRoom/{chatRoomId}.do")
	public String enterChatRoom(@PathVariable("chatRoomId")String chatRoomId, Model model) {
		ChatRoomDto dto = chatRoomService.chatRoomInfo(chatRoomId);
		model.addAttribute("chatRoomInfo", dto);
		return "chatRoom";
	}
}

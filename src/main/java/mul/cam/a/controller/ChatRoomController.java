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
import org.springframework.web.bind.annotation.ResponseBody;

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
		System.out.println(user);
		List<ChatRoomDto> allChatRoom = chatRoomService.printAllChatRoom(user);
		model.addAttribute("allChatRoom", allChatRoom);
		return "chatHome";
	}
	// 채팅방 생성 + 유효성검사(roomId 중복되면 안됨)
	@ResponseBody
	@RequestMapping(value = "createChat.do", method=RequestMethod.POST)
	public ChatRoomDto createChat (
			@RequestParam(value="roomId", required=true)String roomId,
			@RequestParam(value="title", required=true)String title,
			@RequestParam(value="description", required=true)String descriptions,
			@RequestParam(value="member", required=true)String members,
			HttpSession session,
			Model model
			) {
		ChatRoomDto isExistDto = chatRoomService.chatRoomInfo(roomId);
		if (isExistDto != null) { // 이미 존재하는 방이면 생성불가
			return null;
		}
		
		String createdBy = (String)session.getAttribute("User"); // ㄹ그인 정보
		ChatRoomDto dto = new ChatRoomDto(roomId, title, descriptions, members, createdBy);
		System.out.println(dto.getCreatedAt());
		Boolean isSuccess = chatRoomService.createChatRoom(dto);
		if (!isSuccess) { 
			return null;
		}
		return dto;
	}
	
	@GetMapping(value="teamChatting/{chatRoomId}.do")
	public String enterChatRoom(@PathVariable("chatRoomId")String chatRoomId, Model model, HttpSession session) {
		ChatRoomDto dto = chatRoomService.chatRoomInfo(chatRoomId);
		model.addAttribute("chatRoomInfo", dto);
		model.addAttribute("User", session.getAttribute("User"));
		return "teamChatting";
	}
	
	//AJAX
	@ResponseBody
	@RequestMapping(value = "showChatInfo.do", method=RequestMethod.POST)
	public ChatRoomDto showChatInfo(@RequestParam(value="chatRoomId")String chatRoomId) {
		ChatRoomDto chatRoomInfo = chatRoomService.chatRoomInfo(chatRoomId);
		return chatRoomInfo;
	}
	
	//AJAX
	@ResponseBody
	@RequestMapping(value = "exitChatRoom.do", method=RequestMethod.POST)
	public String exitChatRoom(@RequestParam(value="chatRoomId")String chatRoomId,
			HttpSession session) {
		String user = (String)session.getAttribute("User"); // 로그인정보
		boolean updateSuccess = chatRoomService.exitChatRoom(chatRoomId, user);
		
		String message ="Fail";
		if (updateSuccess) message = "Success";
		
		return message;
	}
}

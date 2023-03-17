package mul.cam.a.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ChatController {
	
	// 유저가 참여해있는 채팅방 표시
	@GetMapping("chatHome.do")
	public String chatHome(Model model, HttpSession session) {
		System.out.println((String)session.getAttribute("User"));
		String userId = (String)session.getAttribute("User");
		//List<ChatRoomDto> allChatRoom = service.printAllChatRoom(userId);
		//model.addAttribute("allChatRoom", allChatRoom);
		return "chatHome";
	}
	
	// 전체 채팅방 
	@GetMapping("chating.do")
	public String chating(Model model, HttpSession session) {
		System.out.println((String)session.getAttribute("User"));
		String userId = (String)session.getAttribute("User");
		//List<ChatRoomDto> allChatRoom = service.printAllChatRoom(userId);
		//model.addAttribute("allChatRoom", allChatRoom);
		return "chating";
	}
}

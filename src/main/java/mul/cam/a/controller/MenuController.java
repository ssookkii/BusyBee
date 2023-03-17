package mul.cam.a.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MenuController {

	@GetMapping(value = "login.do")
	public String login() {
		
		return "login";
	}
	
	@GetMapping(value = "calendar.do")
	public String calendar() {
		
		return "calendar";
	}

	 
	@GetMapping(value = "main.do")
	public String main() {

		
		return "main";
	}
	
	@GetMapping(value = "loginMain.do")
	public String loginMain() {
		
		return "loginMain";
	}
	@GetMapping(value = "goAddgroup.do")
	public String addgroup() {
		
		return "goAddgroup";
	}
	
	@GetMapping(value = "goMygroup.do")
	public String goMygroup() {
		
		return "goMygroup";
	}
	
	@GetMapping(value = "goSearchgroup.do")
	public String goSearchgroup() {
		
		return "goSearchgroup";
	}
	
	@GetMapping(value = "goNoti.do")
	public String goNoti() {
		return "goNoti";
	}
	
}
package mul.cam.a.controller;

import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MenuController {

	@GetMapping(value = "login.do")
	public String login() {
		System.out.println("login 메인화면 진입 " + new Date());
		
		return "login";
	}
	
	@GetMapping(value = "calendar.do")
	public String calendar() {
		System.out.println("calendar 일정 관리 화면 진입 " + new Date());
		
		return "calendar";
	}
	
	@GetMapping(value = "main.do")
	public String main() {
		System.out.println("main 화면 진입 " + new Date());
		
		return "main";
	}
	

	
	
}








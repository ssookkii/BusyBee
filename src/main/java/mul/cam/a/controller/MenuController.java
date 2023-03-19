package mul.cam.a.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	@GetMapping(value = "goUserinfo.do")
	public String goUserinfo() {

		return "goUserinfo";
	}
	
	@GetMapping(value = "loginMain.do")
	public String loginMain() {
		
		return "loginMain";
	}
	
	@GetMapping(value = "goAddgroup.do")
	public String goAddgroup() {
		
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
	
	@GetMapping(value = "goManagegroup.do")
	public String goManagegroup(Model model, String group_code) {
		
		model.addAttribute("group_code", group_code);
		return "goManagegroup";
	}
	
}








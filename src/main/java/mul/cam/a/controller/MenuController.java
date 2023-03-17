package mul.cam.a.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import mul.cam.a.dto.GroupMemDto;
import mul.cam.a.service.GroupService;

@Controller
public class MenuController {
	@Autowired
	GroupService service;

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
	
	@GetMapping(value = "goManagegroup.do")
	public String goManagegroup(Model model, String group_code) {
		
		model.addAttribute("group_code", group_code);
		return "goManagegroup";
	}
	
	
	/*그룹 메인 페이지 이동*/
	@GetMapping(value = "groupMainPage.do")
	public String groupMainPage(Model model, String group_code) {
		
		model.addAttribute("group_code", group_code);
		return "groupMainPage";
	}
	
}








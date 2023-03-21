package mul.cam.a.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
	
	@GetMapping(value = "goUserinfo.do")
	public String goUserinfo() {

		return "goUserinfo";
	}
	
	@GetMapping(value = "loginMain.do")
	public String loginMain() {
		
		return "loginMain";
	}
	
	@GetMapping(value = "idandpwd.do")
	public String findId() {
		
		return "idandpwd";
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
	
	/*그룹 메인 페이지 이동*/
	@GetMapping(value = "groupMainPage.do")
	public String groupMainPage(Model model, String group_code,String group_name) {
		
		model.addAttribute("group_code", group_code);
		model.addAttribute("group_name", group_name);
		
		

		return "groupMainPage";
	}
	
	/* 일정관리 이동 */
	@GetMapping(value = "goCalendar.do")
	public String goCalendar(Model model, String group_code, String group_name) {
		
		model.addAttribute("group_code", group_code);
		model.addAttribute("group_name", group_name);

		return "goCalendar";
	}
	
	/* 게시판 이동 */
	@GetMapping(value = "goBbslist.do")
	public String bbslist(Model model, String group_code, String group_name) {
		
		model.addAttribute("group_code", group_code);
		model.addAttribute("org", group_name);
		System.out.println(group_name);
		System.out.println(group_code);

		return "redirect:/bbssession.do";
	}
	
	/* 게시판 미리보기 */
	@GetMapping(value = "preBbslist.do")
	public String preBbslist(Model model, String group_code) {
		
		model.addAttribute("group_code", group_code);

		return "redirect:/bbslist.do";
	}
	
	/* 채팅창 이동 */
	
}
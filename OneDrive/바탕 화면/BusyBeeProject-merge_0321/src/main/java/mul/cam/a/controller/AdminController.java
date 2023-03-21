package mul.cam.a.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import mul.cam.a.dto.BbsDto;
import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.CustomerDto;
import mul.cam.a.dto.MemberDto;
import mul.cam.a.dto.ReportDto;
import mul.cam.a.dto.UserDto;
import mul.cam.a.dto.starDto;
import mul.cam.a.service.BbsService;
import mul.cam.a.service.MemberService;
import mul.cam.a.service.ReportService;
import mul.cam.a.service.UserService;


@Controller
public class AdminController {
	@Autowired
	ReportService reportService;
	@Autowired
	UserService userService;
	@Autowired
	BbsService bbsService;
	
	// 관리자 페이지로 이동
	@PostMapping(value = "admin.do")
	public String admin() {
		return "admin";
	}
	
	// 신고 관리
	@GetMapping(value = "reportList.do")
	public String reportList(BbsParam param, Model model) {

System.out.println("신고 관리 진입 " + new Date());
		
		// 글의 시작과 끝
		int pn = param.getPageNumber();  // 0 1 2 3 4
		int start = 1 + (pn * 10);	// 1  11
		int end = (pn + 1) * 10;	// 10 20 
		
		param.setStart(start);
		param.setEnd(end);
		
		List<ReportDto> list = reportService.reportList(param);
		int len = reportService.getAllReport(param);

		
		int pageBbs = len / 10;		// 25 / 10 -> 2
		if((len % 10) > 0) {
			pageBbs = pageBbs + 1;
		}
		
		if(param.getChoice() == null || param.getChoice().equals("")
				|| param.getSearch() == null || param.getSearch().equals("")) {
				param.setChoice("검색");
				param.setSearch("");
			}
		
		
		model.addAttribute("reportList", list);	// 신고회원 리스트
		model.addAttribute("pageBbs", pageBbs);	// 총 페이지수
		model.addAttribute("pageNumber", param.getPageNumber()); // 현재 페이지
		model.addAttribute("choice", param.getChoice());	// 검색 카테고리
		model.addAttribute("search", param.getSearch());	// 검색어	
		

	return "reportList";
	
	
	}


	// 게시글 관리 이동

	// 모든 게시글
	
	@GetMapping(value = "allbbslist.do")
	public String allbbslist(BbsParam param, Model model, HttpSession session) {
		System.out.println("allbbslist" + new Date());
		
		UserDto login = (UserDto)session.getAttribute("login");
		
		// 글의 시작과 끝
		int pn = param.getPageNumber();  // 0 1 2 3 4
		int start = 1 + (pn * 10);	// 1  11
		int end = (pn + 1) * 10;	// 10 20 
		
		param.setStart(start);
		param.setEnd(end);
		
		System.out.println(param.toString());
		
		List<BbsDto> list = bbsService.allbbslist(param);
		int len = bbsService.adminAllBbs(param);
		
		System.out.println("len: " + len);
		
		int pageBbs = len / 10;		// 25 / 10 -> 2
		if((len % 10) > 0) {
			pageBbs = pageBbs + 1;
		}
		
		if(param.getCategory() == null || param.getCategory().equals("")) {
			param.setCategory("");
		}
		
		if(param.getChoice() == null || param.getChoice().equals("")
				|| param.getSearch() == null || param.getSearch() == ("")) {
			param.setChoice("검색");
			param.setSearch("");
		}
		
		model.addAttribute("bbslist", list);	// 게시판 리스트
		model.addAttribute("pageBbs", pageBbs);	// 총 페이지수
		model.addAttribute("pageNumber", param.getPageNumber()); // 현재 페이지
		model.addAttribute("choice", param.getChoice());	// 검색 초이스
		model.addAttribute("search", param.getSearch());	// 검색어	


		
		return "allbbslist";
	}
	
	
	
	// 신고글 이동
	@GetMapping(value = "goReportPage.do")
	public String goReportPage(int seq, Model model) {
		BbsDto dto = bbsService.getBbs(seq);
		
		model.addAttribute("bbsdto", dto);
		return "redirect:/bbsdetail.do?seq="+seq;
	}
	
	// 회원 관리
		@GetMapping(value = "userList.do")
		public String userList(BbsParam param, Model model) {

	System.out.println("회원 관리 진입 " + new Date());
	
			// 글의 시작과 끝
			int pn = param.getPageNumber();  // 0 1 2 3 4
			int start = 1 + (pn * 10);	// 1  11
			int end = (pn + 1) * 10;	// 10 20 
			
			param.setStart(start);
			param.setEnd(end);
			
			List<UserDto> list = userService.userList(param);
			int len = userService.getAllUser(param);

			
			int pageBbs = len / 10;		// 25 / 10 -> 2
			if((len % 10) > 0) {
				pageBbs = pageBbs + 1;
			}
			
			if(param.getChoice() == null || param.getChoice().equals("")
					|| param.getSearch() == null || param.getSearch().equals("")) {
					param.setChoice("검색");
					param.setSearch("");
				}
			
			
			model.addAttribute("userList", list);	// 신고회원 리스트
			model.addAttribute("userList", list);	// 신고회원 리스트
			model.addAttribute("pageBbs", pageBbs);	// 총 페이지수
			model.addAttribute("pageNumber", param.getPageNumber()); // 현재 페이지
			model.addAttribute("choice", param.getChoice());	// 검색 카테고리
			model.addAttribute("search", param.getSearch());	// 검색어	
			

		return "userList";
		
		
		}
		
		@GetMapping(value = "userBan.do")
		public String userBan(Model model, UserDto dto) {
			
			boolean isS = userService.userBan(dto);
			String userBan = "";
			if(isS) {
				userBan = "USER_BAN_OK";
			}else {
				userBan = "USER_BAN_NG";
			}
			model.addAttribute("userBan", userBan);
			model.addAttribute("banId", dto.getId());

			
			return "message";
		}
		
		@GetMapping(value = "userIn.do")
		public String userIn(Model model, UserDto dto) {
			
			boolean isS = userService.userIn(dto);
			String userIn = "";
			if(isS) {
				userIn = "USER_IN_OK";
			}else {
				userIn = "USER_IN_NG";
			}
			model.addAttribute("userIn", userIn);
			model.addAttribute("inId", dto.getId());

			
			return "message";
		}
		
		// 신고기능
		@PostMapping(value = "reportSubmit.do")
		@ResponseBody
		public Map<String, Object> reportSubmit(ReportDto dto) {
			reportService.reportSubmit(dto);
			System.out.println(dto.toString());
	        Map<String, Object> submit = new HashMap<>();
	        submit.put("success", true); // JSON 데이터 생성
	        return submit;
			
		}
		
		
	
	

}
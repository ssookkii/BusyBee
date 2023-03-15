package mul.cam.a.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.CustomerDto;
import mul.cam.a.dto.ReportDto;
import mul.cam.a.service.ReportService;


@Controller
public class AdminController {
	@Autowired
	ReportService service;
	
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
		
		List<ReportDto> list = service.reportList(param);
		int len = service.getAllReport(param);

		
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
	
	

}

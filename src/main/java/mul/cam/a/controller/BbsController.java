package mul.cam.a.controller;

import java.io.File;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import mul.cam.a.dto.BbsDto;
import mul.cam.a.dto.BbsParam;
import mul.cam.a.service.BbsService;
import mul.cam.a.util.PdsUtil;

@Controller
public class BbsController {
	
	@Autowired
	BbsService service;
	
	@GetMapping(value = "bbslist.do")
	public String bbslist(BbsParam param, Model model) {
		System.out.println("bbslist" + new Date());
		
		// 글의 시작과 끝
		int pn = param.getPageNumber();  // 0 1 2 3 4
		int start = 1 + (pn * 10);	// 1  11
		int end = (pn + 1) * 10;	// 10 20 
		
		param.setStart(start);
		param.setEnd(end);
		
		List<BbsDto> list = service.bbslist(param);
		int len = service.getAllBbs(param);
		
		int pageBbs = len / 10;		// 25 / 10 -> 2
		if((len % 10) > 0) {
			pageBbs = pageBbs + 1;
		}
		
		if(param.getChoice() == null || param.getChoice().equals("")
				|| param.getSearch() == null || param.getSearch() == ("")) {
			param.setChoice("검색");
			param.setSearch("");
		}
		
		model.addAttribute("bbslist", list);	// 게시판 리스트
		model.addAttribute("pageBbs", pageBbs);	// 총 페이지수
		model.addAttribute("pageNumber", param.getPageNumber()); // 현재 페이지
		model.addAttribute("choice", param.getChoice());	// 검색 카테고리
		model.addAttribute("search", param.getSearch());	// 검색어	
		
		return "bbslist";
	}
	
	@GetMapping(value = "bbswrite.do")
	public String bbswrite() {
		System.out.println("bbswrite" + new Date());
		
		return "bbswrite";
	}
	
	@PostMapping(value = "bbswriteAf.do")
	public String bbswriteAf(Model model, BbsDto dto, 
							@RequestParam(value = "fileload", required = false)
							MultipartFile fileload,
							HttpServletRequest req) {
		System.out.println("bbswriteAfcontroller" + new Date());
		
	//	System.out.println(dto.toString());
		System.out.println(fileload);
		
		// filename 취득
		String filename = fileload.getOriginalFilename();	// 원본의 파일명
		
		if(filename != "") {
			System.out.println("파일첨부 작동");

			dto.setFilename(filename);	// 원본 파일명(DB)
			
			// upload의 경로 설정
			// server
			String fupload = req.getServletContext().getRealPath("/upload");
			// 폴더
		//	String fupload = "c:\\temp";
		//	System.out.println("fupload: " + fupload);
			
			// 파일명 충돌되지 않는 명칭(time)으로 변경
			String newfilename = PdsUtil.getNewFileName(filename);
			dto.setNewfilename(newfilename);	// 변경된 파일명(DB)
			
			File file = new File(fupload + "/" + newfilename);
			
			try {
				// 실제로 파일 생성 + 기입 = 업로드
				FileUtils.writeByteArrayToFile(file, fileload.getBytes());
				
				// DB에 저장
				boolean isS = service.writeBbs(dto);
				String bbswrite = "";
				
				if(isS) {
				//	System.out.println("bbswrite_YES");
					bbswrite = "bbswrite_YES";
				}else {
					bbswrite = "bbswrite_NO";
				}
				model.addAttribute("bbswrite", bbswrite);
					
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			System.out.println("파일미첨부 작동");
			
			boolean isS = service.writeBbs(dto);
			String bbswrite = "";
			
			if(isS) {
			//	System.out.println("bbswrite_YES");
				bbswrite = "bbswrite_YES";
			}else {
				bbswrite = "bbswrite_NO";
			}
			model.addAttribute("bbswrite", bbswrite);
		}
		
		return "message";
	}
	
}

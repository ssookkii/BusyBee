package mul.cam.a.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.CustomerDto;
import mul.cam.a.service.CustomerService;
import mul.cam.a.util.PdsUtil;


@Controller
public class CustomerController {
	
	@Autowired
	CustomerService service;

	@GetMapping(value = "customer.do")
	public String customer(BbsParam param, Model model) {
		System.out.println("고객센터 진입 " + new Date());
		
		// 글의 시작과 끝
		int pn = param.getPageNumber();  // 0 1 2 3 4
		int start = 1 + (pn * 10);	// 1  11
		int end = (pn + 1) * 10;	// 10 20 
		
		param.setStart(start);
		param.setEnd(end);
		
		List<CustomerDto> list = service.customer(param);
		int len = service.getAllCustomer(param);

		
		int pageBbs = len / 10;		// 25 / 10 -> 2
		if((len % 10) > 0) {
			pageBbs = pageBbs + 1;
		}
		
		if(param.getChoice() == null || param.getChoice().equals("")
				|| param.getSearch() == null || param.getSearch().equals("")) {
				param.setChoice("검색");
				param.setSearch("");
			}
			
			model.addAttribute("customer", list);	// 게시판 리스트
			model.addAttribute("pageBbs", pageBbs);	// 총 페이지수
			model.addAttribute("pageNumber", param.getPageNumber()); // 현재 페이지
			model.addAttribute("choice", param.getChoice());	// 검색 카테고리
			model.addAttribute("search", param.getSearch());	// 검색어	
			

		return "customer";
		
		
	}
	
	@GetMapping(value = "customerWrite.do")
	public String customerWrite() {
		return "customerWrite";
	}
	
	@PostMapping(value = "customerWriteAf.do")
	public String customerWriteAf(Model model, CustomerDto dto,
							@RequestParam(value = "fileload", required = false)
							MultipartFile fileload,
							HttpServletRequest req) {
		
		// filename 취득
		String filename = fileload.getOriginalFilename();	// 원본의 파일명
		
		dto.setFilename(filename);	// 원본 파일명(DB)
		
		// upload의 경로 설정
		// server
		String fupload = req.getServletContext().getRealPath("/upload");
		
		// 폴더
	//	String fupload = "c:\\temp";
		
		System.out.println("fupload:" + fupload);
		
		// 파일명을 충돌되지 않는 명칭(Date)으로 변경
		String newfilename = PdsUtil.getNewFileName(filename);
		
		dto.setNewfilename(newfilename);	// 변경된 파일명
		
		File file = new File(fupload + "/" + newfilename);
				 
		try {
			// 실제로 파일 생성 + 기입 = 업로드
			FileUtils.writeByteArrayToFile(file, fileload.getBytes());
			
		} catch (IOException e) {			
			e.printStackTrace();
		}
		
		boolean isS = service.customerWrite(dto);
		String customerWrite = "";		
		if(isS) {
			customerWrite = "CUS_ADD_OK";
		}else {
			customerWrite = "CUS_ADD_NG";
		}
		model.addAttribute("customerWrite", customerWrite);
		
		 return "message";
	}
	
	@GetMapping(value = "customerDetail.do")
	public String customerDetail(Model model, int seq) {
		CustomerDto dto = service.getCustomer(seq);
		model.addAttribute("dto", dto);
		
		return "customerDetail";
	}
	
	@PostMapping(value = "filedownLoad.do")
	public String filedownLoad(int seq, String filename, String newfilename, Model model, 
			HttpServletRequest req) {
		
		// 경로
		// server
		String fupload = req.getServletContext().getRealPath("/upload");
				
		// 폴더
		//	String fupload = "c:\\temp";
		
		// 다운로드 받을 파일
		File downloadFile = new File(fupload + "/" + newfilename);				
		
		model.addAttribute("downloadFile", downloadFile);	// file 실제 업로드되어 있는 파일명	경로/35435345345.txt
		model.addAttribute("filename", filename);		// 원 파일명					abc.txt
		model.addAttribute("seq", seq);					// download 카운트를 증가
		
		return "downloadView";
		
	}
	
	@GetMapping(value = "customerDelete.do")
	public String deletePds(CustomerDto dto, Model model) {
		boolean isS = service.customerDelete(dto);
		
		String customerDelete = "CUS_DEL_OK";
		if(!isS) {			
			customerDelete = "CUS_DEL_NG";
		}
		model.addAttribute("customerDelete", customerDelete);
		model.addAttribute("seq", dto.getSeq());
		
		return "message";
	}
	
	@GetMapping(value = "customerUpdate.do")
	public String customerUpdate(Model model,int seq) {
		CustomerDto dto = service.getCustomer(seq);
		
		model.addAttribute("dto", dto);
		return "customerUpdate";
	}
	
	@PostMapping(value = "customerUpdateAf.do")
	public String customerUpdateAf(Model model, CustomerDto dto, 
							@RequestParam(value = "fileload", required = false)
							MultipartFile fileload,
							HttpServletRequest req) {
String originalFileName = fileload.getOriginalFilename();
		
		if(originalFileName != null && !originalFileName.equals("")) { // 파일이 변경되었음
			
			String newfilename = PdsUtil.getNewFileName(originalFileName);
			
			dto.setFilename(originalFileName);
			dto.setNewfilename(newfilename);
			
			String fupload = req.getServletContext().getRealPath("/upload");			
			File file = new File(fupload + "/" + newfilename);
			
			try {
				// 새로운 파일로 업로드
				FileUtils.writeByteArrayToFile(file, fileload.getBytes());
				
				
			} catch (IOException e) {				
				e.printStackTrace();
			}			
			
		}else {	// 파일 변경되지 않았음
			service.customerUpdate(dto);
		}
		
		boolean isS = service.customerUpdate(dto);
		String customerUpdate = "";		
		if(isS) {
			customerUpdate = "CUS_UPDATE_OK";
		}else {
			customerUpdate = "CUS_UPDATE_NG";
		}
		model.addAttribute("customerUpdate", customerUpdate);
		model.addAttribute("seq", dto.getSeq());

		return "message";
		
		
		
	}
	
	@GetMapping(value = "customerAnswer.do")
	public String customerAnswer(Model model,int seq) {
		CustomerDto dto = service.getCustomer(seq);
		
		model.addAttribute("dto", dto);
		return "customerAnswer";
	}
	
	@PostMapping(value = "customerAnswerAf.do")
	public String customerAnswerAf(Model model, CustomerDto dto) {
		
		boolean isS = service.customerAnswer(dto);
		String customerAnswer = "";		
		if(isS) {
			customerAnswer = "CUS_ANSWER_OK";
		}else {
			customerAnswer = "CUS_ANSWER_NG";
		}
		model.addAttribute("customerAnswer", customerAnswer);
		model.addAttribute("seq", dto.getSeq());

		return "message";
		
	}
	
	
}

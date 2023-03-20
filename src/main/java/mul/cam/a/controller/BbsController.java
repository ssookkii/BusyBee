package mul.cam.a.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import mul.cam.a.dto.BbsComment;
import mul.cam.a.dto.BbsDto;
import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.UserDto;
import mul.cam.a.dto.starDto;
import mul.cam.a.service.BbsService;
import mul.cam.a.util.PdsUtil;

@Controller
public class BbsController {
	
	@Autowired
	BbsService service;
	
	@GetMapping(value = "bbslist.do")
	public String bbslist(BbsParam param, Model model, HttpSession session) {
		System.out.println("bbslist" + new Date());
		
		UserDto login = (UserDto)session.getAttribute("login");
		String id = login.getId();
		
		// 글의 시작과 끝
		int pn = param.getPageNumber();  // 0 1 2 3 4
		int start = 1 + (pn * 10);	// 1  11
		int end = (pn + 1) * 10;	// 10 20 
		
		param.setStart(start);
		param.setEnd(end);
		
		System.out.println(param.toString());
		
		List<starDto> star = service.starlist(id);
		List<BbsDto> list = service.bbslist(param);
		int len = service.getAllBbs(param);
		
		System.out.println("len: " + len);
		
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
		model.addAttribute("choice", param.getChoice());	// 검색 초이스
		model.addAttribute("search", param.getSearch());	// 검색어	
		model.addAttribute("category", param.getCategory());	// 카테고리
		model.addAttribute("login", login);
		model.addAttribute("starlist", star);
		
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
			System.out.println("fupload: " + fupload);
			
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
	
	@GetMapping(value = "bbsdetail.do")
	public String bbsdetail(Model model, int seq) {
		BbsDto dto = service.getBbs(seq);
		
		System.out.println(dto.toString());
		model.addAttribute("bbsdto", dto);
		
		return "bbsdetail";
	}
	
	@GetMapping(value = "bbsupdate.do")
	public String bbsupdate(Model model, int seq) {
		BbsDto dto = service.getBbs(seq);
		model.addAttribute("bbsdto", dto);
		
		return "bbsupdate";
	}
	
	@PostMapping(value = "bbsupdateAf.do")
	public String bbsupdateAf(Model model, BbsDto dto,
							@RequestParam(value = "fileload", required = false)
							MultipartFile fileload,
							HttpServletRequest req) {
		
		System.out.println("bbsupdateAfcontroller" + new Date());

		String originalFileName = fileload.getOriginalFilename();
		
		if(originalFileName != null && !originalFileName.equals("")) {	// 파일이 변경됨
			System.out.println("파일첨부 작동");
			
			String newfilename = PdsUtil.getNewFileName(originalFileName);
			
			dto.setFilename(originalFileName);
			dto.setNewfilename(newfilename);
			
			// upload의 경로 설정
			// server
			String fupload = req.getServletContext().getRealPath("/upload");
			// 폴더
		//	String fupload = "c:\\temp";
			
			File file = new File(fupload + "/" + newfilename);
			
			try {
				// 새로운 파일 업로드
				FileUtils.writeByteArrayToFile(file, fileload.getBytes());
				
				// DB갱신
				boolean isS = service.updateBbs(dto);
				System.out.println("DB 통과");
				
				String bbsupdate = "";
				
				if(isS) {
					bbsupdate = "bbsupdate_YES";
				}else {
					bbsupdate = "bbsupdate_NO";
				}
				model.addAttribute("bbsupdate", bbsupdate);
				
			} catch (IOException e) {
				e.printStackTrace();
			}
	
		} else {
			System.out.println("파일미첨부 작동");
			
			System.out.println(dto.toString());
			boolean isS = service.updateBbs(dto);
			System.out.println("DB 통과");
			
			String bbsupdate = "";
			
			if(isS) {
				bbsupdate = "bbsupdate_YES";
			}else {
				bbsupdate = "bbsupdate_NO";
			}
			
			System.out.println(isS);
			
			model.addAttribute("bbsupdate", bbsupdate);
			
			
		}
		return "message";
	}
	
	@PostMapping(value = "filedownload.do")
	public String filedownload(int seq, String filename, String newfilename, Model model, 
			HttpServletRequest req) {
		
		System.out.println("seq: " + seq);
		System.out.println("filename: " + filename);
		System.out.println("newfilename: " + newfilename);
		// 경로 취득
		String fupload = req.getServletContext().getRealPath("/upload");
		// 폴더
	//	String fupload = "c:\\temp";

		// 다운로드 받을 파일 
		File downloadfile = new File(fupload + "/" + newfilename);
		
		model.addAttribute("downloadfile", downloadfile);	// 실제 업로드 되어있는 파일명 		345345345.txt
		model.addAttribute("filename", filename);			// 원본 파일명					abc.txt
		model.addAttribute("seq", seq);						// download 카운트 증가
		
		return "downloadView";
	}
	
	
	@GetMapping(value = "bbsdelete.do")
	public String bbsdelete(Model model, int seq) {
		
		boolean isS = service.deleteBbs(seq);
		String bbsdelete = "";
		
		if(isS) {
			bbsdelete = "bbsdelete_YES";
		}else {
			bbsdelete = "bbsdelete_NO";
		}
		model.addAttribute("bbsdelete", bbsdelete);
		
		return "message";
		
	}
	
	// 댓글
	@PostMapping(value = "commentwriteAf.do")	
	public String commentwriteAf(Model model, BbsComment bbs, int seq) {
		
		boolean isS = service.commentWrite(bbs);
		String bbscomment = "";
		
		if(isS) {
			bbscomment = "bbscomment_YES";
		} else {
			bbscomment = "bbscomment_NO";
		}
		model.addAttribute("bbscomment", bbscomment);
		model.addAttribute("seq", seq);
		
		return "message";
		
	}
	
	@ResponseBody
	@GetMapping(value = "commentList.do")
	public List<BbsComment> commentList(int seq){
		System.out.println("commentList controller" + new Date());
		List<BbsComment> list = service.commentList(seq);
		
		return list;
	}
	
	@GetMapping(value = "deleteBbscomment.do")
	public String deleteBbscomment(Model model, int anseq, int seq) {
		System.out.println("deleteBbscomment controller" + new Date());
		
		System.out.println(seq);
		System.out.println(anseq);
		
		boolean isS = service.deleteBbscomment(anseq);
		String deleteBbscomment = "";
		
		if(isS) {
			deleteBbscomment = "deleteBbscomment_YES";
			System.out.println("댓글 삭제에 성공했습니다");
		}else {
			deleteBbscomment = "deleteBbscomment_NO";
			System.out.println("댓글 삭제에 실패했습니다");
		}
		model.addAttribute("deleteBbscomment", deleteBbscomment);
		model.addAttribute("seq", seq);
		
		return "message";
		
	}
	
	@ResponseBody
	@GetMapping(value = "staradd.do")
	public String staradd(Model model, starDto star) {
		System.out.println("staradd controller" + new Date());
		
	//	System.out.println("staradd: " + star.getSeq());
	//	System.out.println("id: " + star.getId());
		
		boolean isS = service.staradd(star);
		
		String staradd = "";
		if(isS) {
			staradd = "success";
		}
		return staradd;
		
		
	}
}

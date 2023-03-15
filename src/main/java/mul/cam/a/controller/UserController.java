package mul.cam.a.controller;

import java.io.File;
import java.io.IOException;

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

import mul.cam.a.dto.UserDto;
import mul.cam.a.service.UserService;
import mul.cam.a.util.FileUtil;

@Controller
public class UserController {

	@Autowired
	UserService service;
	
	@GetMapping(value = "regi1.do")
	public String regi1() {
		
		return "regi1";
	}
	
	@PostMapping(value = "regi2.do")
	public String regi2(Model model, String id, String password, String email) {
		
		model.addAttribute("id", id);
		model.addAttribute("password", password);
		model.addAttribute("email", email);
		
		return "regi2";
	}
	
	@PostMapping(value = "regiAf.do")
	public String regiAf(Model model, UserDto dto,
					@RequestParam(value = "profPic", required = false)
					MultipartFile profPic, HttpServletRequest req) {
		
		// filename 취득
		String filename = profPic.getOriginalFilename(); // 원본파일명
		dto.setProfPic_Origin(filename);
		
		// upload 경로 설정
		// to server
		String fUpload = req.getServletContext().getRealPath("/upload");
		
		// 파일명을 고유한 명칭으로 변경(Date)
		String newfilename = FileUtil.getNewFileName(filename);
		dto.setProfPic_Server(newfilename);
		
		File file = new File(fUpload + "/" + newfilename);
		
		try {
			FileUtils.writeByteArrayToFile(file, profPic.getBytes());
			
			System.out.println(fUpload);
			boolean isS = service.addUser(dto);
			
			String addUser_Msg = "addUser_FAIL";
			if(isS) {
				addUser_Msg = "addUser_SUCCESS";
			}
			
			model.addAttribute("addUser_Msg", addUser_Msg);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
				
		return "message";
	}
	
	@ResponseBody
	@PostMapping(value = "idCheck.do")
	public String idCheck(Model model, String id) {
		
		boolean isS = service.idCheck(id);
		
		String idCheck_Msg = "idCheck_SUCCESS";
		if(isS) {
			idCheck_Msg = "idCheck_IMPOSSIBLE";
		}
		
		return idCheck_Msg;
	}
	
	@PostMapping(value = "loginCheck.do")
	public String loginCheck(Model model, UserDto dto, HttpSession session) {
		
		UserDto login = service.login(dto);
		
		String loginCheck_Msg = "loginCheck_FAIL";
		
		if(login != null) {
			loginCheck_Msg = "loginCheck_SUCCESS";
			model.addAttribute("name", login.getName());
			model.addAttribute("loginCheck_Msg", loginCheck_Msg);
			session.setAttribute("login", login);
		}
		
		model.addAttribute("loginCheck_Msg", loginCheck_Msg);
		return "message";
	}
}

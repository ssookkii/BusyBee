package mul.cam.a.controller;

import java.io.File;
import java.io.IOException;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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

import mul.cam.a.dto.EmailCertiDto;
import mul.cam.a.dto.UserDto;
import mul.cam.a.service.UserService;
import mul.cam.a.util.FileUtil;

@Controller
public class UserController {

	@Autowired
	UserService service;

	@ResponseBody
	@GetMapping(value = "mailCheck.do")
	public String mailCheck(String email, String purpose) {

		String host = "smtp.naver.com";
		String user = "mulcamsemi2023@naver.com";
		String password = "semibusybee!";

		String to_email = email;

		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 465);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");

		StringBuffer temp =new StringBuffer();
		Random rnd = new Random();
		for(int i=0;i<6;i++) {
			temp.append(rnd.nextInt(10));
		}
		
		String AuthenticationKey = temp.toString();
		System.out.println(AuthenticationKey);

		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		try {
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(user, "Busy Bee"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to_email));

			msg.setSubject("안녕하세요? BUSY BEE 가입 인증 번호입니다..");
			
			String content = "<p style='background-color: rgb(255,197,0); color: rgb(70,15,11); font-weight: bold; font-size:20px;' >"
			  + "🐝  부지런히 일하는 '나'를 위한 협업 Tool, BUSY BEE  🐝"
			  + "</p><br>";
			
			content += "<p>안녕하세요?<p><br>"
					+ "꿀벌처럼 열심히 일하는 🐝 BUSY BEE 서비스팀 🐝 입니다.<br>";
			
			if(purpose.equals("regi") ) {
				content += "<p>BUSY BEE 회원 가입을 위해서 보내드리는 인증 번호입니다.</p><br>";
			} else {
				content += "<p>BUSY BEE 비밀번호 재설정을 위해서 보내드리는 인증 번호입니다.</p><br>";
			}
			
			content += "<p>인증번호는 아래와 같습니다.</p>"
					+ "<p style='font-size:30px; font-weight:bold'>" + AuthenticationKey + "</p><br>";
			
			content += "<p>인증번호 확인란에 위 번호를 입력하시고, 인증 확인 버튼을 눌러주세요.</p>"
					+ "<p>만약 본인이 요청한 인증이 아닐 경우, 메일을 삭제해주세요.</p>"
					+ "<p>감사합니다.</p><br>"
					+ "<p>🐝 BUSY BEE 서비스팀 드림 🐝</p>";	
			
			content += "<p style='background-color: rgb(255,197,0); color: rgb(70,15,11); font-weight: bold; font-size:10px;'>"
					+ "Copyright ⓒ BUSY BEE, 2023. All Rights Reserved."
					+ "</p>";
			
			msg.setContent(content, "text/html;charset=utf-8");

			Transport.send(msg);
			System.out.println("이메일 전송");
			
			service.addCert(new EmailCertiDto(0, to_email, AuthenticationKey, null));

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return AuthenticationKey;
	}
	

	@ResponseBody
	@GetMapping(value = "selectEmail.do")
	public String selectEmail(String email) {
		boolean isS = service.selectEmail(email);
		
		String selectEmail_Msg = "YES";
		if(isS) {
			selectEmail_Msg = "NO";
		}
		
		return selectEmail_Msg;
	}
	
	
	@ResponseBody
	@GetMapping(value = "selectCert.do")
	public String selectCert(EmailCertiDto dto) {
		
		boolean isS = service.selectCert(dto);
		
		String cert_Msg = "cert_FAIL";
		if(isS) {
			cert_Msg = "cert_SUCCESS";
			service.delCert(dto.getCert_email());
		}
		
		return cert_Msg;
	}
	
	@ResponseBody
	@GetMapping(value = "select3.do")
	public String select3(String cert_email) {
		
		service.valCert(cert_email);
		boolean isS = service.select3(cert_email);
		
		String cert3_Msg = "cert3_FAIL";
		if(isS) {
			cert3_Msg = "cert3_SUCCESS";
		}
		
		return cert3_Msg;
	}

	@PostMapping(value = "regiAf.do")
	public String regiAf(Model model, UserDto dto) {

		boolean isS = service.addUser(dto);

		String addUser_Msg = "addUser_FAIL";
		if(isS) {
			addUser_Msg = "addUser_SUCCESS";
		}

		model.addAttribute("addUser_Msg", addUser_Msg);

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

	@ResponseBody
	@GetMapping(value = "selectUser.do")
	public UserDto selectUser(String id) {

		return service.selectUser(id);
	}

	@PostMapping(value = "updUser_n.do")
	public String updUser_n(Model model, UserDto dto) {

		boolean isS = service.updUser_n(dto);

		String updUser_n_Msg = "updUser_n_FAIL";
		if(isS) {
			updUser_n_Msg = "updUser_n_SUCCESS";
		}

		model.addAttribute("updUser_n_Msg", updUser_n_Msg);

		return "message";
	}

	@PostMapping(value = "updUser_y.do")
	public String updUser_y(Model model, UserDto dto,
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
			boolean isS = service.updUser_y(dto);

			String updUser_y_Msg = "updUser_y_FAIL";
			if(isS) {
				updUser_y_Msg = "updUser_y_SUCCESS";
			}

			model.addAttribute("updUser_y_Msg", updUser_y_Msg);

		} catch (IOException e) {
			e.printStackTrace();
		}

		return "message";
	}

	@PostMapping(value = "updUser_b.do")
	public String updUser_b(Model model, UserDto dto) {

		boolean isS = service.updUser_b(dto);

		String updUser_b_Msg = "updUser_b_FAIL";
		if(isS) {
			updUser_b_Msg = "updUser_b_SUCCESS";
		}

		model.addAttribute("updUser_b_Msg", updUser_b_Msg);

		return "message";
	}
	
	@ResponseBody
	@PostMapping(value = "findId.do")
	public UserDto findId(Model model, UserDto dto) {

		return service.findId(dto);
	}
	
	@ResponseBody
	@PostMapping(value = "findforPwd.do")
	public String findforPwd(Model model, UserDto dto) {

		boolean isS = service.findforPwd(dto);
		String findforPwd_Msg;
		if(isS) {
			findforPwd_Msg = "findforPwd_SUCCESS";
		} else {
			findforPwd_Msg = "findforPwd_FAIL";
		}
		
		return findforPwd_Msg;
	}
	
	@PostMapping(value = "updPwd.do")
	public String updPwd(Model model, UserDto dto) {
		
		boolean isS = service.updPwd(dto);
		String updPwd_Msg;
		
		if(isS) {
			updPwd_Msg = "updPwd_SUCCESS";
		} else {
			updPwd_Msg = "updPwd_FAIL";
		}
		
		model.addAttribute("updPwd_Msg", updPwd_Msg);
		
		return "message";
	}

	@GetMapping(value = "delUser.do")
	public String delUser(Model model, String id) {

		boolean isS = service.delUser(id);

		String delUser_Msg = "delUser_FAIL";
		if(isS) {
			delUser_Msg = "delUser_SUCCESS";
		}

		model.addAttribute("delUser_Msg", delUser_Msg);

		return "message";
	}
}
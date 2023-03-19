package mul.cam.a.service;

import java.util.List;

import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.EmailCertiDto;
import mul.cam.a.dto.UserDto;

public interface UserService {

	boolean addCert(EmailCertiDto dto);
	boolean selectCert(EmailCertiDto dto);
	boolean select3(String id);
	boolean delCert(String email);
	boolean valCert(String email);
	boolean selectEmail(String email);
	
	// User 추가
	boolean addUser(UserDto dto);
	boolean addUser_N(UserDto dto);
	
	// ID 중복체크
	boolean idCheck(String id);
	
	// Login
	UserDto login(UserDto dto);
	
	UserDto selectUser(String id);
	
	boolean updUser_n(UserDto dto);
	boolean updUser_y(UserDto dto);
	boolean updUser_b(UserDto dto);
	
	UserDto findId(UserDto dto);
	boolean findforPwd(UserDto dto);
	boolean updPwd(UserDto dto);
	
	boolean delUser(String id);
	
	// 유저 리스트
	List<UserDto> userList(BbsParam param);
	
	// 유저 총 수
	int getAllUser(BbsParam param);
	
	// 유저 정지
	boolean userBan(UserDto dto);
	
	// 정지 해제
	boolean userIn(UserDto dto);
}
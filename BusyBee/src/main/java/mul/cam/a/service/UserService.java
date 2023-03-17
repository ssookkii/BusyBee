package mul.cam.a.service;

import mul.cam.a.dto.EmailCertiDto;
import mul.cam.a.dto.UserDto;

public interface UserService {

	boolean addCert(EmailCertiDto dto);
	boolean selectCert(EmailCertiDto dto);
	boolean select3(String id);
	
	// User 추가
	boolean addUser(UserDto dto);
	
	// ID 중복체크
	boolean idCheck(String id);
	
	// Login
	UserDto login(UserDto dto);
	
	UserDto selectUser(String id);
	
	boolean updUser_n(UserDto dto);
	boolean updUser_y(UserDto dto);
	boolean updUser_b(UserDto dto);
	
	boolean delUser(String id);
}

package mul.cam.a.service;

import mul.cam.a.dto.UserDto;

public interface UserService {

	// User 추가
	boolean addUser(UserDto dto);
	
	// ID 중복체크
	boolean idCheck(String id);
	
	// Login
	UserDto login(UserDto dto);
}

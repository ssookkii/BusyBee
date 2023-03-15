package mul.cam.a.service;

import mul.cam.a.dto.UserDto;

public interface UserService {

	// User 추가
	public boolean addUser(UserDto dto);
	
	// ID 중복체크
	public boolean idCheck(String id);
	
	// Login
	public UserDto login(UserDto dto);
}

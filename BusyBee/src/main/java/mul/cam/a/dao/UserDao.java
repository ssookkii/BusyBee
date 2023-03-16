package mul.cam.a.dao;

import mul.cam.a.dto.UserDto;

public interface UserDao {

	// User 추가
	int addUser(UserDto dto);
	
	// ID 중복체크
	int idCheck(String id);
	
	// Login
	UserDto login(UserDto dto);
}

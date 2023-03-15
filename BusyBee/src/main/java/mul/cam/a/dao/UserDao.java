package mul.cam.a.dao;

import mul.cam.a.dto.UserDto;

public interface UserDao {

	// User 추가
	public int addUser(UserDto dto);
	
	// ID 중복체크
	public int idCheck(String id);
	
	// Login
	public UserDto login(UserDto dto);
}

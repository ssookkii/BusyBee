package mul.cam.a.dao;

import mul.cam.a.dto.EmailCertiDto;
import mul.cam.a.dto.UserDto;

public interface UserDao {

	int addCert(EmailCertiDto dto);
	int selectCert(EmailCertiDto dto);
	int select3(String id);
	
	// User 추가
	int addUser(UserDto dto);
	
	// ID 중복체크
	int idCheck(String id);
	
	// Login
	UserDto login(UserDto dto);
	
	UserDto selectUser(String id);
	
	int updUser_n(UserDto dto);
	int updUser_y(UserDto dto);
	int updUser_b(UserDto dto);
	
	int delUser(String id);

}

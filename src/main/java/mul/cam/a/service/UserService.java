package mul.cam.a.service;

import java.util.List;

import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.UserDto;

public interface UserService {

	// User 추가
	public boolean addUser(UserDto dto);
	
	// ID 중복체크
	public boolean idCheck(String id);
	
	// Login
	public UserDto login(UserDto dto);
	
	// 유저 리스트
	List<UserDto> userList(BbsParam param);
	
	// 유저 총 수
	int getAllUser(BbsParam param);
	
	// 유저 정지
	boolean userBan(UserDto dto);
	
	// 정지 해제
	boolean userIn(UserDto dto);
	
	UserDto selectUser(String id);



}

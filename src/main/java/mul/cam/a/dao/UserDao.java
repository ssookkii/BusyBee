package mul.cam.a.dao;

import java.util.List;

import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.MemberDto;
import mul.cam.a.dto.UserDto;

public interface UserDao {

	// User 추가
	public int addUser(UserDto dto);
	
	// ID 중복체크
	public int idCheck(String id);
	
	// Login
	public UserDto login(UserDto dto);
	
	// 유저 리스트
	List<UserDto> userList(BbsParam param);
	
	// 유저 총 수
	int getAllUser(BbsParam param);
	
	// 유저 정지
	int userBan(UserDto dto);
	
	// 정지 해제
	int userIn(UserDto dto);
	
	UserDto selectUser(String id);

}

package mul.cam.a.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mul.cam.a.dao.UserDao;
import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.MemberDto;
import mul.cam.a.dto.UserDto;

@Repository
public class UserDaoImpl implements UserDao {

	@Autowired
	SqlSession session;
	
	String ns = "User.";
	
	@Override
	public int addUser(UserDto dto) {
		return session.insert(ns + "addUser", dto);
	}

	@Override
	public int idCheck(String id) {
		return session.selectOne(ns + "idCheck", id);
	}

	@Override
	public UserDto login(UserDto dto) {
		return session.selectOne(ns + "login", dto);
	}

	@Override
	public List<UserDto> userList(BbsParam param) {
		// TODO Auto-generated method stub
		return session.selectList(ns + "userList", param);
	}

	@Override
	public int getAllUser(BbsParam param) {
		// TODO Auto-generated method stub
		return session.selectOne(ns + "getAllUser", param);
	}

	@Override
	public int userBan(UserDto dto) {
		// TODO Auto-generated method stub
		return session.update(ns + "userBan", dto);
	}

	@Override
	public int userIn(UserDto dto) {
		// TODO Auto-generated method stub
		return session.update(ns + "userIn", dto);
	}

	@Override
	public UserDto selectUser(String id) {
		return session.selectOne(ns + "selectUser", id);
	}

}

package mul.cam.a.dao.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mul.cam.a.dao.UserDao;
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

}

package mul.cam.a.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mul.cam.a.dao.UserDao;
import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.EmailCertiDto;
import mul.cam.a.dto.UserDto;

@Repository
public class UserDaoImpl implements UserDao {

	@Autowired
	SqlSession session;
	
	String ns = "User.";
	
	@Override
	public int addCert(EmailCertiDto dto) {
		return session.insert(ns + "addCert", dto);
	}
	
	@Override
	public int selectCert(EmailCertiDto dto) {
		return session.selectOne(ns + "selectCert", dto);
	}
	
	@Override
	public int select3(String id) {
		return session.selectOne(ns + "select3", id);
	}
	
	@Override
	public int delCert(String email) {
		return session.delete(ns + "delCert", email);
	}
	
	@Override
	public int valCert(String email) {
		return session.delete(ns + "valCert", email);
	}
	
	@Override
	public int addUser(UserDto dto) {
		return session.insert(ns + "addUser", dto);
	}
	
	@Override
	public int addUser_N(UserDto dto) {
		return session.insert(ns + "addUser_N", dto);
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
	public UserDto selectUser(String id) {
		return session.selectOne(ns + "selectUser", id);
	}

	@Override
	public int updUser_n(UserDto dto) {
		return session.update(ns + "updUser_n", dto);
	}

	@Override
	public int updUser_y(UserDto dto) {
		return session.update(ns + "updUser_y", dto);
	}
	
	@Override
	public int updUser_b(UserDto dto) {
		return session.update(ns + "updUser_b", dto);
	}
	
	@Override
	public UserDto findId(UserDto dto) {
		return session.selectOne(ns + "findId", dto);
	}
	
	@Override
	public int findforPwd(UserDto dto) {
		return session.selectOne(ns + "findforPwd", dto);
	}

	@Override
	public int updPwd(UserDto dto) {
		return session.update(ns + "updPwd", dto);
	}

	@Override
	public int delUser(String id) {
		return session.delete(ns + "delUser", id);
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

}

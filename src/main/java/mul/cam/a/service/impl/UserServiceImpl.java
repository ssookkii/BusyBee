package mul.cam.a.service.impl;

<<<<<<< HEAD
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mul.cam.a.dao.UserDao;
import mul.cam.a.dto.UserDto;
import mul.cam.a.service.UserService;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDao dao;

	@Override
	public boolean addUser(UserDto dto) {
		int count = dao.addUser(dto);
		return count>0?true:false;
	}

	@Override
	public boolean idCheck(String id) {
		int count = dao.idCheck(id);
		
		// 참이면 ID 중복
		return count>0?true:false;
	}

	@Override
	public UserDto login(UserDto dto) {

		return dao.login(dto);
=======
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mul.cam.a.dao.UserDao;
import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.MemberDto;
import mul.cam.a.dto.UserDto;
import mul.cam.a.service.UserService;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDao dao;

	@Override
	public boolean addUser(UserDto dto) {
		int count = dao.addUser(dto);
		return count>0?true:false;
	}

	@Override
	public boolean idCheck(String id) {
		int count = dao.idCheck(id);
		
		// 참이면 ID 중복
		return count>0?true:false;
	}

	@Override
	public UserDto login(UserDto dto) {

		return dao.login(dto);
	}

	@Override
	public List<UserDto> userList(BbsParam param) {
		// TODO Auto-generated method stub
		return dao.userList(param);
	}

	@Override
	public int getAllUser(BbsParam param) {
		// TODO Auto-generated method stub
		return dao.getAllUser(param);
	}

	@Override
	public boolean userBan(UserDto dto) {
		int count = dao.userBan(dto);
		return count>0?true:false;
	}

	@Override
	public boolean userIn(UserDto dto) {
		int count = dao.userIn(dto);
		return count>0?true:false;
		
	}
	
	@Override
	public UserDto selectUser(String id) {
		return dao.selectUser(id);
>>>>>>> refs/remotes/origin/iye
	}
	
	
	
}

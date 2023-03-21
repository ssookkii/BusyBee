package mul.cam.a.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mul.cam.a.dao.UserDao;
import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.EmailCertiDto;
import mul.cam.a.dto.UserDto;
import mul.cam.a.service.UserService;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDao dao;

	@Override
	public boolean addCert(EmailCertiDto dto) {
		int count = dao.addCert(dto);
		return count>0?true:false;
	}

	@Override
	public boolean selectEmail(String email) {
		int count = dao.selectEmail(email);
		
		// true면 중복 이메일
		return count>0?true:false;
	}
	
	@Override
	public boolean selectCert(EmailCertiDto dto) {
		int count = dao.selectCert(dto);
		// true면 인증 완료
		return count>0?true:false;
	}
	
	@Override
	public boolean select3(String id) {
		int count = dao.select3(id);
		return count<3?true:false;
	}
	
	@Override
	public boolean delCert(String email) {
		int count = dao.delCert(email);
		return count>0?true:false;
	}
	
	@Override
	public boolean valCert(String email) {
		int count = dao.valCert(email);
		return count>0?true:false;
	}
	
	@Override
	public boolean addUser(UserDto dto) {
		int count = dao.addUser(dto);
		return count>0?true:false;
	}
	
	@Override
	public boolean addUser_N(UserDto dto) {
		int count = dao.addUser_N(dto);
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
	public UserDto selectUser(String id) {
		return dao.selectUser(id);
	}

	@Override
	public boolean updUser_n(UserDto dto) {
		int count = dao.updUser_n(dto);
		return count>0?true:false;
	}


	@Override
	public UserDto findId(UserDto dto) {
		return dao.findId(dto);
	}
	
	@Override
	public boolean findforPwd(UserDto dto) {
		int count = dao.findforPwd(dto);
		return count>0?true:false;
	}

	@Override
	public boolean updPwd(UserDto dto) {
		int count = dao.updPwd(dto);
		return count>0?true:false;
	}
	
	@Override
	public boolean delUser(String id) {
		int count = dao.delUser(id);
		return count>0?true:false;
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
	

}

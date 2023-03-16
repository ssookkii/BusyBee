package mul.cam.a.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mul.cam.a.dao.GroupDao;
import mul.cam.a.dto.GroupDto;
import mul.cam.a.dto.GroupMemDto;
import mul.cam.a.dto.NotiDto;
import mul.cam.a.service.GroupService;

@Service
public class GroupServiceImpl implements GroupService {

	@Autowired
	GroupDao dao;

	@Override
	public boolean addGroup(GroupDto dto) {
		int count = dao.addGroup(dto);
		return count>0?true:false;
	}

	@Override
	public boolean addGroupMem(GroupMemDto dto) {
		int count = dao.addGroupmem(dto);
		return count>0?true:false;
	}

	@Override
	public List<GroupDto> selectGroup1(String id) {
		return dao.selectGroup1(id);
	}
	
	@Override
	public List<GroupDto> selectGroup2(String id) {
		return dao.selectGroup2(id);
	}

	@Override
	public List<GroupDto> allGroup(GroupDto dto) {
		return dao.allGroup(dto);
	}

	@Override
	public boolean addNoti(NotiDto dto) {
		int count = dao.addNoti(dto);
		return count>0?true:false;
	}

	@Override
	public boolean checkDupl(GroupMemDto dto) {
		int count = dao.checkDupl(dto);
		
		// true면 이미 가입되어 있음
		return count>0?true:false;
	}


	
	
}

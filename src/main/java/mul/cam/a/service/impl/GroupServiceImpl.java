package mul.cam.a.service.impl;

<<<<<<< HEAD
import java.util.ArrayList;
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


	public List<String> getUserIdsByGroupId(String group_code) {
	    List<String> groupMembers = dao.getMembersByGroupCode(group_code);
	    
	    List<String> userIds = new ArrayList<>();
	    for (String id : groupMembers) {
	        userIds.add(id);

	   
	}
	    return userIds;

	}
	
	public GroupDto selectGroupInfo(String group_code) {
	    return dao.selectGroupInfo(group_code);
	}
}
	
	
=======
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
		int count = dao.addGroupMem(dto);
		return count>0?true:false;
	}
	
	@Override
	public boolean delGroupMem(GroupMemDto dto) {
		int count = dao.delGroupMem(dto);
		return count>0?true:false;
	}

	@Override
	public List<GroupDto> selectGroup1(String id) {
		return dao.selectGroup1(id);
	}
	
	@Override
	public boolean selectGroup1Cnt(GroupDto dto) {
		int count = dao.selectGroup1Cnt(dto);
		
		// true면 사용자가 리더라는 의미
		return count>0?true:false;
	}
	
	@Override
	public List<GroupDto> selectGroup2(String id) {
		return dao.selectGroup2(id);
	}
	
	@Override
	public boolean selectGroup2Cnt(GroupMemDto dto) {
		int count = dao.selectGroup2Cnt(dto);
		
		// true면 소속된 그룹이라는 의미
		return count>0?true:false;
	}

	@Override
	public List<GroupDto> allGroup(GroupDto dto) {
		return dao.allGroup(dto);
	}
	
	@Override
	public List<GroupMemDto> allGroupMem(String group_code) {
		return dao.allGroupMem(group_code);
	}

	@Override
	public GroupDto singleGroup(String group_code) {
		return dao.singleGroup(group_code);
	}
	
	@Override
	public boolean updGroup(GroupDto dto) {
		int count = dao.updGroup(dto);
		return count>0?true:false;
	}
	
	@Override
	public boolean updLeader(GroupDto dto) {
		int count = dao.updLeader(dto);
		return count>0?true:false;
	}
	
	@Override
	public boolean addNoti(NotiDto dto) {
		int count = dao.addNoti(dto);
		return count>0?true:false;
	}

	@Override
	public boolean deleteNoti(NotiDto dto) {
		int count = dao.deleteNoti(dto);
		return count>0?true:false;
	}
	
	@Override
	public List<NotiDto> selectNoti_from(String id) {
		return dao.selectNoti_from(id);
	}
	
	@Override
	public List<NotiDto> selectNoti_to(String id) {
		return dao.selectNoti_to(id);
	}

	@Override
	public boolean duplNoti(NotiDto dto) {
		int count = dao.duplNoti(dto);
		
		// true면 기존의 승인이 대기중이라는 의미
		return count>0?true:false;
	}

	@Override
	public boolean inv_duplNoti(NotiDto dto) {
		int count = dao.inv_duplNoti(dto);
		
		// true면 기존의 승인이 대기중이라는 의미
		return count>0?true:false;
	}



}
>>>>>>> refs/remotes/origin/iye

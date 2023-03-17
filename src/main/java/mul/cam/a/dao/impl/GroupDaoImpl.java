package mul.cam.a.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mul.cam.a.dao.GroupDao;
import mul.cam.a.dto.GroupDto;
import mul.cam.a.dto.GroupMemDto;
import mul.cam.a.dto.NotiDto;

@Repository
public class GroupDaoImpl implements GroupDao {

	@Autowired
	SqlSession session;

	String ns = "Group.";
	
	@Override
	public int addGroup(GroupDto dto) {
		return session.insert(ns + "addGroup", dto);
	}

	@Override
	public int addGroupMem(GroupMemDto dto) {
		return session.insert(ns + "addGroupMem", dto);
	}
	
	@Override
	public int delGroupMem(GroupMemDto dto) {
		return session.delete(ns + "delGroupMem", dto);
	}

	@Override
	public List<GroupDto> selectGroup1(String id) {
		List<GroupDto> dto = session.selectList(ns + "selectGroup1", id);
		return dto;
	}
	
	@Override
	public int selectGroup1Cnt(GroupDto dto) {
		return session.selectOne(ns + "selectGroup1Cnt", dto);
	}

	@Override
	public List<GroupDto> selectGroup2(String id) {
		List<GroupDto> dto = session.selectList(ns + "selectGroup2", id);
		return dto;
	}
	
	@Override
	public int selectGroup2Cnt(GroupMemDto dto) {
		return session.selectOne(ns + "selectGroup2Cnt", dto);
	}


	@Override
	public List<GroupDto> allGroup(GroupDto dto) {
		List<GroupDto> groups = session.selectList(ns + "allGroup", dto);
		return groups;
	}
	
	@Override
	public List<GroupMemDto> allGroupMem(String group_code) {
		return session.selectList(ns + "allGroupMem", group_code);
	}
	
	@Override
	public GroupDto singleGroup(String group_code) {
		return session.selectOne(ns + "singleGroup", group_code);
	}

	@Override
	public int updGroup(GroupDto dto) {
		return session.update(ns + "updGroup", dto);
	}
	
	@Override
	public int updLeader(GroupDto dto) {
		return session.update(ns + "updLeader", dto);
	}

	
	@Override
	public int addNoti(NotiDto dto) {
		return session.insert(ns + "addNoti", dto);
	}

	@Override
	public int deleteNoti(NotiDto dto) {
		return session.delete(ns + "deleteNoti", dto);
	}

	@Override
	public List<NotiDto> selectNoti_from(String id) {
		return session.selectList(ns + "selectNoti_from", id);
	}
	
	@Override
	public List<NotiDto> selectNoti_to(String id) {
		return session.selectList(ns + "selectNoti_to", id);
	}

	@Override
	public int duplNoti(NotiDto dto) {
		return session.selectOne(ns + "duplNoti", dto);
	}

	@Override
	public int inv_duplNoti(NotiDto dto) {
		return session.selectOne(ns + "inv_duplNoti", dto);
	}

	@Override
	public List<String> getMembersByGroupCode(String group_code) {
	    return session.selectList(ns + "getMembersByGroupCode", group_code);
	}
	
	public GroupDto selectGroupInfo(String group_code) {
	    return session.selectOne(ns + "selectGroupInfo", group_code);
	}
}
	
	


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
	public int addGroupmem(GroupMemDto dto) {
		return session.insert(ns + "addGroupMem", dto);
	}

	@Override
	public List<GroupDto> selectGroup1(String id) {
		List<GroupDto> dto = session.selectList(ns + "selectGroup1", id);
		return dto;
	}

	@Override
	public List<GroupDto> selectGroup2(String id) {
		List<GroupDto> dto = session.selectList(ns + "selectGroup2", id);
		return dto;
	}

	@Override
	public List<GroupDto> allGroup(GroupDto dto) {
		List<GroupDto> groups = session.selectList(ns + "allGroup", dto);
		return groups;
	}

	@Override
	public int addNoti(NotiDto dto) {
		return session.insert(ns + "addNoti", dto);
	}

	@Override
	public int checkDupl(GroupMemDto dto) {
		return session.selectOne(ns = "checkDupl", dto);
	}

	@Override
	public List<String> getMembersByGroupCode(String group_code) {
	    return session.selectList(ns + "getMembersByGroupCode", group_code);
	}
	
	public GroupDto selectGroupInfo(String group_code) {
	    return session.selectOne(ns + "selectGroupInfo", group_code);
	}
}
	
	


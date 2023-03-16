package mul.cam.a.dao;

import java.util.List;

import mul.cam.a.dto.GroupDto;
import mul.cam.a.dto.GroupMemDto;
import mul.cam.a.dto.NotiDto;

public interface GroupDao {

	int addGroup(GroupDto dto);
	int addGroupmem(GroupMemDto dto);
	
	List<GroupDto> selectGroup1(String id);
	List<GroupDto> selectGroup2(String id);
	
	List<GroupDto> allGroup(GroupDto dto);
	int checkDupl(GroupMemDto dto);
	
	int addNoti(NotiDto dto);
	
	 List<String> getMembersByGroupCode(String group_code);
	 public GroupDto selectGroupInfo(String group_code);
}

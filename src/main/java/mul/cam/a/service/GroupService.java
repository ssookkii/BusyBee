package mul.cam.a.service;

import java.util.List;

import mul.cam.a.dto.GroupDto;
import mul.cam.a.dto.GroupMemDto;
import mul.cam.a.dto.NotiDto;

public interface GroupService {

	boolean addGroup(GroupDto dto);
	
	boolean addGroupMem(GroupMemDto dto);
	
	List<GroupDto> selectGroup1(String id);
	List<GroupDto> selectGroup2(String id);
	
	List<GroupDto> allGroup(GroupDto dto);
	boolean checkDupl(GroupMemDto dto);
	
	boolean addNoti(NotiDto dto);

	List<String> getUserIdsByGroupId(String group_code);
	public GroupDto selectGroupInfo(String group_code);
}

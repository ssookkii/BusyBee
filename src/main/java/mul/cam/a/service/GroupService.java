package mul.cam.a.service;

import java.util.List;

import mul.cam.a.dto.GroupDto;
import mul.cam.a.dto.GroupMemDto;
import mul.cam.a.dto.NotiDto;

public interface GroupService {

	boolean addGroup(GroupDto dto);
	boolean addGroupMem(GroupMemDto dto);
	boolean delGroupMem(GroupMemDto dto);
	
	GroupDto singleGroup(String group_code);
	List<GroupDto> selectGroup1(String id);
	boolean selectGroup1Cnt(GroupDto dto);
	List<GroupDto> selectGroup2(String id);
	boolean selectGroup2Cnt(GroupMemDto dto);
	
	List<GroupDto> allGroup(GroupDto dto);
	List<GroupMemDto> allGroupMem(String group_code);
	
	boolean updGroup(GroupDto dto);
	boolean updLeader(GroupDto dto);
	
	boolean addNoti(NotiDto dto);
	boolean deleteNoti(NotiDto dto);
	List<NotiDto> selectNoti_from(String id);
	List<NotiDto> selectNoti_to(String id);
	
	boolean duplNoti(NotiDto dto);
	boolean inv_duplNoti(NotiDto dto);
}

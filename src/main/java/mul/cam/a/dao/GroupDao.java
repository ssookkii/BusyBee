package mul.cam.a.dao;

import java.util.List;

import mul.cam.a.dto.GroupDto;
import mul.cam.a.dto.GroupMemDto;
import mul.cam.a.dto.NotiDto;

public interface GroupDao {

	int addGroup(GroupDto dto);
	int addGroupMem(GroupMemDto dto);
	int delGroupMem(GroupMemDto dto);
	int delGroup(String group_code);
	
	GroupDto singleGroup(String group_code);
	List<GroupDto> similarGroup(String search);
	
	List<GroupDto> selectGroup1(String id);
	int selectGroup1Cnt(GroupDto dto);
	List<GroupDto> selectGroup2(String id);
	int selectGroup2Cnt(GroupMemDto dto);
	List<GroupDto> allGroup(GroupDto dto);
	
	List<GroupMemDto> allGroupMem(String group_code);
	
	int updGroup(GroupDto dto);
	int updLeader(GroupDto dto);
	
	int addNoti(NotiDto dto);
	int deleteNoti(NotiDto dto);
	List<NotiDto> selectNoti_from(String id);
	List<NotiDto> selectNoti_to(String id);
	
	int duplNoti(NotiDto dto);
	int inv_duplNoti(NotiDto dto);
	
	 List<String> getMembersByGroupCode(String group_code);
	 public GroupDto selectGroupInfo(String group_code);
}
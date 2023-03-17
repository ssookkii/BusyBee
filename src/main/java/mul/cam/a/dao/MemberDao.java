package mul.cam.a.dao;

import java.util.List;

import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.MemberDto;

public interface MemberDao {

	List<MemberDto> allMember();
	
	int getAllMember(BbsParam param);

	int idCheck(String id);
	
	int addMember(MemberDto dto);
	
	MemberDto login(MemberDto dto);
	
	
}

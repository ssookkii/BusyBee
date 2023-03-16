package mul.cam.a.service;

import java.util.List;

import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.MemberDto;

public interface MemberService {

	List<MemberDto> allMember();
	
	int getAllMember(BbsParam param);
	
	boolean idCheck(String id);
	boolean addMember(MemberDto dto);
	MemberDto login(MemberDto dto);
}

package mul.cam.a.dao;

import java.util.List;

import mul.cam.a.dto.BbsComment;
import mul.cam.a.dto.BbsDto;
import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.starDto;

public interface BbsDao {
	
	List<BbsDto> bbslist(BbsParam bbs);
	
	int getAllBbs(BbsParam bbs);
	
	int writeBbs(BbsDto dto);

	BbsDto getBbs(int seq);
	
	int updateBbs(BbsDto dto);
	
	int deleteBbs(int seq);
	
	int commentWrite(BbsComment bbs);
	
	List<BbsComment> commentList(int seq);
	
	int deleteBbscomment(int anseq);
	
	int staradd(starDto star);
	
	List<starDto> starlist(String id);
}


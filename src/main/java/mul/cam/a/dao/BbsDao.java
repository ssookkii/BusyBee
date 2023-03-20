package mul.cam.a.dao;

import java.util.List;

import mul.cam.a.dto.BbsComment;
import mul.cam.a.dto.BbsDto;
import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.MyBbsParam;
import mul.cam.a.dto.starDto;

public interface BbsDao {
	
	List<BbsDto> bbslist(BbsParam bbs);
	
	int getAllBbs(BbsParam bbs);
	
	int writeBbs(BbsDto dto);

	BbsDto getBbs(int seq);
	int updatereadcount(int seq);
	
	int updateBbs(BbsDto dto);
	
	int deleteBbs(int seq);
	
	int commentWrite(BbsComment bbs);
	
	List<BbsComment> commentList(int seq);
	
	int deleteBbscomment(int anseq);
	
	int staradd(starDto star);
	
	List<starDto> starlist(String id);
	
	int stardelete(starDto star);
	
	List<BbsDto> mybbslist(MyBbsParam mybbs);
	int getMyBbs(MyBbsParam param);
	
	List<BbsDto> mystarlist(MyBbsParam mybbs);
	int getMystarBbs(MyBbsParam param);
	
	// 게시판 미리보기
	List<BbsDto> preBbsList(String group_code);
	
	// 모든 게시글
	List<BbsDto> allbbslist(BbsParam bbs);


}
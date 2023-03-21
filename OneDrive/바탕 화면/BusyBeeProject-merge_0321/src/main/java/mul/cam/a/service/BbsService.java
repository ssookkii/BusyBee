package mul.cam.a.service;

import java.util.List;

import mul.cam.a.dto.BbsComment;
import mul.cam.a.dto.BbsDto;
import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.MyBbsParam;
import mul.cam.a.dto.starDto;

public interface BbsService {
	
	boolean writeBbs (BbsDto dto);
	
	List<BbsDto> bbslist(BbsParam bbs);
	
	int getAllBbs(BbsParam bbs);

	BbsDto getBbs(int seq);
	
	boolean updateBbs (BbsDto dto);
	
	boolean deleteBbs (int seq);
	
	boolean commentWrite (BbsComment bbs);
	
	List<BbsComment> commentList(int seq);
	
	boolean deleteBbscomment (int anseq);
	
	boolean staradd (starDto star);
	
	List<starDto> starlist(String id);
	
	boolean stardelete (starDto star);
	
	List<BbsDto> mybbslist(MyBbsParam mybbs);
	int getMyBbs(MyBbsParam mybbs);
	
	List<BbsDto> mystarlist(MyBbsParam mybbs);
	int getMystarBbs(MyBbsParam param);
	
	List<BbsDto> preBbsList(String group_code);
	
	List<BbsDto> allbbslist(BbsParam bbs);

	int adminAllBbs(BbsParam bbs);

}
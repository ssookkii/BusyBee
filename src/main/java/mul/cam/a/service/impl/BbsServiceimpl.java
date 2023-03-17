package mul.cam.a.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mul.cam.a.dao.BbsDao;
import mul.cam.a.dto.BbsComment;
import mul.cam.a.dto.BbsDto;
import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.starDto;
import mul.cam.a.service.BbsService;

@Service
public class BbsServiceimpl implements BbsService {

	@Autowired
	BbsDao dao;
	
	@Override
	public List<BbsDto> bbslist(BbsParam bbs) {		
		return dao.bbslist(bbs);
	}

	@Override
	public int getAllBbs(BbsParam bbs) {		
		return dao.getAllBbs(bbs);
	}

	@Override
	public boolean writeBbs(BbsDto dto) {
		System.out.println("bbswriteAfBbsService" + new Date());
		
		return dao.writeBbs(dto)>0?true:false;
	}
	
	@Override
	public BbsDto getBbs(int seq) {
		return dao.getBbs(seq);
	}
	
	@Override
	public boolean updateBbs(BbsDto dto) {
		System.out.println("updateBbsService" + new Date());
		int n = dao.updateBbs(dto);
		return n>0?true:false;
	}
	
	@Override
	public boolean deleteBbs(int seq) {
		return dao.deleteBbs(seq)>0?true:false;
	}
	
	@Override
	public boolean commentWrite(BbsComment bbs) {
		return dao.commentWrite(bbs)>0?true:false;
	}
	
	@Override
	public List<BbsComment> commentList(int seq) {
		System.out.println("commentList service" + new Date());
		return dao.commentList(seq);
	}	
	
	@Override
	public boolean deleteBbscomment(int anseq) {
		System.out.println("deleteBbscomment service" + new Date());
		return dao.deleteBbscomment(anseq)>0?true:false;
	}

	@Override
	public boolean staradd(starDto star) {
		System.out.println("staradd Service" + new Date());
		return dao.staradd(star)>0?true:false;
	}
	
	@Override
	public List<starDto> starlist(String id) {
		System.out.println("starlist Service" + new Date());
		return dao.starlist(id);
	}
}

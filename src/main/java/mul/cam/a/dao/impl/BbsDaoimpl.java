package mul.cam.a.dao.impl;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mul.cam.a.dao.BbsDao;
import mul.cam.a.dto.BbsComment;
import mul.cam.a.dto.BbsDto;
import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.MyBbsParam;
import mul.cam.a.dto.starDto;

@Repository
public class BbsDaoimpl implements BbsDao {
	
	@Autowired
	SqlSession session;
	
	String ns = "Bbs.";
	
	@Override
	public List<BbsDto> bbslist(BbsParam bbs) {
		System.out.println("bbslist dao" + new Date());
		return session.selectList(ns + "bbslist", bbs);
	}

	@Override
	public int getAllBbs(BbsParam bbs) {		
		return session.selectOne(ns + "getAllBbs", bbs);
	}

	@Override
	public int writeBbs(BbsDto dto) {
		System.out.println("bbswriteAfBbsDao" + new Date());
		
		return session.insert(ns + "writeBbs", dto);
	}
	
	@Override
	public BbsDto getBbs(int seq) {
		System.out.println("getBbsDao" + new Date());
		
		return session.selectOne(ns + "getBbs", seq);
	}
	@Override
	public int updatereadcount(int seq) {
	//	System.out.println("updatereadcountdao" + new Date());
		return session.update(ns + "updatereadcount", seq);
	}

	@Override
	public int updateBbs(BbsDto dto) {
		System.out.println("updateBbsDao" + new Date());
		
		return session.update(ns + "updateBbs", dto);
	}

	@Override
	public int deleteBbs(int seq) {
		return session.delete(ns + "deletBbs", seq);
	}
	
	@Override
	public int commentWrite(BbsComment bbs) {
		return session.insert(ns + "commentWrite", bbs);
	}
	
	@Override
	public List<BbsComment> commentList(int seq) {
		System.out.println("commentList dao" + new Date());
		return session.selectList(ns + "commentList", seq);
	}
	
	@Override
	public int deleteBbscomment(int anseq) {
		System.out.println("deleteBbscomment dao" + new Date());
		return session.delete(ns + "deleteBbscomment", anseq);
	}

	@Override
	public int staradd(starDto star) {
		System.out.println("staradd dao" + new Date());
		return  session.insert(ns + "staradd", star);
	}
	
	@Override
	public List<starDto> starlist(String id) {
		System.out.println("starlist dao" + new Date());
		return session.selectList(ns + "starlist", id);
	}
	
	@Override
	public int stardelete(starDto star) {
		System.out.println("stardelete dao" + new Date());
		return session.delete(ns + "stardelete", star);
	}
	
	@Override
	public List<BbsDto> mybbslist(MyBbsParam mybbs) {
		return session.selectList(ns + "mybbslist", mybbs);
	}
	
	@Override
	public int getMyBbs(MyBbsParam param) {
		return session.selectOne(ns + "getMyBbs", param);
	}

	@Override
	public List<BbsDto> mystarlist(MyBbsParam mybbs) {
		return session.selectList(ns + "mystarlist", mybbs);
	}

	@Override
	public int getMystarBbs(MyBbsParam param) {
		// TODO Auto-generated method stub
		return session.selectOne(ns + "getMystarBbs", param);
	}

	@Override
	public List<BbsDto> preBbsList(String group_code) {
		// TODO Auto-generated method stub
		return session.selectList(ns + "preBbsList", group_code);
	}

	@Override
	public List<BbsDto> allbbslist(BbsParam bbs) {
		// TODO Auto-generated method stub
		return session.selectList(ns + "allbbslist", bbs);
	}

	@Override
	public int adminAllBbs(BbsParam bbs) {
		// TODO Auto-generated method stub
		return session.selectOne(ns + "adminAllBbs", bbs);
	}
	
	
	
}
package mul.cam.a.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mul.cam.a.dao.ReportDao;
import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.ReportDto;

@Repository
public class ReportDaoImpl implements ReportDao{

	@Autowired
	SqlSession session;
	
	String ns = "Report.";
	
	@Override
	public List<ReportDto> reportList(BbsParam param) {
		// TODO Auto-generated method stub
		return session.selectList(ns + "reportList", param);
	}

	@Override
	public int getAllReport(BbsParam param) {
		// TODO Auto-generated method stub
		return session.selectOne(ns + "getAllReport", param);
	}

	@Override
	public int reportSubmit(ReportDto dto) {
		// TODO Auto-generated method stub
		return session.insert(ns + "reportSubmit", dto);
	}



}
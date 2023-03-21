package mul.cam.a.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mul.cam.a.dao.ReportDao;
import mul.cam.a.dao.UserDao;
import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.ReportDto;
import mul.cam.a.dto.UserDto;
import mul.cam.a.service.ReportService;

@Service
public class ReportServiceImpl implements ReportService{

	@Autowired
	ReportDao dao;
	@Autowired
	UserDao userDao;
	
	@Override
	public List<ReportDto> reportList(BbsParam param) {
		// TODO Auto-generated method stub
		return dao.reportList(param);
	}

	@Override
	public int getAllReport(BbsParam param) {
		// TODO Auto-generated method stub
		return dao.getAllReport(param);
	}

	@Override
	public boolean reportSubmit(ReportDto dto) {
		int count = dao.reportSubmit(dto);
		return count>0?true:false;
	}

}
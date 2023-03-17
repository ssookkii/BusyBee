package mul.cam.a.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mul.cam.a.dao.CustomerDao;
import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.CustomerDto;
import mul.cam.a.service.CustomerService;

@Service
public class CustomerServiceImpl implements CustomerService{

	@Autowired
	CustomerDao dao;
	
	@Override
	public List<CustomerDto> customer(BbsParam bbs) {
		// TODO Auto-generated method stub
		return dao.customer(bbs);
	}

	@Override
	public int getAllCustomer(BbsParam bbs) {
		// TODO Auto-generated method stub
		return dao.getAllCustomer(bbs);
	}

	@Override
	public boolean customerWrite(CustomerDto dto) {
		int count = dao.customerWrite(dto);
		return count>0?true:false;
	}

	@Override
	public CustomerDto getCustomer(int seq) {
		// TODO Auto-generated method stub
		return dao.getCustomer(seq);
	}

	@Override
	public boolean customerDelete(CustomerDto dto) {
		int count = dao.customerDelete(dto);

		return count>0?true:false;
	}

	@Override
	public boolean customerUpdate(CustomerDto dto) {
		int count = dao.customerUpdate(dto);
		return count>0?true:false;
	}

	@Override
	public boolean customerAnswer(CustomerDto dto) {
		dao.customerAnswerUpdate(dto);
		int count = dao.customerAnswer(dto);
		return count>0?true:false;
	}



}

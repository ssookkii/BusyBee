package mul.cam.a.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mul.cam.a.dao.CustomerDao;
import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.CustomerDto;

@Repository
public class CustomerDaoImpl implements CustomerDao{
	
	@Autowired
	SqlSession session;

	String ns = "Customer.";
	@Override
	public List<CustomerDto> customer(BbsParam bbs) {
		// TODO Auto-generated method stub
		return session.selectList(ns + "customer", bbs);
	}
	@Override
	public int getAllCustomer(BbsParam bbs) {
		// TODO Auto-generated method stub
		return session.selectOne(ns + "getAllCustomer", bbs);
	}
	@Override
	public int customerWrite(CustomerDto dto) {
		// TODO Auto-generated method stub
		return session.insert(ns + "customerWrite", dto);
	}
	@Override
	public CustomerDto getCustomer(int seq) {
		// TODO Auto-generated method stub
		return session.selectOne(ns + "getCustomer", seq);
	}
	@Override
	public int customerDelete(CustomerDto dto) {
		// TODO Auto-generated method stub
		return session.delete(ns + "customerDelete", dto);
	}
	@Override
	public int customerUpdate(CustomerDto dto) {
		// TODO Auto-generated method stub
		return session.delete(ns + "customerUpdate", dto);
	}
	@Override
	public int customerAnswer(CustomerDto dto) {
		// TODO Auto-generated method stub
		return session.insert(ns + "customerAnswer", dto);
	}
	@Override
	public int customerAnswerUpdate(CustomerDto dto) {
		// TODO Auto-generated method stub
		return session.update(ns + "customerAnswerUpdate", dto);
	}
	
}
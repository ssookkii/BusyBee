package mul.cam.a.dao;

import java.util.List;

import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.CustomerDto;

public interface CustomerDao {

	List<CustomerDto> customer(BbsParam bbs);
	
	int getAllCustomer(BbsParam bbs);
	
	
	// CRUD
	int customerWrite(CustomerDto dto);
	
	CustomerDto getCustomer(int seq);
	
	int customerDelete(CustomerDto dto);
	
	int customerUpdate(CustomerDto dto);
	
	/* 답글 */
	int customerAnswer(CustomerDto dto);

	int customerAnswerUpdate(CustomerDto dto);

	
}

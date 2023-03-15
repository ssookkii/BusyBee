package mul.cam.a.service;

import java.util.List;

import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.CustomerDto;

public interface CustomerService {
	
	List<CustomerDto> customer(BbsParam bbs);

	int getAllCustomer(BbsParam bbs);

	// 문의하기
	boolean customerWrite(CustomerDto dto);
	
	CustomerDto getCustomer(int seq);

	boolean customerDelete(CustomerDto dto);
	
	boolean customerUpdate(CustomerDto dto);
	
	/* 답글 */
	boolean customerAnswer(CustomerDto dto);


}

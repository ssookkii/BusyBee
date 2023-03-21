package mul.cam.a.dao;

import java.util.List;


import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.ReportDto;
import mul.cam.a.dto.UserDto;

public interface ReportDao {

	List<ReportDto> reportList(BbsParam param);
	
	int getAllReport(BbsParam param);
	
	int reportSubmit(ReportDto dto);

}
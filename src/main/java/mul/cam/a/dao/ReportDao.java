package mul.cam.a.dao;

import java.util.List;


import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.ReportDto;

public interface ReportDao {

	List<ReportDto> reportList(BbsParam param);
	
	int getAllReport(BbsParam param);
	
	int reportSubmit(ReportDto dto);
	
	int countUp(ReportDto dto);
	
}
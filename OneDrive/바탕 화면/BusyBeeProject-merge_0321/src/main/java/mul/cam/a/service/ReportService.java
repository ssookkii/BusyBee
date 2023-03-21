package mul.cam.a.service;

import java.util.List;

import mul.cam.a.dto.BbsParam;
import mul.cam.a.dto.ReportDto;

public interface ReportService {

	List<ReportDto> reportList(BbsParam param);
	
	int getAllReport(BbsParam param);

	boolean reportSubmit(ReportDto dto);
	

}
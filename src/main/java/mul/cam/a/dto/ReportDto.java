package mul.cam.a.dto;

public class ReportDto {
	
	private int report_id;
	private String reporter_id;
	private String reported_id;
	private String report_content;
	private int report_seq;
	private String report_type;
	private String report_date;
	private int auth;
	private int report_count;
	
	public ReportDto(int report_id, String reporter_id, String reported_id, String report_content, int report_seq,
			String report_type, String report_date, int auth, int report_count) {
		super();
		this.report_id = report_id;
		this.reporter_id = reporter_id;
		this.reported_id = reported_id;
		this.report_content = report_content;
		this.report_seq = report_seq;
		this.report_type = report_type;
		this.report_date = report_date;
		this.auth = auth;
		this.report_count = report_count;
	}

	
	public ReportDto() {
		// TODO Auto-generated constructor stub
	}




	

	public int getReport_id() {
		return report_id;
	}
	public void setReport_id(int report_id) {
		this.report_id = report_id;
	}
	
	
	public int getReport_count() {
		return report_count;
	}
	
	public void setReport_count(int report_count) {
		this.report_count = report_count;
	}
	public String getReporter_id() {
		return reporter_id;
	}
	public void setReporter_id(String reporter_id) {
		this.reporter_id = reporter_id;
	}
	public String getReported_id() {
		return reported_id;
	}
	public void setReported_id(String reported_id) {
		this.reported_id = reported_id;
	}
	public String getReport_content() {
		return report_content;
	}
	public void setReport_content(String report_content) {
		this.report_content = report_content;
	}
	public int getReport_seq() {
		return report_seq;
	}
	public void setReport_seq(int report_seq) {
		this.report_seq = report_seq;
	}
	public String getReport_type() {
		return report_type;
	}
	public void setReport_type(String report_type) {
		this.report_type = report_type;
	}
	public String getReport_date() {
		return report_date;
	}
	public void setReport_date(String report_date) {
		this.report_date = report_date;
	}
	public int getAuth() {
		return auth;
	}
	public void setAuth(int auth) {
		this.auth = auth;
	}


}

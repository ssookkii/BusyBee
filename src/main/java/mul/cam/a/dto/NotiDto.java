package mul.cam.a.dto;

public class NotiDto {

	private int seq;
	private String to_id;
	private String from_id;
	private String group_code;
	private String regidate;
	
	public NotiDto() {
	}

	public NotiDto(int seq, String to_id, String from_id, String group_code, String regidate) {
		super();
		this.seq = seq;
		this.to_id = to_id;
		this.from_id = from_id;
		this.group_code = group_code;
		this.regidate = regidate;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getTo_id() {
		return to_id;
	}

	public void setTo_id(String to_id) {
		this.to_id = to_id;
	}

	public String getFrom_id() {
		return from_id;
	}

	public void setFrom_id(String from_id) {
		this.from_id = from_id;
	}

	public String getGroup_code() {
		return group_code;
	}

	public void setGroup_code(String group_code) {
		this.group_code = group_code;
	}

	public String getRegidate() {
		return regidate;
	}

	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}
	
	
}

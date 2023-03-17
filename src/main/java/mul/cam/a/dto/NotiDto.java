package mul.cam.a.dto;

public class NotiDto {

	private int seq;
	private String to_id;
	private String name;
	private String from_id;
	private String group_code;
	private String group_name;
	private String regimsg;
	private String regidate;
	
	public NotiDto() {
	}

	public NotiDto(int seq, String to_id, String from_id_name, String from_id, String group_code, String group_name,
			String regimsg, String regidate) {
		super();
		this.seq = seq;
		this.to_id = to_id;
		this.name = name;
		this.from_id = from_id;
		this.group_code = group_code;
		this.group_name = group_name;
		this.regimsg = regimsg;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getGroup_name() {
		return group_name;
	}

	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}

	public String getRegimsg() {
		return regimsg;
	}

	public void setRegimsg(String regimsg) {
		this.regimsg = regimsg;
	}

	public String getRegidate() {
		return regidate;
	}

	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}

}

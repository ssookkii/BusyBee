package mul.cam.a.dto;

import java.io.Serializable;

public class GroupMemDto implements Serializable {

	private int seq;
	private String id;
	private String group_code;
	private String regidate;
	
	public GroupMemDto() {
	}

	public GroupMemDto(int seq, String id, String group_code, String regidate) {
		super();
		this.seq = seq;
		this.id = id;
		this.group_code = group_code;
		this.regidate = regidate;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

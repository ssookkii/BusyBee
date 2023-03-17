
package mul.cam.a.dto;

import java.io.Serializable;

public class GroupMemDto implements Serializable {

	private int seq;
	private String id;
	private String group_code;
	private String regidate;
	
	// Params for allGroupMem.do
	private String name;
	private String email;
	private String phone;
	private String phone_public;

	
	public GroupMemDto() {
	}

	public GroupMemDto(int seq, String id, String group_code, String regidate) {
		super();
		this.seq = seq;
		this.id = id;
		this.group_code = group_code;
		this.regidate = regidate;
	}
	
	

	public GroupMemDto(String name, String email, String phone, String phone_public) {
		super();
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.phone_public = phone_public;
	}
	
	

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPhone_public() {
		return phone_public;
	}

	public void setPhone_public(String phone_public) {
		this.phone_public = phone_public;
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

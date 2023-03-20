package mul.cam.a.dto;

import java.io.Serializable;

public class MemberDto implements Serializable{
	
	private String id;
	private String pwd;
	private String name;
	private String email;
	private int auth;
	private int reported_count;
	
	public MemberDto() {
	}



	public MemberDto(String id, String pwd, String name, String email, int auth, int reported_count) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.auth = auth;
		this.reported_count = reported_count;
	}



	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
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

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}
	
	
	
	

	public int getReported_count() {
		return reported_count;
	}

	public void setReported_count(int reported_count) {
		this.reported_count = reported_count;
	}

	@Override
	public String toString() {
		return "MemberDto [id=" + id + ", pwd=" + pwd + ", name=" + name + ", email=" + email + ", auth=" + auth + "]";
	}
	

}

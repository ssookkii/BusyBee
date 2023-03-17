
package mul.cam.a.dto;

import java.io.Serializable;

public class UserDto implements Serializable {

	String id;
	String password;
	String name;
	String birth;
	String email;
	String phone;
	String phone_public;
	int auth;
	String profMsg;
	String profPic_Origin;
	String profPic_Server;
	String regidate;
	int reported_count;
	
	public UserDto() {
	}
	



	public UserDto(String id, String password, String name, String birth, String email, String phone,
			String phone_public, int auth, String profMsg, String profPic_Origin, String profPic_Server,
			String regidate, int reported_count, int seq) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
		this.birth = birth;
		this.email = email;
		this.phone = phone;
		this.phone_public = phone_public;
		this.auth = auth;
		this.profMsg = profMsg;
		this.profPic_Origin = profPic_Origin;
		this.profPic_Server = profPic_Server;
		this.regidate = regidate;
		this.reported_count = reported_count;
	}




	public UserDto(String id, String password) {
		super();
		this.id = id;
		this.password = password;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
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
	public int getAuth() {
		return auth;
	}
	public void setAuth(int auth) {
		this.auth = auth;
	}
	public String getProfMsg() {
		return profMsg;
	}
	public void setProfMsg(String profMsg) {
		this.profMsg = profMsg;
	}
	public String getProfPic_Origin() {
		return profPic_Origin;
	}

	public void setProfPic_Origin(String profPic_Origin) {
		this.profPic_Origin = profPic_Origin;
	}

	public String getProfPic_Server() {
		return profPic_Server;
	}

	public void setProfPic_Server(String profPic_Server) {
		this.profPic_Server = profPic_Server;
	}

	public String getRegidate() {
		return regidate;
	}
	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}



	public int getReported_count() {
		return reported_count;
	}



	public void setReported_count(int reported_count) {
		this.reported_count = reported_count;
	}

	
	


	
	
	
	
}

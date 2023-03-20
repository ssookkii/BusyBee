package mul.cam.a.dto;

public class EmailCertiDto {

	private int seq;
	private String cert_email;
	private String authkey;
	private String senddate;
	
	public EmailCertiDto() {
	}
	
	public EmailCertiDto(int seq, String cert_email, String authkey, String senddate) {
		super();
		this.seq = seq;
		this.cert_email = cert_email;
		this.authkey = authkey;
		this.senddate = senddate;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getCert_email() {
		return cert_email;
	}

	public void setCert_email(String cert_email) {
		this.cert_email = cert_email;
	}

	public String getAuthkey() {
		return authkey;
	}

	public void setAuthkey(String authkey) {
		this.authkey = authkey;
	}

	public String getSenddate() {
		return senddate;
	}

	public void setSenddate(String senddate) {
		this.senddate = senddate;
	}
	
}

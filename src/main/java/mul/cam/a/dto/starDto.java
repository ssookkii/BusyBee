package mul.cam.a.dto;

public class starDto {
	
	private int seq;		// sequence	번호
	private String id;		// 작성자
	
	public starDto() {
		// TODO Auto-generated constructor stub
	}

	public starDto(int seq, String id) {
		super();
		this.seq = seq;
		this.id = id;
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

	@Override
	public String toString() {
		return "starDto [seq=" + seq + ", id=" + id + "]";
	}
	

}

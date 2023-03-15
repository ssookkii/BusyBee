package mul.cam.a.dto;

import java.io.Serializable;

// BBS  Bulletin Board System
public class CustomerDto implements Serializable {

	private int seq;		// sequence 글번호
	private String id;		// 작성자
	
	private int ref;		// 답글용	 	그룹번호(글번호)	
	private int step;		//			행번호
	private int depth;		//			깊이
	
	private String filename;	// 원본 파일명		abc.txt
	private String newfilename;	// 업로드 파일명   4543464.txt
	
	private String title;
	private String content;
	private String wdate;
	private boolean secret;
	
 CustomerDto(int seq, String id, int ref, int step, int depth, String filename, String newfilename,
			String title, String content, String wdate, boolean secret) {
		super();
		this.seq = seq;
		this.id = id;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
		this.filename = filename;
		this.newfilename = newfilename;
		this.title = title;
		this.content = content;
		this.wdate = wdate;
		this.secret = secret;
	}





	public boolean isSecret() {
		return secret;
	}





	public void setSecret(boolean secret) {
		this.secret = secret;
	}





	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getNewfilename() {
		return newfilename;
	}

	public void setNewfilename(String newfilename) {
		this.newfilename = newfilename;
	}



	
	public CustomerDto() {
	}

	public CustomerDto(String id, String title, String content) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
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

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}



	@Override
	public String toString() {
		return "CustomerDto [seq=" + seq + ", id=" + id + ", ref=" + ref + ", step=" + step + ", depth=" + depth + ", title="
				+ title + ", content=" + content + ", wdate=" + wdate + 
				"]";
	}
	
}

package mul.cam.a.dto;

import java.io.Serializable;



public class BbsComment implements Serializable{

	private int seq;
	private int anseq;
	private String id;
	private String content;
	private String wdate;
	
	public BbsComment() {
		// TODO Auto-generated constructor stub
	}

	public BbsComment(int seq, int anseq, String id, String content, String wdate) {
		super();
		this.seq = seq;
		this.anseq = anseq;
		this.id = id;
		this.content = content;
		this.wdate = wdate;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getAnseq() {
		return anseq;
	}

	public void setAnseq(int anseq) {
		this.anseq = anseq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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
		return "BbsComment [seq=" + seq + ", anseq=" + anseq + ", id=" + id + ", content=" + content + ", wdate="
				+ wdate + "]";
	}
	
	
	
}

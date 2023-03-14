package mul.cam.a.dto;

import java.io.Serializable;

// BBS  Bulletin Board System
public class BbsDto implements Serializable {

	private int seq;		// sequence	번호
	private String id;		// 작성자
	
	private int ref;		// 답글용 그룹번호(글번호)
	private int step;		// 행번호 
	private int depth;		// 길이
	
	private String title;		// 글 제목
	private String content;	// 글내용
	private String wdate;	// 글작성일자
	
	private int del;		// 삭제여부
	private int readcount;	// 조회수
	
	private int star;		// 중요
	private int org;		// 조직
	
	private String filename;		// 파일명
	private String newfilename;		// 시스템파일명
	private String category;		// 분류
	
	public BbsDto() {
		// TODO Auto-generated constructor stub
	}



	public BbsDto(String id, String title, String content, int org, String filename, String newfilename,
			String category) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.org = org;
		this.filename = filename;
		this.newfilename = newfilename;
		this.category = category;
	}



	public BbsDto(int seq, String id, int ref, int step, int depth, String title, String content, String wdate, int del,
			int readcount, int star, int org, String filename, String newfilename, String category) {
		super();
		this.seq = seq;
		this.id = id;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
		this.title = title;
		this.content = content;
		this.wdate = wdate;
		this.del = del;
		this.readcount = readcount;
		this.star = star;
		this.org = org;
		this.filename = filename;
		this.newfilename = newfilename;
		this.category = category;
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

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public int getStar() {
		return star;
	}

	public void setStar(int star) {
		this.star = star;
	}

	public int getOrg() {
		return org;
	}

	public void setOrg(int org) {
		this.org = org;
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

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	@Override
	public String toString() {
		return "BbsDto [seq=" + seq + ", id=" + id + ", ref=" + ref + ", step=" + step + ", depth=" + depth + ", title="
				+ title + ", content=" + content + ", wdate=" + wdate + ", del=" + del + ", readcount=" + readcount
				+ ", star=" + star + ", org=" + org + ", filename=" + filename + ", newfilename=" + newfilename
				+ ", category=" + category + "]";
	}
	
	
}

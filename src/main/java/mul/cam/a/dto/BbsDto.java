package mul.cam.a.dto;

import java.io.Serializable;

/*
-- 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.

-- busybee_bbs Table Create SQL
-- 테이블 생성 SQL - busybee_bbs
CREATE TABLE busybee_bbs
(
    `seq`        INT              NOT NULL    AUTO_INCREMENT COMMENT '글번호. 글번호', 
    `ref`        DECIMAL(8)       NOT NULL    COMMENT '그룹번호. 그룹번호', 
    `step`       DECIMAL(8)       NOT NULL    COMMENT '행번호. 행번호', 
    `depth`      DECIMAL(8)       NOT NULL    COMMENT '깊이번호. 깊이번호', 
    `id`         VARCHAR(50)      NOT NULL    COMMENT '작성자. 회원 아이디', 
    `title`      VARCHAR(200)     NOT NULL    COMMENT '제목. 제목', 
    `content`    VARCHAR(4000)    NOT NULL    COMMENT '내용. 내용', 
    `wdate`      TIMESTAMP        NOT NULL    COMMENT '작성일. 작성일', 
    `readcount`  DECIMAL(8)       NOT NULL    COMMENT '조회수. 조회수', 
    `org`        VARCHAR(50)      NOT NULL    COMMENT '조직명. 조직명', 
    `filename`   VARCHAR(50)      NOT NULL    COMMENT '파일명. 파일명', 
    `newfname`   VARCHAR(50)      NOT NULL    COMMENT '시스템파일명. 시스템파일명', 
    `category`   VARCHAR(50)      NOT NULL    COMMENT '카테고리', 
    `del`        INT              NOT NULL    COMMENT '삭제', 
     PRIMARY KEY (seq)
);


-- busybee_bbscomment Table Create SQL
-- 테이블 생성 SQL - busybee_bbscomment
CREATE TABLE busybee_bbscomment
(
    `seq`      INT              NOT NULL    COMMENT '글번호. 부모글번호', 
    `anseq`    INT              NOT NULL    AUTO_INCREMENT COMMENT '댓글번호. 댓글번호', 
    `id`       VARCHAR(50)      NOT NULL    COMMENT '작성자. 회원 아이디', 
    `content`  VARCHAR(4000)    NOT NULL    COMMENT '내용. 내용', 
    `wdate`    TIMESTAMP        NOT NULL    COMMENT '작성일. 작성일', 
     PRIMARY KEY (anseq)
);

-- Foreign Key 설정 SQL - busybee_bbscomment(seq) -> busybee_bbs(seq)
ALTER TABLE busybee_bbscomment
    ADD CONSTRAINT FK_busybee_bbscomment_seq_busybee_bbs_seq FOREIGN KEY (seq)
        REFERENCES busybee_bbs (seq) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - busybee_bbscomment(seq)
-- ALTER TABLE busybee_bbscomment
-- DROP FOREIGN KEY FK_busybee_bbscomment_seq_busybee_bbs_seq;


-- busybee_star Table Create SQL
-- 테이블 생성 SQL - busybee_star
CREATE TABLE busybee_star
(
    `id`   VARCHAR(50)    NOT NULL    COMMENT '작성자', 
    `seq`  INT            NOT NULL    COMMENT '글번호'
);

-- Foreign Key 설정 SQL - busybee_star(id, seq) -> busybee_bbs(id, seq)
ALTER TABLE busybee_star
    ADD CONSTRAINT FK_busybee_star_id_busybee_bbs_id FOREIGN KEY (id, seq)
        REFERENCES busybee_bbs (id, seq) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Foreign Key 삭제 SQL - busybee_star(id, seq)
-- ALTER TABLE busybee_star
-- DROP FOREIGN KEY FK_busybee_star_id_busybee_bbs_id;

*/

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

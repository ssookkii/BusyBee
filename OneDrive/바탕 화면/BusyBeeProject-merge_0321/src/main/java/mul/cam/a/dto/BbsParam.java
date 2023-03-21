package mul.cam.a.dto;

import java.io.Serializable;

public class BbsParam implements Serializable{

	private String choice;	// 제목/내용/작성자
	private String search;	// 검색어
	private String category;	// 분류
	private int pageNumber; // [1][2][3]
	private String group_code;	// 코드
	private String org;
	
	private int start;
	private int end;
	
	public BbsParam() {
	}

	public BbsParam(String choice, String search, String category, int pageNumber, String group_code, String org,
			int start, int end) {
		super();
		this.choice = choice;
		this.search = search;
		this.category = category;
		this.pageNumber = pageNumber;
		this.group_code = group_code;
		this.org = org;
		this.start = start;
		this.end = end;
	}



	public String getChoice() {
		return choice;
	}

	public void setChoice(String choice) {
		this.choice = choice;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}

	public String getGroup_code() {
		return group_code;
	}

	public void setGroup_code(String group_code) {
		this.group_code = group_code;
	}

	public String getOrg() {
		return org;
	}

	public void setOrg(String org) {
		this.org = org;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	@Override
	public String toString() {
		return "BbsParam [choice=" + choice + ", search=" + search + ", category=" + category + ", pageNumber="
				+ pageNumber + ", group_code=" + group_code + ", org=" + org + ", start=" + start + ", end=" + end
				+ "]";
	}

	

	

	
	
}
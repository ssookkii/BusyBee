package mul.cam.a.dto;

import java.io.Serializable;

public class GroupDto implements Serializable {

	private String group_code;
	private String group_name;
	private String group_info;
	private String leader_name;
	private String leader_id;
	private String regidate;
	
	// Params for allGroup.do
	private String choice;
	private String search;
	
	public GroupDto() {
	}

	public GroupDto(String group_code, String group_name, String group_info, String leader_name, String leader_id,
			String regidate) {
		super();
		this.group_code = group_code;
		this.group_name = group_name;
		this.group_info = group_info;
		this.leader_name = leader_name;
		this.leader_id = leader_id;
		this.regidate = regidate;
	}
	
	public GroupDto(String choice, String search) {
		super();
		this.choice = choice;
		this.search = search;
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

	public String getGroup_code() {
		return group_code;
	}

	public void setGroup_code(String group_code) {
		this.group_code = group_code;
	}

	public String getGroup_name() {
		return group_name;
	}

	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}

	public String getGroup_info() {
		return group_info;
	}

	public void setGroup_info(String group_info) {
		this.group_info = group_info;
	}

	public String getLeader_name() {
		return leader_name;
	}

	public void setLeader_name(String leader_name) {
		this.leader_name = leader_name;
	}

	public String getLeader_id() {
		return leader_id;
	}

	public void setLeader_id(String leader_id) {
		this.leader_id = leader_id;
	}

	public String getRegidate() {
		return regidate;
	}

	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}

	
}

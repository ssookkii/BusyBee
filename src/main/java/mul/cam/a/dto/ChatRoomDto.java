package mul.cam.a.dto;

import java.util.Date;
import java.util.List;

public class ChatRoomDto {
	
	//participants 제거
	private String roomId;
	private String title;
	private String descriptions;
	private String members;
	private String createdBy; 
	private Date createdAt;
	
	public ChatRoomDto() {
	}

	public ChatRoomDto(String title, String descriptions, String members) {
		super();
		this.title = title;
		this.descriptions = descriptions;
		this.members = members;
	}

	public ChatRoomDto(String title, String descriptions, String members, String createdBy) {
		super();
		this.title = title;
		this.descriptions = descriptions;
		this.members = members;
		this.createdBy = createdBy;
	}

	public ChatRoomDto(String roomId, String title, String descriptions, String members, String createdBy) {
		super();
		this.roomId = roomId;
		this.title = title;
		this.descriptions = descriptions;
		this.members = members;
		this.createdBy = createdBy;
	}

	public ChatRoomDto(String roomId, String title, String descriptions, String members, String createdBy,
			Date createdAt) {
		super();
		this.roomId = roomId;
		this.title = title;
		this.descriptions = descriptions;
		this.members = members;
		this.createdBy = createdBy;
		this.createdAt = createdAt;
	}

	public String getRoomId() {
		return roomId;
	}

	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescriptions() {
		return descriptions;
	}

	public void setDescriptions(String descriptions) {
		this.descriptions = descriptions;
	}

	public String getMembers() {
		return members;
	}

	public void setMembers(String members) {
		this.members = members;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	

}

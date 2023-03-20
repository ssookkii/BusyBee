package mul.cam.a.dto;

import java.util.Date;

public class ChatMessageDto {
	private String roomId;
	private String writer;
	private String recipient;
	private String message;
	private Date sendTime;
	
	public ChatMessageDto() {
		
	}

	public ChatMessageDto(String roomId, String writer, String recipient, String message) {
		super();
		this.roomId = roomId;
		this.writer = writer;
		this.recipient = recipient;
		this.message = message;
	}
	
	public String getRoomId() {
		return roomId;
	}
	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getRecipient() {
		return recipient;
	}
	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Date getSendTime() {
		return sendTime;
	}
	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}
	
	
}

package mul.cam.a.dto;

import java.io.Serializable;

public class EventDto implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private int scheduleId;      // 일정 번호
	private String id;           // 사용자 id
	private String title;        // 일정 제목
	private String description;  // 일정 내용
	private String startDate;    // 시작일
	private String endDate;      // 종료일
	private String groupCode;    // 일정 그룹 코드
	private boolean isPublic;    // 일정 공개 여부
	private boolean isAllDay;    // 종일 일정 여부

	public EventDto() {
	}

	public EventDto(int scheduleId, String id, String title, String description, String startDate,
			String endDate, String groupCode, boolean isPublic, boolean isAllDay) {
		super();
		this.scheduleId = scheduleId;
		this.id = id;
		this.title = title;
		this.description = description;
		this.startDate = startDate;
		this.endDate = endDate;
		this.groupCode = groupCode;
		this.isPublic = isPublic;
		this.isAllDay = isAllDay;
	}

	public int getScheduleId() {
		return scheduleId;
	}

	public void setScheduleId(int scheduleId) {
		this.scheduleId = scheduleId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getGroupCode() {
		return groupCode;
	}

	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}

	public boolean getIsPublic() {
		return isPublic;
	}

	public void setIsPublic(boolean isPublic) {
		this.isPublic = isPublic;
	}

	public boolean getIsAllDay() {
		return isAllDay;
	}

	public void setIsAllDay(boolean isAllDay) {
		this.isAllDay = isAllDay;
	}
}

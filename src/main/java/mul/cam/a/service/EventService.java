package mul.cam.a.service;

import java.util.List;

import mul.cam.a.dto.EventDto;

public interface EventService {

	List<EventDto> groupScheduleList(String id, String groupCode);
	EventDto selectSchedule(int scheduleId);
	
	boolean insertSchedule(EventDto dto);
	boolean updateSchedule(EventDto dto);
	boolean deleteSchedule(int scheduleId);
	List<EventDto> getScheduleList(String id);
}
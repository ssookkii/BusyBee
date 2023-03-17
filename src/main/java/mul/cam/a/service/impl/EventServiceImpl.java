package mul.cam.a.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mul.cam.a.dao.EventDao;
import mul.cam.a.dto.EventDto;
import mul.cam.a.service.EventService;

@Service
public class EventServiceImpl implements EventService {

	@Autowired
	EventDao dao;


	@Override
	public boolean insertSchedule(EventDto dto) {
		return dao.insertSchedule(dto);
	}

	@Override
	public EventDto selectSchedule(int scheduleId) {
		return dao.selectSchedule(scheduleId);
	}

	@Override
	public boolean updateSchedule(EventDto dto) {
		return dao.updateSchedule(dto);
	}

	@Override
	public boolean deleteSchedule(int scheduleId) {
		return dao.deleteSchedule(scheduleId);
	}

	@Override
	public List<EventDto> groupScheduleList(String id, String groupCode) {
	    return dao.groupScheduleList(id, groupCode);
	}
	@Override
	public List<EventDto> getScheduleList(String id) {
		return dao.getScheduleList(id);
	}
	
	

}

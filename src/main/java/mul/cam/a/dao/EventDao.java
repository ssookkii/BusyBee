package mul.cam.a.dao;

import java.util.List;

import mul.cam.a.dto.EventDto;
import mul.cam.a.dto.GroupMemDto;

public interface EventDao {


	List<EventDto> groupScheduleList(String id, String groupCode);  //모든 일정 정보를 조회하기 위한 메소드
	boolean insertSchedule(EventDto dto); // 새로운 일정을 추가하기 위한 메소드
	EventDto selectSchedule(int scheduleId);//특정 일정 정보를 조회하기 위한 메소드
	boolean updateSchedule(EventDto dto); //기존 일정 정보를 수정하기 위한 메소드
	boolean deleteSchedule(int scheduleId); // 기존 일정 정보를 삭제하기 위한 메소드
	List<EventDto> getScheduleList(String id);  //모든 일정 정보를 조회하기 위한 메소드
	List<EventDto> preScheduleList(String id, String groupCode);  //일정 정보 미리보기를 조회하기 위한 메소드
}
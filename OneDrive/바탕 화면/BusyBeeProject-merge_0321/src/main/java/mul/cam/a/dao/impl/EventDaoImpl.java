package mul.cam.a.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mul.cam.a.dao.EventDao;
import mul.cam.a.dto.EventDto;
import mul.cam.a.dto.GroupMemDto;

@Repository
public class EventDaoImpl implements EventDao {
	
	@Autowired
	private SqlSession sqlSession;
	String ns = "Event.";
	
	@Override
	public boolean insertSchedule(EventDto dto) {
	    int count = sqlSession.insert(ns + "insertSchedule", dto);
	    return count > 0 ? true : false;
	}


	@Override
	public EventDto selectSchedule(int scheduleId) {
		return sqlSession.selectOne(ns+ "selectSchedule", scheduleId);
	}

	@Override
	public boolean updateSchedule(EventDto dto) {
		int count = sqlSession.update(ns+ "updateSchedule", dto);
		return count > 0 ? true : false;
	}

	@Override
	public boolean deleteSchedule(int seq) {
		int count = sqlSession.delete(ns + "deleteSchedule", seq);
		return count > 0 ? true : false;
	}

	public List<EventDto> groupScheduleList(String id, String groupCode) {
	    Map<String, Object> map = new HashMap<>();
	    map.put("id", id);
	    map.put("groupCode", groupCode);
	    return sqlSession.selectList(ns + "groupScheduleList", map);
	}

	@Override
	public List<EventDto> getScheduleList(String id) {
	    return sqlSession.selectList(ns + "getScheduleList", id);
	}
	
	public List<EventDto> preScheduleList(String id, String groupCode) {
	    Map<String, Object> map = new HashMap<>();
	    map.put("id", id);
	    map.put("groupCode", groupCode);
	    return sqlSession.selectList(ns + "preScheduleList", map);
	}




}

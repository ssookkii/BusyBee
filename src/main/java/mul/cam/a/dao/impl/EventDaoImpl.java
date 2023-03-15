package mul.cam.a.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mul.cam.a.dao.EventDao;
import mul.cam.a.dto.EventDto;

@Repository
public class EventDaoImpl implements EventDao {
	
	@Autowired
	private SqlSession sqlSession;
	String ns = "Event.";
	
	@Override
	public List<EventDto> getScheduleList() {
		return sqlSession.selectList(ns + "getScheduleList");
	}

	@Override
	public boolean insertSchedule(EventDto dto) {
	    int count = sqlSession.insert(ns + "insertSchedule", dto);
	    return count > 0 ? true : false;
	}


	@Override
	public EventDto selectSchedule(int seq) {
		return sqlSession.selectOne(ns+ "getSchedule", seq);
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







}

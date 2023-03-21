package mul.cam.a.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import mul.cam.a.dto.EventDto;
import mul.cam.a.dto.UserDto;
import mul.cam.a.service.EventService;

@Controller
public class EventController {

    @Autowired
    EventService eventService;
 

    @GetMapping(value = "groupeventlist.do", produces = "application/json")
    @ResponseBody
    public List<EventDto> groupeventList(@RequestParam String id, @RequestParam String groupCode) {
        List<EventDto> list = eventService.groupScheduleList(id, groupCode);
        return list;
    }


    @GetMapping(value = "eventwrite.do")
    public String eventWrite() {
        return "eventwrite";
    }

    @PostMapping(value = "eventwriteAf.do")
    @ResponseBody // 반환 값이 JSON 형태로 전달됨
    public Map<String, Object> eventWriteAf(@RequestBody EventDto eventDto) {
        eventService.insertSchedule(eventDto);
        Map<String, Object> result = new HashMap<>();
        result.put("success", true); // JSON 데이터 생성
        return result;
    }


    @GetMapping(value = "eventdetail.do")
    @ResponseBody
    public EventDto eventDetail(@RequestParam int scheduleId) {
        EventDto eventDto = eventService.selectSchedule(scheduleId);
        return eventDto;
    }

    @PostMapping(value = "eventupdate.do")
    @ResponseBody
    public String eventUpdate(@RequestBody EventDto eventDto) {
        eventService.updateSchedule(eventDto);
        return "eventlist";
    }

    @PostMapping(value = "eventdelete.do")
    @ResponseBody
    public String eventDelete(@RequestParam int scheduleId) {
        eventService.deleteSchedule(scheduleId);
        return "success";
    }
    
    @GetMapping(value = "eventlist.do", produces = "application/json")
    @ResponseBody
    public List<EventDto> eventList(HttpSession session) {

        UserDto login = (UserDto) session.getAttribute("login");
        String id = login.getId();
        List<EventDto> list = eventService.getScheduleList(id);
        return list;
    }
    
    @GetMapping(value = "preScheduleList.do", produces = "application/json")
    @ResponseBody
    public List<EventDto> preScheduleList(@RequestParam String id, @RequestParam String groupCode) {
        List<EventDto> list = eventService.preScheduleList(id, groupCode);
        return list;
    }

    

}

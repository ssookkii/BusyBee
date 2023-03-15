package mul.cam.a.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import mul.cam.a.dto.EventDto;
import mul.cam.a.service.EventService;

@Controller
public class EventController {

    @Autowired
    EventService eventService;
/*
    @GetMapping(value = "calendar.do")
    public String calendar(Model model, CalendarParam calendarParam) {
        List<EventDto> list = eventService.getScheduleList();
        model.addAttribute("scheduleList", list);
        return "calendar";
    }
    */
 
    @GetMapping(value = "eventlist.do", produces = "application/json")
    @ResponseBody
    public List<EventDto> eventList() {
        List<EventDto> list = eventService.getScheduleList();
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
    public String eventDetail(Model model, @RequestParam int seq) {
        EventDto eventDto = eventService.selectSchedule(seq);
        model.addAttribute("eventDto", eventDto);
        return "eventdetail";
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


}

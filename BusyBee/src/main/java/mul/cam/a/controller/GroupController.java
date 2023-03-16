package mul.cam.a.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import mul.cam.a.dto.GroupDto;
import mul.cam.a.dto.GroupMemDto;
import mul.cam.a.dto.NotiDto;
import mul.cam.a.service.GroupService;

@Controller
public class GroupController {

	
	@Autowired
	GroupService service;
	
	@GetMapping(value = "addGroup.do")
	public String addGroup(Model model, GroupDto dto) {
		
		boolean isS = service.addGroup(dto);
		
		String addGroup_Msg = "addGroup_FAIL";
		if(isS) {
			addGroup_Msg = "addGroup_SUCCESS";
		}
		model.addAttribute("addGroup_Msg", addGroup_Msg);
		return "message";
	}
	
	@GetMapping(value = "addGroupMem.do")
	public String addGroupMem(Model model, GroupMemDto dto) {
		
		boolean isS = service.addGroupMem(dto);
		String addGroupMem_Msg = "addGroupMem_FAIL";
		if(isS) {
			addGroupMem_Msg = "addGroupMem_SUCCESS";
		}
		model.addAttribute("addGroupMem_Msg", addGroupMem_Msg);
		return "message";
	}
	
	@ResponseBody
	@GetMapping(value = "selectGroup1.do")
	public List<GroupDto> selectGroup1(String id) {
		
		return service.selectGroup1(id);
	}
	
	@ResponseBody
	@GetMapping(value = "selectGroup2.do")
	public List<GroupDto> selectGroup2(String id) {
		return service.selectGroup2(id);
	}
	
	@ResponseBody
	@GetMapping(value = "allGroup.do")
	public List<GroupDto> allGroup(GroupDto dto) {
		return service.allGroup(dto);
	}
	
	@GetMapping(value = "addNoti.do")
	public String addNoti(Model model, NotiDto dto) {
		
		boolean isS = service.addNoti(dto);
		String addNoti_Msg = "addNoti_FAIL";
		if(isS) {
			addNoti_Msg = "addNoti_SUCCESS";
		}
		model.addAttribute("addNoti_Msg", addNoti_Msg);
		return "message";
	}
	
	@ResponseBody
	@GetMapping(value = "checkDupl.do")
	public String checkDupl(GroupMemDto dto) {
		
		boolean isS = service.checkDupl(dto);
		String checkDupl_Msg = "checkDupl_SUCCESS";
		if(isS) {
			checkDupl_Msg = "checkDupl_FAIL";
		}
		
		return checkDupl_Msg;
	}
}

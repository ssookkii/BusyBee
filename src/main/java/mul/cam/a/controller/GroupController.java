package mul.cam.a.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
			NotiDto noti = new NotiDto(0, null, null, dto.getId(), dto.getGroup_code(), null, null, null);
			service.deleteNoti(noti);
		}
		model.addAttribute("addGroupMem_Msg", addGroupMem_Msg);
		return "message";
	}
	
	// 내가 탈퇴
	@GetMapping(value = "delGroupMem.do")
	public String delGroupMem(Model model, GroupMemDto dto) {
		
		boolean isS = service.delGroupMem(dto);
	
		String delGroupMem_Msg = "delGroupMem_FAIL";
		if(isS) {
			delGroupMem_Msg = "delGroupMem_SUCCESS";
		}
		model.addAttribute("delGroupMem_Msg", delGroupMem_Msg);
		return "message";
	}
	
	// 리더가 추방
	@GetMapping(value = "outGroupMem.do")
	public String outGroupMem(Model model, GroupMemDto dto) {
		
		boolean isS = service.delGroupMem(dto);
	
		String outGroupMem_Msg = "outGroupMem_FAIL";
		if(isS) {
			outGroupMem_Msg = "outGroupMem_SUCCESS";
		}
		model.addAttribute("outgroup_code", dto.getGroup_code());
		model.addAttribute("outGroupMem_Msg", outGroupMem_Msg);
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
	
	@ResponseBody
	@GetMapping(value = "allGroupMem.do")
	public List<GroupMemDto> allGroupMem(String group_code) {
		return service.allGroupMem(group_code);
	}

	@ResponseBody
	@GetMapping(value = "singleGroup.do")
	public GroupDto singleGroup(String group_code) {
		
		return service.singleGroup(group_code);
	}
	
	@GetMapping(value = "updGroup.do")
	public String updGroup(Model model, GroupDto dto) {
		
		boolean isS = service.updGroup(dto);
		String updGroup_Msg = "updGroup_FAIL";
		if(isS) {
			updGroup_Msg = "updGroup_SUCCESS";
		}
		model.addAttribute("group_code", dto.getGroup_code());
		model.addAttribute("updGroup_Msg", updGroup_Msg);
		return "message";
	}
	
	// 내가 리더에게 요청한 가입이 알림으로
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
	
	// 리더가 나에게 요청한 가입이 알림으로
	@GetMapping(value = "inv_addNoti.do")
	public String inv_addNoti(Model model, NotiDto dto) {
			
		boolean isS = service.addNoti(dto);
		String inv_addNoti_Msg = "inv_addNoti_FAIL";
		if(isS) {
			inv_addNoti_Msg = "inv_addNoti_SUCCESS";
		}
		model.addAttribute("inv_group_code", dto.getGroup_code());
		model.addAttribute("inv_addNoti_Msg", inv_addNoti_Msg);
		return "message";
	}	
	
	// 내가 그룹 가입 요청 취소
	@GetMapping(value = "deleteNoti.do")
	public String deleteNoti(Model model, NotiDto dto) {
		
		boolean isS = service.deleteNoti(dto);
		String deleteNoti_Msg = "deleteNoti_FAIL";
		if(isS) {
			deleteNoti_Msg = "deleteNoti_SUCCESS";
		}
		
		model.addAttribute("deleteNoti_Msg", deleteNoti_Msg);
		return "message";
	}
	
	// 리더가 그룹 가입 요청 거절
	@GetMapping(value = "lead_deleteNoti.do")
	public String lead_deleteNoti(Model model, NotiDto dto) {
			
		boolean isS = service.deleteNoti(dto);
		String lead_deleteNoti_Msg = "lead_deleteNoti_FAIL";
		if(isS) {
			lead_deleteNoti_Msg = "lead_deleteNoti_SUCCESS";
		}
		
		model.addAttribute("lead_deleteNoti_Msg", lead_deleteNoti_Msg);
		return "message";
	}
	
	@GetMapping(value = "changeleader.do")
	public String changeleader(Model model, GroupDto dto, String id, String name) { // id와 name은 새 leader의 것
			
		boolean isS1 = service.addGroupMem(new GroupMemDto(0, dto.getLeader_id(), dto.getGroup_code(), null));
		boolean isS2 = service.delGroupMem(new GroupMemDto(0, id, dto.getGroup_code(), null));
		boolean isS3 = service.updLeader(new GroupDto(dto.getGroup_code(), null, null, name, id, null));
		String changeleader_Msg = "changeleader_FAIL";
		if(isS1 && isS2 && isS3) {
			changeleader_Msg = "changeleader_SUCCESS";
		}
		
		model.addAttribute("changeleader_Msg", changeleader_Msg);
		return "message";
	}
	
	@ResponseBody
	@GetMapping(value = "selectNoti_from.do")
	public List<NotiDto> selectNoti_from(String id) {
		
		return service.selectNoti_from(id);
	}
	
	@ResponseBody
	@GetMapping(value = "selectNoti_to.do")
	public List<NotiDto> selectNoti_to(String id) {
		
		return service.selectNoti_to(id);
	}
	
	// 내가 리더에게 가입 요청할 때 중복 체크
	@ResponseBody
	@GetMapping(value = "checkDupl.do")
	public String checkDupl(String id, String group_code) {
		
		GroupDto dto1 = new GroupDto(group_code, null, null, null, id, null);
		GroupMemDto dto2 = new GroupMemDto(0, id, group_code, null);
		NotiDto dto3 = new NotiDto(0, null, null, id, group_code, null, null, null);
		
		boolean sGroup1 = service.selectGroup1Cnt(dto1);
		boolean sGroup2 = service.selectGroup2Cnt(dto2);
		boolean sGroup3 = service.duplNoti(dto3);
		
		System.out.println("sGroup1 : " + sGroup1);
		System.out.println("sGroup2 : " + sGroup2);
		System.out.println("sGroup3 : " + sGroup3);

		String checkDupl_Msg="checkDupl_SUCCESS";
		
		if(sGroup1) {
			checkDupl_Msg="Already";
			return checkDupl_Msg;
		}
		
		if(sGroup2) {
			checkDupl_Msg="Already";
			return checkDupl_Msg;
		}
		
		if(sGroup3) {
			checkDupl_Msg="WAIT";
			return checkDupl_Msg;
		}
		
		return checkDupl_Msg;
	}
	
	// 리더가 사용자를 추가할 때 중복 체크
	@ResponseBody
	@GetMapping(value = "inv_checkDupl.do")
	public String inv_checkDupl(String id, String group_code) {
		
		GroupDto dto1 = new GroupDto(group_code, null, null, null, id, null);
		GroupMemDto dto2 = new GroupMemDto(0, id, group_code, null);
		NotiDto dto3 = new NotiDto(0, id, null, null, group_code, null, null, null);
		
		boolean sGroup1 = service.selectGroup1Cnt(dto1);
		boolean sGroup2 = service.selectGroup2Cnt(dto2);
		boolean sGroup3 = service.inv_duplNoti(dto3);
		
		System.out.println("sGroup1 : " + sGroup1);
		System.out.println("sGroup2 : " + sGroup2);
		System.out.println("sGroup3 : " + sGroup3);

		String inv_checkDupl_Msg="inv_checkDupl_SUCCESS";
		
		if(sGroup1) {
			inv_checkDupl_Msg="Already";
			return inv_checkDupl_Msg;
		}
		
		if(sGroup2) {
			inv_checkDupl_Msg="Already";
			return inv_checkDupl_Msg;
		}
		
		if(sGroup3) {
			inv_checkDupl_Msg="WAIT";
			return inv_checkDupl_Msg;
		}
		
		return inv_checkDupl_Msg;
	}	
	
	@ResponseBody
    @GetMapping(value="userId.do")
    public List<String> getUserIdsByGroupId(@RequestParam String group_code) {
        return service.getUserIdsByGroupId(group_code);
}
	@GetMapping(value = "getGroupInfo.do")
	@ResponseBody
	public GroupDto getGroupInfo(@RequestParam String group_code) {
	    return service.selectGroupInfo(group_code);
	}
}
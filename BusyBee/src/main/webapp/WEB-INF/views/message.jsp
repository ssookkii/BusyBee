<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String addUser_Msg = (String) request.getAttribute("addUser_Msg");
	if(addUser_Msg!=null && addUser_Msg!="") {
		if(addUser_Msg=="addUser_SUCCESS") {
			%>
			<script>
			alert('BusyBee의 가족이 되신 것을 환영합니다 :)');
			location.href="loginMain.do";
			</script>
			<%
		} else {
			%>
			<script>
			alert('회원가입을 다시 진행해주세요.');
			location.href="regi2.do";
			</script>
			<%
		}
	}
	
	String loginCheck_Msg = (String) request.getAttribute("loginCheck_Msg");
	if(loginCheck_Msg!=null && loginCheck_Msg!="") {
		if(loginCheck_Msg=="loginCheck_SUCCESS") {
			String name = (String) request.getAttribute("name");
			%>
			<script>
			alert('오늘도 파이팅입니다, ' + '<%=name %>' + '님 :)');
			location.href="login.do";
			</script>
			<%
		} else {
			%>
			<script>
			alert('로그인 정보를 다시 확인해주세요.');
			location.href="loginMain.do";
			</script>
			<%
		}
	}
	
	// 프로필사진이 바뀌지 않는 정보수정
	String updUser_n_Msg = (String) request.getAttribute("updUser_n_Msg");
	if(updUser_n_Msg!=null && updUser_n_Msg!="") {
		if(updUser_n_Msg=="updUser_n_SUCCESS") {
			%>
			<script>
			alert('회원정보가 수정되었습니다.');
			location.href="goUserinfo.do";
			</script>
			<%
		} else {
			%>
			<script>
			alert('회원정보 수정에 실패했습니다. 다시 시도해주세요.');
			location.href="goUserinfo.do";
			</script>
			<%
		}
	}
	
	// 프로필사진이 바뀌는 정보수정
	String updUser_y_Msg = (String) request.getAttribute("updUser_y_Msg");
	if(updUser_y_Msg!=null && updUser_y_Msg!="") {
		if(updUser_y_Msg=="updUser_y_SUCCESS") {
			%>
			<script>
			alert('회원정보가 수정되었습니다.');
			location.href="goUserinfo.do";
			</script>
			<%
		} else {
			%>
			<script>
			alert('회원정보 수정에 실패했습니다. 다시 시도해주세요.');
			location.href="goUserinfo.do";
			</script>
			<%
		}
	}
	
	// 프로필사진이 바뀌는 정보수정(기본 프로필사진)
	String updUser_b_Msg = (String) request.getAttribute("updUser_b_Msg");
	if(updUser_b_Msg!=null && updUser_b_Msg!="") {
		if(updUser_b_Msg=="updUser_b_SUCCESS") {
			%>
			<script>
			alert('회원정보가 수정되었습니다.');
			location.href="goUserinfo.do";
			</script>
			<%
		} else {
			%>
			<script>
			alert('회원정보 수정에 실패했습니다. 다시 시도해주세요.');
			location.href="goUserinfo.do";
			</script>
			<%
		}
	}
	
	String delUser_Msg = (String) request.getAttribute("delUser_Msg");
	if(delUser_Msg!=null && delUser_Msg!="") {
		if(delUser_Msg=="delUser_SUCCESS") {
			%>
			<script>
			alert('그동안 BusyBee를 사용해주셔서 감사합니다.');
			location.href="loginMain.do";
			</script>
			<%
		} else {
			%>
			<script>
			alert('계정 삭제에 실패했습니다. 다시 시도해주세요.');
			location.href="goUserinfo.do";
			</script>
			<%
		}
	}
	
	String addGroup_Msg = (String) request.getAttribute("addGroup_Msg");
	if(addGroup_Msg!=null && addGroup_Msg!="") {
		if(addGroup_Msg=="addGroup_SUCCESS") {
			%>
			<script>
			alert('그룹을 생성하였습니다.');
			location.href="goMygroup.do";
			</script>
			<%
		} else {
			%>
			<script>
			alert('그룹 생성에 실패했습니다. 다시 생성해주세요.');
			location.href="goAddgroup.do";
			</script>
			<%
		}
	}
	
	String addGroupMem_Msg = (String) request.getAttribute("addGroupMem_Msg");
	if(addGroupMem_Msg!=null && addGroupMem_Msg!="") {
		if(addGroupMem_Msg=="addGroupMem_SUCCESS") {
			%>
			<script>
			alert('그룹 가입을 승인했습니다.');
			location.href="goNoti.do";
			</script>
			<%
		} else {
			%>
			<script>
			alert('그룹 가입에 실패했습니다.');
			location.href="goNoti.do";
			</script>
			<%
		}
	}
	
	String delGroupMem_Msg = (String) request.getAttribute("delGroupMem_Msg");
	if(delGroupMem_Msg!=null && delGroupMem_Msg!="") {
		if(delGroupMem_Msg=="delGroupMem_SUCCESS") {
			%>
			<script>
			alert('그룹에서 탈퇴했습니다.');
			location.href="goMygroup.do";
			</script>
			<%
		} else {
			%>
			<script>
			alert('그룹 탈퇴에 실패했습니다.');
			location.href="goMygroup.do";
			</script>
			<%
		}
	}
	
	String outGroupMem_Msg = (String) request.getAttribute("outGroupMem_Msg");
	if(outGroupMem_Msg!=null && outGroupMem_Msg!="") {
		if(outGroupMem_Msg=="outGroupMem_SUCCESS") {
			String outgroup_code = (String) request.getAttribute("outgroup_code");
			%>
			<script>
			alert('해당 멤버를 그룹에서 추방했습니다.');
			location.href="goManagegroup.do?group_code=" + '<%=outgroup_code %>';
			</script>
			<%
		} else {
			String outgroup_code = (String) request.getAttribute("outgroup_code");
			%>
			<script>
			alert('추방에 실패했습니다. 다시 시도해주세요.');
			location.href="goManagegroup.do?group_code=" + '<%=outgroup_code %>';
			</script>
			<%
		}
	}
	
	String addNoti_Msg = (String) request.getAttribute("addNoti_Msg");
	if(addNoti_Msg!=null && addNoti_Msg!="") {
		if(addNoti_Msg=="addNoti_SUCCESS") {
			%>
			<script>
			alert('그룹 리더에게 가입 신청을 보냈습니다.');
			location.href="goNoti.do";
			</script>
			<%
		} else {
			%>
			<script>
			alert('가입 신청에 실패했습니다. 다시 시도해주세요.');
			location.href="goSearchgroup.do";
			</script>
			<%
		}
	}
	
	String inv_addNoti_Msg = (String) request.getAttribute("inv_addNoti_Msg");
	if(inv_addNoti_Msg!=null && inv_addNoti_Msg!="") {
		if(inv_addNoti_Msg=="inv_addNoti_SUCCESS") {
			String inv_group_code = (String) request.getAttribute("inv_group_code");
			%>
			<script>
			alert('해당 멤버에게 가입 요청을 보냈습니다.');
			location.href="goManagegroup.do?group_code=" + '<%=inv_group_code %>';
			</script>
			<%
		} else {
			String inv_group_code = (String) request.getAttribute("inv_group_code");
			%>
			<script>
			alert('가입 요청 전송에 실패했습니다.. 다시 시도해주세요.');
			location.href="goManagegroup.do?group_code=" + '<%=inv_group_code %>';
			</script>
			<%
		}
	}
	
	String deleteNoti_Msg = (String) request.getAttribute("deleteNoti_Msg");
	if(deleteNoti_Msg!=null && deleteNoti_Msg!="") {
		if(deleteNoti_Msg=="deleteNoti_SUCCESS") {
			%>
			<script>
			alert('그룹 가입 요청을 취소했습니다.');
			location.href="goNoti.do";
			</script>
			<%
		} else {
			%>
			<script>
			alert('그룹 승인 오류입니다. 다시 확인해주세요.');
			alert('<%=deleteNoti_Msg%>');
			location.href="goNoti.do";
			</script>
			<%
		}
	}
	
	String lead_deleteNoti_Msg = (String) request.getAttribute("lead_deleteNoti_Msg");
	if(lead_deleteNoti_Msg!=null && lead_deleteNoti_Msg!="") {
		if(lead_deleteNoti_Msg=="lead_deleteNoti_SUCCESS") {
			%>
			<script>
			alert('그룹 가입 요청을 거절했습니다.');
			location.href="goNoti.do";
			</script>
			<%
		} else {
			%>
			<script>
			alert('그룹 승인 오류입니다. 다시 확인해주세요.');
			alert('<%=deleteNoti_Msg%>');
			location.href="goNoti.do";
			</script>
			<%
		}
	}
	
	String updGroup_Msg = (String) request.getAttribute("updGroup_Msg");
	if(updGroup_Msg!=null && updGroup_Msg!="") {
		if(updGroup_Msg=="updGroup_SUCCESS") {
			String group_code = (String) request.getAttribute("group_code");
			%>
			<script>
			alert('그룹 정보를 수정했습니다.');
			location.href="goManagegroup.do?group_code=" + '<%=group_code %>';
			</script>
			<%
		} else {
			String group_code = (String) request.getAttribute("group_code");
			%>
			<script>
			alert('그룹 정보 수정에 실패했습니다. 다시 확인해주세요.');
			alert('<%=deleteNoti_Msg%>');
			location.href="goManagegroup.do?group_code=" + '<%=group_code %>';
			</script>
			<%
		}
	}
	
	String changeleader_Msg = (String) request.getAttribute("changeleader_Msg");
	if(changeleader_Msg!=null && changeleader_Msg!="") {
		if(changeleader_Msg=="changeleader_SUCCESS") {
			%>
			<script>
			alert('리더를 위임했습니다. 나의 그룹 확인으로 넘어갑니다.');
			location.href="goMygroup.do";
			</script>
			<%
		} else {
			%>
			<script>
			alert('리더 변경에 실패했습니다. 나의 그룹 확인으로 넘어갑니다.');
			alert('<%=deleteNoti_Msg%>');
			location.href="goMygroup.do";
			</script>
			<%
		}
	}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메시지</title>
</head>
<body>
    <h1>${message}</h1>
</body>
</html>

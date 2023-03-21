<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String group_code = (String)request.getAttribute("group_code");
String org = (String)request.getAttribute("org");

%>

<%

//고객센터 글 작성
String customerWrite = (String)request.getAttribute("customerWrite");
if(customerWrite != null && !customerWrite.equals("")){
	if(customerWrite.equals("CUS_ADD_OK")){
		%>
		<script type="text/javascript">
		alert("성공적으로 작성되었습니다");
		location.href = "customer.do";
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		alert("다시 작성해 주십시오");
		location.href = "customerWrite.do";
		</script>
		<%
	}
}
//고객센터 글 삭제
String customerDelete = (String)request.getAttribute("customerDelete");
if(customerDelete != null && !customerDelete.equals("")){
	if(customerDelete.equals("CUS_DEL_OK")){
		%>
		<script type="text/javascript">
		alert("성공적으로 삭제되었습니다");
		location.href = "customer.do";
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		alert("삭제에 실패했습니다.");
		location.href = "customer.do";
		</script>
		<%
	}
}
//고객센터 글 수정
String customerUpdate = (String)request.getAttribute("customerUpdate");
if(customerUpdate != null && !customerUpdate.equals("")){
	if(customerUpdate.equals("CUS_UPDATE_OK")){
		%>
		<script type="text/javascript">
		alert("성공적으로 수정되었습니다");
		location.href = "customer.do";
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		alert("수정하기에 실패했습니다");
		location.href = "customerDetail.do?seq="+seq;
		</script>
		<%
	}
}
//고객센터 답글 작성
String customerAnswer = (String)request.getAttribute("customerAnswer");
if(customerAnswer != null && !customerAnswer.equals("")){
	if(customerAnswer.equals("CUS_ANSWER_OK")){
		%>
		<script type="text/javascript">
		alert("성공적으로 작성되었습니다");
		location.href = "customer.do";
		</script>
		<%
	}
	else{
		%>
		<script type="text/javascript">
		alert("작성에 실패했습니다");
		location.href = "customerAnswer.do?seq="+seq;
		</script>
		<%
	}
}
//회원가입
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
	
	
	// 로그인
		String loginCheck_Msg = (String) request.getAttribute("loginCheck_Msg");
		if(loginCheck_Msg!=null && loginCheck_Msg!="") {
			if(loginCheck_Msg=="loginCheck_BANNED"){
				%>
				<script>
				alert('정지된 회원입니다. BUSY BEE 고객샌터로 문의해주세요.');
				location.href="loginMain.do";
				</script>
				<%
			} else if(loginCheck_Msg=="loginCheck_SUCCESS") {
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
	
	// 정보수정
	String updUser_n_Msg = (String) request.getAttribute("updUser_n_Msg");
	if(updUser_n_Msg!=null && updUser_n_Msg!="") {
		if(updUser_n_Msg=="updUser_n_SUCCESS") {
			%>
			<script>
			alert('회원정보가 수정되어 로그아웃 처리됩니다.');
			location.href="loginMain.do";
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
	
	// 그룹 message
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
	String delGroup_Msg = (String) request.getAttribute("delGroup_Msg");
	   if(delGroup_Msg!=null && delGroup_Msg!="") {
	      if(delGroup_Msg=="delGroup_SUCCESS") {
	         %>
	         <script>
	         alert('그룹을 해체했습니다.');
	         location.href="goMygroup.do";
	         </script>
	         <%
	      } else {
	         %>
	         <script>
	         alert('그룹 해체에 실패했습니다.');
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
			group_code = (String) request.getAttribute("group_code");
			%>
			<script>
			alert('그룹 정보를 수정했습니다.');
			location.href="goManagegroup.do?group_code=" + '<%=group_code %>';
			</script>
			<%
		} else {
			group_code = (String) request.getAttribute("group_code");
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
	
	// 유저 정지 message
	String banId = (String)request.getAttribute("banId");
	String userBan = (String)request.getAttribute("userBan");
	if(userBan != null && !userBan.equals("")){
		if(userBan.equals("USER_BAN_OK")){
			%>
			<script type="text/javascript">
			if(!confirm("<%=banId%> 회원을 정지하시겠습니까? ")){
			    alert("취소되었습니다.");
			}else{
			    alert("정지되었습니다.");
			}
			location.href = "userList.do";
			</script>
			<%
		}
		else{
			%>
			<script type="text/javascript">
			alert("error");
			location.href = "userList.do";
			</script>
			<%
		}
	}
	String inId = (String)request.getAttribute("inId");
	String userIn = (String)request.getAttribute("userIn");
	if(userIn != null && !userIn.equals("")){
		if(userIn.equals("USER_IN_OK")){
			%>
			<script type="text/javascript">
			if(!confirm("<%=inId %> 회원의 정지를 해제하시겠습니까? ")){
			    alert("취소되었습니다.");
			}else{
			    alert("해제되었습니다.");
			}
			location.href = "userList.do";
			</script>
			<%
		}
		else{
			%>
			<script type="text/javascript">
			alert("error");
			location.href = "userList.do";
			</script>
			<%
		}
	}
	
	// 게시판 message
		String bbswrite = (String)request.getAttribute("bbswrite");
	if(bbswrite != null && !bbswrite.equals("")){
		if(bbswrite.equals("bbswrite_YES")){
			%>
			<script type="text/javascript">
			alert("성공적으로 작성되었습니다");
			location.href = "bbslist.do?group_code="+'<%=group_code%>'+"&org="+'<%=org%>';
			</script>
			<%
		}
		else{
			%>
			<script type="text/javascript">
			alert("다시 작성해 주십시오");
			location.href = "bbswrite.do";
			</script>
			<%
		}
	}
	String bbsupdate = (String)request.getAttribute("bbsupdate");
	if(bbsupdate != null && !bbsupdate.equals("")){
		if(bbsupdate.equals("bbsupdate_YES")){
			%>
			<script type="text/javascript">
			alert("성공적으로 수정되었습니다");
			location.href = "bbslist.do";
			</script>
			<%
		}
		else{
			int seq = (Integer)request.getAttribute("seq");
			%>
			<script type="text/javascript">
			alert("다시 작성해 주십시오");
			let seq = "<%=seq %>";		
			location.href = "bbsupdate.do?seq=" + seq;
			</script>
			<%
		}	
	}
	String bbsdelete = (String)request.getAttribute("bbsdelete");
	if(bbsdelete != null && !bbsdelete.equals("")){
		if(bbsdelete.equals("bbsdelete_YES")){
		%>
			<script type="text/javascript">
			alert("삭제되었습니다");
			location.href = "bbslist.do";
			</script>
		<% 
	} else{	
		int seq = Integer.parseInt(request.getParameter("seq"));
		%>
			<script type="text/javascript">
			
			alert("삭제에 실패했습니다");
			let seq = "<%=seq %>";
			location.href = "bbsdetail.do?seq=" + seq;
			</script>
		<%
		}
	}
	String bbscomment = (String) request.getAttribute("bbscomment");
	if(bbscomment != null && bbscomment != "") {
		if(bbscomment == "bbscomment_YES") {
			int seq = Integer.parseInt(request.getParameter("seq"));
			%>
			<script type="text/javascript">
			alert("댓글이 작성되었습니다");
			let seq = "<%=seq %>";
			location.href = "bbsdetail.do?seq=" + seq;
			</script>
		<% 
	} else{	
		int seq = Integer.parseInt(request.getParameter("seq"));
		%>
			<script type="text/javascript">
			
			alert("댓글작성에 실패했습니다");
			let seq = "<%=seq %>";
			location.href = "bbsdetail.do?seq=" + seq;
			</script>
		<%
		}
	}
	String deleteBbscomment = (String) request.getAttribute("deleteBbscomment");
	if(deleteBbscomment != null && deleteBbscomment != "") {
		if(deleteBbscomment == "deleteBbscomment_YES") {
			int seq = Integer.parseInt(request.getParameter("seq"));
			%>
			<script type="text/javascript">
			alert("댓글이 삭제되었습니다");
			let seq = "<%=seq %>";
			location.href = "bbsdetail.do?seq=" + seq;
			</script>
		<% 
	} else{	
		int seq = Integer.parseInt(request.getParameter("seq"));
		%>
			<script type="text/javascript">
			
			alert("댓글삭제에 실패했습니다");
			let seq = "<%=seq %>";
			location.href = "bbsdetail.do?seq=" + seq;
			</script>
		<%
		}
	}
	%>







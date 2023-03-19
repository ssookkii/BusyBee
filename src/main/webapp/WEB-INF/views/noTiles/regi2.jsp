<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String id = (String) request.getAttribute("id");
	String password = (String) request.getAttribute("password");
	String email = (String) request.getAttribute("email");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- AJAX -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<!-- 파일유효성 검사를 위한 JQuery 버전 -->
<script src="http://code.jquery.com/jquery-migrate-1.2.1.js"></script>

<!-- 비밀번호 암호화(SHA256) -->
<script	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

</head>
<body>

<form action="regiAf.do" id="frm" method="post" enctype="multipart/form-data">
이름 : <input type="text" id="name" name="name"> <h3 id="nameCheck"></h3>
생년월일 : <input type="date" id="birth" name="birth">

연락처 : <input type="text" id="phone" name="phone"> 공개<input type="checkbox" id="phone_public" name="phone_public">

프로필사진 : <input type="file" accept="image/png, iamge/jpeg" id="profPic" name="profPic">
상태메세지 : <input type="text" name="profMsg">

<input type="hidden" name="id" value='<%=id %>'>
<input type="hidden" id="password" name="password" value='<%=password %>'>
<input type="hidden" name="email" value='<%=email %>'>

<input type="hidden" id="name_OK">
<input type="hidden" id="phone_OK">

<button type="button" onclick="go_regiAf()">회원가입</button>
</form>

<script type="text/javascript">

var saltpw = '<%=password%>'.substr(0,2) + '<%=password%>' + '<%=password%>'.substr('<%=password%>'.length-2, '<%=password%>'.length);


function knowprof(){
	alert($("#profPic").val());
}

var name_OK = document.getElementById("name_OK").value;
var phone_OK = document.getElementById("phone_OK").value;

$("#name").keyup(function(e){
	
	let key = e.key || e.keyCode;

	if($("#name").val()=="") {
		$("#nameCheck").text('');
		name_OK=false;
		return;
	}
	
	if(key==" " || key==32) {
		alert('이름에는 공백이 들어갈 수 없습니다.');
		$("#name").val('');
		$("#nameCheck").text('');
		name_OK=false;
		return;
	}
	
	if($("#name").val().length<15) {
		$("#nameCheck").text('사용 가능한 이름입니다.');
		name_OK = true;
	} else {
		$("#nameCheck").text('이름은 15자를 넘어갈 수 없습니다.');
		name_OK=false;
	}
});

$("#phone").keyup(function(e){
	
	let key = e.key || e.keyCode;

	
	if($("#phone").val()=="") {
		phone_OK=false;
		return;
	}

	// 유효성 검사
	if(key==" " || key==32 || key=="-" || key==109) {
		alert("공백이나 '-' 를 제외하고 입력해주세요.");
		$("#phone").val('');
		phone_OK=false;
		return;
	}
	
	var phoneValid = /[0-9]/g;
	
	if(!phoneValid.test($("#phone").val())) {
		alert("숫자만 입력해주세요.");
		$("#phone").val('');
		phone_OK=false;
		return;
	} else {
		phone_OK=true;
	}
	
});

function go_regiAf() {
	
	var birth = document.getElementById("birth").value;
	
	if(!name_OK) {
		alert('이름을 확인해주세요.');
		$("#name").focus();
	} else if(birth==null || birth=="") {
		alert('생년월일을 설정해주세요.');
		$("#birth").focus();
	} else if(!phone_OK) {
		alert('핸드폰 번호를 확인해주세요.');
		$("#phone").focus();
	} else {
		$("#password").val(sha256(saltpw));
		$("#frm").submit();
	}
}

// 파일 유효성 검사
$(document).on("change", "input[type='file']", function(){

	// 이미지 확장자 유효성 검사
	var file_path = $(this).val();
	var reg = /(.*?)\.(jpg|jpeg|png)$/;

	if (file_path != "" && (file_path.match(reg) == null || reg.test(file_path) == false)) {

		if ($.browser.msie) { // ie 일때 
			$(this).replaceWith($(this).clone(true));
		} else {
			$(this).val("");
		}
		alert("이미지 파일만 업로드 가능합니다.");
	}
	
	// 파일명 길이 유효성 검사
	var filename = $("#profPic").val().substr(12);
	if(filename.length>20) {
		alert("파일명은 확장자를 포함하여, 20자를 넘길 수 없습니다.");
		$(this).val("");
	}
	
	// [참고] 저는 C:/fakepath/로 파일 경로가 설정되기 때문에 substr(12)로 잡았는데,
	// 다른 분이 테스트하시는 환경에서는 오류가 날 수 있으니
	// 프로필 사진명은 짧게 해서 올리시는 것을 추천합니다!
});

</script>

</body>
</html>
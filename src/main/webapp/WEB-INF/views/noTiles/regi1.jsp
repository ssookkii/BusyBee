<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입(1/2)</title>

<!-- AJAX -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

</head>
<body>

<form action="regi2.do" id="frm" method="post">
이메일 : <input type="email" name="email"> <button type="button">인증</button>
인증번호 : <input type="text"> <button type="button">확인</button>

아이디 : <input type="text" id="id" name="id">
<h3 id="idCheck"></h3>

비밀번호 : <input type="password" id="pwd1" name="password">
<h3 id="pwdCheck1"></h3>
비밀번호 확인:<input type="password" id="pwd2">
<h3 id="pwdCheck2"></h3>


<input type="hidden" id="id_OK">
<input type="hidden" id="pwd1_OK">
<input type="hidden" id="pwd2_OK">

<button type="button" onclick="go_regi2()">다음</button>
</form>

<script>
var id_OK = document.getElementById("id_OK").value;
var pwd1_OK = document.getElementById("pwd1_OK").value;
var pwd2_OK = document.getElementById("pwd2_OK").value;

// ID
$("#id").keyup(function(e){
	
	let key = e.key || e.keyCode;
	
	// ID 유효성 검사
	var idValid = /^[a-zA-z0-9]{6,12}$/;
	
	if($("#id").val()=="") {
		$("#idCheck").text('');
		id_OK=false;
		return;
	}
	
	if(key==" " || key==32) {
		alert('아이디에는 공백이 들어갈 수 없습니다.');
		$("#id").val('');
		$("#idCheck").text('');
		id_OK=false;
		return;
	}
	
	$.ajax({
		url:"http://localhost:8090/busyBee/idCheck.do",
		type:"post",
		data:{"id":$("#id").val()},
		success:function(idCheck_Msg) {
			if(idCheck_Msg!=null && idCheck_Msg!="") {
				if(idCheck_Msg=="idCheck_SUCCESS") {
					if(!idValid.test($("#id").val())) {
						$("#idCheck").text('ID는 6~12자, 영문 대소문자와 숫자로 설정해주세요.');
						id_OK=false;
					} else {
						$("#idCheck").text('사용가능한 ID입니다.');
						id_OK=true;
					}

				} else {
					$("#idCheck").text('이미 존재하는 ID입니다.');
					id_OK=false;
				}
			}
		},
		error:function(){
			alert('error');
		}
	});
});

// PWD(1/2)
$("#pwd1").keyup(function(e){
	
	let key = e.key || e.keyCode;

	if($("#pwd1").val()=="") {
		$("#pwdCheck1").text('');
		$("#pwdCheck2").text('');
		pwd1_OK=false;
		pwd2_OK=false;
		return;
	}
	
	if(key==" " || key==32) {
		alert('비밀번호에는 공백이 들어갈 수 없습니다.');
		$("#pwd1").val('');
		$("#pwdCheck1").text('');
		pwd1_OK=false;
		return;
	}
	
	if($("#pwd1").val()==$("#pwd2").val()) {
		$("#pwdCheck2").text('동일합니다.');
		pwd2_OK=true;
	} else{
		$("#pwdCheck2").text('');
		pwd2_OK=false;
	}
	
	// PWD 유효성 검사
	var pwd1 = $("#pwd1").val();
	var numValid = pwd1.search(/[0-9]/g);
	var engValid = pwd1.search(/[a-z]/ig);
	var speValid = pwd1.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	
	if (pwd1.length<8 || pwd1.length>20) {
		$("#pwdCheck1").text('비밀번호는 6~20자로 설정해주세요.');
		pwd1_OK=false;
	} else if(numValid < 0 || engValid < 0 || speValid < 0 ){
		$("#pwdCheck1").text('비밀번호에는 숫자, 영문, 특수문자가 모두 포함되어있어야 합니다.');
		pwd1_OK=false;
	} else {
		$("#pwdCheck1").text('사용가능한 비밀번호입니다.');
		pwd1_OK=true;
	}
	
});

// PWD(2/2)

$("#pwd2").keyup(function(){
	
	if($("#pwd2").val()=="") {
		$("#pwdCheck2").text('');
		pwd2_OK=false;
		return;
	}
	
	if($("#pwd1").val()!=$("#pwd2").val()) {
		$("#pwdCheck2").text('동일한 비밀번호를 입력해주세요.');
		pwd2_OK=false;
	} else {
		$("#pwdCheck2").text('동일합니다.');
		pwd2_OK=true;
	}

});

function go_regi2() {
	
	if(!id_OK) {
		alert('아이디 중복 여부를 확인해주세요.');
		$("#id").focus();
	} else if((!pwd1_OK)) {
		alert('사용 가능한 비밀번호인지 확인해주세요.');
		$("#pwd1").focus();		
	} else if((!pwd2_OK)) {
		alert('동일한 비밀번호를 입력했는지 확인해주세요.');
		$("#pwd2").focus();		
	} else {
		$("#frm").submit();
	}
	
	
}

</script>
</body>
</html>
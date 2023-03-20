<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- AJAX -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<!-- 비밀번호 암호화(SHA256) -->
<script	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<style type="text/css">
*, *:before, *:after {
	 box-sizing: border-box;
	 margin: 0;
	 padding: 0;
}
 body {
	 font-family: 'Open Sans', Helvetica, Arial, sans-serif;
	 background: #ededed;
}
 input, button {
	 border: none;
	 outline: none;
	 background: none;
	 font-family: 'Open Sans', Helvetica, Arial, sans-serif;
}
 .tip {
	 font-size: 20px;
	 margin: 40px auto 50px;
	 text-align: center;
}
 .cont {
	 overflow: hidden;
	 position: relative;
	 width: 900px;
	 height: 550px;
	 margin: 0 auto 100px;
	 background: #fff;
}
 .form {
	 position: relative;
	 width: 640px;
	 height: 100%;
	 transition: transform 1.2s ease-in-out;
	 padding: 50px 30px 0;
}
 .sub-cont {
	 overflow: hidden;
	 position: absolute;
	 left: 640px;
	 top: 0;
	 width: 900px;
	 height: 100%;
	 padding-left: 260px;
	 background: #fff;
	 transition: transform 1.2s ease-in-out;
}
 .cont.s--signup .sub-cont {
	 transform: translate3d(-640px, 0, 0);
}
 button {
	 display: block;
	 margin: 0 auto;
	 width: 260px;
	 height: 36px;
	 border-radius: 30px;
	 color: #fff;
	 font-size: 15px;
	 cursor: pointer;
}
 .img {
	 overflow: hidden;
	 z-index: 2;
	 position: absolute;
	 left: 0;
	 top: 0;
	 width: 260px;
	 height: 100%;
	 padding-top: 360px;
}
 .img:before {
	 content: '';
	 position: absolute;
	 right: 0;
	 top: 0;
	 width: 900px;
	 height: 100%;
	 background-image: url('./images/beehive3.jpg');
	 background-size: cover;
	 transition: transform 1.2s ease-in-out;
}
 .img:after {
	 content: '';
	 position: absolute;
	 left: 0;
	 top: 0;
	 width: 100%;
	 height: 100%;
	 background: rgba(0, 0, 0, 0.5);
}
 .cont.s--signup .img:before {
	 transform: translate3d(640px, 0, 0);
}
 .img__text {
	 z-index: 2;
	 position: absolute;
	 left: 0;
	 top: 50px;
	 width: 100%;
	 padding: 0 20px;
	 text-align: center;
	 color: #fff;
	 transition: transform 1.2s ease-in-out;
}
 .img__text h2 {
	 margin-bottom: 10px;
	 font-weight: normal;
}
 .img__text p {
	 font-size: 14px;
	 line-height: 1.5;
}
 .cont.s--signup .img__text.m--up {
	 transform: translateX(520px);
}
 .img__text.m--in {
	 transform: translateX(-520px);
}
 .cont.s--signup .img__text.m--in {
	 transform: translateX(0);
}
 .img__btn {
	 overflow: hidden;
	 z-index: 2;
	 position: relative;
	 width: 100px;
	 height: 36px;
	 margin: 0 auto;
	 background: transparent;
	 color: #fff;
	 text-transform: uppercase;
	 font-size: 15px;
	 cursor: pointer;
}
 .img__btn:after {
	 content: '';
	 z-index: 2;
	 position: absolute;
	 left: 0;
	 top: 0;
	 width: 100%;
	 height: 100%;
	 border: 2px solid #fff;
	 border-radius: 30px;
}
 .img__btn span {
	 position: absolute;
	 left: 0;
	 top: 0;
	 display: flex;
	 justify-content: center;
	 align-items: center;
	 width: 100%;
	 height: 100%;
	 transition: transform 1.2s;
}
 .img__btn span.m--in {
	 transform: translateY(-72px);
}
 .cont.s--signup .img__btn span.m--in {
	 transform: translateY(0);
}
 .cont.s--signup .img__btn span.m--up {
	 transform: translateY(72px);
}
 h2 {
	 width: 100%;
	 font-size: 26px;
	 text-align: center;
}
 label {
	 display: block;
	 width: 260px;
	 margin: 25px auto 0;
	 text-align: center;
}
 label span {
	 font-size: 12px;
	 color: #cfcfcf;
	 text-transform: uppercase;
}
 input {
	 display: block;
	 width: 100%;
	 margin-top: 5px;
	 padding-bottom: 5px;
	 font-size: 14px;
	 border-bottom: 1px solid rgba(0, 0, 0, 0.4);
	 text-align: center;
}
 .forgot-pass {
	 margin-top: 15px;
	 text-align: center;
	 font-size: 12px;
	 color: #cfcfcf;
}
 .submit {
	 margin-top: 40px;
	 margin-bottom: 20px;
	 background: rgb(255, 197, 0);
	 text-transform: uppercase;
	 font-weight: bold;
}
 .fb-btn {
	 border: 2px solid #d3dae9;
	 color: #8fa1c7;
}
 .fb-btn span {
	 font-weight: bold;
	 color: #455a81;
}
 .sign-in {
	 transition-timing-function: ease-out;
}
 .cont.s--signup .sign-in {
	 transition-timing-function: ease-in-out;
	 transition-duration: 1.2s;
	 transform: translate3d(640px, 0, 0);
}
 .sign-up {
	 transform: translate3d(-900px, 0, 0);
}
 .cont.s--signup .sign-up {
	 transform: translate3d(0, 0, 0);
}
 .icon-link {
	 position: absolute;
	 left: 5px;
	 bottom: 5px;
	 width: 32px;
}
 .icon-link img {
	 width: 100%;
	 vertical-align: top;
}
.center {
  display: block;
  margin-left: auto;
  margin-right: auto;
  width: 280px;
  height: 40px;
}
.small {
	margin-top : 10px;
	font-size : 8pt;
	font-family : "나눔바른고딕";
	color : rgba(0, 0, 0, 0.5);
}
a{
	text-decoration-line : none;
	color : rgba(0, 0, 0, 0.5);
}
a:visited {
	color : rgba(0, 0, 0, 0.5);
}
</style>
</head>
<body>
<br><br><br><br><br><br><br><br>


<div class="cont">
  <div class="form sign-in">
  <br>
  	<img src = "./images/LetterLogo.png" class="center">
  	<br><br>
    <label>
      <span>ID</span>
      <input type="text" id="id" name="id" maxlength="12" placeholder="ID를 입력해주세요.">
    </label>
    <br>
    <label>
      <span>Password</span>
      <input type="password" id="password" name="password" maxlength="20" placeholder="비밀번호를 입력해주세요.">
    </label>
    <br>
    <button type="button" class="submit" onclick="go_login()">로그인</button>
    <br>
    <p class="forgot-pass"><a href="idandpwd.do">🐝 ID나 비밀번호가 기억나지 않으세요?</a></p>
  </div>
  <div class="sub-cont">
    <div class="img">
      <div class="img__text m--up">
        <h2 style="font-size: 23pt; font-family: '나눔바른고딕'">반갑습니다!</h2>
        <p>BUSY BEE에 가입하셔서,</p>
        <p>다양한 기능을 누려보세요 🐝</p>
      </div>
      <div class="img__text m--in">
        <h2 style="font-size: 23pt; font-family: '나눔바른고딕'">회원이신가요?</h2>
        <p>BUSY BEE에 로그인해주세요.</p>
        <p>팀원들이 기다리고 있어요 🐝</p>
      </div>
      <div class="img__btn">
        <span class="m--up">회원가입</span>
        <span class="m--in">로그인</span>
      </div>
    </div>
    <div id="emailAf" class="form sign-up">
    <br>
    <img src = "./images/LetterLogo.png" class="center">
	<br><br>
      <label>
        <span>이메일</span>
        <br>
        <input type="text" id="email" maxlength="25" placeholder="이메일을 입력해주세요."/>
      </label>
      <br>
      <p id="isValidE" style="text-align: center"></p>
      <br>
      <label>
        <span>인증번호</span>
        <br>
        <input type="text" id="certNum" maxlength="6" placeholder="인증번호 전송을 눌러주세요." disabled="disabled" />
      </label>
      <br>
      <p id="ePt" style="text-align: center"></p>
      <div id = "emailCertBtn">
      <button type="button" class="submit" onclick="doCert()">인증번호 전송</button>
      </div>
    </div>
  </div>
</div>

<form action="loginCheck.do" id="frm1" method="post">
<input type="hidden" id="loginId" name="id">
<input type="hidden" id="loginPwd" name="password">
</form>

<input type="hidden" id="id_OK">
<input type="hidden" id="pwd1_OK">
<input type="hidden" id="pwd2_OK">
<input type="hidden" id="name_OK">
<input type="hidden" id="phone_OK">
<form action="regiAf.do" id="frm2" method="post">
<input type="hidden" id="submitEmail" name="email">
<input type="hidden" id="submitId" name="id">
<input type="hidden" id="submitPwd" name="password">
<input type="hidden" id="submitName" name="name">
<input type="hidden" id="submitPhone" name="phone">
</form>

<script type="text/javascript">
document.querySelector('.img__btn').addEventListener('click', function() {
	  document.querySelector('.cont').classList.toggle('s--signup');
	});
// 로그인
function go_login() {
	var id = document.getElementById("id").value;
	var password = document.getElementById("password").value;
	
	if(id==null || id.trim()=="") {
		alert('ID를 입력해주세요.');
	} else if(password==null || password.trim()==""){
		alert('비밀번호를 입력해주세요.');
	} else {
		var loginsaltpw = password.substr(0,2) + password + password.substr(password.length-2, password.length);
		
		$("#loginId").val(id);
		$("#loginPwd").val(sha256(loginsaltpw));
		$("#frm1").submit();
	}
}
// 회원가입-1
var userEamil = "";
var authkey = "";
cert_OK = false;
// EMAIL 인증
function doCert() {
	
	// 이메일 정규식
	var emailValid = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	userEmail = $.trim($("#email").val());
	var checkE = true;
	
	// 이메일이 유효한가?
	if(userEmail == ""){
		$("#isValidE").html("이메일을 입력해주세요");
		$("#isValidE").css("color", "red");
		$("#isValidE").css("font-family", "나눔바른고딕");
		return;
	} else if(!emailValid.test(userEmail)) {
		$("#isValidE").html("유효한 이메일을 입력해주세요");
		$("#isValidE").css("color", "red");
		$("#isValidE").css("font-family", "나눔바른고딕");
		return;
	// BUSY BEE에 등록된 이메일인가?
	} else {
		$.ajax({
			url : "selectEmail.do",
			async : false,
			type : "get",
			data : {"email" : userEmail},
			success: function(msg) {
				if(msg=="NO") {
					$("#isValidE").html("BUSY BEE에 이미 등록된 이메일입니다.");
					$("#isValidE").css("color", "red");
					$("#isValidE").css("font-family", "나눔바른고딕");
					$("#email").val('');
					checkE = false;
				} else {
					checkE = true;
				}
			}
		});
	}
	
	var check3 = true;
	
	if (!checkE) {
		return
	
	// 일일 인증 3회를 초과했는가?
	} else {
		$.ajax({
			url : "select3.do",
			async:false,
			type : 'get',
			data : {"cert_email" : userEmail},
			success : function(msg) {
				if(msg=="cert3_FAIL"){
					$("#isValidE").html("일일 최대 인증횟수 3회를 초과했습니다.");
					$("#isValidE").css("color", "red");
					$("#isValidE").css("font-family", "나눔바른고딕");
					$("#email").val('');
					check3 = false;
				} else {
					$("#isValidE").html("인증 이메일을 전송했습니다.<br>인증은 하루 3회까지 가능합니다.");
					$("#isValidE").css("color", "blue");
					$("#isValidE").css("font-family", "나눔바른고딕");
					$("#certNum").attr("disabled", false);
					$("#certNum").attr("placeholder", '');
					check3 = true;
				}
			},
			error : function(){
				alert('error');
			}
		})
	}
	if (!check3) {
		return;
	
	// 이메일 인증 번호 전송
	} else {
		$.ajax({
			url : "mailCheck.do",
			type : 'get',
			data : {"email" : userEmail, "purpose" : "regi"},
			success : function(data) {
				$("#certNum").attr('placeholder','');
				$("#certNum").attr('disabled',false);
				$("#certNum").focus();
				$("#isValidE").html("인증 이메일을 전송했습니다.<br>인증은 하루 3회까지 가능합니다.");
				$("#isValidE").css("color", "blue");
				$("#isValidE").css("font-family", "나눔바른고딕");
				authkey = data;
				
				// 인증번호 전송 -> 인증하기로 변함
				$("#emailCertBtn").html('');
				var eBtn = "<button type='button' class='submit' onclick='checkCert()'>인증하기</button>"
				$("#emailCertBtn").append(eBtn);
			},
			error : function(){
				alert('error');
			}
		});
	}
}
function checkCert(){
	$.ajax({
		type : 'get',
		url : "selectCert.do",
		async:false,
		data : {"cert_email" : userEmail, "authkey" : $("#certNum").val()},
		success : function(msg) {
			if(msg!=null && msg!=""){
				if(msg=="cert_SUCCESS") {
					$("#emailAf").html('');
					$("#emailAf").attr('class', 'form sign-up');
				var after = "<label>"
			       			+ "<span>아이디</span>"
			        		+ "<input type='text' id='afId' maxlength='12' placeholder='영대소문자, 숫자, 6~12자'/>"
			      		+ "</label>"
			      		+ "<label>"
			       			+ "<span>비밀번호</span>"
			        		+ "<input type='password' id='afPw1' maxlength='20' placeholder='영대소문자, 숫자, 특수문자, 12~20자'/>"
			      		+ "</label>"
				      	+ "<label>"
			       			+ "<span>비밀번호 확인</span>"
			        		+ "<input type='password' id='afPw2' maxlength='20' placeholder='동일한 비밀번호를 입력해주세요.'/>"
			        		+ "<p class='small'>* SHA-256과 SALT를 통해 안전하게 저장됩니다.</p>"
			      		+ "</label>"
				      	+ "<label>"
			       			+ "<span>이름</span>"
			        		+ "<input type='text' id='afName' maxlength='15' placeholder='이름을 입력해주세요.'/>"
			      		+ "</label>"
			      		+ "<label>"
			       			+ "<span>연락처</span>"
			        		+ "<input type='text' id='phone' maxlength='15' placeholder='- 제외하고 입력해주세요.'/>"
		      			+ "</label>"
		      			+ "<button type='button' class='submit' onclick='checkRegi()'>가입하기</button>"
			      + "<br>";
			      $("#emailAf").append(after);
				} else {
					$("#ePt").html('인증번호가 틀렸습니다. 다시 확인해주세요.');
					$("#ePt").css("color", "red");
					$("#ePt").css("font-family", "나눔바른고딕");
				}
			}
		},
		error : function() {
			alert('error');
		}
	});
	 
}
var id_OK = document.getElementById("id_OK").value;
var pwd1_OK = document.getElementById("pwd1_OK").value;
var pwd2_OK = document.getElementById("pwd2_OK").value;
var name_OK = document.getElementById("name_OK").value;
var phone_OK = document.getElementById("phone_OK").value;
function checkRegi(){
	
	// ID 유효성 검사
	var idValid = /^[a-zA-z0-9]{6,12}$/;
	
	$.ajax({
		url:"idCheck.do",
		type:"post",
		async:false,
		data:{"id":$("#afId").val()},
		success:function(idCheck_Msg) {
			if(idCheck_Msg!=null && idCheck_Msg!="") {
				if(idCheck_Msg=="idCheck_SUCCESS") {
					if(!idValid.test($("#afId").val())) {
						alert('ID는 6~12자, 영문 대소문자와 숫자로 설정해주세요.');
						$("#afId").val('');
						id_OK=false;
					} else {
						id_OK=true;
					}
				} else {
					alert('이미 존재하는 ID입니다.');
					$("#afId").val();
					id_OK=false;
				}
			}
		},
		error:function(){
			alert('error');
		}
	});
	
	if(!id_OK) {
		return;
	} else {
		// PWD 유효성 검사
		var afPw1 = $("#afPw1").val();
		var numValid = afPw1.search(/[0-9]/g);
		var engValid = afPw1.search(/[a-z]/ig);
		var speValid = afPw1.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		
		if (afPw1.length<8 || afPw1.length>20) {
			alert('비밀번호는 6~20자로 설정해주세요.');
			$("#afPw1").val('');
			pwd1_OK=false;
		} else if(numValid < 0 || engValid < 0 || speValid < 0 ){
			alert('비밀번호에는 숫자, 영문, 특수문자가 모두 포함되어있어야 합니다.');
			$("#afPw1").val('');
			pwd1_OK=false;
		} else {
			pwd1_OK=true;
		}
	}
	
	if(!pwd1_OK) {
		return;
	} else {
		if($("#afPw1").val()!=$("#afPw2").val()) {
			alert('동일한 비밀번호를 입력해주세요.');
			$("#afPw2").val('');
			pwd2_OK=false;
		} else {
			pwd2_OK=true;
		}
	}
	
	if(!pwd2_OK) {
		return;
	} else {
		var nameValid = /\s/g;
		if(nameValid.test($("#afName").val())) {
			alert('이름에는 공백이 들어갈 수 없습니다.');
			$("#afName").val('');
			name_OK = false;
		} else {
			name_OK = true;
		}
	} 
	
	if(!name_OK) {
		return;
	} else {
		var phoneValid = /^[0-9]*$/;
		if($.trim($("#phone").val())=="") {
			alert('연락처를 입력해주세요. 이후에 공개 여부를 변경할 수 있습니다.');
		} else if(!phoneValid.test($("#phone").val())) {
			alert('연락처는 -를 제외한 숫자만 입력해주세요.');
			$("#phone").val('');
			phone_OK = false;
		} else {
			phone_OK = true;
		}
	}
	
	if(phone_OK) {
	var submitPwd = $("#afPw1").val();
	var saltpw = submitPwd.substr(0,2) + submitPwd + submitPwd.substr(submitPwd.length-2, submitPwd.length);
	$("#submitEmail").val(userEmail);
	$("#submitId").val($("#afId").val());
	$("#submitPwd").val(sha256(saltpw));
	$("#submitName").val($("#afName").val());
	$("#submitPhone").val($("#phone").val());
	$("#frm2").submit();
	}
}
</script>

</body>
</html>
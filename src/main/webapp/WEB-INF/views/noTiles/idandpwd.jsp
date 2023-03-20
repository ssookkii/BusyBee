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
	 background: rgba(70, 15, 0, 0.8);
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
  <div id="div1" class="form sign-in">
  <br>
  	<img src = "./images/LetterLogo.png" class="center">
  	<br><br>
    <label>
      <span>이메일</span>
      <input type="text" id="email" maxlength="25" placeholder="이메일을 입력해주세요."/>
    </label>
    <p id="eValid" style="text-align: center; margin-top: 10px;font-size:10pt"></p>
    <label>
      <span>이름</span>
      <input type="text" id="name" maxlength="20" placeholder="이름을 입력해주세요."/>
    </label>
    <p id="nValid" style="text-align: center; margin-top: 10px;font-size:10pt"></p>
    <br>
    <button type="button" class="submit" id="doFind">아이디 찾기</button>
    <br>
    <p class="forgot-pass"><a href="loginMain.do">🐝 기억났어요. 로그인하러 갈래요!</a></p>
  </div>
  <div class="sub-cont">
    <div class="img">
      <div class="img__text m--up">
        <h2 style="font-size: 23pt; font-family: '나눔바른고딕'">비밀번호 재설정</h2>
        <p>아이디와 이메일로</p>
        <p>새 비밀번호를 설정하세요 🐝</p>
      </div>
      <div class="img__text m--in">
        <h2 style="font-size: 23pt; font-family: '나눔바른고딕'">ID 찾기</h2>
        <p>이메일과 이름으로</p>
        <p>가입했던 ID를 찾아보세요 🐝</p>
      </div>
      <div class="img__btn">
        <span style="font-size:9pt" class="m--up">비밀번호 재설정</span>
        <span class="m--in">ID 찾기</span>
      </div>
    </div>
    <div id="emailAf" class="form sign-up">
    <br>
    <img src = "./images/LetterLogo.png" class="center">
    <br>
      <label>
        <span>이메일</span>
        <input type="text" id="emailPW" maxlength="25" placeholder="이메일을 입력해주세요."/>
      </label>
      <p id="eValidPW" style="text-align: center; margin-top: 10px;font-size:10pt"></p>
      <label>
        <span>ID</span>
        <input type="text" id="idPW" maxlength="12" placeholder="ID를 입력해주세요."/>
      </label>
      <p id="iValidPW" style="text-align: center; margin-top: 10px;font-size:10pt"></p>
      <label>
        <span>인증번호</span>
        <input type="text" id="certNum" maxlength="6" placeholder="인증번호 전송을 눌러주세요." disabled="disabled" />
      </label>
      <p id="ePt" style="text-align: center; margin-top: 10px;font-size:10pt"></p>
      <div id = "emailCertBtn">
      <button type="button" class="submit" onclick="doCert()">인증번호 전송</button>
      </div>
      <br>
    	<p class="forgot-pass" style="margin-top: 20px"><a href="loginMain.do">🐝 기억났어요. 로그인하러 갈래요!</a></p>
    </div>
  </div>
</div>

<form action="updPwd.do" id="frm" method="post">
<input type="hidden" id="c_password" name="password">
<input type="hidden" id="c_id" name="id">
</form>

<script type="text/javascript">
document.querySelector('.img__btn').addEventListener('click', function() {
	  document.querySelector('.cont').classList.toggle('s--signup');
	});
	
// ID찾기
$("#doFind").click(function(){
	
	// 이메일 유효성 검사
	var emailValid = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	var userEmail = $.trim($("#email").val());
	
	if(userEmail == ""){
		$("#eValid").html("유효한 이메일을 입력해주세요");
		$("#eValid").css("color", "red");
		$("#eValid").css("font-family", "나눔바른고딕");
		return;
	} else if(!emailValid.test(userEmail)) {
		$("#eValid").html("유효한 이메일을 입력해주세요");
		$("#eValid").css("color", "red");
		$("#eValid").css("font-family", "나눔바른고딕");
		return;
	} else {
		$("#eValid").html("");
	}
	
	// 이름 유효성검사
	var nameValid = /\s/g;
	
	if($.trim($("#name").val())=="") {
		$("#nValid").html("유효한 이름을 입력해주세요");
		$("#nValid").css("color", "red");
		$("#nValid").css("font-family", "나눔바른고딕");
		return;
	}
	if(nameValid.test($("#name").val())) {
		$("#nValid").html("이름에는 공백이 들어갈 수 없습니다.");
		$("#nValid").css("color", "red");
		$("#nValid").css("font-family", "나눔바른고딕");
		return;
	} else {
		$("#nValid").html("");
	}
	
	$.ajax({
		url:"findId.do",
		type:"post",
		data:{"name":$("#name").val(), "email":$("#email").val()},
	
		success:function(data) {
			if(data==null || data=="") {
				$("#div1").html('');
				var result =   "<br>"
							  	+ "<img src = './images/LetterLogo.png' class='center'>"
								+ "<label>"
								+ "<br><br><br><br><br>"
								+ "<h3 style='text-align='center''>등록된 정보가 없습니다.</h3>"
								+ "<br>"
								+ "<button type='button' class='submit' onclick='retry()'>아이디 다시 찾기</button>"
								+ "<br><br><br>"
								+ "<p class='forgot-pass'><a href='loginMain.do'>🐝 기억났어요. 로그인하러 갈래요!</a></p>"
							+ "</label>";
				$("#div1").append(result);
			} else {
				
				var found1 = data.id
				var found2 = data.regidate
				var tableTd = "";
				var star = '*';
				for(var i=0; i<data.id.length-4; i++) {
					star += '*';
				}
				
				$("#div1").html('');
				var result =   "<br>"
							  	+ "<img src = './images/LetterLogo.png' class='center'>"
								+ "<label>"
								+ "<br><br><br><br><br>"
								+ "<h2 style='text-align='center''>🐝 ID : " + found1.substr(0,3) + star + "</h2>"
								+ "<h5 style='text-align='center''>[가입일 : " + found2.substr(0,10) +"]</h5>"
								+ "<br>"
								+ "<button type='button' class='submit' onclick='retry()'>아이디 다시 찾기</button>"
								+ "<br><br><br>"
								+ "<p class='forgot-pass'><a href='loginMain.do'>🐝 기억났어요. 로그인하러 갈래요!</a></p>"
							+ "</label>";
				$("#div1").append(result);
			}
		},
		error:function(){
			alert('error');
		}
		
	});
});
// 비밀번호 재설정
var authkey = "";
var userEmailPW = "";
var idPW = "";
function doCert(){
	
	var email_OK = true;
	var id_OK = true;
	
	// 이메일 정규식
	var emailValid = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	userEmailPW = $("#emailPW").val();
	
	if(userEmailPW == "") {
		$("#eValidPW").html("유효한 이메일을 입력해주세요");
		$("#eValidPW").css("color", "red");
		$("#eValidPW").css("font-family", "나눔바른고딕");
		email_OK = false;
		return;
	}
	if(!emailValid.test(userEmailPW)) {
		$("#eValidPW").html("유효한 이메일을 입력해주세요");
		$("#eValidPW").css("color", "red");
		$("#eValidPW").css("font-family", "나눔바른고딕");
		$("#email").val('');
		email_OK = false;
		return;
	} else {
		$("#eValidPW").html("");
		email_OK = true;
	}
	
	if(!email_OK) {
		return;
	} else {
		var idValid = /^[a-zA-z0-9]{6,12}$/;
		var userIdPW = $("#idPW").val();
		if($.trim(userIdPW)=="") {
			$("#iValidPW").html("유효한 아이디를 입력해주세요");
			$("#iValidPW").css("color", "red");
			$("#iValidPW").css("font-family", "나눔바른고딕");
			id_OK=false;
			return;
		}
		
		if(!idValid.test(userIdPW)) {
			$("#iValidPW").html("유효한 아이디를 입력해주세요");
			$("#iValidPW").css("color", "red");
			$("#iValidPW").css("font-family", "나눔바른고딕");
			id_OK=false;
			return;
		} else {
			id_OK=true;
		}
		
	}
	
	if(!id_OK) {
		return;
	} else {
		$.ajax({
			url : "findforPwd.do",
			type : "post",
			data : {"id" : $("#idPW").val(), "email" : userEmailPW},
			success : function(msg) {
				if(msg=="findforPwd_SUCCESS") {
					$("#idPW").attr('disabled', true);
					$("#namePW").attr('disabled', true);
					$("#emailPW").attr('disabled', true);
					idPW = $("#idPW").val();
					sendCert();
				} else {
					alert('일치하는 정보가 없습니다. 다시 확인해주세요.');
				}
			},
			error : function(msg) {
				alert('error');
			}
		});
	}
}
function sendCert() {
	
	var check3 = true;
	
	$.ajax({
		url : "select3.do",
		async:false,
		type : 'get',
		data : {"cert_email" : userEmailPW},
		success : function(msg) {
			if(msg=="cert3_FAIL"){
				alert('일일 최대 인증횟수 3회를 초과했습니다. 다음에 다시 시도해주세요.');
				location.href='loginMain.do';
				check3 = false;
			}
		},
		error : function(){
			alert('error');
		}
	});
	if (!check3) {
		return;
	}
	else {
	$.ajax({
			url : "mailCheck.do",
			type : 'get',
			data : {"email" : userEmailPW, "purpose" : "find"},
			success : function(data) {
				alert('인증번호가 전송되었습니다. 인증은 일일 3회까지 가능합니다.');
				$("#certNum").attr("disabled", false);
				authkey = data;
				
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
		data : {"cert_email" : userEmailPW, "authkey" : $("#certNum").val()},
		success : function(msg) {
			if(msg!=null && msg!=""){
				if(msg=="cert_SUCCESS") {
					$("#emailAf").html('');
					$("#emailAf").attr('class', 'form sign-up');
				var after = "<br>"
			  				+ "<img src = './images/LetterLogo.png' class='center'>"
			  				+ "<br><br>"
							+ "<label>"
			       			+ "<span>새 비밀번호</span>"
			        		+ "<input type='password' id='afPw1' maxlength='20' placeholder='영대소문자, 숫자, 특수문자, 12~20자'/>"
			      		+ "</label>"
			      		+ "<br>"
			      		+ "<label>"
			       			+ "<span>새 비밀번호 확인</span>"
			        		+ "<input type='password' id='afPw2' maxlength='20' placeholder='동일한 비밀번호를 입력해주세요.'/>"
			      		+ "</label>"
			      		+ "<br>"
		      			+ "<button type='button' class='submit' onclick='changePwd()'>재설정 완료</button>"
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
function changePwd() {
	
	var afPw1 = $("#afPw1").val();
	var numValid = afPw1.search(/[0-9]/g);
	var engValid = afPw1.search(/[a-z]/ig);
	var speValid = afPw1.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	
	if (afPw1.length<8 || afPw1.length>20) {
		alert('비밀번호는 6~20자로 설정해주세요.');
		$("#afPw1").val('');
		pwd1_OK=false;
		return;
	} else if(numValid < 0 || engValid < 0 || speValid < 0 ){
		alert('비밀번호에는 숫자, 영문, 특수문자가 모두 포함되어있어야 합니다.');
		$("#afPw1").val('');
		pwd1_OK=false;
		return;
	} else {
		pwd1_OK=true;
	}
	
	if(!pwd1_OK) {
		return;
	} else {
		if($("#afPw1").val()!=$("#afPw2").val()) {
			alert('동일한 비밀번호를 입력해주세요.');
			$("#afPw2").val('');
			pwd2_OK=false;
		} else {
			var userPwd = $("#afPw1").val();
			var saltpw = userPwd.substr(0,2) + userPwd + userPwd.substr(userPwd.length-2, userPwd.length);
			$("#c_id").val(idPW);
			$("#c_password").val(sha256(saltpw));
			$("#frm").submit();
		}
	}
	
	
}
function retry() {
	location.href="idandpwd.do";
}
</script>


</body>
</html>

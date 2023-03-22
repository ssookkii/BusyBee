<%@page import="java.util.List"%>
<%@page import="mul.cam.a.dto.GroupMemDto"%>
<%@page import="mul.cam.a.dto.GroupDto"%>
<%@page import="mul.cam.a.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%
	UserDto login = (UserDto) session.getAttribute("login");
	String id = login.getId();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<style>

/* 메뉴 CSS */



.wrapper{
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}
.mainMenu{
	position : absolute;
    width: 400px;
    display: block;
    border-radius: 10px;
    overflow: hidden;
    margin: 0;
    padding-left:120px;
    font-family: 'lato';
    list-style: none;
    text-decoration: none;
}
.item{

    overflow: hidden;
}
.subMenuBtn{
    display: block;
    padding: 15px 20px;
    background-color: #ffe1b7;
    color: #fff;
    position: relative;
    font-size: 24px;
    font-weight: 1000;
    text-decoration: none;

}

.subMenuBtn:before{
    content: '';
    position: absolute;
    width: 0;
    height: 0;
    border-left: 8px solid transparent;
    border-right:8px solid transparent;
    border-top:10px solid #ffe5a7;
    right: 15px;
    bottom: -10px;
    z-index: 9;
        text-decoration: none;
    
    
}
.subMenuBtn i {
    margin-right: 10px;
}
.subMenu{
    background: #ffecd2;
    overflow: hidden;
    transition: max-height 0.7s;
    max-height: 0;
        text-decoration: none;
    
}

.subMenu a{
    display: block;
    padding: 15px 20px;
    color: #8c5a0b;
    font-size: 14px;
    border-bottom: 1px solid #f3e1c8;
    position: relative;
        text-decoration: none;
    

    
}
.subMenu a:before{
    content: '';
    opacity: 0;
    transition: opacity 0.3s;
        text-decoration: none;
    

}
.subMenu a:hover:before{
    content: '';
    position: absolute;
    height: 0;
    width: 6px;
    left: 0;
    top:0;
    opacity: 1;
    /* background-color: #d8d824; */
    border-top: 24px solid transparent;
    border-left: 11px solid #f3e1c8;
    border-bottom: 24px solid transparent;
        text-decoration: none;
    
}
.subMenu a:after{
    content: '';
    opacity: 0;
    transition: opacity 0.3s;
        text-decoration: none;
    

}
.subMenu a:hover:after{
    content: '';
    position: absolute;
    height: 0;
    width: 6px;
    right: 0px;
    top:0;
    opacity: 1;
    /* background-color: #d8d824; */
    border-top: 24px solid transparent;
    border-right: 11px solid #f3e1c8;
    border-bottom: 24px solid transparent;
        text-decoration: none;
    
    
}
.subMenu a:hover{
    background: #f8d6a7;
    background: -moz-linear-gradient(top, #feeed9 0%, #feeed9 50%, #f8d6a7 51%, #f8d6a7 100%);
    background: -webkit-linear-gradient(top, #feeed9 0%,#feeed9 50%,#f8d6a7 51%,#f8d6a7 100%);
    background: linear-gradient(to bottom, #feeed9 0%,#feeed9 50%,#f8d6a7 51%,#f8d6a7 100%);
    filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#feeed9', endColorstr='#f8d6a7',GradientType=0 );
    transition: all 0.3s;
    border-bottom: 1px solid #ffe5a7;
    text-decoration: none;
    
    
}
.subMenu a:last-child{
    border:none;
        text-decoration: none;
    
}
.item:target .subMenu{
    max-height: 30em;
}

</style>


</head>
<body>

<!-- 탭 메뉴 -->

	<input type="hidden" id="id" value='<%=id %>'>
    <div class="wrapper">
        <ul class="mainMenu">
            <li class="item" id="account">
                <a style="color:#b38154; text-decoration: none; " href="#account" class="subMenuBtn" ><img src = "./images/mark2.png" width="40px" height="35px" style="float: left;  "/>나의 그룹</a>
                 <div id="subMenu" class="subMenu" >
                                              
               </div>
            </li>
                 <li  style="color: #bca880; font-size:14px; text-decoration: none; text-align:center;"><p id="nogroup"></p></li>
        </ul>
    </div>




  <script type="text/javascript">
   $(document).ready(function(){
		var group1;
		var group2;
		var count = 1;
		
		// Leader
		$.ajax({
			url:"selectGroup1.do",
			type:"get",
			data:{"id":$("#id").val()},
			async:false,
			success:function(data) {
				//alert(data);

				if(data!=null && data!="") {
					var submenu = '';
					$.each(data, function(i){
					submenu += "<a href='groupMainPage.do?group_code="+data[i].group_code+"&group_name="+data[i].group_name+"'>"+data[i].group_name+"</a>";
						 
					});
					$("#subMenu").append(submenu);
					group1 = true;
					groupCheck();
				} else if (data==null || data=="") {
					group1 = false;
					groupCheck();
				}
			},	
			error:function(){
				alert('error');
			}
		});
	// Member
	$.ajax({
		url:"selectGroup2.do",
		type:"get",
		data:{"id":$("#id").val()},
		success:function(data) {
			//alert(data);

			if(data!=null && data!="") {
				var submenu = '';
				$.each(data, function(i){
					var group_code = data[i].group_code;
					submenu += "<a href='groupMainPage.do?group_code="+data[i].group_code+"&group_name="+data[i].group_name+"'>"+data[i].group_name+"</a>";

				});
				$("#subMenu").append(submenu);
				group2 = true;
				groupCheck();
			} else if (data==null || data=="") {
				group2 = false;
				groupCheck();
			}
		},
		error:function(){
			alert('error');
		}
		
		
		
	});
	
	function groupCheck(){
		
		/* 		alert("group1 =" + group1);
				alert("group2 =" + group2);
				 */
				if(group1=="undefined" || group2=="undefined") {
					return;
				}
				
				if(group1==false && group2==false) {
		/* 			alert("group1* =" + group1);
					alert("group2* =" + group2); */
					$("#nogroup").html(' <a href="goSearchgroup.do" style="color: #bca880; font-size:14px; text-decoration: none;"> 가입한 그룹이 없어요! </br> 그룹을 가입하고 BUSY BEE를 누려보세요! ');
				}
			}
			
		});
 
  </script>
</body>
</html>

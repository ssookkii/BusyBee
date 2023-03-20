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

    #topMenu {
            height: 30px;  /* 메인 메뉴의 높이 */
            width: 100px;  /* 메인 메뉴의 넓이 */
    }
    #topMenu ul {           /* 메인 메뉴 안의 ul을 설정함: 상위메뉴의 ul+하위 메뉴의 ul */
        list-style-type: none;  /* 메인 메뉴 안의 ul 내부의 목록 표시를 없애줌 */
        margin: 0px;            /* 메인 메뉴 안의 ul의 margin을 없앰 */
        padding: 0px;           /* 메인 메뉴 안의 ul의 padding을 없앰 */
    }
    #topMenu ul li {            /* 메인 메뉴 안에 ul 태그 안에 있는 li 태그의 스타일 적용(상위/하위메뉴 모두) */
        color: white;               /* 글씨 색을 흰색으로 설정 */
        background-color: #2D2D2D;  /* 배경 색을 RGB(2D2D2D)로 설정 */
        float: left;                /* 왼쪽으로 나열되도록 설정 */
        line-height: 30px;          /* 텍스트 한 줄의 높이를 30px로 설정 */
        vertical-align: middle;     /* 세로 정렬을 가운데로 설정 */
        text-align: center;         /* 텍스트를 가운데로 정렬 */
        position: relative;         /* 해당 li 태그 내부의 top/left 포지션 초기화 */
    }
    .menuLink {           /* 상위 메뉴와 하위 메뉴의 a 태그에 공통으로 설정할 스타일 */
        text-decoration:none;               /* a 태그의 꾸밈 효과 제거 */
        display: block;                     /* a 태그의 클릭 범위를 넓힘 */
        width: 250px;                       /* 기본 넓이를 150px로 설정 */
        font-size: 32px;                    /* 폰트 사이즈를 12px로 설정 */
        font-weight: bold;                  /* 폰트를 굵게 설정 */
        font-family: "Trebuchet MS", Dotum; /* 기본 폰트를 영어/한글 순서대로 설정 */
    }
    .submenuLink{
        text-decoration:none;               /* a 태그의 꾸밈 효과 제거 */
        display: block;                     /* a 태그의 클릭 범위를 넓힘 */
        width: 250px;                       /* 기본 넓이를 150px로 설정 */
        font-size: 16px;                    /* 폰트 사이즈를 12px로 설정 */
        font-weight: bold;                  /* 폰트를 굵게 설정 */
        font-family: "Trebuchet MS", Dotum; /* 기본 폰트를 영어/한글 순서대로 설정 */
    }
    .menuLink {     /* 상위 메뉴의 글씨색을 흰색으로 설정 */
        color: white;
    }
    .topMenuLi:hover .menuLink {    /* 상위 메뉴의 li에 마우스오버 되었을 때 스타일 설정 */
        color: red;                 /* 글씨 색 빨간색 */
        background-color: #4d4d4d;  /* 배경색을 밝은 회색으로 설정 */
    }
    .submenuLink {          /* 하위 메뉴의 a 태그 스타일 설정 */
        color: #2d2d2d;             /* 글씨 색을 RGB(2D2D2D)로 설정 */
        background-color: white;    /* 배경색을 흰색으로 설정 */
        border: solid 1px black;    /* 테두리를 설정 */
        margin-top: -1px;           /* 위 칸의 하단 테두리와 아래칸의 상단 테두리가 겹쳐지도록 설정 */
    }
    .longLink {     /* 좀 더 긴 메뉴 스타일 설정 */
        width: 190px;   /* 넓이는 190px로 설정 */
    }
    .submenu {              /* 하위 메뉴 스타일 설정 */
        position: absolute;     /* html의 flow에 영향을 미치지 않게 absolute 설정 */
        height: 0px;            /* 초기 높이는 0px로 설정 */
        transition: height .2s; /* height를 변화 시켰을 때 0.2초간 변화 되도록 설정(기본) */
        -webkit-transition: height .2s; /* height를 변화 시켰을 때 0.2초간 변화 되도록 설정(구버전 크롬/사파라ㅣ) */
        -moz-transition: height .2s; /* height를 변화 시켰을 때 0.2초간 변화 되도록 설정(구버전 파폭) */
        -o-transition: height .2s; /* height를 변화 시켰을 때 0.2초간 변화 되도록 설정(구버전 오페라) */
   		max-height: 200px;
		overflow-x: hidden;
		overflow-y: auto;
   
    }
    .topMenuLi:hover .submenu { /* 상위 메뉴에 마우스 모버한 경우 그 안의 하위 메뉴 스타일 설정 */
        height: 500px;           /* 높이를 93px로 설정 */
    }
    .submenuLink:hover {        /* 하위 메뉴의 a 태그의 마우스 오버 스타일 설정 */
        color: red;                 /* 글씨색을 빨간색으로 설정 */
        background-color: #dddddd;  /* 배경을 RGB(DDDDDD)로 설정 */
    }
    
}


</style>


</head>
<body>

<input type="hidden" id="id" value='<%=id %>'>
<nav id="topMenu" >
		<ul>
			<li class="topMenuLi">
                <a class="menuLink">나의 그룹</a>
                <ul id="submenu" class="submenu">                               
                <li><p id="nogroup" ></p></li>
  
               </ul>
               
 
		</ul>
	</nav>


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
					submenu += "<li><a href='groupMainPage.do?group_code="+data[i].group_code+"&group_name="+data[i].group_name+"' class='submenuLink longLink'>"+data[i].group_name+"</a></li>";
						 
					});
					$("#submenu").append(submenu);
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
					submenu += "<li><a href='groupMainPage.do?group_code="+data[i].group_code+"&group_name="+data[i].group_name+"' class='submenuLink longLink'>"+data[i].group_name+"</a></li>";

				});
				$("#submenu").append(submenu);
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
					$("#nogroup").text('가입한 그룹이 없습니다.');	
				}
			}
			
		});
 
  </script>
</body>
</html>

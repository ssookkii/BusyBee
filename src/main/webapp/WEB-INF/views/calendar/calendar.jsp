<%@page import="mul.cam.a.dao.GroupDao"%>
<%@page import="mul.cam.a.service.impl.GroupServiceImpl"%>
<%@page import="mul.cam.a.service.GroupService"%>
<%@page import="mul.cam.a.dto.GroupDto"%>
<%@page import="mul.cam.a.service.EventService"%>
<%@page import="mul.cam.a.dto.UserDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.List"%>
<%@page import="mul.cam.a.dto.EventDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 관리</title>
<link rel="stylesheet" href="css/mystyle.css">

<!-- jQuery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="https://bootswatch.com/5/minty/bootstrap.min.css">


<!-- Moment.js -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script
	src='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.4.0/fullcalendar.min.js'></script>

<!-- Bootstrap Datepicker -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap-responsive.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>


<!-- timepicker -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>




<%
EventDto dto = (EventDto) request.getAttribute("scheduleList");
UserDto login = (UserDto)session.getAttribute("login");
String id = login.getId();
String myGroup = request.getParameter("groupCode");
String myGroupName = "";
%>


</head>
<body>
<script>	

function initTimepicker() {
	  $('#edit-start-time, #edit-end-time').timepicker({
	    timeFormat: 'HH:mm',
	    interval: 30,
	    defaultTime: '9',
	    minTime: '0',
	    maxTime: '23',
	    startTime:'0',
	    dynamic: false,
	    dropdown: true,
	    scrollbar: true
	  });
	}	
		// 캘린더 영역 생성
	$(document).ready(function() {

		$(document).ready(function(){

		  var group1;
		  var group2;

		  // Leader
		  $.ajax({
		    url:'selectGroup1.do?id=' + '<%=id%>',
		    type:"get",
		    success:function(data) {
		      if(data!=null && data!="") {
		        var group = '';
		        $.each(data, function(i){
		        	if( data[i].group_code === '<%=myGroup%>') { 
		        		myGroupName = data[i].group_name ;
			        console.log(myGroupName);
		        	} });
		    
		        group1 = true;
		      } else if (data==null || data=="") {
		        group1 = false;
		      }
		    }, 
		    error:function(){
		      alert('error');
		    }
		  });

		  // Member
		  $.ajax({
		    url:'selectGroup2.do?id=' + '<%=id%>',
		    type:"get",
		    success:function(data) {
		      if(data!=null && data!="") {
		        var group = '';
		        $.each(data, function(i){
		        	if( data[i].group_code === '<%=myGroup%>') { 
		        		myGroupName = data[i].group_name ;
			        	console.log(myGroupName);
		        	}   });
		   
		        group2 = true;
		      } else if (data==null || data=="") {
		        group2 = false;
		      }
		    },
		    error:function(){
		      alert('error');
		    }
		  });
		});

		 setTimeout(function() {
		      if (myGroupName !== undefined) {
		        var groupNameElem = $('<div style="text-align: center; font-size: 20px; font-weight: bold; margin-top: 10px;">현재 내 그룹: ' + myGroupName + '</div>');
		        $('#calendar').before(groupNameElem);
		      }
		    }, 100);
		 
	    $('#calendar').fullCalendar({
	        // 일정 데이터
	        events: function(start, end, timezone, callback) {
	        	  $.ajax({

	        		  url: 'groupeventlist.do?id=' + '<%=id%>&groupCode=<%=myGroup%>',
		                dataType: 'json',
		                success: function(response) {
		                    var events = [];
		                    // 서버에서 가져온 일정 목록을 이벤트 객체로 변환합니다.
		                    
		                    for (var i = 0; i < response.length; i++) {
		                        events.push({
		                            id: response[i].id,
		                            groupCode: response[i].groupCode,
		                            scheduleId:response[i].scheduleId,
		                            title: response[i].title,
		                            start: moment(response[i].startDate), // moment.js 객체로 변환
		                            end: moment(response[i].endDate), // moment.js 객체로 변환
		                            description: response[i].description
		                        });
		                    }
		                    // 이벤트 객체 목록을 캘린더에 할당합니다.
		                    callback(events);
		                }
		            })
	        },
	    
	        // 일정 추가/수정/삭제 기능
	        editable: true,
	        eventStartEditable: true,
	        eventDurationEditable: true,
	        displayEventTime: false,


	        eventClick: function(event, jsEvent, view) {
	          
	        },

	        dayClick: function(date, jsEvent, view) {
	            var clickedDate = date.format('YYYY-MM-DD');
	            selectedDate = clickedDate;
	            
	            var events = $('#calendar').fullCalendar('clientEvents', function(event) {
	                var days = [];
	                var day = moment(event.start);
	                var endDay = moment(event.end);
	                while (day <= endDay ) {
	                    days.push(day.format('YYYY-MM-DD'));
	                    day.add(1, 'days');
	                }
	                
	                return days.indexOf(date.format('YYYY-MM-DD')) >= 0;
	            });

	            if (events.length === 0) {
	                // 해당 날짜에 일정이 없는 경우
	                $('.card-body').html('<p>해당 날짜에 일정이 없습니다.</p>');
	                $('.card-title').html(date.format('YYYY-MM-DD'));
	            } else {
	                var html = '<table class="event-table"><thead><tr><th></th><th>일정 제목</th><th>일정 시간</th></tr></thead><tbody>';
	                $.each(events, function(index, event) {
	                	html += '<tr><td><input type="checkbox" name="eventIds[]" value="' + event.scheduleId + '" style="display:none;"></td><td class="event-title" data-eventid="' + event.scheduleId + '">' + event.title + '</td><td>' + moment(event.start).format('YYYY-MM-DD HH:mm') + ' - ' + moment(event.end).format('YYYY-MM-DD HH:mm') + '</td></tr>';

	                });
	                html += '</tbody></table>';
	                $('.card-body').html(html);
	                $('.card-title').html(clickedDate);
	            }
	        },

	        });
		
		

		
	 // 삭제 버튼 클릭 시 다중삭제 모달 열기
	    $('#delete-event-btn').click(function() {
	        var events = $('#calendar').fullCalendar('clientEvents', function(event) {
	            var days = [];
	            var day = moment(event.start);
	            var endDay = moment(event.end);

	            while (day <= endDay) {
	                days.push(day.format('YYYY-MM-DD'));
	                day.add(1, 'days');
	            }

	            return days.indexOf(selectedDate) >= 0;
	        });

	        if (events.length === 0 ) {
	            // 해당 날짜에 일정이 없는 경우
	            $('#messageConfirmModal .modal-title').html(selectedDate + '');
	            $('#messageConfirmModal .modal-body').html('삭제할 일정이 없습니다');
	            $('#messageConfirmModal').modal('show');
	        } else {
	            var html = '<form>';
	            $.each(events, function(index, event) {
	                html += '<li style="display: block;"><input type="checkbox" name="eventIds[]" value="' + event.scheduleId + '"> ' + event.title + '</li> <br/>';
	            });
	            html += '</form>';
	            $('#deleteConfirmModal .modal-title').html('삭제할 일정을 선택하세요.');
	            $('#deleteConfirmModal .modal-body').html(html);
	            $('#deleteConfirmModal #customConfirmBtn').html('삭제');
	            $('#deleteConfirmModal').modal('show');
	        }
	        
	        $('#deleteConfirmBtn').click(function() {
	        	 // 체크된 일정의 scheduleId들을 배열로 수집
	        	 var selectedEventIds = $('input[name="eventIds[]"]:checked').map(function() {
	        		    return $(this).val();
	        		  }).get();
	        	 
			    // 일정 삭제 요청, 여러개를 삭제하기 위해 each 사용
			    $.each(selectedEventIds, function(index, eventId) {
				    $.ajax({
				      url: 'eventdelete.do',
				      type: 'POST',
				      data: { 'scheduleId': eventId },
				      success: function(response) {
				        // FullCalendar에서 일정 삭제
				        $('#calendar').fullCalendar('removeEvents', selectedEventIds);
				        // 일정 리스트 업데이트
				        location.reload();
				      },
				      error: function() {
				        alert('일정을 삭제하는데 실패하였습니다.');
				      }
			    });
			    });
			
			    $('#customConfirmModal').modal('hide');
			  });
			});

	    });
	
		


	
  </script>

	
		<table style="width: 100%;">
		
			<tr>
				<td style="width: 60%;">

			<div id='calendar'></div>
					
				</td>
				<td>
				
					<div style="text-align: right;">
					
						<div id="event-list">
							<div style="margin-right: 20px;">
								<button id="add-event-btn" class="btn btn-warning">일정
									추가</button>
								<button id="delete-event-btn" class="btn btn-warning">일정
									삭제</button>
							</div>
							<div class="flex-item card border-light mb-3">
								<div class="card-header"
									style="height: 40px; font-size: 15px; display: flex; justify-content: center; align-items: center;">일정
									리스트</div>
								<div class="card-title" style="height: 40px; font-size: 15px;"></div>
								<div class="card-body" style="height: 600px"></div>
								<ul id="event-check-list"></ul>



							</div>

						</div>

					</div>

				</td>
			</tr>
		</table>
	</div>


	<!-- 상세보기 Modal -->
	<div class="modal" id="eventModal" tabindex="-1"
		aria-labelledby="eventModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="eventModalLabel"></h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true"></span>
					</button>
				</div>

				<div class="modal-body">
					<table>
						<thead>
							<tr>
								<th>일정 시간</th>
							</tr>
						</thead>

						<tbody>
							<tr>
								<td>
									<p id="eventDate"></p>
								</td>
							</tr>
						</tbody>

						<thead>
							<tr>
								<th>일정 상세 내용</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="event-description" style="height: 150px;">
									<p id="eventDescription"></p>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<div>

						<button type="button" class="btn btn-warning"
							data-bs-dismiss="modal" id="share-event-btn">일정 공유</button>
						<button type="button" class="btn btn-warning"
							data-bs-dismiss="modal" id="update-event-btn">일정 수정</button>
						<button type="button" class="btn btn-dark" data-bs-dismiss="modal"
							id="one-delete-event-btn">일정 삭제</button>
					</div>

				</div>
			</div>
		</div>
	</div>

	<!-- 수정 Modal -->
	<div class="modal" id="editEventModal" tabindex="-1"
		aria-labelledby="editEventModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="editEventModalLabel"></h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true"></span>
					</button>
				</div>
				<div class="modal-body">
					<table>
						<thead>
							<tr>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><p id="editEventDate"></p></td>
							</tr>
						</tbody>
						<thead>
							<tr>
								<th>일정 상세 내용</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="edit-event-description" style="height: 150px;"><textarea
										id="edit-description"></textarea></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-warning"
						id="edit-save-event-btn">수정 완료</button>
					<button type="button" class="btn btn-dark" data-bs-dismiss="modal">취소</button>

				</div>
			</div>
		</div>
	</div>
	
	<!-- 삭제 모달 -->
<div class="modal" id="customConfirmModal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-warning text-white">
      </div>
      <div class="modal-body" style="height: 80px; display: flex; align-items: center; justify-content: center;">
        <p>정말로 일정을 삭제하시겠습니까?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-warning" data-dismiss="modal" id="cancel">취소</button>
        <button type="button" class="btn btn-dark" id="customConfirmBtn">삭제</button>
      </div>
    </div>
  </div>
</div>
	<!-- 다중 삭제 모달 -->
<div class="modal" id="deleteConfirmModal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-warning text-white" >
        <h8 class="modal-title" ></h8>
      </div>
      <div class="modal-body" style="height: 200px; display: flex; align-items: center; justify-content: center;">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-warning" data-dismiss="modal" id="deletecancel">취소</button>
        <button type="button" class="btn btn-dark" id="deleteConfirmBtn">삭제</button>
      </div>
    </div>
  </div>
</div>
	<!-- 메시지 모달 -->
<div class="modal" id="messageConfirmModal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content" >
      <div class="modal-header bg-warning text-white">
      </div>
      <div class="modal-body" style="height: 150px; display: flex; align-items: center; justify-content: center;">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-warning" data-dismiss="modal" id="messageCancel">확인</button>
      </div>
    </div>
  </div>
</div>
<!-- 알림 모달 -->
<div class="modal" id="today-event-modal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content" >
      <div class="modal-header bg-warning text-white" style="font-size:17px">
      </div>
      <div class="modal-body" style="height: 100px; display: flex; align-items: center; justify-content: center;">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-warning" data-dismiss="modal" id="alarmCancel">확인</button>
      </div>
    </div>
  </div>
</div>
	<script>
	
	// 일정 추가에 그룹 추가 

		
			// 일정 추가 버튼 클릭 시 일정 추가 화면으로 전환
		$('#event-list').on('click', '#add-event-btn', function(){
			
			$(document).ready(function() {
				  // 체크박스 클릭 시
				  $('#all-day').change(function() {
				    // 체크박스가 체크되면 시작일정의 시간 인풋과 종료일정의 날짜 시간 인풋을 비활성화
				    if (this.checked) {
				      // 시작일정의 시간 인풋과 종료일정의 날짜 시간 인풋을 비활성화
				      $('#event-start-time, #event-end-date, #event-end-time').prop('disabled', true);
				      // 시작일정의 시간을 '00:00'으로 변경
				      $('#event-start-time').val('00:00');
				      // 종료일정의 날짜를 시작일정과 동일한 날짜로 변경
				      $('#event-end-date').val($('#event-start-date').val());
				      $('#event-end-time').val('23:59');
				    } else {
				      // 시작일정의 시간 인풋과 종료일정의 날짜 시간 인풋을 활성화
				      $('#event-start-time, #event-end-date, #event-end-time').prop('disabled', false);
				    }
				  });
				});
			$(document).ready(function(){

				  var group1;
				  var group2;
				  var myGroupname='';
				  // 일단 groupSelector를 먼저 정의한다.
				  var groupSelector = $("#add-group-selector");

				  // Leader
				  $.ajax({
				    url:'selectGroup1.do?id=' + '<%=id%>',
				    type:"get",
				    success:function(data) {
				      if(data!=null && data!="") {
				        var group = '';
				        $.each(data, function(i){
				        	if( data[i].group_code === '<%=myGroup%>') { 
				        	myGroupname = data[i].group_name ;
					          group += '<option value=' + data[i].group_code + '>' + data[i].group_name + '</option>';
				        	} });
				        $("#add-group-selector").append(group);
				        group1 = true;
				      } else if (data==null || data=="") {
				        group1 = false;
				      }
				    }, 
				    error:function(){
				      alert('error');
				    }
				  });

				  // Member
				  $.ajax({
				    url:'selectGroup2.do?id=' + '<%=id%>',
				    type:"get",
				    success:function(data) {
				      if(data!=null && data!="") {
				        var group = '';
				        $.each(data, function(i){
				        	if( data[i].group_code === '<%=myGroup%>') { 
					        	myGroupname = data[i].group_name ;
				          group += '<option value=' + data[i].group_code + '>' + data[i].group_name + '</option>';
				        	}   });
				        $("#add-group-selector").append(group);
				        group2 = true;
				      } else if (data==null || data=="") {
				        group2 = false;
				      }
				    },
				    error:function(){
				      alert('error');
				    }
				  });
				});
			
			
			// 이전 HTML 코드 저장
		        previousHTML = $('#event-list').html();
			
			// 일정 추가 폼으로 변경
			  $('#event-list').html(`
					  <div class="add-form">
			  
					  <form action="eventwriteAf.do" id="frm" method="post">
					  
						<div class="flex-item card border-light mb-3">
						<div class="card-header"
							style="height: 40px; font-size: 16px; display: flex; justify-content: center; align-items: center;">일정
							추가</div>
							<div class="card-body" style="height: 600px">
							 <div class="form-group">
						      <label for="event-title" style = "font-size: 14px;" >일정 제목</label>
						      <input type="text" class="form-control" id="event-title" placeholder="일정 제목을 입력하세요" style = "font-size: 14px;" autocomplete="off">
						    </div>
						    
						    <div class="form-group">
						    <label for="event-start-date" style = "font-size: 14px;">일정</label>
						    <div class="input-group date">
						    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
						        <input type="text" class="form-control datetimepicker-input" id="event-start-date" data-target="#event-start-date" placeholder="시작일" style = "font-size: 14px;" autocomplete="off">
						        <input type="text" class="form-control datetimepicker-input" id="event-start-time" data-target="#event-start-date" placeholder="시간" style = "font-size: 14px;" autocomplete="off">
						        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
						        <input type="text" class="form-control datetimepicker-input" id="event-end-date" data-target="#event-start-date" placeholder="종료일" style = "font-size: 14px;" autocomplete="off">
						        <input type="text" class="form-control datetimepicker-input" id="event-end-time" data-target="#event-start-date" placeholder="시간" style = "font-size: 14px;" autocomplete="off">
						        <div class="input-group-append" data-target="#event-start-date">
						        <div class="input-group-text">
						        <input type="checkbox" id="all-day" aria-label="all-day" style="margin-top: 1px;">
						        <label for="all-day" style="margin-bottom: 0; font-size: 14px; margin-left: 5px;">종일</label>
						      </div>
						            
						        </div>
						        
						        
						    </div>
						    
						    
						</div>
						<label for="event-start-date" style = "font-size: 14px;">현재 내 그룹</label>
						 <div class="input-group-append">
						 
						 <select class="form-control" id="add-group-selector"  style = "font-size: 14px; " disabled>
					    </select>
					    </div>
						    <div class="form-group">
						      <label for="event-description" style = "font-size: 14px;">일정 내용</label>
						      <textarea class="form-control" id="event-description" rows="3" style="height: 300px"></textarea>
						    </div>
						    
						    <button type="button" class="btn btn-warning" id="save-event-btn" style = "font-size: 14px;">저장</button>
						    <button type="button" class="btn btn-secondary" id="cancel-event-btn" style = "font-size: 14px;">취소</button>
						  </form>
						</div>

					</div>
					</div>

			  `);
								
								  
// datepicker 초기화
$(document).ready(function() {
	
	
  $('#event-start-date, #event-end-date').datepicker({
	  	format: 'yyyy-mm-dd',
	    autoclose: true,
	    todayHighlight: true,
	    changeMonth: true,
	    changeYear: true,
	    showMonthAfterYear: true,
	    showButtonPanel: true
  });

  $('#event-start-time, #event-end-time').timepicker({
	    timeFormat: 'HH:mm',
	    interval: 30,
	    minTime: '0',
	    maxTime: '23',
	    startTime:'9',
	    dynamic: false,
	    dropdown: true,
	    scrollbar: true
});
  
});

			//저장 버튼 클릭 이벤트 처리
			$(document).ready(function() {
			
			  $('#save-event-btn').on('click', function() {
			    var title = $('#event-title').val();
			
			    var startDate = $('#event-start-date').val() + 'T' + $('#event-start-time').val();
			    var endDate = $('#event-end-date').val() + 'T' + $('#event-end-time').val();
			    
			    if (!$('#event-start-date').val() || $('#event-start-date').val() === '') {
			    	  $('#messageConfirmModal .modal-body').html('시작일을 선택해주세요.');
			    	  $('#messageConfirmModal').modal('show');
			    	  return;
			    	}
			    if (!$('#event-start-time').val() || $('#event-start-time').val() === '') {
			    	  $('#messageConfirmModal .modal-body').html('시작일 시간을 선택해주세요.');
			    	  $('#messageConfirmModal').modal('show');
			    	  return;
			    	}
			    if (!$('#event-end-date').val() || $('#event-end-date').val() === '') {
			    	  $('#messageConfirmModal .modal-body').html('종료일을 선택해주세요.');
			    	  $('#messageConfirmModal').modal('show');
			    	  return;
			    	}
			    if (!$('#event-end-time').val() || $('#event-end-time').val() === '') {
			    	  $('#messageConfirmModal .modal-body').html('종료일 시간을 선택해주세요.');
			    	  $('#messageConfirmModal').modal('show');
			    	  return;
			    	}
			    if ($('#all-day').prop('checked')) {
				      // 시작일정의 시간을 '00:00'으로 변경
				      startDate = $('#event-start-date').val() + 'T00:00';
				      // 종료일정의 날짜를 시작일정과 동일한 날짜로 변경
				      endDate = $('#event-start-date').val() + 'T23:59';

				    }
			
			    var description = $('#event-description').val();
			    var groupCode = $('#add-group-selector').val();
			    var id = '<%=id%>'; 
			     
			    var eventData = {
			      "id": id,
				  "groupCode": groupCode,
				  "title": title,
				 "startDate": startDate,
				 "endDate": endDate,
				  "description": description
			    };
			    if (!title) {
		            $('#messageConfirmModal .modal-body').html('제목을 입력해주세요');
		            $('#messageConfirmModal').modal('show');
			        return;
			    }
			    // 종료 일정 유효성 검사
			    if (moment(endDate).isSameOrBefore(startDate)) {
		            $('#messageConfirmModal .modal-body').html('종료일은 시작일보다 이후여야 합니다.');
		            $('#messageConfirmModal').modal('show');
			        return;
			      }
				 // 체크박스가 선택된 경우

			
			    $.ajax({
			      url: 'eventwriteAf.do' ,
			      type: 'POST',
			      data: JSON.stringify(eventData),
			      contentType: 'application/json',
			      success: function(response) {
			        // 일정을 추가한 후 FullCalendar를 갱신합니다.
			        $('#calendar').fullCalendar('refetchEvents');
			        // 일정 리스트로 변경합니다.
			        location.reload();
			      },
			      error: function() {
			        alert('일정을 추가하는데 실패하였습니다.');
			      }
			    });
			  });
			});

			// 취소 버튼 클릭 이벤트 처리
				 $('#cancel-event-btn').on('click', function() {
			  // 이전 화면으로 돌아가기 전에 클릭 이벤트 핸들러를 제거합니다.
				 $('#add-event-btn').off('click');
				 // 일정 리스트로 변경
			     $('#event-list').html(previousHTML);
						  });

								});
			
				// 일정 상세 보기 
				$('.card-body').off('click').on('click', '.event-title', function() {
					
				  var eventId = $(this).data('eventid');
				  var scheduleId = $(this).data('eventid'); // 모달창에 전달할 scheduleId
				  
				  
				  var events = $('#calendar').fullCalendar('clientEvents');
				  var event = events.filter(function(event) {
				    return event.scheduleId === eventId;
			 		 })[0];
			
				  $('#eventModalLabel').text(event.title);
				  $('#eventDate').text(moment(event.start).format('YYYY-MM-DD HH:mm') + ' - ' + moment(event.end).format('YYYY-MM-DD HH:mm'));
				  $('.event-description').text(event.description);
				  $('#update-event-btn').data('scheduleId', scheduleId); 
				  $('#share-event-btn').data('scheduleId', scheduleId); 
				  $('#one-delete-event-btn').data('scheduleId', scheduleId);// 일정 수정, 삭제 버튼에 scheduleId 전달
				  $('#eventModal').modal('show');
			
				});
				
				// 일정 수정
				$('#update-event-btn').off('click').on('click', function() {

					// datepicker 초기화
					$(document).ready(function() {												
					  $('#edit-start-date, #edit-end-date').datepicker({
						  	format: 'yyyy-mm-dd',
						    autoclose: true,
						    todayHighlight: true,
						    changeMonth: true,
						    changeYear: true,
						    showMonthAfterYear: true,
						    showButtonPanel: true
					  });

					  $('#edit-start-time, #edit-end-time').timepicker({
						    timeFormat: 'HH:mm',
						    interval: 30,
						    minTime: '0',
						    maxTime: '23',
						    dynamic: false,
						    dropdown: true,
						    scrollbar: true
					});
					  
					});


						
					  var eventId = $(this).data('scheduleId');
					  var scheduleId = $(this).data('scheduleId'); // 모달창에 전달할 scheduleId
					  
					  var events = $('#calendar').fullCalendar('clientEvents');
					  var event = events.filter(function(event) {
					    return event.scheduleId === eventId;
					  })[0];
					  

					 
					$('#eventModal').modal('hide');
					$('#editEventModal').modal('show');
					
					$('#editEventModalLabel').html('<form action="eventupdate.do" id="frm" method="post"><input type="text" id="edit-title" data-eventid="' + event.scheduleId + '" value="[수정] ' + event.title + '"autocomplete="off">');

					$('#editEventDate').html('<div class="form-group">' +
						    '<label for="event-start-date" style="font-size: 14px;">일정</label>' +
						    '<div class="input-group date">' +
						    '<div class="input-group-text"><i class="fa fa-calendar"></i></div>' +
						    '<input type="text" class="form-control datetimepicker-input" id="edit-start-date" value="' + event.start.format('YYYY-MM-DD') + '" style="font-size: 14px;" autocomplete="off">' +
						    '<input type="text" class="form-control datetimepicker-input" id="edit-start-time" value="' + event.start.format('HH:mm') + '" style="font-size: 14px;" autocomplete="off">' +
						    
						    '<div class="input-group-text"><i class="fa fa-calendar"></i></div>' +
						    '<input type="text" class="form-control datetimepicker-input" id="edit-end-date" value="' + event.end.format('YYYY-MM-DD') + '" style="font-size: 14px;" autocomplete="off"> ' +
						    '<input type="text" class="form-control datetimepicker-input" id="edit-end-time" value="' + event.end.format('HH:mm') + '" style="font-size: 14px;" autocomplete="off">' +
						    '<div class="input-group-append" data-target="#edit-start-date">' +
						    '<div class="input-group-text">' +
						    '<input type="checkbox" id="all-day-update" name="all-day-update" aria-label="all-day-update" style="margin-top: 1px;">'+
						    '<label for="all-day-update" style="margin-bottom: 0; font-size: 14px; margin-left: 5px;">종일</label>'+

						    '</div>' +
						    '</div>' +
						    '</div>' +

						    '</form>');
					$('#all-day-update').on('change', function() {
					    // 체크박스가 체크되면 시작일정의 시간 인풋과 종료일정의 날짜 시간 인풋을 비활성화
					    if (this.checked) {
					        console.log('checked');
					        // 시작일정의 시간 인풋과 종료일정의 날짜 시간 인풋을 비활성화
					        $('#edit-start-time, #edit-end-date, #edit-end-time').prop('disabled', true);
					        // 시작일정의 시간을 '00:00'으로 변경
					        $('#edit-start-time').val('00:00');
					        // 종료일정의 날짜를 시작일정과 동일한 날짜로 변경
					        $('#edit-end-date').val($('#edit-start-date').val());
					        $('#edit-end-time').val('23:59');
					    } else {
					        // 시작일정의 시간 인풋과 종료일정의 날짜 시간 인풋을 활성화
					        $('#edit-start-time, #edit-end-date, #edit-end-time').prop('disabled', false);
					    }
					}); 
					$('.edit-event-description').html('<textarea id="edit-description" style="width:470px; height: 300px;">' + event.description + '</textarea>');
					$('#edit-save-event-btn').data('scheduleId', scheduleId); 

					
					//수정완료 버튼 클릭 이벤트 처리
					
					  $('#edit-save-event-btn').on('click', function() {
						$('#editEventModal').modal('hide');
						var eventId = $(this).data('scheduleId');
						
					    var title = $('#edit-title').val();
					    var startDate = $('#edit-start-date').val() + 'T' + $('#edit-start-time').val();
					    var endDate = $('#edit-end-date').val() + 'T' + $('#edit-end-time').val();
					    var description = $('#edit-description').val();
					    var groupCode = '<%=myGroup%>'; 

					    var eventData = {
					     "scheduleId" : eventId,
						  "groupCode": groupCode,
						  "title": title,
						 "startDate": startDate,
						 "endDate": endDate,
						  "description": description
					    };
					

					    
					    $.ajax({
					    	  url: 'eventupdate.do',
					    	  type: 'POST',
					    	  data: JSON.stringify(eventData),
					    	  contentType: 'application/json',
					    	  success: function(response) {
					    		  location.reload();
					    	  },
					    	  error: function() {
					    	    alert('일정을 수정하는데 실패하였습니다.');
					    	  }
					    	});
					  });
 });
				// 단일 일정 삭제 버튼 클릭 이벤트 처리
					$('#one-delete-event-btn').click(function() {
					  var eventId = $('#one-delete-event-btn').data('scheduleId');

					  // 확인창 띄우기
					  $('#customConfirmModal').modal('show');
					
					  $('#customConfirmBtn').click(function() {
					    // 일정 삭제 요청
					    $.ajax({
					      url: 'eventdelete.do',
					      type: 'POST',
					      data: { 'scheduleId': eventId },
					      success: function(response) {
					        // FullCalendar에서 일정 삭제
					        $('#calendar').fullCalendar('removeEvents', eventId);
					        // 일정 리스트 업데이트
					        location.reload();
					      },
					      error: function() {
					        alert('일정을 삭제하는데 실패하였습니다.');
					      }
					    });
					
					    $('#customConfirmModal').modal('hide');
					  });
					});

// cancel 동작
$('#customConfirmModal, #deleteConfirmModal, #messageConfirmModal, #today-event-modal').on('click', '[id$="Cancel"]', function() {
  $(this).closest('.modal').modal('hide');
});


// 알림 

$(document).ready(function() {
  var today = new Date(); // 현재 날짜 객체 생성
  var dd = today.getDate();
  var mm = today.getMonth() + 1;
  var yyyy = today.getFullYear();
  if (dd < 10) {
    dd = '0' + dd;
  }
  if (mm < 10) {
    mm = '0' + mm;
  }
  today = yyyy + '-' + mm + '-' + dd; // yyyy-mm-dd 형식으로 변환

  // 일정 목록을 불러와서 현재 날짜와 비교
  $.ajax({
	url: 'groupeventlist.do?id=' + '<%=id%>&groupCode=<%=myGroup%>',
    type: 'get',
    dataType: 'json',
    success: function(data) {
      if (data != null && data.length > 0) {
        var todayEventList = [];
        for (var i = 0; i < data.length; i++) {
          var eventStart = data[i].startDate.split(" ")[0];
          var eventEnd = data[i].endDate.split(" ")[0];
          if (eventStart <= today && today <= eventEnd) {
            todayEventList.push(data[i]);
          }
        }
        if (todayEventList.length > 0) {
          // 일정이 있을 경우 모달 띄우기
          var alreadyShown = sessionStorage.getItem('todayEventShown');
          if (alreadyShown !== 'true') {
            $('#today-event-modal').modal('show');
            // 일정 목록을 모달에 출력
            var todayEventHtml = '';
            for (var j = 0; j < todayEventList.length; j++) {
              todayEventHtml += todayEventList[j].title + '</br>';
            }
            $('#today-event-modal .modal-header').html('오늘 일정을 확인하세요.');
            $('#today-event-modal .modal-body').html(todayEventHtml);
            // 확인 버튼을 누르면 해당 일정을 더 이상 보지 않도록 설정
            $('#today-event-modal .modal-footer button').click(function() {
              sessionStorage.setItem('todayEventShown', 'true');
            });
          }
        }
      }
    },
  });
});

// 일정 공유
$('#share-event-btn').click(function() {
	  var scheduleId = $(this).data('scheduleId');
  
  // AJAX를 이용하여 서버에 일정 정보를 전송
  $.ajax({
    url: 'userId.do?group_code=' + '<%=myGroup%>',
    type: 'get',
    success: function(data) {
        for (var i = 0; i < data.length; i++) {
            
            var shareid = data[i];
            console.log(shareid);
            // 내가 로그인한 유저의 아이디와 같은 경우 일정 중복 추가되지 않게 건너뛰기
            if (data[i] === '<%= id %>') {
                continue;
            }
          
          	  $.get('eventdetail.do', { scheduleId: scheduleId }, function(event) {
          	    // 서버에서 반환된 일정 정보를 처리하는 로직 작성
          	     
          	      var title = event.title;
				  var start = event.startDate;
				  var end = event.endDate;
				  var description = event.description;
				  var groupCode = '<%=myGroup%>';

				  
				  
	          	  var eventData ={
	          	    id : shareid,
	          	    title : title,
	          	    startDate : start,
	          	    endDate : end,
	          	    description : description,
	          	    groupCode : groupCode
	          	    };
          	    console.log(eventData);
          	    
          	 $.ajax({
			      url: 'eventwriteAf.do' ,
			      type: 'POST',
			      data: JSON.stringify(eventData),
			      contentType: 'application/json',
			      success: function(response) {
			        // 일정을 추가한 후 FullCalendar를 갱신합니다.
			        $('#calendar').fullCalendar('refetchEvents');
			        // 일정 리스트로 변경합니다.
			        
			        $('#today-event-modal .modal-header').html('알림');
			        $('#today-event-modal .modal-body').html('일정을 공유하였습니다.');
			        $('#today-event-modal').modal('show');
			      },
			      error: function() {
			        alert('일정을 추가하는데 실패하였습니다.');
			      }
			    });
          	    

          	    // 캘린더에 일정 추가하는 로직 작성
          	  },"json");
          	
			   
            
        }
    },
    error: function(jqXHR, textStatus, errorThrown) {
        // 처리 중 오류가 발생했을 때 수행할 코드
    }
});
  
  $.ajax({
	    url: 'getGroupInfo.do?group_code=' + '<%=myGroup%>',
	    type: 'get',
	    success: function(data) {
	            
	            var shareid = data.leader;
	            console.log(shareid);
	            // 내가 로그인한 유저의 아이디와 같은 경우 일정 중복 추가되지 않게 건너뛰기
	            if (data !== '<%= id %>') {
	            
	          
	          	  $.get('eventdetail.do', { scheduleId: scheduleId }, function(event) {
	          	    // 서버에서 반환된 일정 정보를 처리하는 로직 작성
	          	     
	          	      var title = event.title;
					  var start = event.startDate;
					  var end = event.endDate;
					  var description = event.description;
					  var groupCode = '<%=myGroup%>';


		          	  var eventData ={
		          	    id : shareid,
		          	    title : title,
		          	    startDate : start,
		          	    endDate : end,
		          	    description : description,
		          	    groupCode : groupCode
		          	    };
	          	    console.log(eventData);
	          	    
	          	 $.ajax({
				      url: 'eventwriteAf.do' ,
				      type: 'POST',
				      data: JSON.stringify(eventData),
				      contentType: 'application/json',
				      success: function(response) {
				        // 일정을 추가한 후 FullCalendar를 갱신합니다.
				        $('#calendar').fullCalendar('refetchEvents');
				        // 일정 리스트로 변경합니다.
				        
				        $('#today-event-modal .modal-header').html('알림');
				        $('#today-event-modal .modal-body').html('일정을 공유하였습니다.');
				        $('#today-event-modal').modal('show');
				      },
				      error: function() {
				        alert('일정을 추가하는데 실패하였습니다.');
				      }
				    });
	          	    

	          	    // 캘린더에 일정 추가하는 로직 작성
	          	  },"json");
	          	
				   
	            
	        
	            }},
	    error: function(jqXHR, textStatus, errorThrown) {
	        // 처리 중 오류가 발생했을 때 수행할 코드
	    }
	});
  
});


		</script>



</body>
</html>
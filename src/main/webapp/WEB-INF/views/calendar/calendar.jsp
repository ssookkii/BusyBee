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

<%	
	EventDto dto = (EventDto)request.getAttribute("scheduleList");
%> 

<!-- jQuery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Moment.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script
	src='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.4.0/fullcalendar.min.js'></script>

<!-- jQuery UI CSS -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<!-- FullCalendar CSS -->
<link rel='stylesheet'
	href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.4.0/fullcalendar.min.css' />


<!-- Bootstrap Datepicker -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap-responsive.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>


<!-- timepicker -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/css/bootstrap-timepicker.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/js/bootstrap-timepicker.min.js"></script>


<!-- Bootstrap -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>

<link rel="stylesheet"
	href="https://bootswatch.com/5/minty/bootstrap.min.css">

</head>
<body>

	<script>
	$(document).ready(function() {
	    // 캘린더 영역 생성
	    $('#calendar').fullCalendar({
	        // 일정 데이터
	        events: function(start, end, timezone, callback) {
	            $.ajax({
	                url: 'eventlist.do', // 일정 목록을 가져올 요청 경로
	                dataType: 'json',
	                success: function(response) {
	                    console.log(response); // 일정 데이터 확인
	                    var events = [];
	                    // 서버에서 가져온 일정 목록을 이벤트 객체로 변환합니다.
	                    for (var i = 0; i < response.length; i++) {
	                        events.push({
	                            id: response[i].id,
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
	        	var events = $('#calendar').fullCalendar('clientEvents', function(event) {

	        	    var days = [];
	        	    var day = moment(event.start);
	        	    var endDay = moment(event.end);

	        	    while (day <= endDay) {
	        	        days.push(day.format('YYYY-MM-DD'));
	        	        day.add(1, 'days');
	        	    }

	        	    return days.indexOf(date.format('YYYY-MM-DD')) >= 0;
	        	});

	        	if (events.length === 0) {
	        	    // 해당 날짜에 일정이 없는 경우
	        	    $('.card-body').html('<p>해당 날짜에 일정이 없습니다.</p>');
	        	    $('.card-title').html(date.format('YYYY-MM-DD'));
	        	}
	        	
	        	// 해당 날짜에 일정이 있는 경우
	        	   else {
	        	       var html = '<table class="event-table"><thead><tr><th>일정 제목</th><th>일정 시간</th></tr></thead><tbody>';
	        	       $.each(events, function(index, event) {
	        	    	   html += '<td class="event-title" data-eventid="' + event.scheduleId + '">' + event.title + '</td><td>' + event.start.format('YYYY-MM-DD HH:mm') + ' - ' + event.end.format('YYYY-MM-DD HH:mm') + '</td></tr>';

	        	          
	        	       });
	        	       html += '</tbody></table>';
	        	       $('.card-body').html(html);
	        	       $('.card-title').html(clickedDate);
	        	   }

	        	 
	        	},
	        });
	      });

    
    
  </script>





	<div style="margin-left: auto; margin-right: auto;">
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



							</div>

						</div>

					</div>

				</td>
			</tr>
		</table>
	</div>

	
<!-- Modal -->
      <div class="modal" id="eventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="eventModalLabel"></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
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
              <td>  <p id="eventDate"></p></td>
            </tr>
            </tbody>
            
             <thead>
            <tr>
              <th>일정 상세 내용</th>
            </tr>
          </thead>
          <tbody>
          <tr >
				<td class="event-description" style="height: 150px; "> <p id="eventDescription" ></p></td>
             </tr>
             </tbody>
          </table>
      
       
      </div>
      <div class="modal-footer">
      <div>
      
        <button type="button" class="btn btn-warning" data-bs-dismiss="modal">일정 공유</button>
        <button type="button" class="btn btn-dark" data-bs-dismiss="modal">일정 삭제</button>
      </div> 
        
      </div>
    </div>
  </div>
</div>

	<script>
		
								// 일정 추가 버튼 클릭 시 일정 추가 화면으로 전환
								$('#add-event-btn').on('click', function() {
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
												<div class="card-body" style="height: 660px">
												 <div class="form-group">
											      <label for="event-title" style = "font-size: 14px;">일정 제목</label>
											      <input type="text" class="form-control" id="event-title" placeholder="일정 제목을 입력하세요" style = "font-size: 14px;">
											    </div>
											    
											    <div class="form-group">
											    <label for="event-start-date" style = "font-size: 14px;">시작 일정</label>
											    <div class="input-group date">
											        <input type="text" class="form-control datetimepicker-input" id="event-start-date" data-target="#event-start-date" placeholder="날짜를 선택하세요" style = "font-size: 14px;">
											        <input type="text" class="form-control datetimepicker-input" id="event-start-time" data-target="#event-start-date" placeholder="시간을 선택하세요" style = "font-size: 14px;">
											        <div class="input-group-append" data-target="#event-start-date">
											            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
											        </div>
											        
											        
											    </div>
											    
											    
											</div>
											
											<div class="form-group">
											    <label for="event-end-date" style = "font-size: 14px;">종료 일정</label>
											    <div class="input-group date" style = "font-size: 14px;">
											    <input type="text" class="form-control datetimepicker-input" id="event-end-date" data-target="#event-start-date" placeholder="날짜를 선택하세요" style = "font-size: 14px;">
										        <input type="text" class="form-control datetimepicker-input" id="event-end-time" data-target="#event-start-date" placeholder="시간을 선택하세요" style = "font-size: 14px;">
											        <div class="input-group-append" data-target="#event-end-date" >
											            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
											        </div>
											    </div>
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
	   	format: 'HH:mm',
	    step: 5,
	    showSeconds: false,
	    showMeridian: false,
	    showButtonPanel: true // 확인 버튼 대신 Close 버튼 표시
});
  
});

					//저장 버튼 클릭 이벤트 처리
					$(document).ready(function() {
					
					  $('#save-event-btn').on('click', function() {
					    var title = $('#event-title').val();
					
					    var startDate = $('#event-start-date').val() + 'T' + $('#event-start-time').val();
					    var endDate = $('#event-end-date').val() + 'T' + $('#event-end-time').val();
					
					    var description = $('#event-description').val();
					    var groupCode = "A"; // 임시 데이터
					    var id = "ssookkii"; // 임시 데이터
					     
					    var eventData = {
					      "id": id,
						  "groupCode": groupCode,
						  "title": title,
						 "startDate": startDate,
						 "endDate": endDate,
						  "description": description
					    };
					
					
					    $.ajax({
					      url: 'eventwriteAf.do' ,
					      type: 'POST',
					      data: JSON.stringify(eventData),
					      contentType: 'application/json',
					      success: function(response) {
					        // 일정을 추가한 후 FullCalendar를 갱신합니다.
					        $('#calendar').fullCalendar('refetchEvents');
					        // 일정 리스트로 변경합니다.
					        $('#event-list').html('일정 리스트');
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
				$('.card-body').on('click', '.event-title', function() {
					
				  var eventId = $(this).data('eventid');
				  console.log(eventId);
				  
				  var events = $('#calendar').fullCalendar('clientEvents');
				  var event = events.filter(function(event) {
				    return event.scheduleId === eventId;
			 		 })[0];
			
				  $('#eventModalLabel').text(event.title);
				  $('#eventDate').text(moment(event.start).format('YYYY-MM-DD HH:mm') + ' - ' + moment(event.end).format('YYYY-MM-DD HH:mm'));
				  $('.event-description').text(event.description);
				  $('#eventModal').modal('show');
			});


							
		</script>
</body>
</html>
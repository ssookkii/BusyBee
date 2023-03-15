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
EventDto dto = (EventDto) request.getAttribute("scheduleList");
%>

<!-- jQuery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Moment.js -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap-responsive.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>


<!-- timepicker -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>


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
	            selectedDate = clickedDate;
	            
	            var events = $('#calendar').fullCalendar('clientEvents', function(event) {
	                var days = [];
	                var day = moment(event.start);
	                var endDay = moment(event.end);
	                console.log('day: '+day);
	                console.log('endDay: '+endDay);
	                while (day <= endDay ) {
	                    days.push(day.format('YYYY-MM-DD'));
	                    day.add(1, 'days');
	                }
	                
	                console.log(days);
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

	        if (events.length === 0) {
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
      <div class="modal-body" style="height: 200px; display: flex; align-items: center; justify-content: center;">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-warning" data-dismiss="modal" id="messageCancel">취소</button>
      </div>
    </div>
  </div>
</div>
	<script>
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
						    <label for="event-start-date" style = "font-size: 14px;">일정</label>
						    <div class="input-group date">
						    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
						        <input type="text" class="form-control datetimepicker-input" id="event-start-date" data-target="#event-start-date" placeholder="시작일" style = "font-size: 14px;">
						        <input type="text" class="form-control datetimepicker-input" id="event-start-time" data-target="#event-start-date" placeholder="시간" style = "font-size: 14px;">
						        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
						        <input type="text" class="form-control datetimepicker-input" id="event-end-date" data-target="#event-start-date" placeholder="종료일" style = "font-size: 14px;">
						        <input type="text" class="form-control datetimepicker-input" id="event-end-time" data-target="#event-start-date" placeholder="시간" style = "font-size: 14px;">
						        <div class="input-group-append" data-target="#event-start-date">
						        
						            
						        </div>
						        
						        
						    </div>
						    
						    
						</div>

						 <div class="input-group-append">
					      <div class="input-group-text">
					        <input type="checkbox" id="all-day" aria-label="all-day" style="margin-top: 1px;">
					        <label for="all-day" style="margin-bottom: 0; font-size: 14px; margin-left: 5px;">종일</label>
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
	    timeFormat: 'HH:mm',
	    interval: 30,
	    minTime: '00:00',
	    maxTime: '23:00',
	    dynamic: false,
	    dropdown: true,
	    appendTo:'body',
	    scrollbar: true
});
  
});

			//저장 버튼 클릭 이벤트 처리
			$(document).ready(function() {
			
			  $('#save-event-btn').on('click', function() {
			    var title = $('#event-title').val();
			
			    var startDate = $('#event-start-date').val() + 'T' + $('#event-start-time').val();
			    var endDate = $('#event-end-date').val() + 'T' + $('#event-end-time').val();
			    
			    if ($('#all-day').prop('checked')) {
				      // 시작일정의 시간을 '00:00'으로 변경
				      startDate = $('#event-start-date').val() + 'T00:00';
				      // 종료일정의 날짜를 시작일정과 동일한 날짜로 변경
				      endDate = $('#event-start-date').val() + 'T23:59';

				    }
			
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
			    
			    // 종료 일정 유효성 검사
			    if (moment(endDate).isSameOrBefore(startDate)) {
			        alert('종료일은 시작일보다 이후여야 합니다.');
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
				  $('#one-delete-event-btn').data('scheduleId', scheduleId);// 일정 수정, 삭제 버튼에 scheduleId 전달
				  console.log(eventId, scheduleId);
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
						    minTime: '00:00',
						    maxTime: '23:00',
						    dynamic: false,
						    dropdown: true,
						    appendTo:'body',
						    scrollbar: true // 확인 버튼 대신 Close 버튼 표시
					});
					  
					});


					  var eventId = $(this).data('scheduleId');
					  var scheduleId = $(this).data('scheduleId'); // 모달창에 전달할 scheduleId
					  console.log(eventId, scheduleId);
					  
					  var events = $('#calendar').fullCalendar('clientEvents');
					  var event = events.filter(function(event) {
					    return event.scheduleId === eventId;
					  })[0];


					$('#eventModal').modal('hide');
					$('#editEventModal').modal('show');
					$('#editEventModalLabel').html('<form action="eventupdate.do" id="frm" method="post"><input type="text" id="edit-title" data-eventid="' + event.scheduleId + '" value="[수정] ' + event.title + '">');

					$('#editEventDate').html('<div class="form-group">' +
						    '<label for="event-start-date" style="font-size: 14px;">일정</label>' +
						    '<div class="input-group date">' +
						    '<div class="input-group-text"><i class="fa fa-calendar"></i></div>' +
						    '<input type="text" class="form-control datetimepicker-input" id="edit-start-date" value="' + event.start.format('YYYY-MM-DD') + '" style="font-size: 14px;">' +
						    '<input type="text" class="form-control datetimepicker-input" id="edit-end-date" value="' + event.end.format('YYYY-MM-DD') + '" style="font-size: 14px;"> ' +
						    '<div class="input-group-text"><i class="fa fa-calendar"></i></div>' +
						    '<input type="text" class="form-control datetimepicker-input" id="edit-end-time" value="' + event.end.format('HH:mm') + '" style="font-size: 14px;">' +
						    '<input type="text" class="form-control datetimepicker-input" id="edit-start-time" value="' + event.start.format('HH:mm') + '" style="font-size: 14px;">' +
						    '<div class="input-group-append" data-target="#edit-start-date">' +
						    
						    '</div>' +
						    '</div>' +
						    '</div>' +

						    '</form>');

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
					    var groupCode = "A"; // 임시 데이터

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
$('#cancel').click(function() {
	$('#customConfirmModal').modal('hide');
	});
$('#deletecancel').click(function() {
	$('#deleteConfirmModal').modal('hide');
	});
$('#messageCancel').click(function() {
	$('#messageConfirmModal').modal('hide');
	});

		</script>



</body>
</html>
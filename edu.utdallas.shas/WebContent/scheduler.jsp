<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<%@ page import="edu.utdallas.shas.Schedule" %>
<%@ page import="edu.utdallas.shas.ScheduleEvent" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SHAS Scheduler</title>
<link rel='stylesheet' href='js/fullcalendar/fullcalendar.css' />
<script src='js/fullcalendar/lib/jquery.min.js'></script>
<script src='js/fullcalendar/lib/moment.min.js'></script>
<script src='js/fullcalendar/lib/jquery-ui.custom.min.js'></script>
<script src='js/fullcalendar/fullcalendar.js'></script>
<% String calendarjson = (String) request.getSession().getAttribute("calendarjson"); %>
<script>
	var calData = <%= calendarjson %>;
	var calEventSources = [];
	$(document).ready(function() {
	
	
		/* initialize the external events
		-----------------------------------------------------------------*/
	
		$('#external-events .fc-event').each(function() {
		
			// create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
			// it doesn't need to have a start or end
			var eventObject = {
				title: $.trim($(this).text()) // use the element's text as the event title
			};
			
			// store the Event Object in the DOM element so we can get to it later
			$(this).data('eventObject', eventObject);
			
			// make the event draggable using jQuery UI
			$(this).draggable({
				zIndex: 999,
				revert: true,      // will cause the event to go back to its
				revertDuration: 0  //  original position after the drag
			});
			
		});
	
	
		/* initialize the calendar
		-----------------------------------------------------------------*/
		
		$('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek'
			},
			editable: true,
			allDaySlot: false,
			timezone: 'UTC',
			droppable: true, // this allows things to be dropped onto the calendar !!!
			drop: function(date) { // this function is called when something is dropped
			
				// retrieve the dropped element's stored Event Object
				var originalEventObject = $(this).data('eventObject');
				
				// we need to copy it, so that multiple events don't have a reference to the same object
				var copiedEventObject = $.extend({}, originalEventObject);
				
				// assign it the date that was reported
				copiedEventObject.start = date;
				copiedEventObject.end = moment(date).add(30, 'minutes');
				var eventSrc = null;
				if ($('#one-shot').is(':checked')) {
					copiedEventObject.type = 'one-shot';
					copiedEventObject.eventobj = $.extend({}, copiedEventObject);
					eventSrc = [copiedEventObject];
					calData.push(copiedEventObject.eventobj);
				}
				else if ($('#weekly').is(':checked')) {
					copiedEventObject.type = 'weekly';
					eventSrc = repeatES(copiedEventObject, 7, 'days');
					calData.push(copiedEventObject);
				}
				else if ($('#monthly').is(':checked')) {
					copiedEventObject.type = 'monthly';
					eventSrc = repeatES(copiedEventObject, 1, 'month');
					calData.push(copiedEventObject);
				}
				$('#calendar').fullCalendar('addEventSource', eventSrc);
				calEventSources.push(eventSrc);
				alert(JSON.stringify(calData));
			},
			eventDrop: function(event, delta, revertFunc) {
				updateRecurObj(event);
			},
			eventResize: function(event, delta, revertFunc) {
				updateRecurObj(event);
			}
		});
		
		for (var i = 0; i < calData.length; i++) {
			var ev = calData[i];
			var eventSrc = null;
			if (ev.type === 'one-shot') {
				evnew = $.extend({}, ev);
				evnew.eventobj = ev;
				eventSrc = [evnew];
			}
			else if (ev.type === 'weekly') {
				eventSrc = repeatES(ev, 7, 'days');
			}
			else if (ev.type === 'monthly') {
				eventSrc = repeatES(ev, 1, 'month');
			}
			$('#calendar').fullCalendar('addEventSource', eventSrc);
			calEventSources.push(eventSrc);
		}
	});

	function updateRecurObj(event) {
		event.eventobj.start = event.start;
		event.eventobj.end = event.end;
		event.eventobj.allDay = event.allDay;
	}
	function repeatES(eventobj, time, unit) {
		return function(start, end, timezone, callback) {
			var events = [];
		
			var loop = moment(eventobj.start);
			while (loop.isBefore(start)) {
				loop.add(time, unit);
			}
			events.push({
				title: eventobj.title,
				start: moment(loop),
				eventobj: eventobj,
				allDay: false
			})
		    while (!loop.isAfter(end)) {
		    	loop.add(time, unit);
		    	events.push({
			    	title: eventobj.title,
		    		start: moment(loop),
		    		eventobj: eventobj,
		    		allDay: false
		    	});
			} // for loop
		
			// return events generated
			callback( events );
		};
	}
	function setjson() {
		var eventsFromCalendar = $('#calendar').fullCalendar('clientEvents');
		$('input[name=calendarjson]').val(JSON.stringify(calData));
		alert(JSON.stringify(calData));
	}
	
	function clearcal() {
		for (var i = 0; i < calEventSources.length; i++) {
			$('#calendar').fullCalendar('removeEventSource', calEventSources[i]);
		}
		calData = [];
	}
</script>

<style>

	body {
		margin-top: 40px;
		text-align: center;
		font-size: 14px;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
	}
		
	#wrap {
		width: 1100px;
		margin: 0 auto;
	}
		
	#external-events {
		float: left;
		width: 175px;
		padding: 0 10px;
		border: 1px solid #ccc;
		background: #eee;
		text-align: left;
	}
		
	#external-events h4 {
		font-size: 16px;
		margin-top: 0;
		padding-top: 1em;
	}
		
	#external-events .fc-event {
		margin: 10px 0;
		cursor: pointer;
	}
		
	#external-events p {
		margin: 1.5em 0;
		font-size: 11px;
		color: #666;
	}
		
	#external-events p input {
		margin: 0;
		vertical-align: middle;
	}

	#calendar {
		float: right;
		width: 900px;
	}

</style>

</head>
<body>
<%@ include file="./header.jsp" %>

<h3>Set Schedule</h3>
	<div id='wrap'>

		<div id='external-events'>
			<h4>Appliances</h4>
			<div class='fc-event'>Security Alarm</div>
			<div class='fc-event'>Sprinkler</div>
			<div class='fc-event'>HVAC</div>
			<form>
				<p>
					<input type="radio" name="sched" id="one-shot" value="one-shot" checked="checked"><label for="one-shot">One-shot</label>
					<input type="radio" name="sched" id="weekly" value="weekly"><label for="weekly">Weekly</label>
					<input type="radio" name="sched" id="monthly" value="monthly"><label for="monthly">Monthly</label>
				</p>
			</form>
		</div>
<form action="./SchedulerServlet" method="post" onsubmit="return setjson();">
<input type="hidden" name="calendarjson" value="">
		<div id='calendar'></div>

		<div style='clear:both'></div>
<input type="submit" id="submit" value="Update Schedule">
<input type="button" id="clear" value="Clear Schedule" onclick="clearcal();">
</form>
	</div>

</body>
</html>
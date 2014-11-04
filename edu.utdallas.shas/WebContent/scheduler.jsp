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

<script>

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
				right: 'month,agendaWeek,agendaDay'
			},
			editable: true,
			droppable: true, // this allows things to be dropped onto the calendar !!!
			drop: function(date) { // this function is called when something is dropped
			
				// retrieve the dropped element's stored Event Object
				var originalEventObject = $(this).data('eventObject');
				
				// we need to copy it, so that multiple events don't have a reference to the same object
				var copiedEventObject = $.extend({}, originalEventObject);
				
				// assign it the date that was reported
				copiedEventObject.start = date;
				
				// render the event on the calendar
				// the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
				$('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
				
				// is the "remove after drop" checkbox checked?
				if ($('#drop-remove').is(':checked')) {
					// if so, remove the element from the "Draggable Events" list
					$(this).remove();
				}
				
			}
		});
		
		
	});

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
		width: 150px;
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

<%
Schedule sched = (Schedule)request.getSession().getAttribute("schedule");
ScheduleEvent alarmSE = sched.getSchedule("alarm");
ScheduleEvent sprinklerSE = sched.getSchedule("sprinkler");

ArrayList<Integer> alarmDays = new ArrayList<Integer>();
ArrayList<Integer> sprinklerDays = new ArrayList<Integer>();
String alarmStart = "";
String alarmEnd = "";
String sprinklerStart = "";
String sprinklerEnd = "";

SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");

if (alarmSE != null) {
	for (int i : alarmSE.getDaysOfWeek())
		alarmDays.add(i);
	
	alarmStart = sdf.format(alarmSE.getStartTime());
	alarmEnd = sdf.format(alarmSE.getEndTime());
}

if (sprinklerSE != null) {
	for (int i : sprinklerSE.getDaysOfWeek())
		sprinklerDays.add(i);
	
	sprinklerStart = sdf.format(sprinklerSE.getStartTime());
	sprinklerEnd = sdf.format(sprinklerSE.getEndTime());
}
%>
<h3>Set Schedule</h3>
	<div id='wrap'>

		<div id='external-events'>
			<h4>Draggable Events</h4>
			<div class='fc-event'>My Event 1</div>
			<div class='fc-event'>My Event 2</div>
			<div class='fc-event'>My Event 3</div>
			<div class='fc-event'>My Event 4</div>
			<div class='fc-event'>My Event 5</div>
			<p>
				<input type='checkbox' id='drop-remove' />
				<label for='drop-remove'>remove after drop</label>
			</p>
		</div>

		<div id='calendar'></div>

		<div style='clear:both'></div>

	</div>
<form action="./SchedulerServlet" method="post">
<fieldset style = "width: 450px">
<legend style="font-size: 18px; font-weight: bold; color: #3300ff; font-family: Georgia, serif;">
Security Alarm</legend>
<table>
	<tr>
		<td align="center">Monday</td>
		<td align="center">Tuesday</td>
		<td align="center">Wednesday</td>
		<td align="center">Thursday</td>
		<td align="center">Friday</td>
		<td align="center">Saturday</td>
		<td align="center">Sunday</td>
	</tr>
	<tr>
		<td align="center"><input type="checkbox" name="alarm" value="M" <% if (alarmDays.contains(Calendar.MONDAY)) { %> checked="checked" <% } %>></td>
		<td align="center"><input type="checkbox" name="alarm" value="T" <% if (alarmDays.contains(Calendar.TUESDAY)) { %> checked="checked" <% } %>></td>
		<td align="center"><input type="checkbox" name="alarm" value="W" <% if (alarmDays.contains(Calendar.WEDNESDAY)) { %> checked="checked" <% } %>></td>
		<td align="center"><input type="checkbox" name="alarm" value="TR" <% if (alarmDays.contains(Calendar.THURSDAY)) { %> checked="checked" <% } %>></td>
		<td align="center"><input type="checkbox" name="alarm" value="F" <% if (alarmDays.contains(Calendar.FRIDAY)) { %> checked="checked" <% } %>></td>
		<td align="center"><input type="checkbox" name="alarm" value="S" <% if (alarmDays.contains(Calendar.SATURDAY)) { %> checked="checked" <% } %>></td>
		<td align="center"><input type="checkbox" name="alarm" value="SU" <% if (alarmDays.contains(Calendar.SUNDAY)) { %> checked="checked" <% } %>></td>
	</tr>
</table>
<table>
	<tr>
		<td>Start: <input type="text" name="alarmstart" value="<%= alarmStart %>" placeholder="hh:mm:ss"></td>
		<td>End: <input type="text" name="alarmend" value="<%= alarmEnd %>" placeholder="hh:mm:ss"></td>
	</tr>
</table>
</fieldset>
<fieldset style = "width: 450px">
<legend style="font-size: 18px; font-weight: bold; color: #3300ff; font-family: Georgia, serif;">
Sprinkler</legend>
<table>
	<tr>
		<td align="center">Monday</td>
		<td align="center">Tuesday</td>
		<td align="center">Wednesday</td>
		<td align="center">Thursday</td>
		<td align="center">Friday</td>
		<td align="center">Saturday</td>
		<td align="center">Sunday</td>
	</tr>
	<tr>
		<td align="center"><input type="checkbox" name="sprinkler" value="M" <% if (sprinklerDays.contains(Calendar.MONDAY)) { %> checked="checked" <% } %>></td>
		<td align="center"><input type="checkbox" name="sprinkler" value="T" <% if (sprinklerDays.contains(Calendar.TUESDAY)) { %> checked="checked" <% } %>></td>
		<td align="center"><input type="checkbox" name="sprinkler" value="W" <% if (sprinklerDays.contains(Calendar.WEDNESDAY)) { %> checked="checked" <% } %>></td>
		<td align="center"><input type="checkbox" name="sprinkler" value="TR" <% if (sprinklerDays.contains(Calendar.THURSDAY)) { %> checked="checked" <% } %>></td>
		<td align="center"><input type="checkbox" name="sprinkler" value="F" <% if (sprinklerDays.contains(Calendar.FRIDAY)) { %> checked="checked" <% } %>></td>
		<td align="center"><input type="checkbox" name="sprinkler" value="S" <% if (sprinklerDays.contains(Calendar.SATURDAY)) { %> checked="checked" <% } %>></td>
		<td align="center"><input type="checkbox" name="sprinkler" value="SU" <% if (sprinklerDays.contains(Calendar.SUNDAY)) { %> checked="checked" <% } %>></td>
	</tr>
</table>
<table>
	<tr>
		<td>Start: <input type="text" name="sprinklerstart" value="<%= sprinklerStart %>" placeholder="hh:mm:ss"></td>
		<td>End: <input type="text" name="sprinklerend" value="<%= sprinklerEnd %>" placeholder="hh:mm:ss"></td>
	</tr>
</table>
</fieldset>
<input type="submit" id="submit" value="Submit">
</form>
</body>
</html>
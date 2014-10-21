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
<form action="./SchedulerServlet" method="post">
<fieldset style = "width: 300px">
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
		<td>Start: <input type="text" name="alarmstart" value="<%= alarmStart %>"></td>
		<td>End: <input type="text" name="alarmend" value="<%= alarmEnd %>"></td>
	</tr>
</table>
</fieldset>
<fieldset style = "width: 300px">
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
		<td>Start: <input type="text" name="sprinklerstart" value="<%= sprinklerStart %>"></td>
		<td>End: <input type="text" name="sprinklerend" value="<%= sprinklerEnd %>"></td>
	</tr>
</table>
</fieldset>
<input type="submit" id="submit" value="Submit">
</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SHAS Scheduler</title>
</head>
<body>
<%@ include file="./header.jsp" %>

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
		<td align="center"><input type="checkbox" name="alarm" value="M"></td>
		<td align="center"><input type="checkbox" name="alarm" value="T"></td>
		<td align="center"><input type="checkbox" name="alarm" value="W"></td>
		<td align="center"><input type="checkbox" name="alarm" value="TR"></td>
		<td align="center"><input type="checkbox" name="alarm" value="F"></td>
		<td align="center"><input type="checkbox" name="alarm" value="S"></td>
		<td align="center"><input type="checkbox" name="alarm" value="SU"></td>
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
		<td align="center"><input type="checkbox" name="sprinkler" value="M"></td>
		<td align="center"><input type="checkbox" name="sprinkler" value="T"></td>
		<td align="center"><input type="checkbox" name="sprinkler" value="W"></td>
		<td align="center"><input type="checkbox" name="sprinkler" value="TR"></td>
		<td align="center"><input type="checkbox" name="sprinkler" value="F"></td>
		<td align="center"><input type="checkbox" name="sprinkler" value="S"></td>
		<td align="center"><input type="checkbox" name="sprinkler" value="SU"></td>
	</tr>
</table>
</fieldset>
<input type="submit" id="submit" value="Submit">
</form>
</body>
</html>
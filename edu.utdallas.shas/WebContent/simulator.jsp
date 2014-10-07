<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="./js/jquery-1.11.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SHAS Simulator</title>
</head>
<body>
<%@ include file="./header.jsp" %>
<h3>Adjust all the appliances values here!</h3>

<table>
	<tr>
		<th>Security Breached : </th>
		<th><select name="securityAlarm" id="securityAlarm" >
     			<option id="securityNo" value="No"> No </option>
     			<option id="securityYes" value="Yes"> Yes </option>
     		</select>
     	</th>
	</tr>
	<tr><%@ include file="./sprinkler.jsp" %></tr>
</table>

</body>
<script type="text/javascript">
$(document).ready(function() {
	
		//alert("security breached...");
	$('#securityAlarm').change(function() {
		  var securityAlarmValue = $(this).find(":selected").text();
		  //alert(securityAlarmValue);
		  if($.trim(securityAlarmValue) === "Yes")
			  <%request.setAttribute("securityBreached","yes");%>
			  alert('Security Breached! The system will call the police after 90 seconds.');
			  setTimeout("alert('90 seconds has passed, calling police now!')" , 90000);
			  //window.location = "./SHASHome.jsp";
		});
});
	
</script>
</html>

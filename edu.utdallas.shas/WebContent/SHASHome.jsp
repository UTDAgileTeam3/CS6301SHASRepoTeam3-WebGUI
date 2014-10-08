<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SHAS Home</title>

<%

String uname = (String) request.getSession().getAttribute("uname");
boolean securityBreached = (Boolean) request.getSession().getAttribute("securityBreached");
long securityAlarmMillis = 0;
if (securityBreached) {
	Calendar cal = Calendar.getInstance();
	cal.setTime((java.util.Date)request.getSession().getAttribute("securityBreachStart"));
	cal.add(Calendar.SECOND, 90);
	securityAlarmMillis = cal.getTime().getTime();
}
String sprinkler1 = (String) request.getSession().getAttribute("sprinklerzone1select");
String sprinkler2 = (String) request.getSession().getAttribute("sprinklerzone2select");
String sprinkler3 = (String) request.getSession().getAttribute("sprinklerzone3select");
String sprinkler4 = (String) request.getSession().getAttribute("sprinklerzone4select");
/* if (request.getSession().getAttribute("uname") == null) {
	 
    response.sendRedirect("login.jsp");
} */

 %>

<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/jquery.countdown.css"> 
<script type="text/javascript" src="js/jquery.plugin.js"></script> 
<script type="text/javascript" src="js/jquery.countdown.js"></script>

<style type="text/css">
       .greenzone  { background-color: green;}
       .grayzone   { background-color: gray;} 
    </style>
    <script type="text/javascript">
    $(document).ready(function(){
   
    	<%if(sprinkler1!=null && (sprinkler1).equalsIgnoreCase("on")){%>
       		    $("#sprinklerzone1").addClass("greenzone");
    		    $("#sprinklerzone1").removeClass("grayzone");
        <%}%>
        <%if(sprinkler1!=null &&(sprinkler1).equalsIgnoreCase("off")){%>
   
    			$("#sprinklerzone1").addClass("grayzone");
    			$("#sprinklerzone1").removeClass("greenzone");
    	<%}%>
     	<%if(sprinkler2!=null && (sprinkler2).equalsIgnoreCase("on")){%>
		    	$("#sprinklerzone2").addClass("greenzone");
	    		$("#sprinklerzone2").removeClass("grayzone");
		<%}%>
		<%if(sprinkler2!=null && (sprinkler2).equalsIgnoreCase("off")){%>
				$("#sprinklerzone2").addClass("grayzone");
				$("#sprinklerzone2").removeClass("greenzone");
		<%}%>
		<%if(sprinkler3!=null && (sprinkler3).equalsIgnoreCase("on")){%>
	    		$("#sprinklerzone3").addClass("greenzone");
    			$("#sprinklerzone3").removeClass("grayzone");
		<%}%>
		<%if(sprinkler3!=null && (sprinkler3).equalsIgnoreCase("off")){%>
				$("#sprinklerzone3").addClass("grayzone");
				$("#sprinklerzone3").removeClass("greenzone");
		<%}%>
		<%if(sprinkler4!=null && (sprinkler4).equalsIgnoreCase("on")){%>
    			$("#sprinklerzone4").addClass("greenzone");
				$("#sprinklerzone4").removeClass("grayzone");
		<%}%>
		<%if(sprinkler4!=null && (sprinkler4).equalsIgnoreCase("off")){%>
				$("#sprinklerzone4").addClass("grayzone");
				$("#sprinklerzone4").removeClass("greenzone");
		<%}%>

    });
    </script>
    </head>
<body>
<%@ include file="./header.jsp" %>
<h3 style="color: #3300ff">Welcome ${uname} to SHAS!</h3>

<%
/*Properties properties = new Properties();
properties.load(getServletContext().getResourceAsStream("/WEB-INF/database.properties"));
System.out.println(properties);
String url = properties.getProperty("jdbc.url");
String driver = properties.getProperty("jdbc.driver");
String username = properties.getProperty("jdbc.username");
String password = properties.getProperty("jdbc.password");

Class.forName(driver);
Connection conn = DriverManager.getConnection(url, username, password);
*/
%>

<form>
	<fieldset style = "width: 300px">
        <legend style="font-size: 18px; font-weight: bold; color: #3300ff; font-family: Georgia, serif;">
 		Security Status</legend>
 	<% if (!securityBreached) { %>
 	The security alarm has not detected a breach.
 	<% } else { %>
 	<span id="securityCountdownHidden" style="display: none;"></span>
 	<span id="securityCountdown" style="color: red;"></span>
 	<script type="text/javascript">
 	function updateCountdown(periods) {
 		var msg = 'The security alarm has detected a breach.';
 		if (periods[6] === 0) {
 			msg += ' The police and homeowner have been notified!';
 		}
 		else {
			msg += ' The homeowner has been notified. If the alarm is not cancelled, the police will be notified in ' + periods[6] + ' seconds.';
 		}
 		$('#securityCountdown').text(msg);
 	}
 	$(document).ready(function(){
 		$('#securityCountdownHidden').countdown({until: new Date(<%= securityAlarmMillis %>), format: 'S', 
 	    	onTick: updateCountdown, tickInterval: 1, alwaysExpire: true})
 	});
 	</script>
 	<% } %>
	</fieldset>
	<fieldset style = "width: 300px">
        <legend style="font-size: 18px; font-weight: bold; color: #3300ff; font-family: Georgia, serif;">
 		Sprinkler Status </legend>                            
	<table align="center" border="2px" style="width:200px;height: 200px">
		<tr>
		<TH id="sprinklerzone1" class="grayzone">Sprinkler Zone1</TH>
		<TH id="sprinklerzone2" class="grayzone">Sprinkler Zone2</TH>
		<TR/>

		<TR>
		<TH id="sprinklerzone3" class="grayzone">Sprinkler Zone3</TH>
		<TH id="sprinklerzone4" class="grayzone">Sprinkler Zone4</TH>
		
	</table>
	</fieldset>
</form>
</body>
 
</html>
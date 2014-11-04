<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
        body { font-family:Arial, Helvetica, Sans-Serif; font-size:0.8em;}
        #sprinkler { border:3px; border-color:black;height:100px; width:500px;}
        #sprinkler h4 { margin:0px; padding:0px;}
        #sprinkler img { float:right;}
        #sprinkler ul { margin:10px 0 10px 40px; padding:0px;}
        #sprinkler th { background:#7CB8E2 url(./images/header_bkg.png) repeat-x scroll center left; color:#fff; padding:7px 15px; text-align:left;}
        #sprinkler td { background:#C7DDEE none repeat-x scroll center left; color:#000; padding:7px 15px; }
        #sprinkler tr.odd td { background:#fff url(./images/row_bkg.png) repeat-x scroll center left; cursor:pointer; }
        #sprinkler div.arrow { background:transparent url(./images/arrows.png) no-repeat scroll 0px -16px; width:16px; height:16px; display:block;}
        #sprinkler div.up { background-position:0px 0px;}
</style>
<script type="text/javascript" src="./js/jquery-1.11.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SHAS Simulator</title>

<%
boolean securityBreached = (Boolean) request.getSession().getAttribute("securityBreached");
boolean securityEnabled = (Boolean) request.getSession().getAttribute("securityEnabled");
String hvac = (String) request.getSession().getAttribute("hvac");
String hvacTemperature = (String) request.getSession().getAttribute("hvacTemperature"); 
boolean smokeDetected = (Boolean) request.getSession().getAttribute("smokeDetectedB");
boolean coDetected = (Boolean) request.getSession().getAttribute("coDetectedB");
boolean naturalGasDetected = (Boolean) request.getSession().getAttribute("naturalGasDetectedB");
%>
<script type="text/javascript">
$(document).ready(function(){
	var temperature = <%=hvacTemperature%>;

$("#hvacTemperature").val(temperature);
});
function hvacOffClicked()
{
		$("#hvacTemperature").prop("disabled",!this.checked);
}
function acOrHeaterOnClicked()
{
		$("#hvacTemperature").prop("disabled", false);
}

</script>
</head>
<body>
<%@ include file="./header.jsp" %>
<h3>Adjust all the appliances values here!</h3>

<form action="./SHASControllerServlet" method="post" onsubmit="return checkSecurity()">
<table>
	<tr>
		<td>
			<fieldset style = "width: 500px; height: 120px">
			<legend style="font-size: 18px; font-weight: bold; color: #3300ff; font-family: Georgia, serif;">
			Security Alarm</legend>
			<table cellspacing="20px">
				<TR>
					<TD >
					<h4>Enabled: <select name="securityAlarmEnabled" id="securityAlarmEnabled" onchange="updateEnabled()">
					     <option id="securityEnabledNo" value="No"> No </option>
					     <option id="securityEnabledYes" value="Yes" <%if (securityEnabled) {%> selected="selected" <%}%>> Yes </option>
					</select></h4>
					</TD>
					<TD >
					<h4>Security Breached:
					<%-- <select name="securityAlarm" id="securityAlarm" <% if (!securityEnabled) { %> disabled="disabled" <% } %>>
					     <option id="securityNo" value="No"> No </option>
					     <option id="securityYes" value="Yes" <%if (securityBreached) {%> selected="selected" <%}%>> Yes </option>
					</select></h4> --%>
					</TD>
				</TR>
			</table>
			</fieldset>
		</td>
		<td>
			<fieldset style = "width: 400px; height: 120px">
			<legend style="font-size: 18px; font-weight: bold; color: #3300ff; font-family: Georgia, serif;">
			HVAC</legend>
			<table cellspacing="20px">
				<TR>
					<TD>
						<INPUT TYPE="radio" NAME="hvac" id="hvacOff" VALUE="hvacOff" onclick="hvacOffClicked();" <%if(hvac!=null && hvac.equalsIgnoreCase("hvacOff")){ %> CHECKED<%} %>><B>OFF</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            			<INPUT TYPE="radio" NAME="hvac" id="acOn" VALUE="acOn" onclick="acOrHeaterOnClicked();" <%if(hvac!=null && hvac.equalsIgnoreCase("acOn")){ %> CHECKED<%} %>><B>AC ON</B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            			<INPUT TYPE="radio" NAME="hvac" id="heaterOn" VALUE="heaterOn" onclick="acOrHeaterOnClicked();" <%if(hvac!=null && hvac.equalsIgnoreCase("heaterOn")){ %> CHECKED<%} %>><B>Heater ON</B>
					</TD>
				</TR>
				<TR>
					<TD>
						<B> Enter Temperature(in fahrenheit): <input type="text" name="hvacTemperature" id="hvacTemperature" maxlength="2" style="width:30px"  <%if(hvac!=null && hvac.equalsIgnoreCase("hvacOff")){ %> disabled<%} %>/></B>
					</TD>
				</TR>
			</table>
			</fieldset>
		</td>
	</tr>
	<tr>
	<td>
	<fieldset style = "width: 500px">
	<legend style="font-size: 18px; font-weight: bold; color: #3300ff; font-family: Georgia, serif;">
	Sprinklers</legend>
	<%@ include file="./sprinkler.jsp" %>
	</fieldset>
	</td>
	<td>
		<fieldset style = "width: 400px; height: 225px">
			<legend style="font-size: 18px; font-weight: bold; color: #3300ff; font-family: Georgia, serif;">
			Safety Alarms</legend>
			<table cellspacing="5px">
				<TR>
					<TD >
					<h4>Smoke Detected:</h4></TD><TD><h4> <select name="smokeDetected" id="smokeDetected" onchange="">
					     <option id="smokeDetectedNo" value="No"> No </option>
					     <option id="smokeDetectedYes" value="Yes" <%if (smokeDetected) {%> selected="selected" <%}%>> Yes </option>
					</select></h4>
					</TD>
				</TR>
				<TR>
					<TD >
					<h4>Carbon Monoxide Detected:</h4></TD><TD>
					<h4><select name="coDetected" id="coDetected">
					     <option id="coDetectedNo" value="No"> No </option>
					     <option id="coDetectedYes" value="Yes" <%if (coDetected) {%> selected="selected" <%}%>> Yes </option>
					</select></h4>
					</TD>
				</TR>
				<TR>
					<TD >
					<h4>Natural Gas Detected:</h4></TD><TD>
					<h4>
					<select name="naturalGasDetected" id="naturalGasDetected">
					     <option id="naturalGasDetectedNo" value="No"> No </option>
					     <option id="naturalGasDetectedYes" value="Yes" <%if (naturalGasDetected) {%> selected="selected" <%}%>> Yes </option>
					</select></h4>
					</TD>
				</TR>
			</table>
			</fieldset>
	</td>
	</tr>
</table>
<input type="submit" id="submitsprinkler" value="Submit">

</form>

<script type="text/javascript">
function checkSecurity() {
	<% if (!securityBreached) { %>
	if ($.trim($('#securityAlarm').find(":selected").text()) === "Yes") {
		return confirm('You are about to activate the security alarm. If it is not cancelled within 90 seconds, the system will notify the police. Are you sure you wish to continue?');
	}
	else {
		return true;
	}
	<% } else { %>
	return true;
	<% } %>
}

function updateEnabled() {
	document.getElementById("securityAlarm").disabled = (document.getElementById("securityAlarmEnabled").value === "No");
}
</script>

</body>
</html>
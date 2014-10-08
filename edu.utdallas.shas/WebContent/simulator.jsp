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
        #sprinkler th { background:#7CB8E2 url(header_bkg.png) repeat-x scroll center left; color:#fff; padding:7px 15px; text-align:left;}
        #sprinkler td { background:#C7DDEE none repeat-x scroll center left; color:#000; padding:7px 15px; }
        #sprinkler tr.odd td { background:#fff url(./images/row_bkg.png) repeat-x scroll center left; cursor:pointer; }
        #sprinkler div.arrow { background:transparent url(./images/arrows.png) no-repeat scroll 0px -16px; width:16px; height:16px; display:block;}
        #sprinkler div.up { background-position:0px 0px;}
</style>    
<script type="text/javascript" src="./js/jquery-1.11.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SHAS Simulator</title>
</head>
<body>
<%@ include file="./header.jsp" %>
<h3>Adjust all the appliances values here!</h3>

<form action="./SHASControllerServlet" method="post">
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
<input type="submit" id="submitsprinkler" value="Submit">
</form>

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
</body>
</html>
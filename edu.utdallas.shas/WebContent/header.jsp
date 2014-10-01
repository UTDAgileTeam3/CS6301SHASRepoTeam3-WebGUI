<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<table align="right">
	<tr>

		<td> <a href="simulator.jsp"><img border="0px" title="set values here" alt="settings" src="./images/settings.gif" width="40px" height="30px"/></a></td>
		<td><a href="#" onclick="logout();"><img border="0px" title="Logout" alt="Logout" src="./images/logout.jpg" width="40px" height="30px"/></a></td>
	</tr>
</table>
<script type="text/javascript">
function logout()
{
	alert("hi..");
	<%request.getSession().removeAttribute("uname");%>
	<%request.setAttribute("errorMessage","You have logged out successfully!");%>
	window.location("./login.jsp");
}
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.lang.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SHAS Home</title>
<script type="text/javascript" src="./js/jquery-1.11.1.min.js"></script>
<%@ include file="./header.jsp" %>
</head>
<body>
<%
 String uname = (String) request.getAttribute("uname");
String sessionUname = (String)request.getSession().getAttribute("uname");
/* if (request.getSession().getAttribute("uname") == null) {
	 
    response.sendRedirect("login.jsp");
} */

 %>

<h3>Welcome <% if (uname != null) {%>  <%=uname%><%} %> to SHAS!</h3>
<script type="text/javascript">alert(sessionUname);</script>
</body>
</html>
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
<script type="text/javascript" src="./js/jquery-1.11.1.min.js"></script>
</head>
<body>
<%@ include file="./header.jsp" %>
<h3>Welcome ${uname} to SHAS!</h3>

<%
Properties properties = new Properties();
properties.load(getServletContext().getResourceAsStream("/WEB-INF/database.properties"));
System.out.println(properties);
String url = properties.getProperty("jdbc.url");
String driver = properties.getProperty("jdbc.driver");
String username = properties.getProperty("jdbc.username");
String password = properties.getProperty("jdbc.password");

Class.forName(driver);
Connection conn = DriverManager.getConnection(url, username, password);

%>

<%
 String uname = (String) request.getAttribute("uname");
String scurityBreached = (String) request.getAttribute("securityBreached");

String sessionUname = (String)request.getSession().getAttribute("uname");
/* if (request.getSession().getAttribute("uname") == null) {
	 
    response.sendRedirect("login.jsp");
} */

 %>
<h3>${url} ${driver} ${username} ${password}</h3>
<script type="text/javascript">alert("hi..");alert("security:"+<%=scurityBreached%>);</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%@ page import="java.sql.*" %>
<% 
Properties properties = new Properties();
properties.load(getServletContext().getResourceAsStream("/WEB-INF/database.properties"));
System.out.println(properties);
String url = properties.getProperty("jdbc.url");
String driver = properties.getProperty("jdbc.driver");
String username = properties.getProperty("jdbc.username");
String password = properties.getProperty("jdbc.password");

Class.forName(driver); 
Connection myConn=DriverManager.getConnection(url, username, password);
Statement statement = myConn.createStatement() ;
            ResultSet resultset = statement.executeQuery("select * from shasuser") ;%>
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create New User for SHAS</title>
<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
function validateForm()
{
	var password = $.trim($('#new_password').val());
	var confirmPassword = $.trim($('#confirm_new_password').val());
	var name = $.trim($('#new_name').val());
	var uname = $.trim($('#new_uname').val());
	var phonenumber = $.trim($('#new_phonenumber').val());
	var email = $.trim($('#new_email').val());
	if( password === confirmPassword)
	{
		if(!isBlank(password) && !isBlank(confirmPassword) && !isBlank(name) && !isBlank(uname) && !isBlank(phonenumber) && !isBlank(email))
			return true;
		else
		{
			alert("All the fields should have proper values!");
			return false;
		}
	}
	else
	{
		alert("Password confirmation does not match with the entered password!!");
		return false;
	}
}

function isBlank(string)
{
	if(string === '')
		return true;
	return false;
}
</script>
</head>
<body>
<%@ include file="./header.jsp" %>
<%-- <TABLE BORDER="1">
            <TR>
                
                <TH>Name</TH>
                <TH>Phone number</TH>
            </TR>
            <% while(resultset.next()){ %>
            <TR>
                <TD> <%= resultset.getString(3) %></td>
                <TD> <%= resultset.getString(4) %></TD>
               </TR>
            <% } %>
        </TABLE> --%>
<center>
<form action="./NewUserServlet" method ="post" onsubmit="return validateForm();">
	<fieldset style = "width: 700px">
        <legend style="font-size: 18px; font-weight: bold; color: #3300ff; font-family: Georgia, serif;">
 		Create New User </legend>   
<table>
	<tr>
		<th align="left">Enter your name:</th>
		<th align="left"><input align="left" type="text" name="new_name" id="new_name" style = "width:300px"/></th>
	</tr>
	<tr>
		<th align="left">Enter Username:</th>
		<th align="left"><input align="left" type="text" name="new_uname" id="new_uname" style = "width:150px"/></th>
	</tr>
	<tr>
		<th align="left">Enter Password: </th>
		<th align="left"><input align="left" type="password" name="new_password" id="new_password" style = "width:150px"/></th>
	</tr>
	<tr>
		<th align="left">Confirm the password: </th>
		<th align="left"><input align="left" type="password" name="confirm_new_password" id="confirm_new_password" style = "width:150px"/></th>
	</tr>
	<tr>
		<th align="left">Enter phone number: </th>
		<th align="left"><input align="left" type="text" name="new_phonenumber" id="new_phonenumber" style = "width:150px"/></th>
	</tr>
	<tr>
		<th align="left">Enter email id: </th>
		<th align="left"><input align="left" type="text" name="new_email" id="new_email" style = "width:300px"/></th>
	</tr>
	<tr>
		<th></th>
		<th></th>
	</tr>
	<TR>
		<TH align="center"><input type="submit" value="Create User"/></TH>
		<TH align="center"><input type="reset" value="Reset"/></TH>
	</TR>
</table>
</fieldset>
</form>
</center>
</body>
</html>
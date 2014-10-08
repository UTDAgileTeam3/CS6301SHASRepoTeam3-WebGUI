<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SHAS Login</title>

</head>
<body>
	<div style="width:100%; height:150px; background-image:url('./images/topdiv2.png');text-align: center;text-decoration: underline; color: #ffffff; font-size: 40px">Smart Home Automation System</div><BR/><BR/><BR/>
	<center>
	<form action="./HomePageServlet" method ="post" >
	<fieldset style = "width: 400px">
        <legend style="font-size: 18px; font-weight: bold; color: #3300ff; font-family: Georgia, serif;">
 		Welcome </legend>                            
	<table align="left">
		<tr>
		<TH>Enter User Name: </TH>
		<TH><input type="text" name="uname" id="uname"/></TH>
		<TR/>

		<TR>
		<TH>Enter Password: </TH>
		<TH><input type="password" name="password" id="password"/></TH>
		<TR/>

		<TR>
		<TH align="center"><input type="submit" value="Login"/></TH>
		<TH align="center"><input type="reset" value="Reset"/></TH>
		</TR>
		<tr ><td style="color: red; font-style: italic;" colspan="2">
		
			<%if(null!=request.getAttribute("errorMessage"))
    		{
				out.println(request.getAttribute("errorMessage"));
			}%>
			</td>
		</tr>
	</table>
	</fieldset>
	</form>
    </center>
</body>
</html>
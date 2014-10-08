<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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

    <script src="./jquery-1.11.1.min.js" type="text/javascript"></script>
  
    <script type="text/javascript">  
        $(document).ready(function(){
            $("#sprinkler tr:odd").addClass("odd");
            $("#sprinkler tr:not(.odd)").hide();
            $("#sprinkler tr:first-child").show();
            
            $("#arrow").click(function(){

                ($(this)).closest("tr").next("tr").toggle();
                ($(this)).closest("tr").find(".arrow").toggleClass("up");
            });
            
        });
        
    </script> 
       
</head>
<body>
<center>
<form action="./SHASControllerServlet" method ="post" >
 
<table id="sprinkler" >
        <tr>
            <th><h3>Sprinkler Zone</h3></th>
            <th><h3>Status</h3></th>
            <th></th>
        </tr>
        <tr>
            <td class="tog"><h4>Sprinkler Zone1</h4></td>
            <td><select name="sprinklerzone1select" id="sprinklerzone1select" >
     			<option id="sprinklerzone1off" value="off"> OFF </option>
     			<option id="sprinklerzone1on" value="on"> ON </option>
     			
     		</select>
     		</td>
            <td class="tog"><div id="arrow" class="arrow"></div></td>
        </tr>
        <tr>
            <td colspan="5">
               
                <h4>Additional information</h4>
                <ul>
                    <li>This is zone 1 covering top left zone of garden</li>
                    <li><a href="#">Set the Schedule</a></li>
                    
                 </ul>   
            </td>
        </tr>
        <tr>
            <td><h4>Sprinkler Zone2</h4></td>
            <td><select name="sprinklerzone2select" id="sprinklerzone2select" >
     			<option id="sprinklerzone2off" value="off"> OFF </option>
     			<option id="sprinklerzone2on" value="on"> ON </option>
     			
     		</select>
     		</td>
          	<td><div id="arrow" class="arrow"></div></td>
        </tr>
        <tr>
            <td colspan="5">
               
                <h4>Additional information</h4>
                <ul>
                    <li>This is zone 2 covering top right zone of garden</li>
                    <li><a href="#">Set the Schedule</a></li>
                    
                 </ul> 
            </td>
        </tr>
        <tr>
            <td><h4>Sprinkler Zone3</h4></td>
            <td><select name="sprinklerzone3select" id="sprinklerzone3select" onclick="doUnbind()">
     			<option id="sprinklerzone3off" value="off"> OFF </option>
     			<option id="sprinklerzone3on" value="on"> ON </option>
     			
     		</select>
     		</td>
            <td><div id="arrow" class="arrow"></div></td>
        </tr>
        <tr>
            <td colspan="5">
               
                <h4>Additional information</h4>
                 <ul>
                    <li>This is zone 3 covering bottom left zone of garden</li>
                    <li><a href="#">Set the Schedule</a></li>
                    
                 </ul>
            </td>
        </tr>
        <tr>
            <td><h4>Sprinkler Zone4</h4></td>
            <td><select name="sprinklerzone4select" id="sprinklerzone4select" >
     			<option id="sprinklerzone4off" value="off"> OFF </option>
     			<option id="sprinklerzone4on" value="on"> ON </option>
     			
     		</select>
     		</td>
            <td><div id="arrow" class="arrow"></div></td>
        </tr>
        <tr>
            <td colspan="5">
               
                <h4>Additional information</h4>
                 <ul>
                    <li>This is zone 4 covering bottom right zone of garden</li>
                    <li><a href="#">Set the Schedule</a></li>
                    
                 </ul>  
            </td>
        </tr>
        <tr><td align="right" colspan="3"><input type="submit" id="submitsprinkler" value="Submit"> </td></tr>
  </table>

</form>
</center>
</body>

</html>
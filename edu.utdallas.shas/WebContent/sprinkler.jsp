<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<center>
<table id="sprinkler" >
<%
String sprinkler1 = (String) request.getSession().getAttribute("sprinklerzone1select");
String sprinkler2 = (String) request.getSession().getAttribute("sprinklerzone2select");
String sprinkler3 = (String) request.getSession().getAttribute("sprinklerzone3select");
String sprinkler4 = (String) request.getSession().getAttribute("sprinklerzone4select");
%>
        <tr>
            <th><h3>Sprinkler Zone</h3></th>
            <th><h3>Status</h3></th>
            <th></th>
        </tr>
        <tr>
            <td class="tog"><h4>Sprinkler Zone1</h4></td>
            <td><select name="sprinklerzone1select" id="sprinklerzone1select" >
     			<option id="sprinklerzone1off" value="off"> OFF </option>
     			<option id="sprinklerzone1on" value="on" <%if(sprinkler1!=null && sprinkler1.equalsIgnoreCase("on")){%> selected="selected" <%}%>> ON </option>
     			
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
     			<option id="sprinklerzone2on" value="on" <%if(sprinkler2!=null && sprinkler2.equalsIgnoreCase("on")){%> selected="selected" <%}%>> ON </option>
     			
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
     			<option id="sprinklerzone3on" value="on" <%if(sprinkler3!=null && sprinkler3.equalsIgnoreCase("on")){%> selected="selected" <%}%>> ON </option>
     			
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
     			<option id="sprinklerzone4on" value="on" <%if(sprinkler4!=null && sprinkler4.equalsIgnoreCase("on")){%> selected="selected" <%}%>> ON </option>
     			
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
  </table>
  </center> 
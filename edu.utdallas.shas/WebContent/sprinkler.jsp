<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  
<script type="text/javascript" src="./js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="./js/jquery-ui.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
    <script type="text/javascript">  
        $(document).ready(function(){
            $("#sprinkler tr:odd").addClass("odd");
            $("#sprinkler tr:not(.odd)").hide();
            $("#sprinkler tr:first-child").show();
        
            for (var i = 1; i <= 4; i++) {
                $("#arrow" + i).click(function(){
                    ($(this)).closest("tr").next("tr").toggle();
                    ($(this)).closest("tr").find(".arrow").toggleClass("up");
                });	
            } 
            
            $( "#zone1_description" ).dialog({ autoOpen: false }).prev(".ui-dialog-titlebar").css("background","#0099FF");
            $( "#zone2_description" ).dialog({ autoOpen: false }).prev(".ui-dialog-titlebar").css("background","#0099FF");
            $( "#zone3_description" ).dialog({ autoOpen: false }).prev(".ui-dialog-titlebar").css("background","#0099FF");
            $( "#zone4_description" ).dialog({ autoOpen: false }).prev(".ui-dialog-titlebar").css("background","#0099FF");
            $( "#set_zone2_description" ).click(function() {
            $( "#zone2_description" ).dialog( "open" );
            });
            $( "#set_zone1_description" ).click(function() {
                $( "#zone1_description" ).dialog( "open" );
            });
            $( "#set_zone2_description" ).click(function() {
                $( "#zone2_description" ).dialog( "open" );
            });
            $( "#set_zone3_description" ).click(function() {
                $( "#zone3_description" ).dialog( "open" );
            });
            $( "#set_zone4_description" ).click(function() {
                $( "#zone4_description" ).dialog( "open" );
            });
        });
        
        function submitDescription(obj)
        {
        	var id = ($.trim(obj.id));
        	if(id === "submit_zone1_description")
        	{
        		//alert("hi.."+);
        		$("#li_zone1_description").text($('textarea#text_zone1_description').val());
        		$( "#zone1_description" ).dialog( "close" );
        	}
        	if(id === "submit_zone2_description")
        	{
        		//alert("hi.."+);
        		$("#li_zone2_description").text($('textarea#text_zone2_description').val());
        		$( "#zone2_description" ).dialog( "close" );
        	}
        	if(id === "submit_zone3_description")
        	{
        		//alert("hi.."+);
        		$("#li_zone3_description").text($('textarea#text_zone3_description').val());
        		$( "#zone3_description" ).dialog( "close" );
        	}
        	if(id === "submit_zone4_description")
        	{
        		//alert("hi.."+);
        		$("#li_zone4_description").text($('textarea#text_zone4_description').val());
        		$( "#zone4_description" ).dialog( "close" );
        	}
        }
        
    </script>
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
            <td><h4>Sprinkler Zone1</h4></td>
            <td><select name="sprinklerzone1select" id="sprinklerzone1select" >
     			<option id="sprinklerzone1off" value="off"> OFF </option>
     			<option id="sprinklerzone1on" value="on" <%if(sprinkler1!=null && sprinkler1.equalsIgnoreCase("on")){%> selected="selected" <%}%>> ON </option>
     			
     		</select>
     		</td>
            <td><div id="arrow1" class="arrow"></div></td>
        </tr>
        <tr>
            <td colspan="5">
               
                <h4>Additional information</h4>
                <ul>
                    <li><div id="li_zone1_description">This is zone 1 covering top left zone of garden</div>
                     <a id="set_zone1_description" href="#"> Edit</a>
                    </li>
                    <li><a>Set the Schedule</a></li>
                 </ul>
                 <div id="zone1_description" title="Sprinkler Zone1 Description">
						<textarea placeholder="Set description here.." rows="15" cols="30" id="text_zone1_description" name ="text_zone1_description" style="max-height:100px;min-height:100px; resize: none"></textarea>
						<input type="button" id="submit_zone1_description" name="submit_zone1_description" value="Submit" onclick="submitDescription(this)"></input>
					</div>
                    
            </td>
        </tr>
        <tr>
            <td><h4>Sprinkler Zone2</h4></td>
            <td><select name="sprinklerzone2select" id="sprinklerzone2select" >
     			<option id="sprinklerzone2off" value="off"> OFF </option>
     			<option id="sprinklerzone2on" value="on" <%if(sprinkler2!=null && sprinkler2.equalsIgnoreCase("on")){%> selected="selected" <%}%>> ON </option>
     			
     		</select>
     		</td>
          	<td><div id="arrow2" class="arrow"></div></td>
        </tr>
        <tr>
            <td colspan="5">
               
                <h4>Additional information</h4>
                <ul>
                    <li ><div id="li_zone2_description">This is zone 2 covering top right zone of garden</div>
                    <a id="set_zone2_description" href="#"> Edit</a>
                    </li>
                    <li><a href="#">Set the Schedule</a></li>
                    
                 </ul> 
                   <div id="zone2_description" title="Sprinkler Zone2 Description">
						<textarea placeholder="Set description here.." rows="15" cols="30" id="text_zone2_description" name ="text_zone2_description" style="max-height:100px;min-height:100px; resize: none"></textarea>
						<input type="button" id="submit_zone2_description" name="submit_zone2_description" value="Submit" onclick="submitDescription(this)"></input>
					</div>
                    
            </td>
        </tr>
        <tr>
            <td><h4>Sprinkler Zone3</h4></td>
            <td><select name="sprinklerzone3select" id="sprinklerzone3select" onclick="doUnbind()">
     			<option id="sprinklerzone3off" value="off"> OFF </option>
     			<option id="sprinklerzone3on" value="on" <%if(sprinkler3!=null && sprinkler3.equalsIgnoreCase("on")){%> selected="selected" <%}%>> ON </option>
     			
     		</select>
     		</td>
            <td><div id="arrow3" class="arrow"></div></td>
        </tr>
        <tr>
            <td colspan="5">
               
                <h4>Additional information</h4>
                 <ul>
                    <li><div id="li_zone3_description">This is zone 3 covering bottom left zone of garden</div>
                     <a id="set_zone3_description" href="#"> Edit</a>
                    </li>
                    <li><a href="#">Set the Schedule</a></li>
                    
                 </ul>
                 <div id="zone3_description" title="Sprinkler Zone3 Description">
						<textarea placeholder="Set description here.." rows="15" cols="30" id="text_zone3_description" name ="text_zone3_description" style="max-height:100px;min-height:100px; resize: none"></textarea>
						<input type="button" id="submit_zone3_description" name="submit_zone3_description" value="Submit" onclick="submitDescription(this)"></input>
				</div>
                    
            </td>
        </tr>
        <tr>
            <td><h4>Sprinkler Zone4</h4></td>
            <td><select name="sprinklerzone4select" id="sprinklerzone4select" >
     			<option id="sprinklerzone4off" value="off"> OFF </option>
     			<option id="sprinklerzone4on" value="on" <%if(sprinkler4!=null && sprinkler4.equalsIgnoreCase("on")){%> selected="selected" <%}%>> ON </option>
     			
     		</select>
     		</td>
            <td><div id="arrow4" class="arrow"></div></td>
        </tr>
        <tr>
            <td colspan="5">
               
                <h4>Additional information</h4>
                 <ul>
                    <li><div id="li_zone4_description">This is zone 4 covering bottom right zone of garden</div>
                     <a id="set_zone4_description" href="#"> Edit</a>
                     </li>
                    <li><a href="#">Set the Schedule</a></li>
                    
                 </ul>  
                 <div id="zone4_description" title="Sprinkler Zone4 Description">
						<textarea placeholder="Set description here.." rows="15" cols="30" id="text_zone4_description" name ="text_zone4_description" style="max-height:100px;min-height:100px; resize: none"></textarea>
						<input type="button" id="submit_zone4_description" name="submit_zone4_description" value="Submit" onclick="submitDescription(this)"></input>
				 </div>
                    
            </td>
        </tr>
  </table>

 
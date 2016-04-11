<%@ include file="realhead.jsp"%>
<% 
if (allnodes.size() == 0){%>
   <script>
    alert("Please add a pattern first");
   </script>
   <% }
%>
<script type="text/javascript" >
function check() {
	if ($('#dID').val()== null ||$('#cID').val()== null) {
		alert("Please chooose a pattern!");
		return false;
	}
	return true;
}
$(document).ready(function() {
$('#dID').change(function() {
    var dNode = $('#dID').val();
    var data={"dNode":dNode}
	var mydata=JSON.stringify(data)
	$.ajax({
        type : "POST",
        url : "showCforD",
        data: mydata,
        contentType: 'application/json;charset=UTF-8',
        success: function(result){
        	obj=JSON.parse(result);
        	belongC=obj['belongC'];
        	$("#cID").html("<option disabled selected value> -- select an Pattern -- </option>");
        	for(i=0;i<belongC.length;i++){
        	$("#cID").append("<option value='" + belongC[i] + "'>" + belongC[i] + "</option>");
        	}}
        });
});
$('#cID').change(function(){
	 var cNode = $('#cID').val();
  	  var data={"cNode":cNode};
	var mydata=JSON.stringify(data);
	$.ajax({
	        type : "POST",
	        url : "showNforC",
	        data: mydata,
	        contentType: 'application/json;charset=UTF-8',
	       	success: function(result){obj=JSON.parse(result);
  	        	var belongN=obj['belongN'];
  	        	$("#nID1").html("<option disabled selected value> -- select an Node -- </option>");
  	        	for(i=0;i<belongN.length;i++){
  	        	$("#nID1").append("<option value='" + belongN[i] + "'>" + belongN[i] + "</option>");
  	        	}}
  	        });
  	    });
$('#nID1').change(function(){
	var node = $('#nID1').val();
	var cNode = $('#cID').val();
	  var data={"cNode":cNode};
	var mydata=JSON.stringify(data);
	$.ajax({
	        type : "POST",
	        url : "showNforC",
	        data: mydata,
	        contentType: 'application/json;charset=UTF-8',
	       	success: function(result){obj=JSON.parse(result);
	        	var belongN=obj['belongN'];
	        	var index = belongN.indexOf(parseInt(node));
	        	if (index > -1) {
	        	    belongN.splice(index, 1);
	        	}
	        	$("#nID2").html("<option disabled selected value> -- select an Node -- </option>");
	        	for(i=0;i<belongN.length;i++){
	        	$("#nID2").append("<option value='" + belongN[i] + "'>" + belongN[i] + "</option>");
	        	}}
	        });
});
});
</script>
			<div class="span12" id="datacontent">

					<table class="table">
						<thead>
							<tr>
								<th colspan="5">Add Non-connector Node</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><select name="dID" id= "dID" class="span1">
										<%
											if (res1 != null && res1.size() != 0) {
												out.println("<option disabled selected value> -- select an Domain -- </option>");
												for (int i = 0; i < res1.size(); i++) {
													int domain = res1.get(i);
													out.println("<option value = " +  domain + ">" +  domain
															+ "</option>");
												}
											}
										%>
								</select></td>
								<td id="ctd"><select id="cID">  
                <option disabled selected value> -- select an Pattern -- </option>
            </select> 
            </td>
								<td id="ntd"><select id="nID1">  
                <option disabled selected value> -- select an Node -- </option> 
            </select>  </td>
            <td id="ntd"><select id="nID2">  
                <option disabled selected value> -- select an Node -- </option> 
            </select>  </td>
            <td><input type="checkbox" name="connectToC" value="yes">Connect To Connector Node</td>
            <td><a class="btn btn-primary"  onclick = "if (check()){addNonNode();}" type="submit">Generate Node</a></td>
							</tr>
						</tbody>
					</table>
			</div>